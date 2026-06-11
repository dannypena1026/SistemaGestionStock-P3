USE [master]
GO
/****** Object:  Database [SistemaStock]    Script Date: 25/3/2026 12:34:43 p. m. ******/
IF DB_ID(N'SistemaStock') IS NULL
BEGIN
    CREATE DATABASE [SistemaStock]
END
GO
ALTER DATABASE [SistemaStock] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SistemaStock].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SistemaStock] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SistemaStock] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SistemaStock] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SistemaStock] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SistemaStock] SET ARITHABORT OFF 
GO
ALTER DATABASE [SistemaStock] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SistemaStock] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SistemaStock] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SistemaStock] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SistemaStock] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SistemaStock] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SistemaStock] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SistemaStock] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SistemaStock] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SistemaStock] SET  ENABLE_BROKER 
GO
ALTER DATABASE [SistemaStock] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SistemaStock] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SistemaStock] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SistemaStock] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SistemaStock] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SistemaStock] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SistemaStock] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SistemaStock] SET RECOVERY FULL 
GO
ALTER DATABASE [SistemaStock] SET  MULTI_USER 
GO
ALTER DATABASE [SistemaStock] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SistemaStock] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SistemaStock] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SistemaStock] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SistemaStock] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SistemaStock] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SistemaStock', N'ON'
GO
ALTER DATABASE [SistemaStock] SET QUERY_STORE = ON
GO
ALTER DATABASE [SistemaStock] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [SistemaStock]
GO
/****** Object:  Table [dbo].[Categorias]    Script Date: 25/3/2026 12:34:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categorias](
	[CategoriaId] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoriaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Movimientos]    Script Date: 25/3/2026 12:34:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movimientos](
	[MovimientoId] [int] IDENTITY(1,1) NOT NULL,
	[ProductoId] [int] NOT NULL,
	[UsuarioId] [int] NOT NULL,
	[Tipo] [varchar](10) NOT NULL,
	[Cantidad] [int] NOT NULL,
	[StockAnterior] [int] NOT NULL,
	[StockNuevo] [int] NOT NULL,
	[Observacion] [varchar](200) NULL,
	[Fecha] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MovimientoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 25/3/2026 12:34:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[ProductoId] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](50) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Descripcion] [varchar](200) NULL,
	[Precio] [decimal](10, 2) NOT NULL,
	[Stock] [int] NOT NULL,
	[StockMinimo] [int] NOT NULL,
	[CategoriaId] [int] NOT NULL,
	[Activo] [bit] NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 25/3/2026 12:34:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RolId] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RolId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 25/3/2026 12:34:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[UsuarioId] [int] IDENTITY(1,1) NOT NULL,
	[NombreUsuario] [varchar](50) NOT NULL,
	[Password] [varchar](100) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[RolId] [int] NOT NULL,
	[Activo] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[UsuarioId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Categorias] ON 

INSERT [dbo].[Categorias] ([CategoriaId], [Nombre]) VALUES (2, N'Electrónica')
INSERT [dbo].[Categorias] ([CategoriaId], [Nombre]) VALUES (3, N'Herramientas')
INSERT [dbo].[Categorias] ([CategoriaId], [Nombre]) VALUES (4, N'Oficina')
INSERT [dbo].[Categorias] ([CategoriaId], [Nombre]) VALUES (5, N'Limpieza')
INSERT [dbo].[Categorias] ([CategoriaId], [Nombre]) VALUES (6, N'Alimentos')
SET IDENTITY_INSERT [dbo].[Categorias] OFF
GO
SET IDENTITY_INSERT [dbo].[Movimientos] ON 

INSERT [dbo].[Movimientos] ([MovimientoId], [ProductoId], [UsuarioId], [Tipo], [Cantidad], [StockAnterior], [StockNuevo], [Observacion], [Fecha]) VALUES (1, 3, 1, N'Entrada', 4, 10, 14, N'123', CAST(N'2026-03-24T16:06:02.877' AS DateTime))
INSERT [dbo].[Movimientos] ([MovimientoId], [ProductoId], [UsuarioId], [Tipo], [Cantidad], [StockAnterior], [StockNuevo], [Observacion], [Fecha]) VALUES (2, 3, 1, N'Salida', 3, 14, 11, N'1241', CAST(N'2026-03-24T16:06:14.117' AS DateTime))
INSERT [dbo].[Movimientos] ([MovimientoId], [ProductoId], [UsuarioId], [Tipo], [Cantidad], [StockAnterior], [StockNuevo], [Observacion], [Fecha]) VALUES (3, 4, 1, N'Entrada', 10, 0, 10, N'Stock inicial', CAST(N'2026-03-24T20:11:36.090' AS DateTime))
INSERT [dbo].[Movimientos] ([MovimientoId], [ProductoId], [UsuarioId], [Tipo], [Cantidad], [StockAnterior], [StockNuevo], [Observacion], [Fecha]) VALUES (4, 5, 1, N'Entrada', 25, 0, 25, N'Stock inicial', CAST(N'2026-03-24T20:11:36.090' AS DateTime))
INSERT [dbo].[Movimientos] ([MovimientoId], [ProductoId], [UsuarioId], [Tipo], [Cantidad], [StockAnterior], [StockNuevo], [Observacion], [Fecha]) VALUES (5, 6, 1, N'Entrada', 15, 0, 15, N'Stock inicial', CAST(N'2026-03-24T20:11:36.090' AS DateTime))
INSERT [dbo].[Movimientos] ([MovimientoId], [ProductoId], [UsuarioId], [Tipo], [Cantidad], [StockAnterior], [StockNuevo], [Observacion], [Fecha]) VALUES (6, 7, 1, N'Entrada', 8, 0, 8, N'Stock inicial', CAST(N'2026-03-24T20:11:36.090' AS DateTime))
INSERT [dbo].[Movimientos] ([MovimientoId], [ProductoId], [UsuarioId], [Tipo], [Cantidad], [StockAnterior], [StockNuevo], [Observacion], [Fecha]) VALUES (7, 8, 1, N'Entrada', 6, 0, 6, N'Stock inicial', CAST(N'2026-03-24T20:11:36.090' AS DateTime))
INSERT [dbo].[Movimientos] ([MovimientoId], [ProductoId], [UsuarioId], [Tipo], [Cantidad], [StockAnterior], [StockNuevo], [Observacion], [Fecha]) VALUES (8, 9, 1, N'Entrada', 20, 0, 20, N'Stock inicial', CAST(N'2026-03-24T20:11:36.090' AS DateTime))
INSERT [dbo].[Movimientos] ([MovimientoId], [ProductoId], [UsuarioId], [Tipo], [Cantidad], [StockAnterior], [StockNuevo], [Observacion], [Fecha]) VALUES (9, 10, 1, N'Entrada', 30, 0, 30, N'Stock inicial', CAST(N'2026-03-24T20:11:36.090' AS DateTime))
INSERT [dbo].[Movimientos] ([MovimientoId], [ProductoId], [UsuarioId], [Tipo], [Cantidad], [StockAnterior], [StockNuevo], [Observacion], [Fecha]) VALUES (10, 11, 1, N'Entrada', 50, 0, 50, N'Stock inicial', CAST(N'2026-03-24T20:11:36.090' AS DateTime))
INSERT [dbo].[Movimientos] ([MovimientoId], [ProductoId], [UsuarioId], [Tipo], [Cantidad], [StockAnterior], [StockNuevo], [Observacion], [Fecha]) VALUES (11, 12, 1, N'Entrada', 40, 0, 40, N'Stock inicial', CAST(N'2026-03-24T20:11:36.090' AS DateTime))
INSERT [dbo].[Movimientos] ([MovimientoId], [ProductoId], [UsuarioId], [Tipo], [Cantidad], [StockAnterior], [StockNuevo], [Observacion], [Fecha]) VALUES (12, 13, 1, N'Entrada', 12, 0, 12, N'Stock inicial', CAST(N'2026-03-24T20:11:36.090' AS DateTime))
INSERT [dbo].[Movimientos] ([MovimientoId], [ProductoId], [UsuarioId], [Tipo], [Cantidad], [StockAnterior], [StockNuevo], [Observacion], [Fecha]) VALUES (13, 14, 1, N'Entrada', 35, 0, 35, N'Stock inicial', CAST(N'2026-03-24T20:11:36.090' AS DateTime))
INSERT [dbo].[Movimientos] ([MovimientoId], [ProductoId], [UsuarioId], [Tipo], [Cantidad], [StockAnterior], [StockNuevo], [Observacion], [Fecha]) VALUES (14, 15, 1, N'Entrada', 15, 0, 15, N'Stock inicial', CAST(N'2026-03-24T20:11:36.090' AS DateTime))
INSERT [dbo].[Movimientos] ([MovimientoId], [ProductoId], [UsuarioId], [Tipo], [Cantidad], [StockAnterior], [StockNuevo], [Observacion], [Fecha]) VALUES (15, 16, 1, N'Entrada', 4, 0, 4, N'Stock inicial', CAST(N'2026-03-24T20:11:36.090' AS DateTime))
INSERT [dbo].[Movimientos] ([MovimientoId], [ProductoId], [UsuarioId], [Tipo], [Cantidad], [StockAnterior], [StockNuevo], [Observacion], [Fecha]) VALUES (16, 17, 1, N'Entrada', 2, 0, 2, N'Stock inicial', CAST(N'2026-03-24T20:11:36.090' AS DateTime))
INSERT [dbo].[Movimientos] ([MovimientoId], [ProductoId], [UsuarioId], [Tipo], [Cantidad], [StockAnterior], [StockNuevo], [Observacion], [Fecha]) VALUES (17, 18, 1, N'Entrada', 3, 0, 3, N'Stock inicial', CAST(N'2026-03-24T20:11:36.090' AS DateTime))
INSERT [dbo].[Movimientos] ([MovimientoId], [ProductoId], [UsuarioId], [Tipo], [Cantidad], [StockAnterior], [StockNuevo], [Observacion], [Fecha]) VALUES (18, 4, 1, N'Salida', 2, 10, 8, N'Venta a cliente', CAST(N'2026-03-24T20:11:36.090' AS DateTime))
INSERT [dbo].[Movimientos] ([MovimientoId], [ProductoId], [UsuarioId], [Tipo], [Cantidad], [StockAnterior], [StockNuevo], [Observacion], [Fecha]) VALUES (19, 5, 1, N'Salida', 5, 25, 20, N'Venta a cliente', CAST(N'2026-03-24T20:11:36.090' AS DateTime))
INSERT [dbo].[Movimientos] ([MovimientoId], [ProductoId], [UsuarioId], [Tipo], [Cantidad], [StockAnterior], [StockNuevo], [Observacion], [Fecha]) VALUES (20, 6, 1, N'Salida', 3, 15, 12, N'Venta a cliente', CAST(N'2026-03-24T20:11:36.090' AS DateTime))
INSERT [dbo].[Movimientos] ([MovimientoId], [ProductoId], [UsuarioId], [Tipo], [Cantidad], [StockAnterior], [StockNuevo], [Observacion], [Fecha]) VALUES (21, 11, 1, N'Salida', 10, 50, 40, N'Consumo interno', CAST(N'2026-03-24T20:11:36.090' AS DateTime))
INSERT [dbo].[Movimientos] ([MovimientoId], [ProductoId], [UsuarioId], [Tipo], [Cantidad], [StockAnterior], [StockNuevo], [Observacion], [Fecha]) VALUES (22, 14, 1, N'Salida', 5, 35, 30, N'Consumo interno', CAST(N'2026-03-24T20:11:36.090' AS DateTime))
INSERT [dbo].[Movimientos] ([MovimientoId], [ProductoId], [UsuarioId], [Tipo], [Cantidad], [StockAnterior], [StockNuevo], [Observacion], [Fecha]) VALUES (23, 16, 1, N'Salida', 2, 4, 2, N'Venta a cliente', CAST(N'2026-03-24T20:11:36.090' AS DateTime))
INSERT [dbo].[Movimientos] ([MovimientoId], [ProductoId], [UsuarioId], [Tipo], [Cantidad], [StockAnterior], [StockNuevo], [Observacion], [Fecha]) VALUES (24, 17, 1, N'Salida', 1, 2, 1, N'Venta a cliente', CAST(N'2026-03-24T20:11:36.090' AS DateTime))
INSERT [dbo].[Movimientos] ([MovimientoId], [ProductoId], [UsuarioId], [Tipo], [Cantidad], [StockAnterior], [StockNuevo], [Observacion], [Fecha]) VALUES (25, 18, 1, N'Salida', 3, 3, 0, N'Venta a cliente', CAST(N'2026-03-24T20:11:36.090' AS DateTime))
SET IDENTITY_INSERT [dbo].[Movimientos] OFF
GO
SET IDENTITY_INSERT [dbo].[Productos] ON 

INSERT [dbo].[Productos] ([ProductoId], [Codigo], [Nombre], [Descripcion], [Precio], [Stock], [StockMinimo], [CategoriaId], [Activo], [FechaCreacion]) VALUES (3, N'prueba1', N'Laptop', N'asd', CAST(5600.00 AS Decimal(10, 2)), 11, 5, 2, 0, CAST(N'2026-03-24T16:03:50.757' AS DateTime))
INSERT [dbo].[Productos] ([ProductoId], [Codigo], [Nombre], [Descripcion], [Precio], [Stock], [StockMinimo], [CategoriaId], [Activo], [FechaCreacion]) VALUES (4, N'ELEC-001', N'Laptop HP 15"', N'Laptop HP con 8GB RAM y 256GB SSD', CAST(45000.00 AS Decimal(10, 2)), 10, 3, 2, 1, CAST(N'2026-03-24T20:09:15.993' AS DateTime))
INSERT [dbo].[Productos] ([ProductoId], [Codigo], [Nombre], [Descripcion], [Precio], [Stock], [StockMinimo], [CategoriaId], [Activo], [FechaCreacion]) VALUES (5, N'ELEC-002', N'Mouse Inalámbrico', N'Mouse inalámbrico Logitech', CAST(850.00 AS Decimal(10, 2)), 25, 5, 2, 1, CAST(N'2026-03-24T20:09:15.993' AS DateTime))
INSERT [dbo].[Productos] ([ProductoId], [Codigo], [Nombre], [Descripcion], [Precio], [Stock], [StockMinimo], [CategoriaId], [Activo], [FechaCreacion]) VALUES (6, N'ELEC-003', N'Teclado USB', N'Teclado USB estándar', CAST(650.00 AS Decimal(10, 2)), 15, 5, 2, 1, CAST(N'2026-03-24T20:09:15.993' AS DateTime))
INSERT [dbo].[Productos] ([ProductoId], [Codigo], [Nombre], [Descripcion], [Precio], [Stock], [StockMinimo], [CategoriaId], [Activo], [FechaCreacion]) VALUES (7, N'ELEC-004', N'Monitor 24"', N'Monitor LED Full HD 24 pulgadas', CAST(12000.00 AS Decimal(10, 2)), 8, 2, 2, 1, CAST(N'2026-03-24T20:09:15.993' AS DateTime))
INSERT [dbo].[Productos] ([ProductoId], [Codigo], [Nombre], [Descripcion], [Precio], [Stock], [StockMinimo], [CategoriaId], [Activo], [FechaCreacion]) VALUES (8, N'HERR-001', N'Taladro Eléctrico', N'Taladro eléctrico 500W con set de brocas', CAST(3500.00 AS Decimal(10, 2)), 6, 2, 3, 1, CAST(N'2026-03-24T20:09:15.993' AS DateTime))
INSERT [dbo].[Productos] ([ProductoId], [Codigo], [Nombre], [Descripcion], [Precio], [Stock], [StockMinimo], [CategoriaId], [Activo], [FechaCreacion]) VALUES (9, N'HERR-002', N'Destornillador Set', N'Set de destornilladores 12 piezas', CAST(750.00 AS Decimal(10, 2)), 20, 5, 3, 1, CAST(N'2026-03-24T20:09:15.993' AS DateTime))
INSERT [dbo].[Productos] ([ProductoId], [Codigo], [Nombre], [Descripcion], [Precio], [Stock], [StockMinimo], [CategoriaId], [Activo], [FechaCreacion]) VALUES (10, N'HERR-003', N'Cinta Métrica 5m', N'Cinta métrica profesional 5 metros', CAST(250.00 AS Decimal(10, 2)), 30, 10, 3, 1, CAST(N'2026-03-24T20:09:15.993' AS DateTime))
INSERT [dbo].[Productos] ([ProductoId], [Codigo], [Nombre], [Descripcion], [Precio], [Stock], [StockMinimo], [CategoriaId], [Activo], [FechaCreacion]) VALUES (11, N'OFIC-001', N'Resma de Papel', N'Resma de papel bond A4 500 hojas', CAST(350.00 AS Decimal(10, 2)), 50, 10, 4, 1, CAST(N'2026-03-24T20:09:15.993' AS DateTime))
INSERT [dbo].[Productos] ([ProductoId], [Codigo], [Nombre], [Descripcion], [Precio], [Stock], [StockMinimo], [CategoriaId], [Activo], [FechaCreacion]) VALUES (12, N'OFIC-002', N'Bolígrafos Caja', N'Caja de bolígrafos azules x12', CAST(180.00 AS Decimal(10, 2)), 40, 10, 4, 1, CAST(N'2026-03-24T20:09:15.993' AS DateTime))
INSERT [dbo].[Productos] ([ProductoId], [Codigo], [Nombre], [Descripcion], [Precio], [Stock], [StockMinimo], [CategoriaId], [Activo], [FechaCreacion]) VALUES (13, N'OFIC-003', N'Grapadora', N'Grapadora de escritorio mediana', CAST(320.00 AS Decimal(10, 2)), 12, 3, 4, 1, CAST(N'2026-03-24T20:09:15.993' AS DateTime))
INSERT [dbo].[Productos] ([ProductoId], [Codigo], [Nombre], [Descripcion], [Precio], [Stock], [StockMinimo], [CategoriaId], [Activo], [FechaCreacion]) VALUES (14, N'LIMP-001', N'Desinfectante 1L', N'Desinfectante multiusos 1 litro', CAST(150.00 AS Decimal(10, 2)), 35, 10, 5, 1, CAST(N'2026-03-24T20:09:15.993' AS DateTime))
INSERT [dbo].[Productos] ([ProductoId], [Codigo], [Nombre], [Descripcion], [Precio], [Stock], [StockMinimo], [CategoriaId], [Activo], [FechaCreacion]) VALUES (15, N'LIMP-002', N'Escoba', N'Escoba plástica con palo', CAST(200.00 AS Decimal(10, 2)), 15, 5, 5, 1, CAST(N'2026-03-24T20:09:15.993' AS DateTime))
INSERT [dbo].[Productos] ([ProductoId], [Codigo], [Nombre], [Descripcion], [Precio], [Stock], [StockMinimo], [CategoriaId], [Activo], [FechaCreacion]) VALUES (16, N'ALIM-001', N'Café 500g', N'Café molido premium 500 gramos', CAST(420.00 AS Decimal(10, 2)), 4, 5, 6, 1, CAST(N'2026-03-24T20:09:15.993' AS DateTime))
INSERT [dbo].[Productos] ([ProductoId], [Codigo], [Nombre], [Descripcion], [Precio], [Stock], [StockMinimo], [CategoriaId], [Activo], [FechaCreacion]) VALUES (17, N'ALIM-002', N'Azúcar 1kg', N'Azúcar blanca refinada 1 kilogramo', CAST(85.00 AS Decimal(10, 2)), 2, 5, 6, 1, CAST(N'2026-03-24T20:09:15.993' AS DateTime))
INSERT [dbo].[Productos] ([ProductoId], [Codigo], [Nombre], [Descripcion], [Precio], [Stock], [StockMinimo], [CategoriaId], [Activo], [FechaCreacion]) VALUES (18, N'ELEC-005', N'Cargador Universal', N'Cargador universal USB-C 65W', CAST(1200.00 AS Decimal(10, 2)), 0, 3, 2, 1, CAST(N'2026-03-24T20:09:15.993' AS DateTime))
SET IDENTITY_INSERT [dbo].[Productos] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RolId], [Nombre]) VALUES (1, N'Admin')
INSERT [dbo].[Roles] ([RolId], [Nombre]) VALUES (2, N'Usuario')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([UsuarioId], [NombreUsuario], [Password], [Nombre], [RolId], [Activo]) VALUES (1, N'admin', N'$2a$11$YP19STiuKRU2O6DFQN2WE.0RswquTakiYmxzmRDXBJ9WeQagdWyva', N'admin', 1, 1)
INSERT [dbo].[Usuarios] ([UsuarioId], [NombreUsuario], [Password], [Nombre], [RolId], [Activo]) VALUES (2, N'usuario', N'$2a$11$NQyaNN5wrL25s5QApGSwXO6QAjo/6fSHM6q6wpbPUlN1D4Ok1ToFK', N'usuario', 2, 1)
INSERT [dbo].[Usuarios] ([UsuarioId], [NombreUsuario], [Password], [Nombre], [RolId], [Activo]) VALUES (3, N'Jupo', N'$2a$11$pHs/GUXRhAbRoWAaiMrle.1M20tzLltSFWxNAdO.ewEGlUXJ0C85i', N'Juan Po', 2, 0)
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Producto__06370DAC4D1B1FF2]    Script Date: 25/3/2026 12:34:43 p. m. ******/
ALTER TABLE [dbo].[Productos] ADD UNIQUE NONCLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuarios__6B0F5AE0980BF8C3]    Script Date: 25/3/2026 12:34:43 p. m. ******/
ALTER TABLE [dbo].[Usuarios] ADD UNIQUE NONCLUSTERED 
(
	[NombreUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Movimientos] ADD  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [dbo].[Productos] ADD  DEFAULT ((0.00)) FOR [Precio]
GO
ALTER TABLE [dbo].[Productos] ADD  DEFAULT ((0)) FOR [Stock]
GO
ALTER TABLE [dbo].[Productos] ADD  DEFAULT ((5)) FOR [StockMinimo]
GO
ALTER TABLE [dbo].[Productos] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Productos] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[Usuarios] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Movimientos]  WITH CHECK ADD  CONSTRAINT [FK_Movimientos_Productos] FOREIGN KEY([ProductoId])
REFERENCES [dbo].[Productos] ([ProductoId])
GO
ALTER TABLE [dbo].[Movimientos] CHECK CONSTRAINT [FK_Movimientos_Productos]
GO
ALTER TABLE [dbo].[Movimientos]  WITH CHECK ADD  CONSTRAINT [FK_Movimientos_Usuarios] FOREIGN KEY([UsuarioId])
REFERENCES [dbo].[Usuarios] ([UsuarioId])
GO
ALTER TABLE [dbo].[Movimientos] CHECK CONSTRAINT [FK_Movimientos_Usuarios]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [FK_Productos_Categorias] FOREIGN KEY([CategoriaId])
REFERENCES [dbo].[Categorias] ([CategoriaId])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_Productos_Categorias]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [FK_Usuarios_Roles] FOREIGN KEY([RolId])
REFERENCES [dbo].[Roles] ([RolId])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [FK_Usuarios_Roles]
GO
ALTER TABLE [dbo].[Movimientos]  WITH CHECK ADD CHECK  (([Cantidad]>(0)))
GO
ALTER TABLE [dbo].[Movimientos]  WITH CHECK ADD CHECK  (([Tipo]='Salida' OR [Tipo]='Entrada'))
GO
USE [master]
GO
ALTER DATABASE [SistemaStock] SET  READ_WRITE 
GO
