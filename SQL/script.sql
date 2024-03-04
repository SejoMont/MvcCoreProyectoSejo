USE [SejoDB]
GO
/****** Object:  Table [dbo].[Eventos]    Script Date: 04/03/2024 22:05:21 ******/
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
/****** Object:  Table [dbo].[Provincias]    Script Date: 04/03/2024 22:05:22 ******/
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
/****** Object:  Table [dbo].[TiposEventos]    Script Date: 04/03/2024 22:05:22 ******/
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
/****** Object:  Table [dbo].[Usuarios]    Script Date: 04/03/2024 22:05:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[UsuarioID] [int] IDENTITY(1,1) NOT NULL,
	[NombreUsuario] [varchar](50) NOT NULL,
	[FotoPerfil] [varchar](255) NULL,
	[Correo] [varchar](100) NOT NULL,
	[Telefono] [varchar](15) NOT NULL,
	[ProvinciaID] [int] NULL,
	[Descripcion] [varchar](300) NULL,
	[RolID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[UsuarioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VISTA_DETALLES_EVENTO]    Script Date: 04/03/2024 22:05:22 ******/
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
/****** Object:  Table [dbo].[ArtistasEvento]    Script Date: 04/03/2024 22:05:22 ******/
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
/****** Object:  Table [dbo].[Roles]    Script Date: 04/03/2024 22:05:22 ******/
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
/****** Object:  View [dbo].[VISTA_DETALLE_USUARIO]    Script Date: 04/03/2024 22:05:22 ******/
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
/****** Object:  Table [dbo].[AsistenciasEventos]    Script Date: 04/03/2024 22:05:22 ******/
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
/****** Object:  Table [dbo].[Resenas]    Script Date: 04/03/2024 22:05:22 ******/
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
/****** Object:  Table [dbo].[Seguimientos]    Script Date: 04/03/2024 22:05:22 ******/
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

INSERT [dbo].[ArtistasEvento] ([ArtistaEventoID], [ArtistaID], [EventoID]) VALUES (1, 2, 1)
INSERT [dbo].[ArtistasEvento] ([ArtistaEventoID], [ArtistaID], [EventoID]) VALUES (2, 2, 2)
INSERT [dbo].[ArtistasEvento] ([ArtistaEventoID], [ArtistaID], [EventoID]) VALUES (3, 1, 1)
SET IDENTITY_INSERT [dbo].[ArtistasEvento] OFF
GO
SET IDENTITY_INSERT [dbo].[AsistenciasEventos] ON 

INSERT [dbo].[AsistenciasEventos] ([AsistenciaID], [UsuarioID], [EventoID]) VALUES (1, 1, 1)
INSERT [dbo].[AsistenciasEventos] ([AsistenciaID], [UsuarioID], [EventoID]) VALUES (2, 1, 2)
SET IDENTITY_INSERT [dbo].[AsistenciasEventos] OFF
GO
SET IDENTITY_INSERT [dbo].[Eventos] ON 

INSERT [dbo].[Eventos] ([EventoID], [NombreEvento], [TipoEventoID], [Fecha], [Hora], [Ubicacion], [Provincia], [Aforo], [Imagen], [Recinto], [MayorDe18], [Descripcion], [LinkMapsProvincia]) VALUES (1, N'Concierto A', 1, CAST(N'2024-04-01' AS Date), CAST(N'20:00:00' AS Time), N'Ubicacion A', 1, 500, N'url_imagen_conciertoA.jpg', 3, 1, N'Descripción del concierto A.', N'url_maps_provincia_A')
INSERT [dbo].[Eventos] ([EventoID], [NombreEvento], [TipoEventoID], [Fecha], [Hora], [Ubicacion], [Provincia], [Aforo], [Imagen], [Recinto], [MayorDe18], [Descripcion], [LinkMapsProvincia]) VALUES (2, N'Festival B', 2, CAST(N'2024-05-15' AS Date), CAST(N'18:30:00' AS Time), N'Ubicacion B', 2, 1000, N'url_imagen_festivalB.jpg', 3, 0, N'Descripción del festival B.', N'url_maps_provincia_B')
SET IDENTITY_INSERT [dbo].[Eventos] OFF
GO
SET IDENTITY_INSERT [dbo].[Provincias] ON 

INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (1, N'Álava')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (2, N'Albacete')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (3, N'Alicante')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (4, N'Almería')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (5, N'Asturias')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (6, N'Ávila')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (7, N'Badajoz')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (8, N'Barcelona')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (9, N'Burgos')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (10, N'Cáceres')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (11, N'Cádiz')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (12, N'Cantabria')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (13, N'Castellón')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (14, N'Ciudad Real')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (15, N'Córdoba')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (16, N'Cuenca')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (17, N'Gerona')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (18, N'Granada')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (19, N'Guadalajara')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (20, N'Guipúzcoa')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (21, N'Huelva')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (22, N'Huesca')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (23, N'Islas Baleares')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (24, N'Jaén')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (25, N'La Coruña')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (26, N'La Rioja')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (27, N'Las Palmas')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (28, N'León')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (29, N'Lérida')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (30, N'Lugo')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (31, N'Madrid')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (32, N'Málaga')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (33, N'Murcia')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (34, N'Navarra')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (35, N'Orense')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (36, N'Palencia')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (37, N'Pontevedra')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (38, N'Salamanca')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (39, N'Santa Cruz de Tenerife')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (40, N'Segovia')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (41, N'Sevilla')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (42, N'Soria')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (43, N'Tarragona')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (44, N'Teruel')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (45, N'Toledo')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (46, N'Valencia')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (47, N'Valladolid')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (48, N'Vizcaya')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (49, N'Zamora')
INSERT [dbo].[Provincias] ([ProvinciaID], [NombreProvincia]) VALUES (50, N'Zaragoza')
SET IDENTITY_INSERT [dbo].[Provincias] OFF
GO
SET IDENTITY_INSERT [dbo].[Resenas] ON 

