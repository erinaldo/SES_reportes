
GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Ciego_EnviadoFoliosDetalles_Select]    Script Date: 17/09/2019 05:28:45 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[Inventarios_Ciego_EnviadoFoliosDetalles_Select]
	@InventarioCiegoFolio	bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT ROW_NUMBER() OVER(ORDER BY ArticuloDescripcion ASC) AS Numero, InventarioCiegoFolio, InventarioCiegoCodigo as ArticuloCodigo,rtrim(ArticuloDescripcion)as ArticuloDescripcion,rtrim(FamiliaNombre) as FamiliaNombre, InventarioCiegoCantidad, InventarioCiegoFechaPrimerConteo , InventarioCiegoCantidadPrimerConteo as PrimerConteo, InventarioCiegoFechaSegundoConteo , 
                         InventarioCiegoCantidadSegundoConteo as SegundoConteo, InventarioCiegoFechaContraloria, InventarioCiegoCantidadSistema, InventarioCiegoCantidadContraloria,InventarioCiegoAleatorio,invdet.InventarioCiegoEntrada,invdet.InventarioCiegoSalida
FROM            InventarioCiegoDetalles as invdet
inner join Articulo as art on art.ArticuloCodigo=invdet.InventarioCiegoCodigo
inner join Familia as fam on art.FamiliaId = fam.FamiliaId
WHERE        (InventarioCiegoFolio = @InventarioCiegoFolio) and (art.ArticuloCantidad <> invdet.InventarioCiegoCantidadSegundoConteo or invdet.InventarioCiegoAleatorio=1)
END

