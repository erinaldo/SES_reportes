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
IF  EXISTS (SELECT * FROM SYS.OBJECTS WHERE TYPE = 'P' AND NAME = 'SP_BSC_DevolucionPreDetalles_General')
DROP PROCEDURE SP_BSC_DevolucionPreDetalles_General
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE SP_BSC_DevolucionPreDetalles_General
	-- Add the parameters for the stored procedure here
	@DevolucionPreId bigint ,
	@ArticuloCodigo char(40) ,
	@DevolucionPreCantidad bigint ,
	@DevolucionPrePUnitarioSimp money ,
	@DevolucionPrePUnitarioCImp money ,
	@DevolucionPreTLinea money
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @Existe int
	declare @mensaje varchar(50)
	
	select @Existe = count(DevolucionPreId) from DevolucionPreDetalles a where (a.DevolucionPreId=@DevolucionPreId and  a.ArticuloCodigo=@ArticuloCodigo)
	if @Existe>0
			select 0;
		else
			INSERT INTO DevolucionPreDetalles
                         (DevolucionPreId, ArticuloCodigo, DevolucionPreCantidad, DevolucionPrePUnitarioSimp, DevolucionPrePUnitarioCImp, DevolucionPreTLinea, FechaInsert)
VALUES        (@DevolucionPreId,@ArticuloCodigo,@DevolucionPreCantidad,@DevolucionPrePUnitarioSimp,@DevolucionPrePUnitarioCImp,@DevolucionPreTLinea, GETDATE())
END
GO
