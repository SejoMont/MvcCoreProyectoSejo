USE [master]
GO
/****** Object:  Database [SejoDB]    Script Date: 06/03/2024 22:44:52 ******/
CREATE DATABASE [SejoDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SejoDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\SejoDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SejoDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\SejoDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
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
/****** Object:  Table [dbo].[Provincias]    Script Date: 06/03/2024 22:44:53 ******/
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
/****** Object:  Table [dbo].[TiposEventos]    Script Date: 06/03/2024 22:44:53 ******/
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
/****** Object:  Table [dbo].[Usuarios]    Script Date: 06/03/2024 22:44:53 ******/
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
/****** Object:  Table [dbo].[Eventos]    Script Date: 06/03/2024 22:44:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Eventos](
	[EventoID] [int] IDENTITY(1,1) NOT NULL,
	[NombreEvento] [varchar](100) NOT NULL,
	[TipoEventoID] [int] NULL,
	[Fecha] [date] NOT NULL,
	[Hora] [time](7) NOT NULL,
	[Ubicacion] [varchar](100) NULL,
	[Provincia] [int] NULL,
	[Aforo] [int] NOT NULL,
	[Imagen] [varchar](255) NULL,
	[Recinto] [int] NULL,
	[MayorDe18] [bit] NOT NULL,
	[Descripcion] [varchar](300) NULL,
	[LinkMapsProvincia] [varchar](255) NULL,
	[EntradasVendidas] [int] NOT NULL,
	[AforoCompleto] [bit] NOT NULL,
	[Precio] [int] NOT NULL,
 CONSTRAINT [PK__Eventos__1EEB5901B0FEB3C4] PRIMARY KEY CLUSTERED 
(
	[EventoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VISTA_DETALLES_EVENTO]    Script Date: 06/03/2024 22:44:53 ******/
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
    E.Hora,
    E.Ubicacion,
    P.NombreProvincia AS Provincia,
    E.Aforo,
    E.Imagen,
    U.NombreUsuario AS Recinto,
    E.MayorDe18,
    E.Descripcion,
    E.Precio,
    E.LinkMapsProvincia
FROM Eventos E
JOIN TiposEventos TE ON E.TipoEventoID = TE.TipoEventoID
JOIN Provincias P ON E.Provincia = P.ProvinciaID
JOIN Usuarios U ON E.Recinto = U.UsuarioID;
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 06/03/2024 22:44:53 ******/
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
/****** Object:  View [dbo].[VISTA_DETALLE_USUARIO]    Script Date: 06/03/2024 22:44:53 ******/
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
    R.NombreRol
FROM Usuarios U
INNER JOIN Roles R ON U.RolID = R.RolID
INNER JOIN Provincias P ON U.ProvinciaID = P.ProvinciaID;  
GO
/****** Object:  Table [dbo].[ArtistasEvento]    Script Date: 06/03/2024 22:44:53 ******/
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
/****** Object:  View [dbo].[vista_detalle_artista]    Script Date: 06/03/2024 22:44:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vista_detalle_artista] as
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
/****** Object:  Table [dbo].[AsistenciasEventos]    Script Date: 06/03/2024 22:44:53 ******/
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
/****** Object:  Table [dbo].[Resenas]    Script Date: 06/03/2024 22:44:53 ******/
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
/****** Object:  Table [dbo].[Seguimientos]    Script Date: 06/03/2024 22:44:53 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[UsuarioIDSeguidor] ASC,
	[UsuarioIDSeguido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Eventos] ADD  CONSTRAINT [DF__Eventos__Entrada__5EBF139D]  DEFAULT ((0)) FOR [EntradasVendidas]
GO
ALTER TABLE [dbo].[Eventos] ADD  CONSTRAINT [DF__Eventos__AforoCo__5FB337D6]  DEFAULT ((0)) FOR [AforoCompleto]
GO
ALTER TABLE [dbo].[Eventos] ADD  CONSTRAINT [DF__Eventos__Precio__656C112C]  DEFAULT ((0)) FOR [Precio]
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
/****** Object:  StoredProcedure [dbo].[SP_ALL_EVENTOS]    Script Date: 06/03/2024 22:44:53 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_ARTISTAS_EVENTO]    Script Date: 06/03/2024 22:44:53 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_DETAILS_EVENTO]    Script Date: 06/03/2024 22:44:53 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_EVENTOS_ARTISTA]    Script Date: 06/03/2024 22:44:53 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_EVENTOS_TIPO]    Script Date: 06/03/2024 22:44:53 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_USUARIO_DETALLE]    Script Date: 06/03/2024 22:44:53 ******/
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
