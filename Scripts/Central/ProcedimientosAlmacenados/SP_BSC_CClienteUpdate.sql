USE [Central]
GO
/****** Object:  StoredProcedure [dbo].[SP_BSC_CClienteUpdate]    Script Date: 25/08/2018 12:38:02 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF  EXISTS (SELECT * FROM SYS.OBJECTS WHERE TYPE = 'P' AND NAME = 'SP_BSC_CClienteUpdate')
DROP PROCEDURE SP_BSC_CClienteUpdate
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[SP_BSC_CClienteUpdate]
	-- Add the parameters for the stored procedure here
	@CClienteId decimal(11, 0),
	@CClienteNombre char(60),
	@CClienteFecha datetime,
	@CClienteActivo char(1),
	@CClientePadreId decimal(11, 0),
	@CClienteTieneElementos bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @correcto bit

	begin transaction T3;
	begin try
		UPDATE       CCliente
		SET                CClienteNombre = @CClienteNombre, CClienteFecha = @CClienteFecha, CClienteActivo = @CClienteActivo, CClientePadreId = @CClientePadreId, CClienteTieneElementos = @CClienteTieneElementos, 
                         FechaUpdate = GETDATE()
		WHERE        (CClienteId = @CClienteId)

		commit transaction T3;
		set @correcto=1
	end try
	begin catch
		rollback transaction T3;
		set @correcto=0
	end catch

	select @correcto resultado
END
