/***********************************************************************
 Autor:        <Matheus Nunes>
 Descrição:    Este script executa automaticamente o DBCC CHECKDB em todas as bases de dados do servidor, exceto nas bases do sistema (master, msdb, model, tempdb), captura o resultado resumido de integridade e grava no banco DB_DBA, na tabela TB_checkdb.
 Observações:  Exclui bancos do sistema e limpa a tabela temporária 
               a cada iteração.
************************************************************************/

-- Remove tabela temporária caso exista
IF OBJECT_ID('tempdb..#Results') IS NOT NULL
    DROP TABLE #Results;

-- Criação da tabela temporária para armazenar o resultado do CHECKDB
CREATE TABLE #Results (
      Error          INT NULL,
      Level          INT NULL,
      State          INT NULL,
      MessageText    VARCHAR(7000) NULL,
      RepairLevel    INT NULL,
      Status         INT NULL,
      DbId           INT NULL,
      Id             INT NULL,
      IndId          INT NULL,
      PartitionID    INT NULL,
      AllocUnitID    INT NULL,
      [File]         INT NULL,
      Page           INT NULL,
      Slot           INT NULL,
      RefFile        INT NULL,
      RefPage        INT NULL,
      RefSlot        INT NULL,
      Allocation     INT NULL
);

-- Loop em todos os bancos exceto os do sistema
EXEC sp_MSforeachdb '
IF ''?'' NOT IN (''master'',''msdb'',''model'',''tempdb'',''distribution'',''DB_DBA'')
BEGIN
    -- Executa o CHECKDB e grava a saída na tabela temporária
    INSERT INTO #Results
        EXEC (''DBCC CHECKDB([?]) WITH TABLERESULTS'');

    -- Grava apenas as mensagens conclusivas na tabela de auditoria
    INSERT INTO DB_DBA.dbo.TB_checkdb (db, Texto)
    SELECT 
          ''?'' AS db,
          MessageText
    FROM #Results
    WHERE MessageText LIKE ''CHECKDB found%'';

    -- Limpa a tabela temporária para o próximo banco
    TRUNCATE TABLE #Results;
END
';

-- Seleciona o histórico gravado
SELECT * 
FROM DB_DBA.dbo.TB_checkdb;
