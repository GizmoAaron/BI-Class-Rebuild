USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_DimMaritalStatus]    Script Date: 4/14/2019 5:13:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alexis Montes
-- Create date: 4/13/19
-- Description:	Loads up values for the DimMartialStatus table and using
--              TrackWorkFlow storeed procedure
-- =============================================

-- NOTES:
-- Should work fine once additional col are added unsure if col will be added using stored procedure
-- or within this procedure as an alter table statment


ALTER PROCEDURE [Project2].[Load_DimMaritalStatus] @GroupMemberUserAuthorizationKey INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

    -- Start of loading values 
	SET NOCOUNT ON;
    SET IDENTITY_INSERT [CH01-01-Dimension].[DimMaritalStatus] ON;
    INSERT INTO [CH01-01-Dimension].[DimMaritalStatus] (MaritalStatus, MaritalStatusDescription, UserAuthorizationKey ,DateAdded ,DateOfLastUpdate)
    SELECT 
        DISTINCT MaritalStatus, 
        CASE
            WHEN MaritalStatus = 'M' THEN 'Married'
            WHEN MaritalStatus = 'S' THEN 'Single'
        END,
        -- additional table values
        @GroupMemberUserAuthorizationKey,
        SYSDATETIME(),
        SYSDATETIME()
    FROM FileUpload.OriginallyLoadedData
    SET IDENTITY_INSERT [CH01-01-Dimension].[DimMaritalStatus] OFF;
    -- End of loading values

    -- start of using TrackWorkFlow
    DECLARE @num AS INT
    DECLARE @startTime AS DATETIME2
    DECLARE @desc AS NVARCHAR(100);

    SELECT @num = COUNT(*) FROM [CH01-01-Dimension].[DimMaritalStatus]
    SELECT @startTime = SYSDATETIME()
    SELECT @desc = 'Loading values for DimMaritalStatus'

    EXEC [Process].[usp_TrackWorkFlow]  @startTime, @desc, @num, 3;
    -- END of TrackWorkFlow

END