USE [SES_ApatzinganV5]
GO
/****** Object:  StoredProcedure [dbo].[asp_CortesZRecibosDetalles_Select]    Script Date: 18/02/2019 10:34:02 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[asp_CortesZRecibosDetalles_Select]
	-- Add the parameters for the stored procedure here
	@FechaInicio varchar(20),
	@FechaFin varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        CRdet.CortesZRecibosId, CRdet.CortesZRecibosInicio, CRdet.CortesZRecibosFin, CRdet.CortesZNCreditoInicio, CRdet.CortesZNCreditoFin
	FROM            CortesZRecibosDetalles as CRdet
	left join CortesZRecibos as CR on CR.CortesZRecibosId=CRdet.CortesZRecibosId
	where CR.CortesZRecibosFecha between @FechaInicio and @FechaFin
	and CRdet.CortesZRecibosId not in (
	SELECT        CRdetS.CortesZRecibosId
	FROM  [SERVER-SON].[Server_Apatzingan].[dbo].[CortesZRecibosDetalles] as CRdetS
	left join [SERVER-SON].[Server_Apatzingan].[dbo].[CortesZRecibos] as CRS on CRS.CortesZRecibosId=CRdetS.CortesZRecibosId
	where CRS.CortesZRecibosFecha between @FechaInicio and @FechaFin)
END
