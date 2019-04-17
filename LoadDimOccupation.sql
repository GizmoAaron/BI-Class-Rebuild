USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_DimOccupation]    Script Date: 4/14/2019 6:24:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alexis Montes
-- Create date: 4/14/2019
-- Description:	loads up values for DimOccupation including for new columns
-- =============================================

-- NOTES:
-- currently unclear if occupation key will be incremented in schema or added manually
--

ALTER PROCEDURE [Project2].[Load_DimOccupation] @GroupMemberUserAuthorizationKey INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

    -- start of loading values
	SET NOCOUNT ON;
    SET IDENTITY_INSERT [CH01-01-Dimension].[DimOccupation] ON;

    CREATE SEQUENCE [Project2].[DimProductSequenceObject]
    AS INT
    START WITH 1
    INCREMENT BY 1	

    -- creates temp table
    SELECT DISTINCT Occupation
    INTO #OCC
    FROM FileUpload.OriginallyLoadedData

    -- reset obj, change project2 to appropriate name
    ALTER SEQUENCE [Project2].[DimProductSequenceObject]
	RESTART WITH 1

    INSERT INTO [CH01-01-Dimension].[DimOccupation] (Occupation, OccupationKey, UserAuthorizationKey ,DateAdded ,DateOfLastUpdate)
    SELECT
        OCC.OCCUPATION,
        -- manual key
        NEXT VALUE FOR [Project2].[DimProductSequenceObject],
         -- additional table values
        @GroupMemberUserAuthorizationKey,
        SYSDATETIME(),
        SYSDATETIME()
    FROM #OCC as OCC
    SET IDENTITY_INSERT [CH01-01-Dimension].[DimOccupation] OFF;
    -- end of loading values

    -- deletes temp table 
    DROP TABLE #OCC

    -- start of track work flow
    DECLARE @num AS INT
    DECLARE @startTime AS DATETIME2
    DECLARE @desc AS NVARCHAR(100)

    
    SELECT @num = COUNT(*) FROM [CH01-01-Dimension].[DimOccupation]
    SELECT @startTime = SYSDATETIME()
    SELECT @desc = 'Loading values for DimOccupation'

    EXEC [Process].[usp_TrackWorkFlow]  @startTime, @desc, @num, 3;
    -- end of track work flow

END