USE [master]
GO
/****** Object:  Database [SejoDB]    Script Date: 19/03/2024 13:06:26 ******/
CREATE DATABASE [SejoDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SejoDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS01\MSSQL\DATA\SejoDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SejoDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS01\MSSQL\DATA\SejoDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [SejoDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SejoDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SejoDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SejoDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SejoDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SejoDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SejoDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [SejoDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SejoDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SejoDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SejoDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SejoDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SejoDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SejoDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SejoDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SejoDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SejoDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SejoDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SejoDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SejoDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SejoDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SejoDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SejoDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SejoDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SejoDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SejoDB] SET  MULTI_USER 
GO
ALTER DATABASE [SejoDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SejoDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SejoDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SejoDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SejoDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SejoDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [SejoDB] SET QUERY_STORE = OFF
GO
USE [SejoDB]
GO
/****** Object:  Table [dbo].[Provincias]    Script Date: 19/03/2024 13:06:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Provincias](
	[ProvinciaID] [int] IDENTITY(1,1) NOT NULL,
	[NombreProvincia] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProvinciaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposEventos]    Script Date: 19/03/2024 13:06:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposEventos](
	[TipoEventoID] [int] NOT NULL,
	[Tipo] [varchar](50) NOT NULL,
	[Imagen] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[TipoEventoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 19/03/2024 13:06:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[UsuarioID] [int] IDENTITY(1,1) NOT NULL,
	[NombreUsuario] [varchar](50) NOT NULL,
	[FotoPerfil] [varchar](255) NULL,
	[Correo] [varchar](100) NOT NULL,
	[Telefono] [varchar](15) NULL,
	[ProvinciaID] [int] NULL,
	[Descripcion] [varchar](300) NULL,
	[RolID] [int] NULL,
	[Password] [varbinary](max) NOT NULL,
	[Salt] [nvarchar](150) NULL,
	[Activo] [bit] NULL,
	[TokenMail] [nvarchar](255) NULL,
 CONSTRAINT [PK__Usuarios__2B3DE7984D352EEA] PRIMARY KEY CLUSTERED 
(
	[UsuarioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Eventos]    Script Date: 19/03/2024 13:06:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Eventos](
	[EventoID] [int] IDENTITY(1,1) NOT NULL,
	[NombreEvento] [varchar](100) NOT NULL,
	[TipoEventoID] [int] NULL,
	[Fecha] [date] NOT NULL,
	[Ubicacion] [varchar](100) NULL,
	[Provincia] [int] NULL,
	[Aforo] [int] NOT NULL,
	[Imagen] [varchar](255) NULL,
	[Recinto] [int] NULL,
	[MayorDe18] [bit] NOT NULL,
	[Descripcion] [varchar](300) NULL,
	[LinkMapsProvincia] [varchar](255) NULL,
	[EntradasVendidas] [int] NOT NULL,
	[Precio] [int] NOT NULL,
 CONSTRAINT [PK__Eventos__1EEB5901B0FEB3C4] PRIMARY KEY CLUSTERED 
(
	[EventoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VISTA_DETALLES_EVENTO]    Script Date: 19/03/2024 13:06:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VISTA_DETALLES_EVENTO] AS
SELECT
    E.EventoID,
  E.NombreEvento,
  TE.Tipo AS TipoEvento,
  E.Fecha,
  E.Ubicacion,
  P.NombreProvincia AS Provincia,
  P.ProvinciaID,
  E.Aforo,
  E.EntradasVendidas,
  E.Imagen,
  U.NombreUsuario AS Recinto,
  U.UsuarioID AS RecintoID,
  E.MayorDe18,
  E.Descripcion,
  E.Precio,
  E.LinkMapsProvincia
FROM Eventos E
JOIN TiposEventos TE ON E.TipoEventoID = TE.TipoEventoID
JOIN Provincias P ON E.Provincia = P.ProvinciaID
JOIN Usuarios U ON E.Recinto = U.UsuarioID;
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 19/03/2024 13:06:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RolID] [int] NOT NULL,
	[NombreRol] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RolID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VISTA_DETALLE_USUARIO]    Script Date: 19/03/2024 13:06:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VISTA_DETALLE_USUARIO] AS
SELECT
    U.UsuarioID,
    U.NombreUsuario,
    U.FotoPerfil,
    U.Correo,
    U.Telefono,
    U.ProvinciaID,
    P.NombreProvincia,
    U.Descripcion,
    U.Activo,
    R.NombreRol,
	R.RolID
FROM Usuarios U
INNER JOIN Roles R ON U.RolID = R.RolID
INNER JOIN Provincias P ON U.ProvinciaID = P.ProvinciaID;
GO
/****** Object:  Table [dbo].[ArtistasEvento]    Script Date: 19/03/2024 13:06:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ArtistasEvento](
	[ArtistaEventoID] [int] IDENTITY(1,1) NOT NULL,
	[ArtistaID] [int] NULL,
	[EventoID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ArtistaEventoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VISTA_DETALLE_ARTISTA]    Script Date: 19/03/2024 13:06:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[VISTA_DETALLE_ARTISTA] as
select
    u.usuarioid,
    u.nombreusuario,
    u.fotoperfil,
    u.provinciaid,
    p.nombreprovincia,
    u.descripcion,
    r.nombrerol,
	r.RolID,
    ae.eventoid
from usuarios u
inner join artistasevento ae on u.usuarioid = ae.artistaid
inner join roles r on u.rolid = r.rolid
inner join provincias p on u.provinciaid = p.provinciaid;  
GO
/****** Object:  Table [dbo].[AsistenciasEventos]    Script Date: 19/03/2024 13:06:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AsistenciasEventos](
	[AsistenciaID] [int] IDENTITY(1,1) NOT NULL,
	[UsuarioID] [int] NOT NULL,
	[EventoID] [int] NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[Correo] [nvarchar](100) NOT NULL,
	[DNI] [nvarchar](20) NOT NULL,
	[QR] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AsistenciaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VISTA_ENTRADAS_DETALLE]    Script Date: 19/03/2024 13:06:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VISTA_ENTRADAS_DETALLE] AS
SELECT 
    AE.AsistenciaID,
    AE.UsuarioID,
    AE.EventoID,
    AE.Nombre,
    AE.Correo,
    AE.DNI,
    AE.QR,
    DE.NombreEvento,
    DE.Fecha,
    DE.Provincia,
    DE.Imagen,
    DE.Recinto
FROM 
    AsistenciasEventos AE
JOIN 
    VISTA_DETALLES_EVENTO DE ON AE.EventoID = DE.EventoID;
GO
/****** Object:  Table [dbo].[Comentarios]    Script Date: 19/03/2024 13:06:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comentarios](
	[ComentarioID] [int] IDENTITY(1,1) NOT NULL,
	[EventoID] [int] NULL,
	[UsuarioID] [int] NULL,
	[Texto] [nvarchar](max) NULL,
	[FechaCreacion] [datetime] NULL,
	[Puntuacion] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ComentarioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[VISTA_DETALLE_COMENTARIO]    Script Date: 19/03/2024 13:06:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VISTA_DETALLE_COMENTARIO] AS
SELECT 
    c.ComentarioID,
    c.EventoID,
    e.NombreEvento,
    c.UsuarioID,
    u.NombreUsuario,
    c.Texto,
    c.FechaCreacion,
    c.Puntuacion
FROM 
    Comentarios c
INNER JOIN 
    Usuarios u ON c.UsuarioID = u.UsuarioID
INNER JOIN 
    Eventos e ON c.EventoID = e.EventoID;
GO
/****** Object:  Table [dbo].[Artistas]    Script Date: 19/03/2024 13:06:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Artistas](
	[idArtista] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](255) NULL,
	[Foto] [nvarchar](255) NULL,
	[IdEvento] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[idArtista] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Resenas]    Script Date: 19/03/2024 13:06:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Resenas](
	[ResenaID] [int] IDENTITY(1,1) NOT NULL,
	[UsuarioID] [int] NULL,
	[RolReviewId] [int] NULL,
	[Comentario] [varchar](300) NULL,
	[Puntuacion] [int] NULL,
	[FechaResena] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ResenaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Seguimientos]    Script Date: 19/03/2024 13:06:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seguimientos](
	[SeguimientoID] [int] IDENTITY(1,1) NOT NULL,
	[UsuarioIDSeguidor] [int] NULL,
	[UsuarioIDSeguido] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SeguimientoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ArtistasEvento] ON 

INSERT [dbo].[ArtistasEvento] ([ArtistaEventoID], [ArtistaID], [EventoID]) VALUES (1, 32, 43)
INSERT [dbo].[ArtistasEvento] ([ArtistaEventoID], [ArtistaID], [EventoID]) VALUES (2, 25, 42)
INSERT [dbo].[ArtistasEvento] ([ArtistaEventoID], [ArtistaID], [EventoID]) VALUES (3, 31, 41)
INSERT [dbo].[ArtistasEvento] ([ArtistaEventoID], [ArtistaID], [EventoID]) VALUES (4, 27, 44)
INSERT [dbo].[ArtistasEvento] ([ArtistaEventoID], [ArtistaID], [EventoID]) VALUES (5, 24, 49)
INSERT [dbo].[ArtistasEvento] ([ArtistaEventoID], [ArtistaID], [EventoID]) VALUES (6, 28, 51)
SET IDENTITY_INSERT [dbo].[ArtistasEvento] OFF
GO
SET IDENTITY_INSERT [dbo].[AsistenciasEventos] ON 

INSERT [dbo].[AsistenciasEventos] ([AsistenciaID], [UsuarioID], [EventoID], [Nombre], [Correo], [DNI], [QR]) VALUES (1, 15, 49, N'Sergio Montero', N'sejo@gmail.com', N'49556633H', N'')
INSERT [dbo].[AsistenciasEventos] ([AsistenciaID], [UsuarioID], [EventoID], [Nombre], [Correo], [DNI], [QR]) VALUES (2, 15, 49, N'Pepito', N'pepito@gmail.com', N'12345567S', N'')
INSERT [dbo].[AsistenciasEventos] ([AsistenciaID], [UsuarioID], [EventoID], [Nombre], [Correo], [DNI], [QR]) VALUES (3, 15, 49, N'Juanito', N'juanito@gmail.com', N'12345678J', N'')
SET IDENTITY_INSERT [dbo].[AsistenciasEventos] OFF
GO
SET IDENTITY_INSERT [dbo].[Comentarios] ON 

INSERT [dbo].[Comentarios] ([ComentarioID], [EventoID], [UsuarioID], [Texto], [FechaCreacion], [Puntuacion]) VALUES (9, 43, 14, N'Concierto bastante emotivo', CAST(N'2024-03-18T23:58:32.760' AS DateTime), 2)
SET IDENTITY_INSERT [dbo].[Comentarios] OFF
GO
SET IDENTITY_INSERT [dbo].[Eventos] ON 

INSERT [dbo].[Eventos] ([EventoID], [NombreEvento], [TipoEventoID], [Fecha], [Ubicacion], [Provincia], [Aforo], [Imagen], [Recinto], [MayorDe18], [Descripcion], [LinkMapsProvincia], [EntradasVendidas], [Precio]) VALUES (41, N'Aleron Club: Fran DC', 1, CAST(N'2024-03-22' AS Date), N'Calle de Atocha, 127, 28012 Madrid, Spain', 1, 5, N'aleron22-03.png', 15, 0, N'Todas las miradas se reu´nen alrededor del Nissan GT-R R34 con Selecta, DJ residente y creador de la fiesta, conduciendo la noche desde lo alto del deportivo.', N'https://www.google.com/maps/d/u/0/viewer?mid=1mhHjAC3R7QovxNYn3FuXlgEqBhU&hl=es&ll=39.47579838925011%2C-0.37267699999999904&z=14', 0, 33)
INSERT [dbo].[Eventos] ([EventoID], [NombreEvento], [TipoEventoID], [Fecha], [Ubicacion], [Provincia], [Aforo], [Imagen], [Recinto], [MayorDe18], [Descripcion], [LinkMapsProvincia], [EntradasVendidas], [Precio]) VALUES (42, N'AGUS FORNITE', 1, CAST(N'2024-03-20' AS Date), N'Calle de Atocha, 127, 28012 Madrid, Spain', 1, 5, N'agusfort.png', 15, 0, N'AgusFortnite2008 y Stiffy son dos jóvenes argentinos que en los últimos 2 años han estado en boca de todo el mundo a causa de su imaginario altamente original y creativo.', N'https://www.google.com/maps/d/u/0/viewer?mid=1mhHjAC3R7QovxNYn3FuXlgEqBhU&hl=es&ll=39.47579838925011%2C-0.37267699999999904&z=14', 0, 17)
INSERT [dbo].[Eventos] ([EventoID], [NombreEvento], [TipoEventoID], [Fecha], [Ubicacion], [Provincia], [Aforo], [Imagen], [Recinto], [MayorDe18], [Descripcion], [LinkMapsProvincia], [EntradasVendidas], [Precio]) VALUES (43, N'k1za en Sound Isidro', 2, CAST(N'2024-03-14' AS Date), N'Calle de Atocha, 127, 28012 Madrid, Spain', 1, 5, N'kiza.png', 15, 0, N'Influenciada por la música desde su infancia, K1ZA comenzó escribiendo canciones con 13 años mientras estudiaba guitarra.', N'https://www.google.com/maps/d/u/0/viewer?mid=1mhHjAC3R7QovxNYn3FuXlgEqBhU&hl=es&ll=39.47579838925011%2C-0.37267699999999904&z=14', 0, 21)
INSERT [dbo].[Eventos] ([EventoID], [NombreEvento], [TipoEventoID], [Fecha], [Ubicacion], [Provincia], [Aforo], [Imagen], [Recinto], [MayorDe18], [Descripcion], [LinkMapsProvincia], [EntradasVendidas], [Precio]) VALUES (44, N'tarchi + bosco herrero', 2, CAST(N'2024-04-04' AS Date), N'Calle de Atocha, 127, 28012 Madrid, Spain', 1, 5, N'tarchi.png', 15, 0, N'el futuro abriendose paso

todas las edades (necesario traer DNI + autorización de tutor legal para menores de 18 años, menos de 16 años acompañados)).', N'https://www.google.com/maps/d/u/0/viewer?mid=1mhHjAC3R7QovxNYn3FuXlgEqBhU&hl=es&ll=39.47579838925011%2C-0.37267699999999904&z=14', 0, 15)
INSERT [dbo].[Eventos] ([EventoID], [NombreEvento], [TipoEventoID], [Fecha], [Ubicacion], [Provincia], [Aforo], [Imagen], [Recinto], [MayorDe18], [Descripcion], [LinkMapsProvincia], [EntradasVendidas], [Precio]) VALUES (47, N'C Marí', 2, CAST(N'2024-05-09' AS Date), N'Calle de Atocha, 127, 28012 Madrid, Spain', 1, 5, N'camri.png', 15, 0, N'Apúrense comprando las entradas, día legendario', N'https://www.google.com/maps/d/u/0/viewer?mid=1mhHjAC3R7QovxNYn3FuXlgEqBhU&hl=es&ll=39.47579838925011%2C-0.37267699999999904&z=14', 0, 18)
INSERT [dbo].[Eventos] ([EventoID], [NombreEvento], [TipoEventoID], [Fecha], [Ubicacion], [Provincia], [Aforo], [Imagen], [Recinto], [MayorDe18], [Descripcion], [LinkMapsProvincia], [EntradasVendidas], [Precio]) VALUES (49, N'MVRK', 2, CAST(N'2024-03-20' AS Date), N'Calle Fuente Del Berro, 28009 Madrid, Madrid, Spain', 1, 3, N'mvrk.png', 16, 0, N'El artista madrileño estrenará el próximo 24 de Octubre su primer full show en La Sala del Wizink Center tras el éxito de su álbum debut “La fe que me tengas” (producido por Sneaky WH).', N'https://www.google.com/maps/d/u/0/viewer?mid=1mhHjAC3R7QovxNYn3FuXlgEqBhU&hl=es&ll=39.47579838925011%2C-0.37267699999999904&z=14', 3, 20)
INSERT [dbo].[Eventos] ([EventoID], [NombreEvento], [TipoEventoID], [Fecha], [Ubicacion], [Provincia], [Aforo], [Imagen], [Recinto], [MayorDe18], [Descripcion], [LinkMapsProvincia], [EntradasVendidas], [Precio]) VALUES (50, N'Cigarettes After Sex', 2, CAST(N'2024-03-25' AS Date), N'Calle Fuente Del Berro, 28009 Madrid, Madrid, Spain', 1, 5, N'Captura de pantalla 2024-03-18 233435.png', 16, 0, N'IMPORTANTE: Si sigues adelante con la compra aceptas expresamente las condiciones generales de Primavera Sound ', N'https://www.google.com/maps/d/u/0/viewer?mid=1mhHjAC3R7QovxNYn3FuXlgEqBhU&hl=es&ll=39.47579838925011%2C-0.37267699999999904&z=14', 0, 44)
INSERT [dbo].[Eventos] ([EventoID], [NombreEvento], [TipoEventoID], [Fecha], [Ubicacion], [Provincia], [Aforo], [Imagen], [Recinto], [MayorDe18], [Descripcion], [LinkMapsProvincia], [EntradasVendidas], [Precio]) VALUES (51, N'Bad Gyal - La Joia 24', 2, CAST(N'2024-04-06' AS Date), N'Calle Fuente Del Berro, 28009 Madrid, Madrid, Spain', 1, 5, N'Captura de pantalla 2024-03-18 233758.png', 16, 0, N'Since starting her musical career in 2016, the Catalan-born singer-songwriter has released some of Spain’s most iconic tracks (‘Fiebre’, ‘Blin Blin’, ‘Alocao’ and ‘Zorra’', N'https://www.google.com/maps/d/u/0/viewer?mid=1mhHjAC3R7QovxNYn3FuXlgEqBhU&hl=es&ll=39.47579838925011%2C-0.37267699999999904&z=14', 0, 31)
INSERT [dbo].[Eventos] ([EventoID], [NombreEvento], [TipoEventoID], [Fecha], [Ubicacion], [Provincia], [Aforo], [Imagen], [Recinto], [MayorDe18], [Descripcion], [LinkMapsProvincia], [EntradasVendidas], [Precio]) VALUES (52, N'rusowsky', 2, CAST(N'2024-05-10' AS Date), N'Paseo Bajo de la Virgen del Puerto, S/N, 28005 Madrid, Spain', 1, 5, N'Captura de pantalla 2024-03-18 234336.png', 17, 0, N's a producer, Madrid’s Rusowsky has been reconfiguring pop, electronica and trap from the confines of his bedroom since before the pandemic.', N'https://www.google.com/maps/d/u/0/viewer?mid=1mhHjAC3R7QovxNYn3FuXlgEqBhU&hl=es&ll=39.47579838925011%2C-0.37267699999999904&z=14', 0, 19)
INSERT [dbo].[Eventos] ([EventoID], [NombreEvento], [TipoEventoID], [Fecha], [Ubicacion], [Provincia], [Aforo], [Imagen], [Recinto], [MayorDe18], [Descripcion], [LinkMapsProvincia], [EntradasVendidas], [Precio]) VALUES (53, N'Dano', 2, CAST(N'2024-04-18' AS Date), N'Paseo Bajo de la Virgen del Puerto, S/N, 28005 Madrid, Spain', 1, 5, N'Captura de pantalla 2024-03-18 234500.png', 17, 0, N'Danilo Amerise Díaz (05/06/1985) mejor conocido como Dano o Dano Ziontifik es un MC, beatmaker, productor y director audiovisual, Dano es el exponente y cabecilla de Ziontifik y toda una institución asentada en el underground del Rap Español.', N'https://www.google.com/maps/d/u/0/viewer?mid=1mhHjAC3R7QovxNYn3FuXlgEqBhU&hl=es&ll=39.47579838925011%2C-0.37267699999999904&z=14', 0, 22)
INSERT [dbo].[Eventos] ([EventoID], [NombreEvento], [TipoEventoID], [Fecha], [Ubicacion], [Provincia], [Aforo], [Imagen], [Recinto], [MayorDe18], [Descripcion], [LinkMapsProvincia], [EntradasVendidas], [Precio]) VALUES (54, N'Xavibo', 2, CAST(N'2024-05-30' AS Date), N'Paseo Bajo de la Virgen del Puerto, S/N, 28005 Madrid, Spain', 1, 5, N'Captura de pantalla 2024-03-18 234828.png', 17, 0, N'Xavibo en Sound Isidro 2024, sala La Riviera apertura de puertas 20:00h', N'https://www.google.com/maps/d/u/0/viewer?mid=1mhHjAC3R7QovxNYn3FuXlgEqBhU&hl=es&ll=39.47579838925011%2C-0.37267699999999904&z=14', 0, 24)
INSERT [dbo].[Eventos] ([EventoID], [NombreEvento], [TipoEventoID], [Fecha], [Ubicacion], [Provincia], [Aforo], [Imagen], [Recinto], [MayorDe18], [Descripcion], [LinkMapsProvincia], [EntradasVendidas], [Precio]) VALUES (55, N'Casa Pepa', 1, CAST(N'2024-03-22' AS Date), N'C. de Cedaceros, 7, 28014 Madrid, Spain', 1, 5, N'Captura de pantalla 2024-03-18 235017.png', 18, 0, N'Raciones de música variada, vermú y el mejor rollo de Madrid cada viernes.', N'https://www.google.com/maps/d/u/0/viewer?mid=1mhHjAC3R7QovxNYn3FuXlgEqBhU&hl=es&ll=39.47579838925011%2C-0.37267699999999904&z=14', 0, 20)
INSERT [dbo].[Eventos] ([EventoID], [NombreEvento], [TipoEventoID], [Fecha], [Ubicacion], [Provincia], [Aforo], [Imagen], [Recinto], [MayorDe18], [Descripcion], [LinkMapsProvincia], [EntradasVendidas], [Precio]) VALUES (58, N'Infierno', 1, CAST(N'2024-03-21' AS Date), N'C. de Cedaceros, 7, 28014 Madrid, Spain', 1, 5, N'Captura de pantalla 2024-03-18 235401.png', 18, 0, N'Sex, Drugs & Music', N'https://www.google.com/maps/d/u/0/viewer?mid=1mhHjAC3R7QovxNYn3FuXlgEqBhU&hl=es&ll=39.47579838925011%2C-0.37267699999999904&z=14', 0, 10)
INSERT [dbo].[Eventos] ([EventoID], [NombreEvento], [TipoEventoID], [Fecha], [Ubicacion], [Provincia], [Aforo], [Imagen], [Recinto], [MayorDe18], [Descripcion], [LinkMapsProvincia], [EntradasVendidas], [Precio]) VALUES (60, N'Primavera Sound', 3, CAST(N'2024-03-29' AS Date), N'Carrer de la Pau, 12, 08930 Sant Adrià de Besòs, Barcelona, Spain', 2, 10, N'Captura de pantalla 2024-03-19 000007.png', 19, 0, N'Primavera Sound Barcelona 2024 se celebrará del 30 de mayo al 1 de junio en el recinto del Parc del Fòrum.', N'https://www.google.com/maps/d/u/0/viewer?mid=1mhHjAC3R7QovxNYn3FuXlgEqBhU&hl=es&ll=39.47579838925011%2C-0.37267699999999904&z=14', 0, 130)
INSERT [dbo].[Eventos] ([EventoID], [NombreEvento], [TipoEventoID], [Fecha], [Ubicacion], [Provincia], [Aforo], [Imagen], [Recinto], [MayorDe18], [Descripcion], [LinkMapsProvincia], [EntradasVendidas], [Precio]) VALUES (61, N'Brunch Electronik', 3, CAST(N'2024-06-02' AS Date), N'Carrer de la Pau, 12, 08930 Sant Adrià de Besòs, Barcelona, Spain', 2, 10, N'Captura de pantalla 2024-03-19 000317.png', 19, 0, N'IMPORTANTE: Si sigues adelante con la reserva aceptas expresamente las condiciones generales de Primavera Sound', N'https://www.google.com/maps/d/u/0/viewer?mid=1mhHjAC3R7QovxNYn3FuXlgEqBhU&hl=es&ll=39.47579838925011%2C-0.37267699999999904&z=14', 0, 50)
INSERT [dbo].[Eventos] ([EventoID], [NombreEvento], [TipoEventoID], [Fecha], [Ubicacion], [Provincia], [Aforo], [Imagen], [Recinto], [MayorDe18], [Descripcion], [LinkMapsProvincia], [EntradasVendidas], [Precio]) VALUES (62, N'Bombastic Madrid', 3, CAST(N'2024-03-30' AS Date), N'Auditorio Miguel Rios, Rivas', 1, 5, N'6689aeb8-14b4-4026-b75d-919ccaa5e74d_alta-libre-aspect-ratio_default_0.png', 20, 0, N'Bombastic en Madrid!', N'https://www.google.com/maps/d/u/0/viewer?mid=1mhHjAC3R7QovxNYn3FuXlgEqBhU&hl=es&ll=39.47579838925011%2C-0.37267699999999904&z=14', 0, 27)
INSERT [dbo].[Eventos] ([EventoID], [NombreEvento], [TipoEventoID], [Fecha], [Ubicacion], [Provincia], [Aforo], [Imagen], [Recinto], [MayorDe18], [Descripcion], [LinkMapsProvincia], [EntradasVendidas], [Precio]) VALUES (63, N'Bombastic PortAventura', 3, CAST(N'2024-07-04' AS Date), N'Portaventura', 2, 5, N'Captura de pantalla 2024-03-19 001102.png', 20, 0, N'El Primer Festival en PortAventura', N'https://www.google.com/maps/d/u/0/viewer?mid=1mhHjAC3R7QovxNYn3FuXlgEqBhU&hl=es&ll=39.47579838925011%2C-0.37267699999999904&z=14', 0, 280)
SET IDENTITY_INSERT [dbo].[Eventos] OFF
GO
SET IDENTITY_INSERT [dbo].[Provincias] ON 

INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (1, N'Madrid')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (2, N'Barcelona')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (3, N'Valencia')
SET IDENTITY_INSERT [dbo].[Provincias] OFF
GO
INSERT [dbo].[Roles] ([RolID], [NombreRol]) VALUES (1, N'Usuario')
INSERT [dbo].[Roles] ([RolID], [NombreRol]) VALUES (2, N'Artista')
INSERT [dbo].[Roles] ([RolID], [NombreRol]) VALUES (3, N'Recinto')
GO
INSERT [dbo].[TiposEventos] ([TipoEventoID], [Tipo], [Imagen]) VALUES (1, N'Fiesta', N'fiestaimagen.png')
INSERT [dbo].[TiposEventos] ([TipoEventoID], [Tipo], [Imagen]) VALUES (2, N'Concierto', N'conciertoimagen.png')
INSERT [dbo].[TiposEventos] ([TipoEventoID], [Tipo], [Imagen]) VALUES (3, N'Festival', N'festival.png')
GO
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([UsuarioID], [NombreUsuario], [FotoPerfil], [Correo], [Telefono], [ProvinciaID], [Descripcion], [RolID], [Password], [Salt], [Activo], [TokenMail]) VALUES (14, N'Sejo', N'default-user.png', N'sejo.monterocastro@gmail.com', N'', 1, N'', 1, 0xB84DAE7832136C7FAE9A125286B4AA2F91F46D84E93DD6F56FD583F6C9D18DA781C912A0D2CDDE5E954B962FC061887D8F0506C6DAD6CE0994F8E46F95BCFE04, N'1k°k	¶«²©¯Ãª"©F«<fB''åh»MÌiÌ>)ª£ÕÕ¶±!u½8ãâ÷Ç', 1, N'hI_B^X_KjwBGBy')
INSERT [dbo].[Usuarios] ([UsuarioID], [NombreUsuario], [FotoPerfil], [Correo], [Telefono], [ProvinciaID], [Descripcion], [RolID], [Password], [Salt], [Activo], [TokenMail]) VALUES (15, N'Independance Club', N'independance.png', N'independanceclub@gmail.com', N'', 1, N'', 3, 0xADA195D6A7E604345E8CE3CD59570756F5A1EA6C409935C6832DF0F4414D41D9019CD8655305FE1572C86D823B3836AA5C7F2984748DD27B6A381327111A26BA, N'³^/à@ReÜËNþr4>8E6u.Dk÷C©MÑÛ%	«1½)µ£ÝuI', 1, N'wdxuHoUDNJQhMF')
INSERT [dbo].[Usuarios] ([UsuarioID], [NombreUsuario], [FotoPerfil], [Correo], [Telefono], [ProvinciaID], [Descripcion], [RolID], [Password], [Salt], [Activo], [TokenMail]) VALUES (16, N'Wizink', N'wizink.png', N'wizink@gmail.com', N'', 1, N'', 3, 0xFF52E4D1CFD7A69EC6B5FFCD427F7018260067B734F82858A9B84ABD558FE6DB84A1FCF3DE5A618E2FB29BED6D6D816117C040C462BFA69F52FE3764292CCCA9, N'3-3N\ÑLÄñk}2í"ÀjÃ©bÁR%«Ìö®ÓèB«I,ðÐ^¡¿Laê', 1, N'cYWCOiET^vFvAy')
INSERT [dbo].[Usuarios] ([UsuarioID], [NombreUsuario], [FotoPerfil], [Correo], [Telefono], [ProvinciaID], [Descripcion], [RolID], [Password], [Salt], [Activo], [TokenMail]) VALUES (17, N'LA RIVIERA', N'riviera.png', N'lariviera@gmail.com', N'', 1, N'', 3, 0x0880ADB3A16F1AC70585E1D2EA12961E5E727B795D928B0BD39EF6B693A95D28F6BA2C4AEFFAE49BCEAE4ACC6F08EB8BF3845CC951C12BE155B51D731E2583BB, N'=Á¹Ãó?´9¿ZHoï½k÷xbíï}÷èÇìÒÈ·÷Ý«,ÝríPÜóÐqKø', 1, N'MZehNwy[fbopKw')
INSERT [dbo].[Usuarios] ([UsuarioID], [NombreUsuario], [FotoPerfil], [Correo], [Telefono], [ProvinciaID], [Descripcion], [RolID], [Password], [Salt], [Activo], [TokenMail]) VALUES (18, N'Teatro Magno', N'magno.png', N'teatromagno@gmail.com', N'', 1, N'', 3, 0xE70B2A24C7FD3A3D33CB53149ABD5AF88F718D2C9FAE2323E7B51CA05F82AE353AC7997A87904E549702A573EA426538007CB81DFC897AE48154ABA49018CB30, N'ñI±hQï%h?½
fu4¬sÑ''öqË§+ál\{pñkiT4JbDÎÓ', 1, N'ViUvkRjbAkPOtH')
INSERT [dbo].[Usuarios] ([UsuarioID], [NombreUsuario], [FotoPerfil], [Correo], [Telefono], [ProvinciaID], [Descripcion], [RolID], [Password], [Salt], [Activo], [TokenMail]) VALUES (19, N'Parc del Fòrum', N'forum.png', N'parc@gmail.com', N'', 1, N'', 3, 0x2B69C1D4682498182FDC8184510C98692D5E5B54B5C09B1081E5F7A3319B6359365F015F76F03B5975B1A871A49446E86626A181F19D5EB13290452BE83782E3, N'f5¥T8JÚ¢õ}9l[ðèmNóEIøê,Àaä"ÇäpH×mÞÃñ|', 1, N'e]DIBPABUaPCRZ')
INSERT [dbo].[Usuarios] ([UsuarioID], [NombreUsuario], [FotoPerfil], [Correo], [Telefono], [ProvinciaID], [Descripcion], [RolID], [Password], [Salt], [Activo], [TokenMail]) VALUES (20, N'Bombastic', N'bombastic.png', N'bombastic@gmail.com', N'', 1, N'', 3, 0x2CC34656594E705FEC6F838398A8EE2781744C490FFD4A6273DBA887562D9C81403F4CB296E913A190445A655F5B1D5E4175E0CCD9325426D760609691FA9636, N'S31I<ó¿W{¥]0è¢«rLÄI½ÃmÅlé-Òãçù>jG`DèWÛj
®D', 1, N'bjmUMNOJ`Kur`d')
INSERT [dbo].[Usuarios] ([UsuarioID], [NombreUsuario], [FotoPerfil], [Correo], [Telefono], [ProvinciaID], [Descripcion], [RolID], [Password], [Salt], [Activo], [TokenMail]) VALUES (24, N'MVRK', N'mark.jpeg', N'mvrk@gmail.com', N'', 1, N'', 2, 0xB84DAE7832136C7FAE9A125286B4AA2F91F46D84E93DD6F56FD583F6C9D18DA781C912A0D2CDDE5E954B962FC061887D8F0506C6DAD6CE0994F8E46F95BCFE04, N'1k°k ¶«²© ¯Ãª"©F«<fB''åh»MÌiÌ>)ª£ÕÕ¶±!u½8ãâ÷Ç', 1, N'hI_B^X_KjwBGBy')
INSERT [dbo].[Usuarios] ([UsuarioID], [NombreUsuario], [FotoPerfil], [Correo], [Telefono], [ProvinciaID], [Descripcion], [RolID], [Password], [Salt], [Activo], [TokenMail]) VALUES (25, N'AGUS FORTNITE', N'agus.jpg', N'agus@gmail.com', N'', 1, N'', 2, 0xB84DAE7832136C7FAE9A125286B4AA2F91F46D84E93DD6F56FD583F6C9D18DA781C912A0D2CDDE5E954B962FC061887D8F0506C6DAD6CE0994F8E46F95BCFE04, N'1k°k ¶«²© ¯Ãª"©F«<fB''åh»MÌiÌ>)ª£ÕÕ¶±!u½8ãâ÷Ç', 1, N'hI_B^X_KjwBGBy')
INSERT [dbo].[Usuarios] ([UsuarioID], [NombreUsuario], [FotoPerfil], [Correo], [Telefono], [ProvinciaID], [Descripcion], [RolID], [Password], [Salt], [Activo], [TokenMail]) VALUES (26, N'Cigarettes After Sex', N'default-user.png', N'cigarettes@gmail.com', N'', 1, N'', 2, 0xB84DAE7832136C7FAE9A125286B4AA2F91F46D84E93DD6F56FD583F6C9D18DA781C912A0D2CDDE5E954B962FC061887D8F0506C6DAD6CE0994F8E46F95BCFE04, N'1k°k ¶«²© ¯Ãª"©F«<fB''åh»MÌiÌ>)ª£ÕÕ¶±!u½8ãâ÷Ç', 1, N'hI_B^X_KjwBGBy')
INSERT [dbo].[Usuarios] ([UsuarioID], [NombreUsuario], [FotoPerfil], [Correo], [Telefono], [ProvinciaID], [Descripcion], [RolID], [Password], [Salt], [Activo], [TokenMail]) VALUES (27, N'tarchi', N'tarchi.png', N'tarchi@gmail.com', N'', 1, N'', 2, 0xB84DAE7832136C7FAE9A125286B4AA2F91F46D84E93DD6F56FD583F6C9D18DA781C912A0D2CDDE5E954B962FC061887D8F0506C6DAD6CE0994F8E46F95BCFE04, N'1k°k ¶«²© ¯Ãª"©F«<fB''åh»MÌiÌ>)ª£ÕÕ¶±!u½8ãâ÷Ç', 1, N'hI_B^X_KjwBGBy')
INSERT [dbo].[Usuarios] ([UsuarioID], [NombreUsuario], [FotoPerfil], [Correo], [Telefono], [ProvinciaID], [Descripcion], [RolID], [Password], [Salt], [Activo], [TokenMail]) VALUES (28, N'Bad Gyal', N'BAD-GYAL.jpg', N'badgyal@gmail.com', N'', 1, N'', 2, 0xB84DAE7832136C7FAE9A125286B4AA2F91F46D84E93DD6F56FD583F6C9D18DA781C912A0D2CDDE5E954B962FC061887D8F0506C6DAD6CE0994F8E46F95BCFE04, N'1k°k ¶«²© ¯Ãª"©F«<fB''åh»MÌiÌ>)ª£ÕÕ¶±!u½8ãâ÷Ç', 1, N'hI_B^X_KjwBGBy')
INSERT [dbo].[Usuarios] ([UsuarioID], [NombreUsuario], [FotoPerfil], [Correo], [Telefono], [ProvinciaID], [Descripcion], [RolID], [Password], [Salt], [Activo], [TokenMail]) VALUES (29, N'Dano', N'default-user.png', N'dano@gmail.com', N'', 1, N'', 2, 0xB84DAE7832136C7FAE9A125286B4AA2F91F46D84E93DD6F56FD583F6C9D18DA781C912A0D2CDDE5E954B962FC061887D8F0506C6DAD6CE0994F8E46F95BCFE04, N'1k°k ¶«²© ¯Ãª"©F«<fB''åh»MÌiÌ>)ª£ÕÕ¶±!u½8ãâ÷Ç', 1, N'hI_B^X_KjwBGBy')
INSERT [dbo].[Usuarios] ([UsuarioID], [NombreUsuario], [FotoPerfil], [Correo], [Telefono], [ProvinciaID], [Descripcion], [RolID], [Password], [Salt], [Activo], [TokenMail]) VALUES (30, N'rusowsky', N'rusowsky.png', N'rusowsky@gmail.com', N'', 1, N'', 2, 0xB84DAE7832136C7FAE9A125286B4AA2F91F46D84E93DD6F56FD583F6C9D18DA781C912A0D2CDDE5E954B962FC061887D8F0506C6DAD6CE0994F8E46F95BCFE04, N'1k°k ¶«²© ¯Ãª"©F«<fB''åh»MÌiÌ>)ª£ÕÕ¶±!u½8ãâ÷Ç', 1, N'hI_B^X_KjwBGBy')
INSERT [dbo].[Usuarios] ([UsuarioID], [NombreUsuario], [FotoPerfil], [Correo], [Telefono], [ProvinciaID], [Descripcion], [RolID], [Password], [Salt], [Activo], [TokenMail]) VALUES (31, N'Fran DC', N'frandc.jpg', N'fran@gmail.com', N'', 1, N'', 2, 0xB84DAE7832136C7FAE9A125286B4AA2F91F46D84E93DD6F56FD583F6C9D18DA781C912A0D2CDDE5E954B962FC061887D8F0506C6DAD6CE0994F8E46F95BCFE04, N'1k°k ¶«²© ¯Ãª"©F«<fB''åh»MÌiÌ>)ª£ÕÕ¶±!u½8ãâ÷Ç', 1, N'hI_B^X_KjwBGBy')
INSERT [dbo].[Usuarios] ([UsuarioID], [NombreUsuario], [FotoPerfil], [Correo], [Telefono], [ProvinciaID], [Descripcion], [RolID], [Password], [Salt], [Activo], [TokenMail]) VALUES (32, N'K1za', N'K1ZA.jpg', N'k1za@gmail.com', N'', 1, N'', 2, 0xB84DAE7832136C7FAE9A125286B4AA2F91F46D84E93DD6F56FD583F6C9D18DA781C912A0D2CDDE5E954B962FC061887D8F0506C6DAD6CE0994F8E46F95BCFE04, N'1k°k ¶«²© ¯Ãª"©F«<fB''åh»MÌiÌ>)ª£ÕÕ¶±!u½8ãâ÷Ç', 1, N'hI_B^X_KjwBGBy')
INSERT [dbo].[Usuarios] ([UsuarioID], [NombreUsuario], [FotoPerfil], [Correo], [Telefono], [ProvinciaID], [Descripcion], [RolID], [Password], [Salt], [Activo], [TokenMail]) VALUES (33, N'Autechre', N'autechre.jpg', N'autechre@gmail.com', N'', 1, N'', 2, 0xB84DAE7832136C7FAE9A125286B4AA2F91F46D84E93DD6F56FD583F6C9D18DA781C912A0D2CDDE5E954B962FC061887D8F0506C6DAD6CE0994F8E46F95BCFE04, N'1k°k ¶«²© ¯Ãª"©F«<fB''åh»MÌiÌ>)ª£ÕÕ¶±!u½8ãâ÷Ç', 1, N'hI_B^X_KjwBGBy')
INSERT [dbo].[Usuarios] ([UsuarioID], [NombreUsuario], [FotoPerfil], [Correo], [Telefono], [ProvinciaID], [Descripcion], [RolID], [Password], [Salt], [Activo], [TokenMail]) VALUES (35, N'Bernabeu', N'default-user.png', N'bernabeu@gmail.com', N'', 1, N'', 3, 0xC6D731391696BE74940CFAA2FB4CC275EB037374BE01473293AEDFF1FBC27CBB547274D72614AD6B88391809783C6F7CB943523B17A115BB3F1680B5EAA335B1, N'âµÁÓ,èmÓNPófdB®Ù¦ÄÙ´aÕm¸¬¤íxrið©¡O`nK	#¯', 0, N'sXvhsRniioUfnJ')
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
GO
/****** Object:  Index [UQ__Seguimie__156927248AD9181B]    Script Date: 19/03/2024 13:06:26 ******/
ALTER TABLE [dbo].[Seguimientos] ADD UNIQUE NONCLUSTERED 
(
	[UsuarioIDSeguidor] ASC,
	[UsuarioIDSeguido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Eventos] ADD  CONSTRAINT [DF__Eventos__Entrada__5EBF139D]  DEFAULT ((0)) FOR [EntradasVendidas]
GO
ALTER TABLE [dbo].[Eventos] ADD  CONSTRAINT [DF__Eventos__Precio__656C112C]  DEFAULT ((0)) FOR [Precio]
GO
ALTER TABLE [dbo].[Artistas]  WITH CHECK ADD FOREIGN KEY([IdEvento])
REFERENCES [dbo].[Eventos] ([EventoID])
GO
ALTER TABLE [dbo].[ArtistasEvento]  WITH CHECK ADD  CONSTRAINT [FK__ArtistasE__Artis__34C8D9D1] FOREIGN KEY([ArtistaID])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[ArtistasEvento] CHECK CONSTRAINT [FK__ArtistasE__Artis__34C8D9D1]
GO
ALTER TABLE [dbo].[ArtistasEvento]  WITH CHECK ADD  CONSTRAINT [FK__ArtistasE__Event__37A5467C] FOREIGN KEY([EventoID])
REFERENCES [dbo].[Eventos] ([EventoID])
GO
ALTER TABLE [dbo].[ArtistasEvento] CHECK CONSTRAINT [FK__ArtistasE__Event__37A5467C]
GO
ALTER TABLE [dbo].[ArtistasEvento]  WITH CHECK ADD  CONSTRAINT [FK__ArtistasE__Event__5441852A] FOREIGN KEY([EventoID])
REFERENCES [dbo].[Eventos] ([EventoID])
GO
ALTER TABLE [dbo].[ArtistasEvento] CHECK CONSTRAINT [FK__ArtistasE__Event__5441852A]
GO
ALTER TABLE [dbo].[AsistenciasEventos]  WITH CHECK ADD  CONSTRAINT [FK_AsistenciasEventos_Eventos] FOREIGN KEY([EventoID])
REFERENCES [dbo].[Eventos] ([EventoID])
GO
ALTER TABLE [dbo].[AsistenciasEventos] CHECK CONSTRAINT [FK_AsistenciasEventos_Eventos]
GO
ALTER TABLE [dbo].[AsistenciasEventos]  WITH CHECK ADD  CONSTRAINT [FK_AsistenciasEventos_Usuarios] FOREIGN KEY([UsuarioID])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[AsistenciasEventos] CHECK CONSTRAINT [FK_AsistenciasEventos_Usuarios]
GO
ALTER TABLE [dbo].[Comentarios]  WITH CHECK ADD  CONSTRAINT [FK_Comentarios_Eventos] FOREIGN KEY([EventoID])
REFERENCES [dbo].[Eventos] ([EventoID])
GO
ALTER TABLE [dbo].[Comentarios] CHECK CONSTRAINT [FK_Comentarios_Eventos]
GO
ALTER TABLE [dbo].[Comentarios]  WITH CHECK ADD  CONSTRAINT [FK_Comentarios_Usuarios] FOREIGN KEY([UsuarioID])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[Comentarios] CHECK CONSTRAINT [FK_Comentarios_Usuarios]
GO
ALTER TABLE [dbo].[Eventos]  WITH CHECK ADD  CONSTRAINT [FK__Eventos__Provinc__3A81B327] FOREIGN KEY([Provincia])
REFERENCES [dbo].[Provincias] ([ProvinciaID])
GO
ALTER TABLE [dbo].[Eventos] CHECK CONSTRAINT [FK__Eventos__Provinc__3A81B327]
GO
ALTER TABLE [dbo].[Eventos]  WITH CHECK ADD  CONSTRAINT [FK__Eventos__Provinc__5629CD9C] FOREIGN KEY([Provincia])
REFERENCES [dbo].[Provincias] ([ProvinciaID])
GO
ALTER TABLE [dbo].[Eventos] CHECK CONSTRAINT [FK__Eventos__Provinc__5629CD9C]
GO
ALTER TABLE [dbo].[Eventos]  WITH CHECK ADD  CONSTRAINT [FK__Eventos__Recinto__398D8EEE] FOREIGN KEY([Recinto])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[Eventos] CHECK CONSTRAINT [FK__Eventos__Recinto__398D8EEE]
GO
ALTER TABLE [dbo].[Eventos]  WITH CHECK ADD  CONSTRAINT [FK__Eventos__TipoEve__3C69FB99] FOREIGN KEY([TipoEventoID])
REFERENCES [dbo].[TiposEventos] ([TipoEventoID])
GO
ALTER TABLE [dbo].[Eventos] CHECK CONSTRAINT [FK__Eventos__TipoEve__3C69FB99]
GO
ALTER TABLE [dbo].[Eventos]  WITH CHECK ADD  CONSTRAINT [FK__Eventos__TipoEve__571DF1D5] FOREIGN KEY([TipoEventoID])
REFERENCES [dbo].[TiposEventos] ([TipoEventoID])
GO
ALTER TABLE [dbo].[Eventos] CHECK CONSTRAINT [FK__Eventos__TipoEve__571DF1D5]
GO
ALTER TABLE [dbo].[Resenas]  WITH CHECK ADD  CONSTRAINT [FK__Resenas__RolRevi__3B75D760] FOREIGN KEY([RolReviewId])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[Resenas] CHECK CONSTRAINT [FK__Resenas__RolRevi__3B75D760]
GO
ALTER TABLE [dbo].[Resenas]  WITH CHECK ADD  CONSTRAINT [FK__Resenas__Usuario__3C69FB99] FOREIGN KEY([UsuarioID])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[Resenas] CHECK CONSTRAINT [FK__Resenas__Usuario__3C69FB99]
GO
ALTER TABLE [dbo].[Seguimientos]  WITH CHECK ADD  CONSTRAINT [FK__Seguimien__Usuar__3D5E1FD2] FOREIGN KEY([UsuarioIDSeguidor])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[Seguimientos] CHECK CONSTRAINT [FK__Seguimien__Usuar__3D5E1FD2]
GO
ALTER TABLE [dbo].[Seguimientos]  WITH CHECK ADD  CONSTRAINT [FK__Seguimien__Usuar__3E52440B] FOREIGN KEY([UsuarioIDSeguido])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[Seguimientos] CHECK CONSTRAINT [FK__Seguimien__Usuar__3E52440B]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [FK__Usuarios__Provin__3F466844] FOREIGN KEY([ProvinciaID])
REFERENCES [dbo].[Provincias] ([ProvinciaID])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [FK__Usuarios__Provin__3F466844]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [FK__Usuarios__RolID__403A8C7D] FOREIGN KEY([RolID])
REFERENCES [dbo].[Roles] ([RolID])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [FK__Usuarios__RolID__403A8C7D]
GO
ALTER TABLE [dbo].[Resenas]  WITH CHECK ADD CHECK  (([Puntuacion]>=(1) AND [Puntuacion]<=(5)))
GO
ALTER TABLE [dbo].[Resenas]  WITH CHECK ADD CHECK  (([Puntuacion]>=(1) AND [Puntuacion]<=(5)))
GO
/****** Object:  StoredProcedure [dbo].[SP_ALL_EVENTOS]    Script Date: 19/03/2024 13:06:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ALL_EVENTOS]
AS
BEGIN
    SELECT *
    FROM VISTA_DETALLES_EVENTO
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_ARTISTAS_EVENTO]    Script Date: 19/03/2024 13:06:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ARTISTAS_EVENTO](@idevento INT)
AS
BEGIN
    SELECT *
    FROM vista_detalle_artista
    WHERE EventoID = @idevento;
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_DETAILS_EVENTO]    Script Date: 19/03/2024 13:06:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DETAILS_EVENTO](@idevento INT)
AS
BEGIN
    SELECT *
    FROM VISTA_DETALLES_EVENTO
    WHERE EventoID = @idevento;
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_EVENTOS_ARTISTA]    Script Date: 19/03/2024 13:06:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_EVENTOS_ARTISTA]
    @idartista INT
AS
BEGIN
    SELECT *
    FROM VISTA_DETALLES_EVENTO
    WHERE EventoID IN (SELECT EventoID FROM ArtistasEvento WHERE ArtistaID = @idartista);
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_EVENTOS_TIPO]    Script Date: 19/03/2024 13:06:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_EVENTOS_TIPO](@tipoevento nvarchar(50))
AS
BEGIN
    SELECT *
    FROM VISTA_DETALLES_EVENTO
    WHERE TipoEvento = @tipoevento;
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_USUARIO_DETALLE]    Script Date: 19/03/2024 13:06:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_USUARIO_DETALLE]
    (@idusuario INT)
AS
BEGIN
    SELECT *
    FROM VISTA_DETALLE_USUARIO
    WHERE UsuarioID = @idusuario;
END;
GO
USE [master]
GO
ALTER DATABASE [SejoDB] SET  READ_WRITE 
GO
