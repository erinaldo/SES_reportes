USE [Central]
GO
/****** Object:  StoredProcedure [dbo].[SP_BSC_FamiliaGeneral]    Script Date: 25/08/2018 12:57:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF  EXISTS (SELECT * FROM SYS.OBJECTS WHERE TYPE = 'P' AND NAME = 'SP_BSC_FamiliaGeneral')
DROP PROCEDURE SP_BSC_FamiliaGeneral
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[SP_BSC_FamiliaGeneral] 
	-- Add the parameters for the stored procedure here
	@FamiliaId decimal(11, 0),
	@FamiliaNombre char(60),
	@FamiliaFecha datetime,
	@FamiliaTipo char(1),
	@FamiliaActivo char(1),
	@FamiliaPadreId decimal(11, 0),
	@IvaId decimal(11, 0),
	@Espadre bit,
	@TieneArticulos bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @correcto bit

	begin transaction T1;
	begin try

		declare @Existe int
		select @Existe = count(FamiliaId) from Familia a where (a.FamiliaId=@FamiliaId)

		if @Existe>0
			Exec dbo.SP_BSC_FamiliaUpdate @FamiliaId,
			@FamiliaNombre,
			@FamiliaFecha,
			@FamiliaTipo,
			@FamiliaActivo,
			@FamiliaPadreId,
			@IvaId,
			@Espadre,
			@TieneArticulos;
		else
			Exec dbo.SP_BSC_FamiliaInsert @FamiliaId,
			@FamiliaNombre,
			@FamiliaFecha,
			@FamiliaTipo,
			@FamiliaActivo,
			@FamiliaPadreId,
			@IvaId,
			@Espadre,
			@TieneArticulos;
	commit transaction T1;
		set @correcto=1
	end try
	begin catch
		rollback transaction T1;
		set @correcto=0
	end catch

	select @correcto resultado
END
