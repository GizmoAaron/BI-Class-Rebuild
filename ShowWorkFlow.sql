USE [BIClass]
GO
/****** Object:  StoredProcedure [Process].[usp_TrackWorkFlow]    Script Date: 4/14/2019 4:31:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [Process].[usp_ShowWorkFlow]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT *
	FROM Process.WorkflowSteps;
END
