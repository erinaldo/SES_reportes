USE [SES_Sincroniza]
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizaCProveedorLocal_Select]    Script Date: 26/08/2018 07:54:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF  EXISTS (SELECT * FROM SYS.OBJECTS WHERE TYPE = 'P' AND NAME = 'SP_BSC_ActualizaCProveedorLocal_Select')
DROP PROCEDURE SP_BSC_ActualizaCProveedorLocal_Select
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[SP_BSC_ActualizaCProveedorLocal_Select]
	-- Add the parameters for the stored procedure here
	@FechaInicio varchar(20),
	@FechaFin varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select CProveedorId,
      CProveedorNombre,
      CProveedorFecha,
      CProveedorActivo,
      CProveedorPadreId,
      CProveedorTieneElementos
	from SES_AdministradorV1.dbo.CProveedor
	where CProveedorFecha between @FechaInicio and @FechaFin
END