INSERT [dbo].[Resenas] ([ResenaID], [UsuarioID], [RolReviewId], [Comentario], [Puntuacion], [FechaResena]) VALUES (1, 1, 2, N'Buena actuación del artista en el concierto A.', 5, CAST(N'2024-04-02' AS Date))
INSERT [dbo].[Resenas] ([ResenaID], [UsuarioID], [RolReviewId], [Comentario], [Puntuacion], [FechaResena]) VALUES (2, 1, 3, N'Excelente organización del recinto en el festival B.', 4, CAST(N'2024-05-16' AS Date))
SET IDENTITY_INSERT [dbo].[Resenas] OFF
GO
INSERT [dbo].[Roles] ([RolID], [NombreRol]) VALUES (1, N'Corriente')
INSERT [dbo].[Roles] ([RolID], [NombreRol]) VALUES (2, N'Artista')
INSERT [dbo].[Roles] ([RolID], [NombreRol]) VALUES (3, N'Recinto')
GO
SET IDENTITY_INSERT [dbo].[Seguimientos] ON 

INSERT [dbo].[Seguimientos] ([SeguimientoID], [UsuarioIDSeguidor], [UsuarioIDSeguido]) VALUES (1, 1, 2)
INSERT [dbo].[Seguimientos] ([SeguimientoID], [UsuarioIDSeguidor], [UsuarioIDSeguido]) VALUES (2, 1, 3)
SET IDENTITY_INSERT [dbo].[Seguimientos] OFF
GO
INSERT [dbo].[TiposEventos] ([TipoEventoID], [Tipo], [Imagen]) VALUES (1, N'Concierto', N'')
INSERT [dbo].[TiposEventos] ([TipoEventoID], [Tipo], [Imagen]) VALUES (2, N'Festival', N'')
GO
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([UsuarioID], [NombreUsuario], [FotoPerfil], [Correo], [Telefono], [ProvinciaID], [Descripcion], [RolID]) VALUES (1, N'UsuarioCorriente', N'url_foto_corriente.jpg', N'corriente@example.com', N'123456789', 1, N'Descripción de usuario corriente.', 1)
INSERT [dbo].[Usuarios] ([UsuarioID], [NombreUsuario], [FotoPerfil], [Correo], [Telefono], [ProvinciaID], [Descripcion], [RolID]) VALUES (2, N'Artista1', N'url_foto_artista1.jpg', N'artista1@example.com', N'987654321', 2, N'Descripción de artista.', 2)
INSERT [dbo].[Usuarios] ([UsuarioID], [NombreUsuario], [FotoPerfil], [Correo], [Telefono], [ProvinciaID], [Descripcion], [RolID]) VALUES (3, N'Recinto1', N'url_foto_recinto1.jpg', N'recinto1@example.com', N'567890123', 3, N'Descripción de recinto.', 3)
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
GO
/****** Object:  Index [UQ__Seguimie__1569272475C15837]    Script Date: 04/03/2024 22:05:22 ******/
ALTER TABLE [dbo].[Seguimientos] ADD UNIQUE NONCLUSTERED 
(
	[UsuarioIDSeguidor] ASC,
	[UsuarioIDSeguido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ArtistasEvento]  WITH CHECK ADD FOREIGN KEY([ArtistaID])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[ArtistasEvento]  WITH CHECK ADD FOREIGN KEY([EventoID])
REFERENCES [dbo].[Eventos] ([EventoID])
GO
ALTER TABLE [dbo].[AsistenciasEventos]  WITH CHECK ADD FOREIGN KEY([EventoID])
REFERENCES [dbo].[Eventos] ([EventoID])
GO
ALTER TABLE [dbo].[AsistenciasEventos]  WITH CHECK ADD FOREIGN KEY([UsuarioID])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[Eventos]  WITH CHECK ADD FOREIGN KEY([Provincia])
REFERENCES [dbo].[Provincias] ([ProvinciaID])
GO
ALTER TABLE [dbo].[Eventos]  WITH CHECK ADD FOREIGN KEY([Recinto])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[Eventos]  WITH CHECK ADD FOREIGN KEY([TipoEventoID])
REFERENCES [dbo].[TiposEventos] ([TipoEventoID])
GO
ALTER TABLE [dbo].[Resenas]  WITH CHECK ADD FOREIGN KEY([RolReviewId])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[Resenas]  WITH CHECK ADD FOREIGN KEY([UsuarioID])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[Seguimientos]  WITH CHECK ADD FOREIGN KEY([UsuarioIDSeguidor])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[Seguimientos]  WITH CHECK ADD FOREIGN KEY([UsuarioIDSeguido])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD FOREIGN KEY([ProvinciaID])
REFERENCES [dbo].[Provincias] ([ProvinciaID])
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD FOREIGN KEY([RolID])
REFERENCES [dbo].[Roles] ([RolID])
GO
ALTER TABLE [dbo].[Resenas]  WITH CHECK ADD CHECK  (([Puntuacion]>=(1) AND [Puntuacion]<=(5)))
GO
/****** Object:  StoredProcedure [dbo].[SP_ALL_EVENTOS]    Script Date: 04/03/2024 22:05:22 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_ARTISTAS_EVENTO]    Script Date: 04/03/2024 22:05:22 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_DETAILS_EVENTO]    Script Date: 04/03/2024 22:05:22 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_EVENTOS_TIPO]    Script Date: 04/03/2024 22:05:22 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_USUARIO_DETALLE]    Script Date: 04/03/2024 22:05:22 ******/
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
