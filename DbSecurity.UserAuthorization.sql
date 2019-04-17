USE [BICLASS]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Julien Bankier
-- Create date: 04/19/2019
-- Description:	CREATE TABLE FOR 
-- =============================================

CREATE TABLE [DBSecurity].[UserAuthorization] (
    --Primary Key (Do I need to chagne something?)
    [UserAuthorizationKey] [int] NOT NULL,
    [ClassTime] [nvarchar] NULL DEFAULT '9:15',
    [Individual project][nvarchar] NULL DEFAULT 'PROJECT 2 RECREATE THE BICLASS DATABASE STAR SCHEMA',
    [GroupMemberLastName] [nvarchar](35) NOT NULL,
    [GroupMemberFirstName][nvarchar](25)NOT NULL,
    [GroupName] [nvarchar](20)NOT NULL,
    [DateAdded] DATETIME2 NULL DEFAULT sysdatetime()
) on [Primary]

GO

-- DO I NEED TO ALTER ANY TABLES?

----UserAuthorizationKey INT NOT NULL, -- primary key
----• ClassTime nchar(5) Null Default either (‘7:45’ or ‘9:15’)
----• Individual project nvarchar (60) null default(‘PROJECT 2 RECREATE THE BICLASS DATABASE STAR SCHEMA’)
----• GroupMemberLastName nvarchar(35) NOT NULL,
----• GroupMemberFirstName nvarchar(25) NOT NULL,
----• GroupName nvarchar(20) NOT NULL,
----• DateAdded datetime2 null default sysdatetime()

