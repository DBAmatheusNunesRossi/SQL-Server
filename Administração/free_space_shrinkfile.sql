/********************************************************************************************
    OBJETIVO
    -----------------------------------------------------------------------------------------
    Este script percorre todos os bancos da instância e calcula o espaço livre interno 
    (unused space) de cada arquivo de dados. 
    Além disso, gera automaticamente o comando DBCC SHRINKFILE correspondente.

    Observação: O SHRINK não é executado — apenas exibido para análise.
********************************************************************************************/
-- Remoção da tabela temporária, caso exista
IF OBJECT_ID('tempdb..#free_space') IS NOT NULL
    DROP TABLE #free_space;


-- Criação da tabela temporária que armazenará os resultados
CREATE TABLE #free_space
(
    db             VARCHAR(300),
    FileName       VARCHAR(300),
    size_free_gb   DECIMAL(18,2),
    Letter         CHAR(5),
    comando        VARCHAR(1000)
);


EXEC sp_MSforeachdb

'use [?]
insert into #free_space
SELECT DB_NAME() AS DbName, 
    name AS FileName,  
    CONVERT(DECIMAL(10,2),size/128.0/1024 - CAST(FILEPROPERTY(name, ''SpaceUsed'') AS INT)/128.0/1024) AS FreeSpaceGB,
	left(physical_name,3) as Letter,
	''USE ['' +  DB_NAME() + ''] dbcc shrinkfile ([''+NAME+''],1)'' as comando
	FROM sys.database_files
WHERE type IN (0)'

SELECT *
FROM #free_space
ORDER BY size_free_gb DESC;


