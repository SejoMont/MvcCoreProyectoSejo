using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using MvcCoreProyectoSejo.Models;
using System.Diagnostics.Metrics;
#region VISTAS Y PROCEDURES
//CREATE VIEW VISTA_DETALLES_EVENTO AS
//SELECT
//    E.EventoID,
//    E.NombreEvento,
//    TE.Tipo AS TipoEvento,
//    E.Fecha,
//    E.Hora,
//    E.Ubicacion,
//    P.NombreProvincia AS Provincia,
//    E.Aforo,
//    E.Imagen,
//    U.NombreUsuario AS Recinto,
//    E.MayorDe18,
//    E.Descripcion,
//    E.LinkMapsProvincia
//FROM Eventos E
//JOIN TiposEventos TE ON E.TipoEventoID = TE.TipoEventoID
//JOIN Provincias P ON E.Provincia = P.ProvinciaID
//JOIN Usuarios U ON E.Recinto = U.UsuarioID;

//CREATE PROCEDURE SP_ALL_EVENTOS
//AS
//BEGIN
//    SELECT *
//    FROM VISTA_DETALLES_EVENTO
//END;

//CREATE PROCEDURE SP_DETAILS_EVENTO(@idevento INT)
//AS
//BEGIN
//    SELECT *
//    FROM VISTA_DETALLES_EVENTO
//    WHERE EventoID = @idevento;
//END;

//CREATE PROCEDURE SP_EVENTOS_TIPO(@tipoevento nvarchar(50))
//AS
//BEGIN
//    SELECT *
//    FROM VISTA_DETALLES_EVENTO
//    WHERE TipoEvento = @tipoevento;
//END;

//CREATE PROCEDURE SP_EVENTOS_ARTISTA
//    @idartista INT
//AS
//BEGIN
//    SELECT *
//    FROM VISTA_DETALLES_EVENTO
//    WHERE EventoID IN (SELECT EventoID FROM ArtistasEvento WHERE ArtistaID = @idartista);
//END;
#endregion

namespace MvcCoreProyectoSejo.Repository
{
    public class EventosRepository
    {
        private EventosContext context;

        public EventosRepository(EventosContext context)
        {
            this.context = context;
        }

        public async Task<List<EventoDetalles>> GetAllEventosAsync()
        {
            string sql = "SP_ALL_EVENTOS";
            var consulta = this.context.EventosDetalles.FromSqlRaw(sql);
            return await consulta.ToListAsync();
        }

        public async Task<EventoDetalles> GetDetallesEventoAsync(int idevento)
        {
            string sql = "SP_DETAILS_EVENTO @idevento";
            SqlParameter pamId = new SqlParameter("@idevento", idevento);
            var consulta = this.context.EventosDetalles.FromSqlRaw(sql, pamId);
            EventoDetalles eventoDetalle = consulta.AsEnumerable().FirstOrDefault();
            return eventoDetalle;
        }

        public async Task<List<TipoEvento>> GetTipoEventosAsync()
        {
            string sql = "select * from TiposEventos";
            var consulta = this.context.TiposEventos.FromSqlRaw(sql);
            return await consulta.ToListAsync();
        }

        public async Task<List<EventoDetalles>> GetAllEventosTipoAsync(string tipo)
        {
            string sql = "SP_EVENTOS_TIPO @tipoevento";
            SqlParameter pamTipo = new SqlParameter("@tipoevento", tipo);
            var consulta = this.context.EventosDetalles.FromSqlRaw(sql, pamTipo);
            return await consulta.ToListAsync();
        }

        public async Task<List<EventoDetalles>> GetAllEventosArtistaAsync(int idartista)
        {
            string sql = "SP_EVENTOS_ARTISTA @idartista";
            SqlParameter pamIdArtista= new SqlParameter("@idartista", idartista);
            var consulta = this.context.EventosDetalles.FromSqlRaw(sql, pamIdArtista);
            return await consulta.ToListAsync();
        }
    }
}
