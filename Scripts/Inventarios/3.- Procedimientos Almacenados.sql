
GO
/****** Object:  StoredProcedure [dbo].[Inventario_Ciego_FoliosDetalles1_Update]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventario_Ciego_FoliosDetalles1_Update]
	@InventarioCiegoFolio bigint,
	@InventarioCiegoCodigo varchar(40),
	@InventarioCiegoCantidadPrimerConteo int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @ArticuloCantidad int

	select @ArticuloCantidad=isnull(ArticuloCantidad,0)from Articulo
	where ArticuloCodigo=@InventarioCiegoCodigo

    -- Insert statements for procedure here
	UPDATE       InventarioCiegoDetalles
	SET                InventarioCiegoCantidadPrimerConteo = @InventarioCiegoCantidadPrimerConteo ,InventarioCiegoCantidad=@ArticuloCantidad,InventarioCiegoFechaPrimerConteo=GETDATE()
	WHERE        (InventarioCiegoFolio = @InventarioCiegoFolio) AND (InventarioCiegoCodigo = @InventarioCiegoCodigo)
END

GO
/****** Object:  StoredProcedure [dbo].[Inventario_Ciego_FoliosDetalles2_Update]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventario_Ciego_FoliosDetalles2_Update]
	@InventarioCiegoFolio bigint,
	@InventarioCiegoCodigo varchar(40),
	@InventarioCiegoCantidadSegundoConteo int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @ArticuloCantidad int

	select @ArticuloCantidad=isnull(ArticuloCantidad,0)from Articulo
	where ArticuloCodigo=@InventarioCiegoCodigo

    -- Insert statements for procedure here
	UPDATE       InventarioCiegoDetalles
	SET                InventarioCiegoCantidadSegundoConteo = @InventarioCiegoCantidadSegundoConteo ,InventarioCiegoCantidad=@ArticuloCantidad,InventarioCiegoFechaSegundoConteo=getdate()
	WHERE        (InventarioCiegoFolio = @InventarioCiegoFolio) AND (InventarioCiegoCodigo = @InventarioCiegoCodigo)
END

GO
/****** Object:  StoredProcedure [dbo].[Inventario_Ciego_FoliosDetalles3_Update]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventario_Ciego_FoliosDetalles3_Update]
	@InventarioCiegoFolio bigint,
	@InventarioCiegoCodigo varchar(40),
	@InventarioCiegoCantidadContraloria int,
	@InventarioCiegoEntrada int,
	@InventarioCiegoSalida int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @ArticuloCantidad int

	select @ArticuloCantidad=isnull(ArticuloCantidad,0)from Articulo
	where ArticuloCodigo=@InventarioCiegoCodigo

    -- Insert statements for procedure here
	UPDATE       InventarioCiegoDetalles
	SET                InventarioCiegoCantidadContraloria = @InventarioCiegoCantidadContraloria ,InventarioCiegoCantidadSistema=@ArticuloCantidad,InventarioCiegoFechaContraloria=getdate(),
					   InventarioCiegoEntrada=@InventarioCiegoEntrada, InventarioCiegoSalida=@InventarioCiegoSalida
	WHERE        (InventarioCiegoFolio = @InventarioCiegoFolio) AND (InventarioCiegoCodigo = @InventarioCiegoCodigo)
END

GO
/****** Object:  StoredProcedure [dbo].[Inventario_Ciego_MarcaCodigo_Update]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventario_Ciego_MarcaCodigo_Update]
	@InventarioCiegoCodigo char(40)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE       Articulo
	SET                ArticuloInventario = 1
	WHERE        (ArticuloCodigo = @InventarioCiegoCodigo)
END

GO
/****** Object:  StoredProcedure [dbo].[Inventarios_ArticuloBuscar_Select]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_ArticuloBuscar_Select]
	@ArticuloDescripcion varchar(200),
	@Registros int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select Top(@Registros) ROW_NUMBER() OVER(ORDER BY ArticuloDescripcion ASC) AS Registro, rtrim(Articulocodigo) as Articulocodigo,rtrim(ArticuloDescripcion) as ArticuloDescripcion,rtrim(FamiliaNombre)as FamiliaNombre
	from Articulo as art
	inner join Familia as Fam on Fam.FamiliaId = Art.FamiliaId
	where (art.ArticuloDescripcion like '%'+@ArticuloDescripcion+'%' or isnull(@ArticuloDescripcion,'')='')
END


GO
/****** Object:  StoredProcedure [dbo].[Inventarios_ArticuloCodigoBuscar_Select]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_ArticuloCodigoBuscar_Select]
	@ArticuloCodigo varchar(40)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT      rtrim(art.ArticuloCodigo) as ArticuloCodigo, rtrim(ArticuloDescripcion)as ArticuloDescripcion, ArticuloUltimoCosto, ArticuloCostoReposicion, ArticuloCostoPromedio, pred.DetallesPreciosVenta,pred.DetallesPreciosVentaImporte,
	isnull((select  CosAd.ArticuloCosteoAdquisicion from 
	(Select isnull(ac.ArticuloCosteoAdquisicion,0)as ArticuloCosteoAdquisicion,max(ac.ArticuloCosteoFecha)as Fecha from ArticuloCosteo as ac
	where ac.ArticuloCodigo=@ArticuloCodigo
	group by ac.ArticuloCosteoAdquisicion)as  CosAd),0)as CostoAdquisicion
	FROM          Articulo as art
	inner join Precios as pre on art.ArticuloCodigo= pre.ArticuloCodigo
	inner join PreciosDetalles as pred on pre.PreciosId= pred.PreciosId and pred.TarifaId=1
	where art.ArticuloCodigo=@ArticuloCodigo
END


GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Ciego_AleatorioFoliosDetalles_Select]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[Inventarios_Ciego_AleatorioFoliosDetalles_Select]
	@InventarioCiegoFolio	bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT ROW_NUMBER() OVER(ORDER BY ArticuloDescripcion ASC) AS Numero, InventarioCiegoFolio, InventarioCiegoCodigo as ArticuloCodigo,rtrim(ArticuloDescripcion)as ArticuloDescripcion,rtrim(FamiliaNombre) as FamiliaNombre, InventarioCiegoCantidad, InventarioCiegoFechaPrimerConteo , InventarioCiegoCantidadPrimerConteo as PrimerConteo, InventarioCiegoFechaSegundoConteo , 
                         InventarioCiegoCantidadSegundoConteo as SegundoConteo, InventarioCiegoFechaContraloria, InventarioCiegoCantidadSistema, InventarioCiegoCantidadContraloria
FROM            InventarioCiegoDetalles as invdet
inner join Articulo as art on art.ArticuloCodigo=invdet.InventarioCiegoCodigo
inner join Familia as fam on art.FamiliaId = fam.FamiliaId
WHERE        (InventarioCiegoFolio = @InventarioCiegoFolio) and art.ArticuloCantidad = invdet.InventarioCiegoCantidadSegundoConteo
END

GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Ciego_Buscar_Folios_Select]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_Ciego_Buscar_Folios_Select]
	@EEstatus varchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @x INT = 0
	DECLARE @firstcomma INT = 0
	DECLARE @nextcomma INT = 0
	DECLARE @TEstatus TABLE (id VARCHAR(50))

	SET @x = LEN(@EEstatus) - LEN(REPLACE(@EEstatus, ',', '')) + 1 

	WHILE @x > 0
    BEGIN
        SET @nextcomma = CASE WHEN CHARINDEX(',', @EEstatus, @firstcomma + 1) = 0
                              THEN LEN(@EEstatus) + 1
                              ELSE CHARINDEX(',', @EEstatus, @firstcomma + 1)
                         END
        INSERT  INTO @TEstatus
        VALUES  ( SUBSTRING(@EEstatus, @firstcomma + 1, (@nextcomma - @firstcomma) - 1) )
        SET @firstcomma = CHARINDEX(',', @EEstatus, @firstcomma + 1)
        SET @x = @x - 1
    END

	SELECT InventarioCiegoFolio, InventarioCiegoFecha, InventarioCiegoEstatus
	FROM   InventarioCiego
	where InventarioCiegoEstatus IN (SELECT * FROM @TEstatus) or len(@EEstatus)=0
END

GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Ciego_EnviadoFolios_Select]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_Ciego_EnviadoFolios_Select]
	@InventarioCiegoFolio bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	
	SELECT        inv.InventarioCiegoFolio, inv.InventarioCiegoFecha, inv.InventarioCiegoEstatus, suc.SucursalesId, suc.SucursalesNombre, inv.InventarioCiegoFinalizacion
	FROM            InventarioCiego AS inv INNER JOIN
							 Sucursales AS suc ON suc.SucursalesId = inv.SucursalesId
	WHERE        (inv.InventarioCiegoFolio = @InventarioCiegoFolio)

	


END

GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Ciego_EnviadoFoliosDetalles_Select]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_Ciego_EnviadoFoliosDetalles_Select]
	@InventarioCiegoFolio	bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT ROW_NUMBER() OVER(ORDER BY ArticuloDescripcion ASC) AS Numero, InventarioCiegoFolio, InventarioCiegoCodigo as ArticuloCodigo,rtrim(ArticuloDescripcion)as ArticuloDescripcion,rtrim(FamiliaNombre) as FamiliaNombre, InventarioCiegoCantidad, InventarioCiegoFechaPrimerConteo , InventarioCiegoCantidadPrimerConteo as PrimerConteo, InventarioCiegoFechaSegundoConteo , 
                         InventarioCiegoCantidadSegundoConteo as SegundoConteo, InventarioCiegoFechaContraloria, InventarioCiegoCantidadSistema, InventarioCiegoCantidadContraloria,InventarioCiegoAleatorio
FROM            InventarioCiegoDetalles as invdet
inner join Articulo as art on art.ArticuloCodigo=invdet.InventarioCiegoCodigo
inner join Familia as fam on art.FamiliaId = fam.FamiliaId
WHERE        (InventarioCiegoFolio = @InventarioCiegoFolio) and (art.ArticuloCantidad <> invdet.InventarioCiegoCantidadSegundoConteo or invdet.InventarioCiegoAleatorio=1)
END

GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Ciego_Folios_Insert]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_Ciego_Folios_Insert]
	@SucursalesId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @Folio bigint
	select @Folio=isnull(max(InventarioCiegoFolio),0)+1 from InventarioCiego
	
	INSERT INTO InventarioCiego
		  (InventarioCiegoFolio, InventarioCiegoFecha, InventarioCiegoEstatus,SucursalesId)
	VALUES(@Folio, GETDATE(), 'Iniciado',@SucursalesId)

	select @Folio as Folio


END

GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Ciego_Folios_Select]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_Ciego_Folios_Select]
	@InventarioCiegoFolio bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	
	SELECT        InventarioCiegoFolio, InventarioCiegoFecha, InventarioCiegoEstatus,suc.SucursalesId,suc.SucursalesNombre
	FROM            InventarioCiego as inv
	inner join Sucursales as suc on suc.SucursalesId=inv.SucursalesId
	WHERE        (InventarioCiegoFolio = @InventarioCiegoFolio)

	


END

GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Ciego_Folios_Update]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_Ciego_Folios_Update]
	@InventarioCiegoFolio int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	UPDATE       InventarioCiego
	SET                InventarioCiegoEstatus = 'Enviado'
	WHERE        (InventarioCiegoFolio = @InventarioCiegoFolio)
END

GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Ciego_FoliosDetalles_Aleatorio_Update]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_Ciego_FoliosDetalles_Aleatorio_Update]
	@InventarioCiegoFolio	bigint,
	@InventarioCiegoCodigo	char(40)	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE       InventarioCiegoDetalles
SET                InventarioCiegoAleatorio = 1
WHERE        (InventarioCiegoFolio = @InventarioCiegoFolio) AND (InventarioCiegoCodigo = @InventarioCiegoCodigo)
END

GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Ciego_FoliosDetalles_Finalizado_Select]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_Ciego_FoliosDetalles_Finalizado_Select]
	@InventarioCiegoFolio	bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT ROW_NUMBER() OVER(ORDER BY ArticuloDescripcion ASC) AS Numero, InventarioCiegoFolio, rtrim(InventarioCiegoCodigo) as ArticuloCodigo,rtrim(ArticuloDescripcion)as ArticuloDescripcion,rtrim(FamiliaNombre) as FamiliaNombre, InventarioCiegoCantidad, InventarioCiegoFechaPrimerConteo , InventarioCiegoCantidadPrimerConteo as PrimerConteo, InventarioCiegoFechaSegundoConteo , 
                         InventarioCiegoCantidadSegundoConteo as SegundoConteo, InventarioCiegoFechaContraloria, InventarioCiegoCantidadSistema, InventarioCiegoCantidadContraloria,InventarioCiegoEntrada,InventarioCiegoSalida
FROM            InventarioCiegoDetalles as invdet
inner join Articulo as art on art.ArticuloCodigo=invdet.InventarioCiegoCodigo
inner join Familia as fam on art.FamiliaId = fam.FamiliaId
WHERE        (InventarioCiegoFolio = @InventarioCiegoFolio) and (InventarioCiegoEntrada>0 or InventarioCiegoSalida>0)
END

GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Ciego_FoliosDetalles_Inicio_Select]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[Inventarios_Ciego_FoliosDetalles_Inicio_Select]
	@InventarioCiegoFolio	bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT ROW_NUMBER() OVER(ORDER BY ArticuloDescripcion ASC) AS Numero, InventarioCiegoFolio, rtrim(InventarioCiegoCodigo) as ArticuloCodigo,rtrim(ArticuloDescripcion)as ArticuloDescripcion,rtrim(FamiliaNombre) as FamiliaNombre, InventarioCiegoCantidad, InventarioCiegoFechaPrimerConteo , InventarioCiegoCantidadPrimerConteo as PrimerConteo, InventarioCiegoFechaSegundoConteo , 
                         InventarioCiegoCantidadSegundoConteo as SegundoConteo, InventarioCiegoFechaContraloria, InventarioCiegoCantidadSistema, InventarioCiegoCantidadContraloria,InventarioCiegoEntrada,InventarioCiegoSalida
FROM            InventarioCiegoDetalles as invdet
inner join Articulo as art on art.ArticuloCodigo=invdet.InventarioCiegoCodigo
inner join Familia as fam on art.FamiliaId = fam.FamiliaId
WHERE        (InventarioCiegoFolio = @InventarioCiegoFolio)
END

GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Ciego_FoliosDetalles_Insert]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_Ciego_FoliosDetalles_Insert]
	@InventarioCiegoFolio	bigint,
	@InventarioCiegoCodigo	char(40),
	@InventarioCiegoCantidad	int,
	@InventarioCiegoCantidadPrimerConteo	int,
	@InventarioCiegoCantidadSegundoConteo	int,
	@InventarioCiegoCantidadSistema	int,
	@InventarioCiegoCantidadContraloria	int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO InventarioCiegoDetalles
               (InventarioCiegoFolio, InventarioCiegoCodigo, InventarioCiegoCantidad, InventarioCiegoFechaPrimerConteo, InventarioCiegoCantidadPrimerConteo, InventarioCiegoFechaSegundoConteo, 
                InventarioCiegoCantidadSegundoConteo, InventarioCiegoFechaContraloria, InventarioCiegoCantidadSistema, InventarioCiegoCantidadContraloria,InventarioCiegoEntrada,InventarioCiegoSalida,InventarioCiegoAleatorio)
	VALUES     (@InventarioCiegoFolio,@InventarioCiegoCodigo,@InventarioCiegoCantidad, GETDATE(),@InventarioCiegoCantidadPrimerConteo, GETDATE(),@InventarioCiegoCantidadSegundoConteo, 
               GETDATE(),@InventarioCiegoCantidadSistema,@InventarioCiegoCantidadContraloria,0,0,0)
END

GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Ciego_FoliosDetalles_Select]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_Ciego_FoliosDetalles_Select]
	@InventarioCiegoFolio	bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT ROW_NUMBER() OVER(ORDER BY ArticuloDescripcion ASC) AS Numero, InventarioCiegoFolio, rtrim(InventarioCiegoCodigo) as ArticuloCodigo,rtrim(ArticuloDescripcion)as ArticuloDescripcion,rtrim(FamiliaNombre) as FamiliaNombre, InventarioCiegoCantidad, InventarioCiegoFechaPrimerConteo , InventarioCiegoCantidadPrimerConteo as PrimerConteo, InventarioCiegoFechaSegundoConteo , 
                         InventarioCiegoCantidadSegundoConteo as SegundoConteo, InventarioCiegoFechaContraloria, InventarioCiegoCantidadSistema, InventarioCiegoCantidadContraloria,InventarioCiegoEntrada,InventarioCiegoSalida
FROM            InventarioCiegoDetalles as invdet
inner join Articulo as art on art.ArticuloCodigo=invdet.InventarioCiegoCodigo
inner join Familia as fam on art.FamiliaId = fam.FamiliaId
WHERE        (InventarioCiegoFolio = @InventarioCiegoFolio) and (InventarioCiegoAleatorio=1 or InventarioCiegoCantidad<>InventarioCiegoCantidadSegundoConteo)
END

GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Ciego_FoliosIniciados_Select]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_Ciego_FoliosIniciados_Select]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select * from InventarioCiego
	where InventarioCiegoEstatus in ('Iniciado','Capturado')
END

GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Ciego_FoliosStatus_Update]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_Ciego_FoliosStatus_Update]
	@InventarioCiegoFolio int,
	@Status varchar(30)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	UPDATE       InventarioCiego
	SET                InventarioCiegoEstatus = @Status
	WHERE        (InventarioCiegoFolio = @InventarioCiegoFolio)

	if @Status = 'Finalizado'
	begin
		UPDATE       InventarioCiego
		SET          InventarioCiegoFinalizacion = GETDATE()
		WHERE        (InventarioCiegoFolio = @InventarioCiegoFolio)
	end
END

GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Config_ArticulosExitencia_Select]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_Config_ArticulosExitencia_Select]
	@InventarioCiegoCodigo varchar(40)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select ArticuloCantidad from Articulo
	where ArticuloCodigo=@InventarioCiegoCodigo
END

GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Config_ArticulosPendientes_Select]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_Config_ArticulosPendientes_Select]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select ROW_NUMBER() OVER(ORDER BY ArticuloDescripcion ASC) AS Numero,rtrim(ArticuloCodigo) as ArticuloCodigo, rtrim(ArticuloDescripcion) as ArticuloDescripcion, ArticuloCantidad,rtrim(fam.FamiliaNombre) as FamiliaNombre,0 as PrimerConteo, 0 as SegundoConteo
	from Articulo as art
	inner join Familia as fam on art.FamiliaId = fam.FamiliaId
	where (articuloactivo ='A' or ArticuloCantidad >0) and  ArticuloInventario= 0
END

GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Config_CajasSelect]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_Config_CajasSelect]
	@SucursalesId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        CajaId, CajaDescripcion
	FROM            Caja
	where SucursalesId=@SucursalesId
END

GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Config_CalculaAvance_Select]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_Config_CalculaAvance_Select]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select count(*) as TotalArticulos,(Select count(*) from articulo where articuloinventario = 1) as TotalArticulosInventario from Articulo
	where articuloactivo ='A' or ArticuloCantidad >0
END

GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Config_InicializaInventario_Select]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_Config_InicializaInventario_Select]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Update Articulo set ArticuloInventario = 0
END

GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Config_Parametros_Select]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_Config_Parametros_Select]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT        ISNULL(InventarioCiegoRotacion, 0) AS InventarioCiegoRotacion,ISNULL(InventarioCiegoPeriodo, 0) AS InventarioCiegoPeriodo, ISNULL(InventarioCiegoActivos, 0) AS InventarioCiegoActivos, ISNULL(InventarioCiegoArticulosDias, 0) AS InventarioCiegoArticulosDias, 
                         ISNULL(InventarioCiegoFoliosEnviados, 0) AS InventarioCiegoFoliosEnviados, ISNULL(InventarioCiegoGeneraFolios, 0) AS InventarioCiegoGeneraFolios, InventarioRutaArchivosPDF, isnull(InventarioCiegoCodigosAleatorios,0) as InventarioCiegoCodigosAleatorios
FROM            InventarioCiegoConfig
END

GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Config_ParametrosUpdate]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_Config_ParametrosUpdate]
	@InventarioCiegoRotacion int,
	@InventarioCiegoPeriodo int,
	@InventarioCiegoActivos int,
	@InventarioCiegoArticulosDias int,
	@InventarioCiegoFoliosEnviados int,
	@InventarioCiegoCodigosAleatorios int,
	@InventarioCiegoGeneraFolios bit,
	@InventarioRutaArchivosPDF varchar(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE       InventarioCiegoConfig
SET                InventarioCiegoRotacion = @InventarioCiegoRotacion,InventarioCiegoPeriodo = @InventarioCiegoPeriodo, InventarioCiegoActivos = @InventarioCiegoActivos, InventarioCiegoArticulosDias = @InventarioCiegoArticulosDias, 
                         InventarioCiegoFoliosEnviados = @InventarioCiegoFoliosEnviados, InventarioCiegoGeneraFolios = @InventarioCiegoGeneraFolios, InventarioRutaArchivosPDF = @InventarioRutaArchivosPDF, 
                         InventarioCiegoCodigosAleatorios = @InventarioCiegoCodigosAleatorios
END

GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Config_SucursalesSelect]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_Config_SucursalesSelect]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        SucursalesId, rtrim(SucursalesNombre) as SucursalesNombre
	FROM            Sucursales
	order by SucursalesId
END


GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Entradas_Articulos_Insert]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Inventarios_Entradas_Articulos_Insert]
	@EntradasMercanciaId	bigint,
	@SucursalesId	bigint,
	@EntradasMercanciaArticuloUltimoIde	bigint,
	@ArticuloCodigo	char(40),
	@EntradasMercanciaArticuloCantidad	bigint,
	@EntradasMercanciaArticuloSub0	decimal(18, 2),
	@EntradasMercanciaArticuloSub16	decimal(18, 2),
	@EntradasMercanciaArticuloIva	decimal(18, 2),
	@EntradasMercanciaArticuloTotal	decimal(18, 2)
	
AS
BEGIN
	SET NOCOUNT ON;
INSERT INTO EntradaMercanciaArticulo
                      (EntradasMercanciaId, SucursalesId, EntradasMercanciaArticuloUltimoIde, ArticuloCodigo, EntradasMercanciaArticuloCantidad, EntradasMercanciaArticuloSub0, 
                      EntradasMercanciaArticuloSub16, EntradasMercanciaArticuloIva, EntradasMercanciaArticuloTotal)
VALUES     (@EntradasMercanciaId,@SucursalesId,@EntradasMercanciaArticuloUltimoIde,@ArticuloCodigo,@EntradasMercanciaArticuloCantidad,@EntradasMercanciaArticuloSub0,@EntradasMercanciaArticuloSub16,@EntradasMercanciaArticuloIva,@EntradasMercanciaArticuloTotal)
END


GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Entradas_Articulos_Select]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Inventarios_Entradas_Articulos_Select]
	@EntradasMercanciaId bigint,
	@SucursalesId decimal(11,0)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT   EntradaMercanciaArticulo.EntradasMercanciaId,  EntradaMercanciaArticulo.EntradasMercanciaArticuloUltimoIde as Numero, rtrim(EntradaMercanciaArticulo.ArticuloCodigo) as ArticuloCodigo, rtrim(Articulo.ArticuloDescripcion) as ArticuloDescripcion, 
                      EntradaMercanciaArticulo.EntradasMercanciaArticuloCantidad as ArticuloCantidad, EntradaMercanciaArticulo.EntradasMercanciaArticuloSub0 as ArticuloSub0, 
                      EntradaMercanciaArticulo.EntradasMercanciaArticuloSub16 as ArticuloSub16, EntradaMercanciaArticulo.EntradasMercanciaArticuloIva as ArticuloIva, 
                      EntradaMercanciaArticulo.EntradasMercanciaArticuloTotal as ArticuloTotalLinea, 
					  (EntradaMercanciaArticulo.EntradasMercanciaArticuloSub0 +
                      EntradaMercanciaArticulo.EntradasMercanciaArticuloSub16) as ArticuloTotal,isnull(EntradaMercanciaCosto.ArticuloCostoReposicion,0)as ArticuloCostoReposicion,isnull(EntradaMercanciaCosto.ArticuloCostoAdquisicion,0)as ArticuloCostoAdquisicion
FROM         EntradaMercanciaArticulo 
INNER JOIN Articulo ON EntradaMercanciaArticulo.ArticuloCodigo = Articulo.ArticuloCodigo
LEFT JOIN EntradaMercanciaCosto on EntradaMercanciaCosto.ArticuloCodigo = Articulo.ArticuloCodigo and EntradaMercanciaArticulo.EntradasMercanciaArticuloUltimoIde = EntradaMercanciaCosto.EntradasMercanciaArticuloUltimoIde
WHERE     (EntradaMercanciaArticulo.EntradasMercanciaId = @EntradasMercanciaId) AND (EntradaMercanciaArticulo.SucursalesId = @SucursalesId)
ORDER BY EntradaMercanciaArticulo.EntradasMercanciaArticuloUltimoIde
END


GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Entradas_ArticulosCosto_Insert]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_Entradas_ArticulosCosto_Insert]
	@EntradasMercanciaId	bigint,
	@ArticuloCodigo	char(40),
	@EntradasMercanciaArticuloUltimoIde	bigint,
	@EntradasMercanciaArticuloCantidad	bigint,
	@ArticuloCostoReposicion	decimal(18, 2),
	@ArticuloCostoAdquisicion	decimal(18, 2)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO EntradaMercanciaCosto
                         (EntradasMercanciaId, ArticuloCodigo,EntradasMercanciaArticuloUltimoIde, EntradasMercanciaArticuloCantidad, ArticuloCostoReposicion)
VALUES        (@EntradasMercanciaId,@ArticuloCodigo,@EntradasMercanciaArticuloUltimoIde,@EntradasMercanciaArticuloCantidad,@ArticuloCostoReposicion)
END


GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Entradas_Buscar_Select]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_Entradas_Buscar_Select]
	@EntradaMercanciaId varchar(200),
	@Registros int,
	@FechaInicio varchar(20),
	@FechaFin varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select Top(@Registros) ROW_NUMBER() OVER(ORDER BY EntradaMercanciaId ASC) AS Registro, ent.EntradaMercanciaId,entt.EntradaMercanciaTipoDescripcion,ent.EntradaMercanciaUnidades, ent.EntradaMercanciaFecha
	from EntradaMercancia as ent
	inner join EntradaMercanciaTipo as entt on ent.EntradaMercanciaTipoId=entt.EntradaMercanciaTipoId
	where (ent.EntradaMercanciaId like '%'+@EntradaMercanciaId+'%' or isnull(@EntradaMercanciaId,'')='')
	and (ent.EntradaMercanciaFecha between @FechaInicio and @FechaFin)
END


GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Entradas_ExistenciaSelect]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_Entradas_ExistenciaSelect]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select rtrim(ArticuloCodigo) as ArticuloCodigo,rtrim(ArticuloDescripcion)as ArticuloDescripcion,ArticuloCantidad from Articulo
	where ArticuloCantidad >0
	Order by 2
END

GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Entradas_Insert]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Inventarios_Entradas_Insert]
	@SucursalesId	bigint,
	@UsuariosId	decimal(11, 0),
	@EntradaMercanciaTipoId	bigint,
	@EntradaMercanciaUnidades	bigint,
	@EntradaMercanciaSub0	decimal(18, 2),
	@EntradaMercanciaSub16	decimal(18, 2),
	@EntradaMercanciaIva	decimal(18, 2),
	@EntradaMercanciaTotal	decimal(18, 2),
	@Observaciones	nvarchar(MAX),
	@Referencias	nvarchar(MAX)
	
AS
BEGIN
	SET NOCOUNT ON;
	declare @EntradaMercanciaId bigint
	select @EntradaMercanciaId = isnull(max(EntradaMercanciaId),0) +1 from EntradaMercancia

	INSERT INTO EntradaMercancia
                (EntradaMercanciaId, SucursalesId, UsuariosId, EntradaMercanciaTipoId, EntradaMercanciaFecha, EntradaMercanciaUnidades, EntradaMercanciaSub0, 
                EntradaMercanciaSub16, EntradaMercanciaIva, EntradaMercanciaTotal, Observaciones, Referencias)
	VALUES     (@EntradaMercanciaId,@SucursalesId,@UsuariosId,@EntradaMercanciaTipoId,getdate(),@EntradaMercanciaUnidades,@EntradaMercanciaSub0,
				@EntradaMercanciaSub16,@EntradaMercanciaIva,@EntradaMercanciaTotal,@Observaciones,@Referencias)
	
	select @EntradaMercanciaId as EntradaMercanciaId

END


GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Entradas_Select]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Inventarios_Entradas_Select]
	 @EntradaMercanciaId bigint,
	 @SucursalesId decimal(11,0)
AS
BEGIN
	SET NOCOUNT ON;
SELECT    EntradaMercanciaId,suc.SucursalesNombre , ent.UsuariosId,usu.UsuariosNombre, ent.EntradaMercanciaTipoId,tipo.EntradaMercanciaTipoDescripcion, EntradaMercanciaFecha, EntradaMercanciaUnidades, EntradaMercanciaSub0, EntradaMercanciaSub16, EntradaMercanciaIva, 
                      EntradaMercanciaTotal, Observaciones, Referencias
FROM         EntradaMercancia as ent
inner join Usuarios as usu on usu.UsuariosId = ent.UsuariosId
inner join EntradaMercanciaTipo as tipo on ent.EntradaMercanciaTipoId= tipo.EntradaMercanciaTipoId
inner join Sucursales as suc on suc.SucursalesId=ent.SucursalesId
WHERE     (EntradaMercanciaId = @EntradaMercanciaId) AND (suc.SucursalesId = @SucursalesId)
END


GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Entradas_TipoEntradaSelect]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_Entradas_TipoEntradaSelect]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT EntradaMercanciaTipoDescripcion as TipoDescripcion, EntradaMercanciaTipoId as TipoId
	FROM   EntradaMercanciaTipo
END

GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Entradas_UsuarioResponsableSelect]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_Entradas_UsuarioResponsableSelect]
	@UsuariosLogin varchar(40)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT us.UsuariosId,us.UsuariosLogin, RTRIM(us.UsuariosNombre) AS UsuariosNombre
	FROM Usuarios us
	where UsuariosLogin=@UsuariosLogin
	order by 1
END

GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Usuarios_Accesos_Select]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_Usuarios_Accesos_Select]
	@UsuariosLogin varchar(60),
	@InventarioPantallaId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        Usuarios.UsuariosLogin, InventarioPantallaUsuario.InventarioPantallaId
	FROM            InventarioPantallaUsuario INNER JOIN
							 Usuarios ON InventarioPantallaUsuario.UsuariosId = Usuarios.UsuariosId
	WHERE        (Usuarios.UsuariosLogin = @UsuariosLogin) AND (InventarioPantallaUsuario.InventarioPantallaId = @InventarioPantallaId)
END

GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Usuarios_Pantallas_Asignadas_Delete]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_Usuarios_Pantallas_Asignadas_Delete]
	@UsuariosId int,
	@InventarioPantallaId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM InventarioPantallaUsuario
	WHERE        (UsuariosId = @UsuariosId) AND (InventarioPantallaId = @InventarioPantallaId)
END

GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Usuarios_Pantallas_Asignadas_Select]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_Usuarios_Pantallas_Asignadas_Select]
	@UsuariosId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        InventarioPantalla.InventarioPantallaId, InventarioPantalla.InventarioPantallaNombre
	FROM            InventarioPantalla INNER JOIN
							 InventarioPantallaUsuario ON InventarioPantalla.InventarioPantallaId = InventarioPantallaUsuario.InventarioPantallaId
	WHERE        (InventarioPantallaUsuario.UsuariosId = @UsuariosId)
END

GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Usuarios_Pantallas_Disponibles_Insert]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_Usuarios_Pantallas_Disponibles_Insert]
	@UsuariosId int,
	@InventarioPantallaId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO InventarioPantallaUsuario
                         (UsuariosId, InventarioPantallaId)
VALUES        (@UsuariosId,@InventarioPantallaId)
END

GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Usuarios_Pantallas_Disponibles_Select]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_Usuarios_Pantallas_Disponibles_Select]
	@UsuariosId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        InventarioPantalla.InventarioPantallaId, InventarioPantalla.InventarioPantallaNombre--InventarioPantallaUsuario.UsuariosId
	FROM            InventarioPantalla 
	where  InventarioPantalla.InventarioPantallaId not in (select distinct InventarioPantallaId from InventarioPantallaUsuario where UsuariosId=@UsuariosId)
	
END

GO
/****** Object:  StoredProcedure [dbo].[Inventarios_Usuarios_Select]    Script Date: 13/08/2019 09:28:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventarios_Usuarios_Select]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	select UsuariosId,rtrim(ltrim(UsuariosNombre)) as UsuariosNombre from Usuarios
	where UsuariosActivo ='A' and len(UsuariosNombre)>0
	order by 2
END

GO
