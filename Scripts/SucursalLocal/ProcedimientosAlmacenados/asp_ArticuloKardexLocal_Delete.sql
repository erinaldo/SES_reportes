USE [SES_CostaRicaV5]
GO
/****** Object:  StoredProcedure [dbo].[asp_ArticuloKardexLocal_Select]    Script Date: 10/02/2019 07:21:39 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[asp_ArticuloKardexLocal_Delete]
	@ArticuloCodigo varchar(40),
	@FechaExistencia varchar(60)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from ArticuloKardex
	where  CONVERT(date,FechaExistencia ,103)= convert(date, @FechaExistencia,103) and ArticuloCodigo=@ArticuloCodigo
end
