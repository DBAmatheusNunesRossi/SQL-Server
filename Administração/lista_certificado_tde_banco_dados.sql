/****************************************************************************************************************************************************************
Esse script consulta o SQL Server para descobrir qual certificado TDE está sendo usado para criptografar um banco de dados específico — no caso, o banco:

- Ele retorna:
- Nome do banco
- Estado da criptografia
- Nome do certificado usado pelo TDE
****************************************************************************************************************************************************************/

USE master;
GO
SELECT 
    db.name AS database_name,
    dek.encryption_state,
    cer.name AS certificate_name
FROM sys.dm_database_encryption_keys dek
JOIN sys.databases db ON dek.database_id = db.database_id
JOIN sys.certificates cer ON dek.encryptor_thumbprint = cer.thumbprint
WHERE db.name = 'nome_banco';
