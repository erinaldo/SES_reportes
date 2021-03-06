USE [SES_ApatzinganV5]
GO
/****** Object:  StoredProcedure [dbo].[asp_DevolucionArticulo_Select]    Script Date: 18/02/2019 04:59:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[asp_DevolucionArticulo_Select]
	-- Add the parameters for the stored procedure here
	@FechaInicio varchar(20),
	@FechaFin varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DevArt.DevolucionId
      ,DevArt.CajaId
      ,DevArt.DevolucionArticuloUltimoIde
      ,DevArt.ArticuloCodigo
      ,DevArt.DevolucionArticuloPrecio
      ,DevArt.DevolucionArticuloCantidad
      ,DevArt.DevolucionArticuloSubtotal
      ,DevArt.DevolucionArticuloIva
      ,DevArt.DevolucionArticuloTotalLinea
	from DevolucionArticulo as DevArt
	inner join Devolucion as Dev
		on DevArt.DevolucionId=Dev.DevolucionId
			and DevArt.CajaId=Dev.CajaId
	where Dev.DevolucionFecha between @FechaInicio and @FechaFin
	and rtrim(DevArt.DevolucionId)+rtrim(DevArt.CajaId)+rtrim(DevArt.DevolucionArticuloUltimoIde) not in (
	SELECT rtrim(DevArtS.DevolucionId)+rtrim(DevArtS.CajaId)+rtrim(DevArtS.DevolucionArticuloUltimoIde)
 	from [SERVER-SON].[Server_Apatzingan].[dbo].[DevolucionArticulo] as DevArtS
	inner join [SERVER-SON].[Server_Apatzingan].[dbo].[Devolucion] as DevS
		on DevArtS.DevolucionId=DevS.DevolucionId
			and DevArtS.CajaId=DevS.CajaId
	where DevS.DevolucionFecha between @FechaInicio and @FechaFin and DevArt.CajaId=DevArtS.CajaId and DevArt.DevolucionArticuloUltimoIde=DevArtS.DevolucionArticuloUltimoIde)
END
