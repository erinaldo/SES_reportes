USE [SES_ApatzinganV5]
GO
/****** Object:  StoredProcedure [dbo].[asp_DevolucionMayoreo_Select]    Script Date: 18/02/2019 10:48:23 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[asp_DevolucionMayoreo_Select]
	-- Add the parameters for the stored procedure here
	@FechaInicio varchar(20),
	@FechaFin varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        DevMay.DevolucionId
	, DevMay.CajaId
	, DevMay.TicketId
	, DevMay.UsuariosId
	, DevMay.Clienteid
	, DevMay.DevolucionFecha
	, DevMay.DevolucionSubtotal0
	, DevMay.DevolucionSubtotal16
	, DevMay.DevolucionIva
	, DevMay.DevolucionDescuento
	, DevMay.DevolucionTotal
	, DevMay.TicketTotalLetra
	, DevMay.DevolucionConcepto
	, DevMay.DevolucionAsignado
	, DevMay.CortesZRecibosId
	, DevMay.NC_Concepto
	FROM            DevolucionMayoreo AS DevMay
	where DevMay.DevolucionFecha between @FechaInicio and @FechaFin
	and DevMay.DevolucionId not in (
	SELECT        DevMayS.DevolucionId
	FROM  [SERVER-SON].[Server_Apatzingan].[dbo].[DevolucionMayoreo] AS DevMayS
	where DevMayS.DevolucionFecha between @FechaInicio and @FechaFin and DevMayS.CajaId=DevMay.CajaId)
	
END
