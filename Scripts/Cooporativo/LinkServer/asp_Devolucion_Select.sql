USE [SES_ApatzinganV5]
GO
/****** Object:  StoredProcedure [dbo].[asp_Devolucion_Select]    Script Date: 18/02/2019 10:40:07 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[asp_Devolucion_Select]
	-- Add the parameters for the stored procedure here
	@FechaInicio varchar(20),
	@FechaFin varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT dev.DevolucionId
      ,dev.CajaId
      ,dev.TicketId
      ,dev.UsuariosId
      ,dev.DevolucionFecha
      ,dev.DevolucionSubtotal0
      ,dev.DevolucionSubtotal16
      ,dev.DevolucionIva
      ,dev.DevolucionTotal
      ,dev.DevolucionAsignadoCorte
      ,dev.CorteZId
	from Devolucion as dev
	where DevolucionFecha between @FechaInicio and @FechaFin
	and dev.DevolucionId not in (
	SELECT devS.DevolucionId
	from [SERVER-SON].[Server_Apatzingan].[dbo].[Devolucion] as devS
	where devS.DevolucionFecha between @FechaInicio and @FechaFin and devS.CajaId=dev.CajaId)
END
