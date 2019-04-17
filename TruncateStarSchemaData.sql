USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[TruncateStarSchemaData]	Script Date: 4/8/2019 10:37:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:   	 Komal Narine
-- Create date:
-- Description:    
-- =============================================
ALTER PROCEDURE [Project2].[TruncateStarSchemaData]
    @GroupMemberUserAuthorizationKey int

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
    truncate table [CH01-01-Dimension].[DimCustomer];
    truncate table [CH01-01-Dimension].[DimGender];
    truncate table [CH01-01-Dimension].[DimMaritalStatus];
    truncate table [CH01-01-Dimension].[DimOccupation];
    truncate table [CH01-01-Dimension].[DimOrderDate];
    truncate table [CH01-01-Dimension].[DimProduct];
    truncate table [CH01-01-Dimension].[DimTerritory];
    truncate table [CH01-01-Dimension].[SalesManagers];
    truncate table [CH01-01-Fact].[Data];

    print 'insert your statements within the Begin\End block which is the equivalentof the Java { \ }'
end


