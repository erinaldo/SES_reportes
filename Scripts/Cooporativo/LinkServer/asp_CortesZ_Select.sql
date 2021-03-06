USE [SES_ApatzinganV5]
GO
/****** Object:  StoredProcedure [dbo].[asp_CortesZ_Select]    Script Date: 18/02/2019 08:44:54 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[asp_CortesZ_Select]
	-- Add the parameters for the stored procedure here
	@FechaInicio varchar(20),
	@FechaFin varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select CortesZId
      ,CajaId
      ,CortesZFecha
      ,UsuariosId
      ,CortesZSub0
      ,CortesZSub16
      ,CortesZIva
      ,CortesZTotal
	from CortesZ as cz
	where CortesZFecha between @FechaInicio and @FechaFin 
	and CortesZId not in(SELECT czS.CortesZId FROM [SERVER-SON].[Server_Apatzingan].[dbo].[CortesZ] as czS
    where czS.CortesZFecha between @FechaInicio and @FechaFin and czS.CajaId=cz.CajaId)
END
