-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF  EXISTS (SELECT * FROM SYS.OBJECTS WHERE TYPE = 'P' AND NAME = 'asp_TicketMayoreoArticulo_Select')
DROP PROCEDURE asp_TicketMayoreoArticulo_Select
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE asp_TicketMayoreoArticulo_Select
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
END
GO
