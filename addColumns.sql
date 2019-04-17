ALTER TABLE [CH01-01-Dimension].[SalesManagers] ADD [UserAuthorizationKey] INT NOT NULL;
ALTER TABLE [CH01-01-Dimension].[DimGender] ADD [UserAuthorizationKey] INT NOT NULL;
ALTER TABLE [CH01-01-Dimension].[DimMaritalStatus] ADD [UserAuthorizationKey] INT NOT NULL;
ALTER TABLE [CH01-01-Dimension].[DimOccupation] ADD [UserAuthorizationKey] INT NOT NULL;
ALTER TABLE [CH01-01-Dimension].[DimOrderDate] ADD [UserAuthorizationKey] INT NOT NULL;
ALTER TABLE [CH01-01-Dimension].[DimTerritory] ADD [UserAuthorizationKey] INT NOT NULL;
ALTER TABLE [CH01-01-Dimension].[DimProduct] ADD [UserAuthorizationKey] INT NOT NULL;
ALTER TABLE [CH01-01-Dimension].[DimCustomer] ADD [UserAuthorizationKey] INT NOT NULL;
ALTER TABLE [CH01-01-Fact].[Data] ADD [UserAuthorizationKey] INT NOT NULL;

ALTER TABLE [CH01-01-Dimension].[SalesManagers] ADD [DateAdded] DATETIME2 NULL default (sysdatetime());
ALTER TABLE [CH01-01-Dimension].[DimGender] ADD [DateAdded] DATETIME2 NULL default (sysdatetime());
ALTER TABLE [CH01-01-Dimension].[DimMaritalStatus] ADD [DateAdded] DATETIME2 NULL default (sysdatetime());
ALTER TABLE [CH01-01-Dimension].[DimOccupation] ADD [DateAdded] DATETIME2 NULL default (sysdatetime());
ALTER TABLE [CH01-01-Dimension].[DimOrderDate] ADD [DateAdded] DATETIME2 NULL default (sysdatetime());
ALTER TABLE [CH01-01-Dimension].[DimTerritory] ADD [DateAdded] DATETIME2 NULL default (sysdatetime());
ALTER TABLE [CH01-01-Dimension].[DimProduct] ADD [DateAdded] DATETIME2 NULL default (sysdatetime());
ALTER TABLE [CH01-01-Dimension].[DimCustomer] ADD [DateAdded] DATETIME2 NULL default (sysdatetime());
ALTER TABLE [CH01-01-Fact].[Data] ADD [DateAdded] DATETIME2 NULL default (sysdatetime());

ALTER TABLE [CH01-01-Dimension].[SalesManagers] ADD [DateOfLastUpdate] DATETIME2 NULL default (sysdatetime());
ALTER TABLE [CH01-01-Dimension].[DimGender] ADD [DateOfLastUpdate] DATETIME2 NULL default (sysdatetime());
ALTER TABLE [CH01-01-Dimension].[DimMaritalStatus] ADD [DateOfLastUpdate] DATETIME2 NULL default (sysdatetime());
ALTER TABLE [CH01-01-Dimension].[DimOccupation] ADD [DateOfLastUpdate] DATETIME2 NULL default (sysdatetime());
ALTER TABLE [CH01-01-Dimension].[DimOrderDate] ADD [DateOfLastUpdate] DATETIME2 NULL default (sysdatetime());
ALTER TABLE [CH01-01-Dimension].[DimTerritory] ADD [DateOfLastUpdate] DATETIME2 NULL default (sysdatetime());
ALTER TABLE [CH01-01-Dimension].[DimProduct] ADD [DateOfLastUpdate] DATETIME2 NULL default (sysdatetime());
ALTER TABLE [CH01-01-Dimension].[DimCustomer] ADD [DateOfLastUpdate] DATETIME2 NULL default (sysdatetime());
ALTER TABLE [CH01-01-Fact].[Data] ADD [DateOfLastUpdate] DATETIME2 NULL default (sysdatetime());