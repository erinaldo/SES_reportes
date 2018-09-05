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
IF  EXISTS (SELECT * FROM SYS.OBJECTS WHERE TYPE = 'P' AND NAME = 'SP_BSC_VendedorInsert')
DROP PROCEDURE SP_BSC_VendedorInsert
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE SP_BSC_VendedorInsert
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

	begin transaction T2;
	begin try
		INSERT INTO Vendedor
                         (VendedorId, VendedorNombre, VendedorApellidos, VendedorActivo, VendedorNombreCompleto, FechaInsert)
		VALUES        (@VendedorId,@VendedorNombre,@VendedorApellidos,@VendedorActivo,@VendedorNombreCompleto, GETDATE())

		commit transaction T2;
		set @correcto=1
	end try
	begin catch
		rollback transaction T2;
		set @correcto=0
	end catch

	select @correcto resultado
END
GO
