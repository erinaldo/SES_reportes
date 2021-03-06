
GO
/****** Object:  Table [dbo].[RPT_VentaAcumuladaIncremento]    Script Date: 26/01/2019 10:19:20 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RPT_VentaAcumuladaIncremento](
	[IdParametro] [int] NOT NULL,
	[NombreParametro] [varchar](50) NULL,
	[ValorParametro] [numeric](18, 4) NULL,
 CONSTRAINT [PK_RPT_VentaAcumuladaIncremento] PRIMARY KEY CLUSTERED 
(
	[IdParametro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[RPT_VentaAcumuladaIncremento] ([IdParametro], [NombreParametro], [ValorParametro]) VALUES (1, N'IncrementoMeta', CAST(20.0000 AS Numeric(18, 4)))
GO
