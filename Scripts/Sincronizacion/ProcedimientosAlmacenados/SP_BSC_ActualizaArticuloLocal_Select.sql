USE [SES_Sincroniza]
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizaArticuloLocal_Select]    Script Date: 26/08/2018 07:32:56 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF  EXISTS (SELECT * FROM SYS.OBJECTS WHERE TYPE = 'P' AND NAME = 'SP_BSC_ActualizaArticuloLocal_Select')
DROP PROCEDURE SP_BSC_ActualizaArticuloLocal_Select
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[SP_BSC_ActualizaArticuloLocal_Select]
	@FechaInicio varchar(20),
	@FechaFin varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select ArticuloCodigo,ArticuloDescripcion,ArticuloCostoReposicion,FamiliaId from SES_AdministradorV1.dbo.Articulo
	where ArticuloFechaUdp between @FechaInicio and @FechaFin
END
