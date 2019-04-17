SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:Julien Bankier
-- Create date: 04/19/2019
-- Description:	Load in products, perform an innerjoin on the orignal data thats been loaded in and the created productCatagory and Subcatagory Tables
-- =============================================
CREATE PROCEDURE [Project2].[Load_DimProduct]
        @GroupMemberUserAuthorizationKey int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
    -- Load data and perform joins when nessasry
	SET NOCOUNT ON;
    SET IDENTITY_INSERT [CH01-01-Dimension].[DimProduct] ON;
    INSERT INTO [CH01-01-Dimension].[DimProduct] (ProductSubcatagoryKey, ProductCategory, ProductCode, ProductName, Color, ModelName, UserAuthorizationKey,DateAdded,DateOfLastUpdate)
    SELECT ProductCategory, ProductCode, ProductName, Color, ModelName, DISTINCT PC.ProductSubcatagoryKey,
    -- increment sequence key
    NEXT VALUE FOR [PkSequence].[DimProductSequenceObject],
    -- Userkey and time for trackng
    @GroupMemberUserAuthorizationKey, SYSDATETIME(), SYSDATETIME()

  -- CANT TELL IF THIS WORKS TILL WE HAVE THE OTHER TWO< MAY NEED TO CHANGE THE NAMES ACCORDINGLY

    FROM  [CH01-01-Dimension].[DimProductCatagory] AS PC 
    INNER JOIN [CH01-01-Dimension].[DimProductSubCatagory] PSC ON PC.ProductCatagoryKey = PSC.ProductCatagoryKey 
    INNER JOIN FileUpload.OriginallyLoadedData AS OG on OG.ProductCategory = PC.ProductCategoryName  AND OG.ProductSubcategory = PSC.DimProductSubCatagoryName 

    SET IDENTITY_INSERT [CH01-01-Dimension].[DimProduct] OFF;


--tracking
DECLARE @num AS INT
DECLARE @startTime AS DATETIME2
DECLARE @desc AS NVARCHAR(100) 
SELECT @num = COUNT(*) FROM [CH01-01-Dimension].[DimProduct]
SELECT @startTime = SYSDATETIME()
SELECT @desc = 'Loading values for DimProduct'
EXEC [Process].[usp_TrackWorkFlow]  @startTime, @desc, @num, @GroupMemberUserAuthorizationKey;
PRINT 'Loaded Dim Product'

END

GO
