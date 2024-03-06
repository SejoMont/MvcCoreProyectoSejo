USE [SejoDB]
GO
/****** Object:  Table [dbo].[Eventos]    Script Date: 06/03/2024 9:57:00 ******/
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
PRIMARY KEY CLUSTERED 
(
	[EventoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Provincias]    Script Date: 06/03/2024 9:57:00 ******/
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
/****** Object:  Table [dbo].[TiposEventos]    Script Date: 06/03/2024 9:57:00 ******/
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
/****** Object:  Table [dbo].[Usuarios]    Script Date: 06/03/2024 9:57:00 ******/
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
/****** Object:  View [dbo].[VISTA_DETALLES_EVENTO]    Script Date: 06/03/2024 9:57:00 ******/
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
    E.LinkMapsProvincia
FROM Eventos E
JOIN TiposEventos TE ON E.TipoEventoID = TE.TipoEventoID
JOIN Provincias P ON E.Provincia = P.ProvinciaID
JOIN Usuarios U ON E.Recinto = U.UsuarioID;
GO
/****** Object:  Table [dbo].[ArtistasEvento]    Script Date: 06/03/2024 9:57:00 ******/
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
/****** Object:  Table [dbo].[Roles]    Script Date: 06/03/2024 9:57:00 ******/
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
/****** Object:  View [dbo].[VISTA_DETALLE_USUARIO]    Script Date: 06/03/2024 9:57:00 ******/
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
    U.Descripcion,
    R.NombreRol,
    AE.EventoID
FROM Usuarios U
INNER JOIN ArtistasEvento AE ON U.UsuarioID = AE.ArtistaID
INNER JOIN Roles R ON U.RolID = R.RolID;


GO
/****** Object:  Table [dbo].[AsistenciasEventos]    Script Date: 06/03/2024 9:57:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AsistenciasEventos](
	[AsistenciaID] [int] IDENTITY(1,1) NOT NULL,
	[UsuarioID] [int] NULL,
	[EventoID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[AsistenciaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Resenas]    Script Date: 06/03/2024 9:57:00 ******/
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
/****** Object:  Table [dbo].[Seguimientos]    Script Date: 06/03/2024 9:57:00 ******/
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
ALTER TABLE [dbo].[ArtistasEvento]  WITH CHECK ADD  CONSTRAINT [FK__ArtistasE__Artis__34C8D9D1] FOREIGN KEY([ArtistaID])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[ArtistasEvento] CHECK CONSTRAINT [FK__ArtistasE__Artis__34C8D9D1]
GO
ALTER TABLE [dbo].[ArtistasEvento]  WITH CHECK ADD FOREIGN KEY([EventoID])
REFERENCES [dbo].[Eventos] ([EventoID])
GO
ALTER TABLE [dbo].[AsistenciasEventos]  WITH CHECK ADD FOREIGN KEY([EventoID])
REFERENCES [dbo].[Eventos] ([EventoID])
GO
ALTER TABLE [dbo].[AsistenciasEventos]  WITH CHECK ADD  CONSTRAINT [FK__Asistenci__Usuar__37A5467C] FOREIGN KEY([UsuarioID])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[AsistenciasEventos] CHECK CONSTRAINT [FK__Asistenci__Usuar__37A5467C]
GO
ALTER TABLE [dbo].[Eventos]  WITH CHECK ADD FOREIGN KEY([Provincia])
REFERENCES [dbo].[Provincias] ([ProvinciaID])
GO
ALTER TABLE [dbo].[Eventos]  WITH CHECK ADD  CONSTRAINT [FK__Eventos__Recinto__398D8EEE] FOREIGN KEY([Recinto])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[Eventos] CHECK CONSTRAINT [FK__Eventos__Recinto__398D8EEE]
GO
ALTER TABLE [dbo].[Eventos]  WITH CHECK ADD FOREIGN KEY([TipoEventoID])
REFERENCES [dbo].[TiposEventos] ([TipoEventoID])
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
/****** Object:  StoredProcedure [dbo].[SP_ALL_EVENTOS]    Script Date: 06/03/2024 9:57:00 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_ARTISTAS_EVENTO]    Script Date: 06/03/2024 9:57:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ARTISTAS_EVENTO]
    (@idevento INT)
AS
BEGIN
    SELECT *
    FROM VISTA_DETALLE_USUARIO
    WHERE EventoID = @idevento;
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_DETAILS_EVENTO]    Script Date: 06/03/2024 9:57:00 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_EVENTOS_ARTISTA]    Script Date: 06/03/2024 9:57:00 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_EVENTOS_TIPO]    Script Date: 06/03/2024 9:57:00 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_USUARIO_DETALLE]    Script Date: 06/03/2024 9:57:00 ******/
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
