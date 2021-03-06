USE [SES_ApatzinganV5]
GO
/****** Object:  StoredProcedure [dbo].[asp_CortesZRecargas_Select]    Script Date: 18/02/2019 09:22:53 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[asp_CortesZRecargas_Select]
	-- Add the parameters for the stored procedure here
	@FechaInicio varchar(20),
	@FechaFin varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        CortesZRecargasId, CajaId,CortesZRecargasFecha, UsuariosId, CortesZRecargasSub0, CortesZRecargasSub16, CortesZRecargasIva, CortesZRecargasTotal, FacturaGlobalFolio, CortesZRecargasFacturado, 
							 CortesZRecargasTotalCosto
	FROM            CortesZRecargas as czr
	WHERE        (CortesZRecargasFecha BETWEEN @FechaInicio AND @FechaFin)
	and czr.CortesZRecargasId not in(SELECT czrS.CortesZRecargasId FROM [SERVER-SON].[Server_Apatzingan].[dbo].[CortesZRecargas] as czrS
    where czrS.CortesZRecargasFecha between @FechaInicio and @FechaFin and czrS.CajaId=czr.CajaId)
END
