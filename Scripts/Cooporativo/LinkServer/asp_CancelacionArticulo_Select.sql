USE [SES_ApatzinganV5]
GO
/****** Object:  StoredProcedure [dbo].[asp_CancelacionArticulo_Select]    Script Date: 18/02/2019 04:57:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[asp_CancelacionArticulo_Select]
	-- Add the parameters for the stored procedure here
	@FechaInicio varchar(20),
	@FechaFin varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT CanArt.CancelacionId
      ,CanArt.CajaId
      ,CanArt.CancelacionArticuloUltimoIde
      ,CanArt.TicketId
      ,CanArt.ArticuloCodigo
      ,CanArt.CancelacionArticuloPrecio
      ,CanArt.CancelacionArticuloCantidad
      ,CanArt.CancelacionArticuloSubtotal
      ,CanArt.CancelacionArticuloIva
      ,CanArt.CancelacionArticuloTotalLinea
	from CancelacionArticulo as CanArt
	inner join Cancelacion as Can
		on CanArt.CancelacionId=Can.CancelacionId
			and CanArt.CajaId=Can.CajaId
	where Can.CancelacionFecha between @FechaInicio and @FechaFin
	and rtrim(CanArt.CancelacionId)+rtrim(CanArt.CajaId)+rtrim(CanArt.CancelacionArticuloUltimoIde) not in(SELECT rtrim(CanArtS.CancelacionId)+rtrim(CanArtS.CajaId)+rtrim(CanArtS.CancelacionArticuloUltimoIde) FROM [SERVER-SON].[Server_Apatzingan].[dbo].[CancelacionArticulo] as CanArtS
	inner join [SERVER-SON].[Server_Apatzingan].[dbo].[Cancelacion] as CanS
		on CanArtS.CancelacionId=CanS.CancelacionId
			and CanArtS.CajaId=CanS.CajaId
    where CanS.CancelacionFecha between @FechaInicio and @FechaFin and CanS.CajaId=CanArt.CajaId and CanArt.CancelacionArticuloUltimoIde=CanArtS.CancelacionArticuloUltimoIde)
END
