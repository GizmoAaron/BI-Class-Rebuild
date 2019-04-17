USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[DropForeignKeysFromStarSchemaData]	Script Date: 4/8/2019 8:57:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:   	 Komal Narine
-- Create date:
-- Description:    Drop the Foreign Keys From the Star Schema
-- =============================================
ALTER PROCEDURE [Project2].[DropForeignKeysFromStarSchemaData]
AS
BEGIN
	declare @sql varchar(max) =
    (
	select
    	'alter table ' + quotename(schema_name(schema_id)) + '.' +
    	quotename(object_name(parent_object_id)) +
    	' drop constraint '+quotename(name) + ';'
	from sys.foreign_keys
	for xml path('')
    );
    exec(@sql);

END;


