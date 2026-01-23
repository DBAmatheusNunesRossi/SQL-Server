USE [DBADMIN]
GO

/****** Object:  StoredProcedure [dbo].[SP_LOCKS]    Script Date: 1/22/2026 7:35:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LOCKS]
AS

drop table if exists #mon_whoisactive

CREATE TABLE #mon_whoisactive(
	
	[dd_hh_mm_ss_mss] [varchar](8000) NULL,
	[SPID] [smallint] NULL,
	[BlkBy] [smallint] NULL,
	[SQLStatement] [xml] NULL,
	[SQLCommand] [xml] NULL,
	[Login] [varchar](300) NULL,
		[Host] [varchar](300) NULL,
	[Program] [varchar](300) NULL
) 



exec DBADMIN.dbo.sp_WhoIsActive 
@get_outer_command =1, @output_column_list = 
'[dd%][session_id][blocking_session_id][sql_text][sql_command][login_name][host_name][program_name]',
@destination_table = '#mon_whoisactive'

select * from  #mon_whoisactive
where spid in (
select distinct BlkBy from #mon_whoisactive
where BlkBy is not null)
or BlkBy in (
select distinct BlkBy from #mon_whoisactive
where BlkBy is not null)
order by BlkBy

GO


