USE [SES_Sincroniza]
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizaClienteLocal_Select]    Script Date: 26/08/2018 07:45:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF  EXISTS (SELECT * FROM SYS.OBJECTS WHERE TYPE = 'P' AND NAME = 'SP_BSC_ActualizaClienteLocal_Select')
DROP PROCEDURE SP_BSC_ActualizaClienteLocal_Select
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[SP_BSC_ActualizaClienteLocal_Select]
	-- Add the parameters for the stored procedure here
	@FechaInicio varchar(20),
	@FechaFin varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select ClienteId,
      ClienteNombre,
      ClienteFecha,
      ClientePaterno,
      ClienteMaterno,
      ClienteRfc,
      ClienteCalle,
      ClienteNInterior,
      ClienteNExterior,
      ClienteColonia,
      LocalidadId,
      ClienteFechaActualizacion,
      ClienteTelefono1,
      ClienteTelefono2,
      ClienteTelefono3,
      ClienteEmail,
      ClienteEmailFiscal,
      ClienteTipoPersona,
      ClienteActivo,
      CClienteId,
      ClienteImpresion,
      ClienteLimiteCredito,
      ClienteSobregiro,
      VendedorId,
      CondicionesPagosId,
      ClienteTieneCredito,
      ClienteDescuento,
      ClienteObservaciones,
      ClienteSaldoActual
	from SES_AdministradorV1.dbo.Cliente
	where ClienteFechaActualizacion between @FechaInicio and @FechaFin
END
