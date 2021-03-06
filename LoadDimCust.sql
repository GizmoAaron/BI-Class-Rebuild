USE [BIClass]
GO
/****** Object:  StoredProcedure [Project2].[Load_DimCustomer]    Script Date: 4/13/2019 1:03:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Komal Narine
-- Create date: 
-- Description:	
-- =============================================
ALTER PROCEDURE [Project2].[Load_DimCustomer]
	@GroupMemberUserAuthorizationKey int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET IDENTITY_INSERT [CH01-01-Dimension].[DimCustomer] ON;
	Insert INTO [CH01-01-Dimension].[DimCustomer] (CustomerKey,CustomerName,UserAuthorizationKey,DateAdded,DateOfLastUpdate)
	SELECT NEXT VALUE FOR [PkSequence].[DimCustomerSequenceObject], C.CustomerName, @GroupMemberUserAuthorizationKey,SYSDATETIME(),SYSDATETIME()
	From (Select CustomerName From [FileUpload].[OriginallyLoadedData] Group by CustomerName) as C;
	SET IDENTITY_INSERT [CH01-01-Dimension].[DimCustomer] OFF;
	Declare @x as int
	Declare @time as datetime2
	Select @x = Count(*) From [CH01-01-Dimension].[DimCustomer]
	Select @time = SYSDATETIME();
	EXEC [Process].[usp_TrackWorkFlow] @time,'Loading Dim Cust',@x,@GroupMemberUserAuthorizationKey;

END
