USE [SES_ApatzinganV5]
GO
/****** Object:  StoredProcedure [dbo].[asp_TicketMayoreo_Select]    Script Date: 18/02/2019 01:55:49 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[asp_TicketMayoreo_Select]
	-- Add the parameters for the stored procedure here
	@FechaInicio varchar(20),
	@FechaFin varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT tm.TicketId
      ,tm.CajaId
      ,tm.UsuarioId
      ,tm.TicketFecha
      ,tm.TicketSubtotal0
      ,tm.TicketSubtotal16
      ,tm.TicketIva
      ,tm.TicketTotal
      ,tm.CortesZRecibosId
      /*,FechaHora*/
      ,tm.ClienteId
	from TicketMayoreo as tm
	where tm.TicketFecha between @FechaInicio and @FechaFin
	and tm.TicketId not in (
	select tmS.TicketId
	from [SERVER-SON].[Server_Apatzingan].[dbo].TicketMayoreo as tmS
	where tmS.TicketFecha between @FechaInicio and @FechaFin
	and tm.CajaId=tmS.CajaId
	)
END
