USE [SES_ApatzinganV5]
GO
/****** Object:  StoredProcedure [dbo].[asp_SalidaMercancia_Select]    Script Date: 18/02/2019 12:48:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[asp_SalidaMercancia_Select]
	-- Add the parameters for the stored procedure here
	@FechaInicio varchar(20),
	@FechaFin varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT s.SalidaMercanciaId
      ,s.SucursalesId
      ,s.UsuariosId
      ,s.SalidaMercanciaTipoId
      ,s.SalidaMercanciaFecha
      ,s.SalidaMercanciaUnidades
      ,s.SalidaMercanciaSub0
      ,s.SalidaMercanciaSub16
      ,s.SalidaMercanciaIva
      ,s.SalidaMercanciaTotal
      ,s.Observaciones
      ,s.Referencias
      ,s.ParaSucursal
	from SalidaMercancia as s
	where SalidaMercanciaFecha between @FechaInicio and @FechaFin
	and s.SalidaMercanciaId not in (
	select sS.SalidaMercanciaId
	from [SERVER-SON].[Server_Apatzingan].[dbo].SalidaMercancia as sS
	where sS.SalidaMercanciaFecha between @FechaInicio and @FechaFin
	and s.SucursalesId=sS.SucursalesId
	)
END
