/**********************************************************************************************
    OBJETIVO:
    -------------------------------------------------------------------------------------------
    Esse script compara a quantidade de linhas das tabelas replicadas entre:
        - Um banco Publisher
        - Um banco Subscriber
        - Baseado nos artigos (tabelas) cadastrados na Publication informada.

    COMO ADAPTAR:
    Basta alterar os seguintes parâmetros:
        @LS_Publisher     = Linked Server que aponta para o Publisher
        @PublisherDB      = Banco no Publisher
        @LS_Subscriber    = Linked Server que aponta para o Subscriber
        @SubscriberDB     = Banco no Subscriber
        @PublicationName  = Nome da Publication configurada no Distributor

    EXEMPLO DE USO:
        DECLARE @LS_Publisher    sysname = N'MeuLinkedPublisher';
        DECLARE @PublisherDB     sysname = N'MeuBancoPublisher';

        DECLARE @LS_Subscriber   sysname = N'MeuLinkedSubscriber';
        DECLARE @SubscriberDB    sysname = N'MeuBancoSubscriber';

        DECLARE @PublicationName sysname = N'MinhaPublication';

**********************************************************************************************/

DECLARE @LS_Publisher    sysname = N'MeuLinkedServer_Publisher';
DECLARE @PublisherDB     sysname = N'Banco_Publisher';

DECLARE @LS_Subscriber   sysname = N'MeuLinkedServer_Subscriber';
DECLARE @SubscriberDB    sysname = N'Banco_Subscriber';

DECLARE @PublicationName sysname = N'Minha_Publication';


/**********************************************************************************************
    1) PREPARAÇÃO DAS TABELAS TEMPORÁRIAS
**********************************************************************************************/
IF OBJECT_ID('tempdb..#Articles') IS NOT NULL DROP TABLE #Articles;
IF OBJECT_ID('tempdb..#CompareRows') IS NOT NULL DROP TABLE #CompareRows;

CREATE TABLE #Articles (
    schema_name sysname,
    table_name  sysname
);

CREATE TABLE #CompareRows (
    schema_name sysname,
    table_name  sysname,
    rows_publisher  bigint,
    rows_subscriber bigint
);

DECLARE @sql nvarchar(max);

/* 1) Buscar dinamicamente as tabelas da publication na distribution */
SET @sql = N'
SELECT 
    a.source_owner  AS schema_name,
    a.source_object AS table_name
FROM BTSP3PRDDRP01.distribution.dbo.MSarticles a
JOIN BTSP3PRDDRP01.distribution.dbo.MSpublications p
    ON a.publication_id = p.publication_id
WHERE p.publication = N''' + @PublicationName + N''';';

INSERT INTO #Articles (schema_name, table_name)
EXEC (@sql);

/* 2) Loop nas tabelas da publication para comparar os rowcounts */
DECLARE 
    @schema sysname,
    @table  sysname,
    @cmd    nvarchar(max);

DECLARE cur CURSOR FAST_FORWARD FOR
    SELECT schema_name, table_name
    FROM #Articles
    ORDER BY schema_name, table_name;

OPEN cur;
FETCH NEXT FROM cur INTO @schema, @table;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @cmd = N'
    INSERT INTO #CompareRows (schema_name, table_name, rows_publisher, rows_subscriber)
    SELECT
        N''' + @schema + ''',
        N''' + @table  + ''',
        -- rowcount Publisher
        (
            SELECT SUM(p.rows)
            FROM   [' + @LS_Publisher + N'].[' + @PublisherDB + N'].sys.partitions p
                   JOIN [' + @LS_Publisher + N'].[' + @PublisherDB + N'].sys.objects o
                        ON p.object_id = o.object_id
            WHERE  o.name = N''' + @table + '''
              AND  SCHEMA_NAME(o.schema_id) = N''' + @schema + '''
              AND  p.index_id IN (0,1)
        ),
        -- rowcount Subscriber
        (
            SELECT SUM(p.rows)
            FROM   [' + @LS_Subscriber + N'].[' + @SubscriberDB + N'].sys.partitions p
                   JOIN [' + @LS_Subscriber + N'].[' + @SubscriberDB + N'].sys.objects o
                        ON p.object_id = o.object_id
            WHERE  o.name = N''' + @table + '''
              AND  SCHEMA_NAME(o.schema_id) = N''' + @schema + '''
              AND  p.index_id IN (0,1)
        );';

    EXEC(@cmd);

    FETCH NEXT FROM cur INTO @schema, @table;
END

CLOSE cur;
DEALLOCATE cur;

--/* 3) Resultado – tudo */
--SELECT *
--FROM #CompareRows
--ORDER BY schema_name, table_name;

/* 4) Só divergências (o que interessa na replicação) */
SELECT *
FROM #CompareRows
WHERE ISNULL(rows_publisher,0) <> ISNULL(rows_subscriber,0)
ORDER BY schema_name, table_name;
