USE [DBADMIN]
GO

/****** Object:  StoredProcedure [dbo].[usp_insere_login]    Script Date: 1/22/2026 7:44:01 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[usp_insere_login]
as 
set nocount on
begin
insert into sqltb_usuarios 
(username, account_status,ds_funcao,nm_sistema,nm_responsavel,nm_area,dt_atualizacao, servername)

select  
a.name as username, 
case 
when b.is_disabled = 0 then 'habilitado'
else 'desabilitado'
end as account_status,
' ' as ds_funcao ,
' ' as nm_sistema ,
' ' as nm_responsavel ,
' ' as nm_area,  
getdate() ,
@@SERVERNAME
from sys.syslogins a inner join  sys.server_principals b
on a.sid = b.sid
where type_desc in ('WINDOWS_LOGIN','SQL_LOGIN','WINDOWS_GROUP') AND a.name not in (
SELECT username
FROM sqltb_usuarios)


update sqltb_usuarios set account_status =  
case when a.is_disabled = 0 then 'habilitado'
when a.is_disabled is null then 'Deletado'
else 'desabilitado'
end
 from sqltb_usuarios b
left outer join 
sys.server_principals a 
on a.name = b.username and b.account_status <> 'Deletados'
end
GO


