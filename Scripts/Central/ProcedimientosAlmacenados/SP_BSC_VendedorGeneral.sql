USE Central
GO
-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF  EXISTS (SELECT * FROM SYS.OBJECTS WHERE TYPE = 'P' AND NAME = 'SP_BSC_VendedorGeneral')
DROP PROCEDURE SP_BSC_VendedorGeneral
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE SP_BSC_VendedorGeneral
	-- Add the parameters for the stored procedure here
	@VendedorId decimal(11, 0),
	@VendedorNombre char(60),
	@VendedorApellidos char(100),
	@VendedorActivo char(1),
	@VendedorNombreCompleto nvarchar(160)
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
		select @Existe = count(VendedorId) from Vendedor a where (a.VendedorId=@VendedorId)

		if @Existe>0
			Exec dbo.SP_BSC_VendedorUpdate @VendedorId,
				@VendedorNombre,
				@VendedorApellidos,
				@VendedorActivo,
				@VendedorNombreCompleto;
		else
			Exec dbo.SP_BSC_VendedorInsert @VendedorId,
				@VendedorNombre,
				@VendedorApellidos,
				@VendedorActivo,
				@VendedorNombreCompleto;
	commit transaction T1;
		set @correcto=1
	end try
	begin catch
		rollback transaction T1;
		set @correcto=0
	end catch

	select @correcto resultado
END
GO
