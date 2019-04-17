SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Julien Bankier
-- Create date: 04/19/2019
-- Description:	Load sales manager data into the table, increment sequence key, tracking
-- =============================================
CREATE PROCEDURE [Project2].[Load_SalesManagers]
	    @GroupMemberUserAuthorizationKey int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    SET IDENTITY_INSERT [CH01-01-Dimension].[SalesManager] ON;
    -- Loads the data and as well as the additional info
	INSERT INTO [CH01-01-Dimension].SalesManagers (SalesMangerKey,Category,SalesManager, Office, UserAuthorizationKey, DateAdded, DateOfLastUpdate )
	SELECT DISTINCT
		ProductCategory,
		SalesManager,
		Office = CASE
					 WHEN SalesManager LIKE 'Marco%' THEN
						 'Redmond'
					 WHEN SalesManager LIKE 'Alberto%' THEN
						 'Seattle'
					 WHEN SalesManager LIKE 'Maurizio%' THEN
						 'Redmond'
					 ELSE
						 'Seattle'
				 END,
    -- increment sequence key
        NEXT VALUE FOR [PkSequence].[SalesManagersSequenceObject],
    -- Userkey and time for trackng
    	@GroupMemberUserAuthorizationKey, SYSDATETIME(), SYSDATETIME()

    FROM FileUpload.OriginallyLoadedData;
    SET IDENTITY_INSERT [CH01-01-Dimension].[SalesManager] OFF;

    -- Tracking
    DECLARE @num AS INT
    DECLARE @startTime AS DATETIME2
    DECLARE @desc AS NVARCHAR(100);
    SELECT @num = COUNT(*) FROM [CH01-01-Dimension].[SalesManagers]
    SELECT @startTime = SYSDATETIME()
    SELECT @desc = 'Loading values for Sales Mangers'
    EXEC [Process].[usp_TrackWorkFlow]  @startTime, @desc, @num, @GroupMemberUserAuthorizationKey;

PRINT 'Loaded Values For Sales Managers'
END;

GO
