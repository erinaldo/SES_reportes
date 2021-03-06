USE [SES_ApatzinganV5]
GO
/****** Object:  StoredProcedure [dbo].[asp_Ticket_Select]    Script Date: 18/02/2019 01:44:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[asp_Ticket_Select]
	-- Add the parameters for the stored procedure here
	@FechaInicio varchar(20),
	@FechaFin varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT t.TicketId
      ,t.CajaId
      ,t.UsuarioId
      ,t.TicketFecha
      /*,TicketHora*/
      ,t.TicketSubtotal0
      ,t.TicketSubtotal16
      ,t.TicketIva
      ,t.TicketTotal
      ,t.CorteZId
	from Ticket as t
	where t.TicketFecha between @FechaInicio and @FechaFin
	and t.TicketId not in (
	SELECT tS.TicketId
	from [SERVER-SON].[Server_Apatzingan].[dbo].Ticket as tS
	where tS.TicketFecha between @FechaInicio and @FechaFin
	and tS.CajaId=t.CajaId
	)
END
