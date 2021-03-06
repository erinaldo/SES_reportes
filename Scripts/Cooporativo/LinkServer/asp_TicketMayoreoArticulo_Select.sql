USE [SES_ApatzinganV5]
GO
/****** Object:  StoredProcedure [dbo].[asp_TicketMayoreoArticulo_Select]    Script Date: 18/02/2019 05:08:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[asp_TicketMayoreoArticulo_Select]
	-- Add the parameters for the stored procedure here
	@FechaInicio varchar(20),
	@FechaFin varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TicMayArt.TicketId
      ,TicMayArt.CajaId
      ,TicMayArt.TicketArticuloUltimoIde
      ,TicMayArt.ArticuloCodigo
      ,TicMayArt.TarifaId
      ,TicMayArt.MedidasId
      ,TicMayArt.TicketArticuloCosto
      ,TicMayArt.TicketArticuloPrecio
      ,TicMayArt.TicketArticuloCantidad
      ,TicMayArt.TicketArticuloCantidadDevolucion
      ,TicMayArt.TicketArticuloCantidadCancelada
      ,TicMayArt.TicketArticuloSubtotal
      ,TicMayArt.TicketArticuloIva
      ,TicMayArt.TicketArticuloTotalLinea
      ,TicMayArt.TicketArticuloDescuento
      ,TicMayArt.TicketArticuloPrecioDescuento
      ,TicMayArt.TicketArticuloIvaDescuento
      ,TicMayArt.TicketArticuloTotal
	from TicketMayoreoArticulo as TicMayArt
	inner join TicketMayoreo as TicMay
		on TicMayArt.TicketId=TicMay.TicketId
			and TicMayArt.CajaId=TicMay.CajaId
	where TicMay.TicketFecha between @FechaInicio and @FechaFin
	and rtrim(TicMayArt.TicketId)+rtrim(TicMayArt.CajaId)+rtrim(TicMayArt.TicketArticuloUltimoIde) not in (
	SELECT rtrim(TicMayArtS.TicketId)+rtrim(TicMayArtS.CajaId)+rtrim(TicMayArtS.TicketArticuloUltimoIde)
      
	from [SERVER-SON].[Server_Apatzingan].[dbo].TicketMayoreoArticulo as TicMayArtS
	inner join [SERVER-SON].[Server_Apatzingan].[dbo].TicketMayoreo as TicMayS
		on TicMayArtS.TicketId=TicMayS.TicketId
			and TicMayArtS.CajaId=TicMayS.CajaId
	where TicMayS.TicketFecha between @FechaInicio and @FechaFin
	and TicMayArt.CajaId=TicMayArtS.CajaId
	and TicMayArt.TicketArticuloUltimoIde=TicMayArtS.TicketArticuloUltimoIde
	)
END
