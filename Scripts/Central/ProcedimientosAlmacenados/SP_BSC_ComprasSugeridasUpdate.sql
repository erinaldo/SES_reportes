USE [Central]
GO
/****** Object:  StoredProcedure [dbo].[SP_BSC_ComprasSugeridasUpdate]    Script Date: 25/08/2018 12:42:16 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF  EXISTS (SELECT * FROM SYS.OBJECTS WHERE TYPE = 'P' AND NAME = 'SP_BSC_ComprasSugeridasUpdate')
DROP PROCEDURE SP_BSC_ComprasSugeridasUpdate
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[SP_BSC_ComprasSugeridasUpdate] 
	-- Add the parameters for the stored procedure here
	@Codigo char(40),
	@Descripcion char(200),
	@Centro int,
	@Morelos int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @correcto bit

	begin transaction T3;
	begin try
		UPDATE       ComprasSugeridas
		SET                Descripcion = @Descripcion, Centro = @Centro, Morelos = @Morelos, FechaUpdate = GETDATE()
		WHERE        (Codigo = @Codigo)

		commit  transaction T3;
		set @correcto=1
	end try
	begin catch
		rollback  transaction T3;
		set @correcto=0
	end catch

	select @correcto resultado
END
