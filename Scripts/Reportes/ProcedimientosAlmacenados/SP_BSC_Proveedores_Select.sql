USE [SES_Reportes]
GO

/****** Object:  StoredProcedure [dbo].[SP_BSC_Proveedores_Select]    Script Date: 29/10/2018 11:46:25 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF  EXISTS (SELECT * FROM SYS.OBJECTS WHERE TYPE = 'P' AND NAME = 'SP_BSC_Proveedores_Select')
DROP PROCEDURE SP_BSC_Proveedores_Select
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_BSC_Proveedores_Select]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select ProveedorId, 'ProveedorNombre' = rtrim(ProveedorNombre) + ' ' + rtrim(ProveedorPaterno) + ' ' + rtrim(ProveedorMaterno) 
	from central.dbo.Proveedor
END

GO

