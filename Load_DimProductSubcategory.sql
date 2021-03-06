USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_DimProductSubcategory]    Script Date: 4/16/2019 12:34:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alexis Montes
-- Create date: 4/16
-- Description:	loads up value for dimProductSubcategory
-- =============================================
ALTER PROCEDURE [Project2].[Load_DimProductSubcategory] @GroupMemberUserAuthorizationKey INT
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.

	CREATE TABLE [CH01-01-Dimension].[DimProductSubcategory](
	ProductSubcategoryKey INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	ProductCategoryKey INT,
	ProductSubCategory VARCHAR(200),
	UserAuthorizationKey INT,
	DateAdded Date,
	DateOfLastUpdate DATE
	);


	-- Creats tmep table based on inner join
	SELECT DISTINCT DPC.[ProductCategoryKey], OL.[ProductSubCategory]
    INTO #PCK
    FROM [FileUpload].[OriginallyLoadedData] as OL
	INNER JOIN [CH01-01-Dimension].[DimProductCategory] AS DPC 
	ON DPC.[ProductCategory] = OL.[ProductCategory]

	-- Load data from original data and from DimProductCategory where ProductCategoryKey is in

	-- the code is dependent on DimProductCategory already being in the database
	SET NOCOUNT ON
	SET IDENTITY_INSERT [CH01-01-Dimension].[DimProductSubcategory] ON
	INSERT INTO [CH01-01-Dimension].[DimProductSubcategory] ([ProductCategoryKey], [ProductSubCategory], [ProductSubcategoryKey], UserAuthorizationKey ,DateAdded ,DateOfLastUpdate)
	SELECT 
		#PCK.[ProductCategoryKey],
		#PCK.[ProductSubCategory],
		NEXT VALUE for [Project2].[DimProductSequenceObject2],
		@GroupMemberUserAuthorizationKey,
        SYSDATETIME(),
        SYSDATETIME()
	FROM #PCK
	--ORDER BY ProductSubcategory ASC
	SET IDENTITY_INSERT [CH01-01-Dimension].[DimProductSubcategory] OFF

	

	-- start of track work flow
    DECLARE @num AS INT
    DECLARE @startTime AS DATETIME2
    DECLARE @desc AS NVARCHAR(100)

    
    SELECT @num = COUNT(*) FROM [CH01-01-Dimension].[DimOccupation]
    SELECT @startTime = SYSDATETIME()
    SELECT @desc = 'Loading values for ProductSubcategory'

	EXEC [Process].[usp_TrackWorkFlow]  @startTime, @desc, @num, 3;
    -- end of track work flow


END;