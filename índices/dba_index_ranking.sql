/***********************************************************************************************
- A função dessa tabela é armazenar um ranking de criticidade de índices por banco de dados
- Indica se o índice é crítico (1) ou não (0).
***********************************************************************************************/

USE [Banco_DBA]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[dba_index_ranking](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[databaseName] [varchar](100) NULL,
	[critical] [bit] NULL,
	[ranking] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


