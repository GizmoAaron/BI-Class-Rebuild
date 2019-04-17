SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Julien Bankier
-- Create date: 04/19/2019
-- Description:	Loads Values into The Dim Gender Table and hard Codes the value for male and female
-- =============================================
CREATE PROCEDURE [Project2].[Load_DimGender]
	    @GroupMemberUserAuthorizationKey int
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
    SET IDENTITY_INSERT [CH01-01-Dimension].[DimGender] ON;
    -- Loads the data and as well as the additional info
    INSERT INTO [CH01-01-Dimension].[DimGender] (Gender, GenderDescription, UserAuthorizationKey,DateAdded,DateOfLastUpdate)
    SELECT Gender,
        CASE
            WHEN Gender = 'M'
                THEN 'Male'
            WHEN Gender = 'F'
                THEN 'Female'
        END,
    -- Userkey and time for trackng
    	@GroupMemberUserAuthorizationKey, SYSDATETIME(), SYSDATETIME()
    FROM FileUpload.OriginallyLoadedData
    SET IDENTITY_INSERT [CH01-01-Dimension].[DimGender] OFF;

    -- Tracking
    DECLARE @num AS INT
    DECLARE @startTime AS DATETIME2
    DECLARE @desc AS NVARCHAR(100);
    SELECT @num = COUNT(*) FROM [CH01-01-Dimension].[DimGender]
    SELECT @startTime = SYSDATETIME()
    SELECT @desc = 'Loading values for DimGender'
    EXEC [Process].[usp_TrackWorkFlow]  @startTime, @desc, @num, @GroupMemberUserAuthorizationKey;

PRINT 'Loaded Values For Dim Gender'
END;

GO
