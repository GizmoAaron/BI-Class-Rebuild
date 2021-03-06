USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_Data]    Script Date: 4/14/2019 4:55:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Komal Narine
-- Create date: 
-- Description:	
--
-- @GroupMemberUserAuthorizationKey is the 
-- UserAuthorizationKey of the Group Member who completed 
-- this stored procedure.
--
-- =============================================
ALTER PROCEDURE [Project2].[Load_Data]
	@GroupMemberUserAuthorizationKey int
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
    /****** Script for SelectTopNRows command from SSMS  ******/
	INSERT INTO [CH01-01-Fact].[Data] 
	(
	[SalesKey], [SalesManagerKey], [OccupationKey], [TerritoryKey], [ProductKey], [CustomerKey], 
	[ProductCategory], [SalesManager], [ProductSubcategory], [ProductCode], [ProductName], [Color], 
	[ModelName], [OrderQuantity], [UnitPrice], [ProductStandardCost], [SalesAmount], [OrderDate], 
	[MonthName], [MonthNumber], [Year], [CustomerName], [MaritalStatus], [Gender], [Education], 
	[Occupation], [TerritoryRegion], [TerritoryCountry], [TerritoryGroup], [UserAuthorizationKey]
	)
	SELECT 
	NEXT value FOR [PkSequence].[DataSequenceObect], ds.[SalesManagerKey], do.[OccupationKey], dt.[TerritoryKey], 
	dp.[ProductKey], dc.[CustomerKey], old.[ProductCategory], old.[SalesManager], old.[ProductSubcategory], 
	old.[ProductCode], old.[ProductName], old.[Color], old.[ModelName], old.[OrderQuantity], old.
	[UnitPrice], old.[ProductStandardCost], old.[SalesAmount], old.[OrderDate], old.[MonthName], old.
	[MonthNumber], old.[Year], old.[CustomerName], old.[MaritalStatus], old.[Gender], old.[Education],
	old.[Occupation], old.[TerritoryRegion], old.[TerritoryCountry], old.[TerritoryGroup], @GroupMemberUserAuthorizationKey
	FROM [FileUpload].[OriginallyLoadedData] AS old
	INNER JOIN [CH01-01-Dimension].[DimProduct] AS dp ON dp.ProductName = old.ProductName
	INNER JOIN [CH01-01-Dimension].[DimTerritory] AS dt ON dt.TerritoryCountry = old.TerritoryCountry
		AND dt.TerritoryGroup = old.TerritoryGroup
		AND dt.TerritoryRegion = old.TerritoryRegion
	INNER JOIN [CH01-01-Dimension].[DimCustomer] AS dc ON dc.CustomerName = old.CustomerName
	INNER JOIN [CH01-01-Dimension].[DimOccupation] AS do ON do.Occupation = old.Occupation
	INNER JOIN [CH01-01-Dimension].[SalesManagers] AS ds ON ds.SalesManager = old.SalesManager;
	Declare @x as int
	Declare @time as datetime2
	Select @x = Count(*) From [CH01-01-Fact].[Data]
	Select @time = SYSDATETIME();
	EXEC [Process].[usp_TrackWorkFlow] @time,'Loading Data into Fact.data',@x,@GroupMemberUserAuthorizationKey;

END;


