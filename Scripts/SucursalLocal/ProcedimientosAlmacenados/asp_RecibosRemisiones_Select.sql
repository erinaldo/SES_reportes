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
IF  EXISTS (SELECT * FROM SYS.OBJECTS WHERE TYPE = 'P' AND NAME = 'asp_RecibosRemisiones_Select')
DROP PROCEDURE asp_RecibosRemisiones_Select
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE asp_RecibosRemisiones_Select
	-- Add the parameters for the stored procedure here
	@FechaInicio varchar(20),
	@FechaFin varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select RecibosId
      ,TicketId
      ,CajaId
      ,RecibosTotal
      ,ReciboTotalLetra
      ,ReciboFecha
      ,ClienteId
      ,UsuariosId
      ,DocumentosId
      ,ReciboConcepto
      ,CortesZRecibosId
      ,FormasdePagoCobranzaId
      ,RecibosAsignado
	from RecibosRemisiones
	where ReciboFecha between @FechaInicio and @FechaFin
END
GO
