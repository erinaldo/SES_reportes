USE [SES_ApatzinganV5]
GO
/****** Object:  StoredProcedure [dbo].[asp_RecibosRemisiones_Select]    Script Date: 18/02/2019 12:42:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[asp_RecibosRemisiones_Select]
	-- Add the parameters for the stored procedure here
	@FechaInicio varchar(20),
	@FechaFin varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select RR.RecibosId
      ,RR.TicketId
      ,RR.CajaId
      ,RR.RecibosTotal
      ,RR.ReciboTotalLetra
      ,RR.ReciboFecha
      ,RR.ClienteId
      ,RR.UsuariosId
      ,RR.DocumentosId
      ,RR.ReciboConcepto
      ,RR.CortesZRecibosId
      ,RR.FormasdePagoCobranzaId
      ,RR.RecibosAsignado
	from RecibosRemisiones as RR
	where RR.ReciboFecha between @FechaInicio and @FechaFin
	and RR.RecibosId not in (
	select RRS.RecibosId
	from [SERVER-SON].[Server_Apatzingan].[dbo].RecibosRemisiones as RRS
	where RRS.ReciboFecha between @FechaInicio and @FechaFin
	)
END
