using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
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
//    E.Ubicacion,
//    P.NombreProvincia AS Provincia,
//    P.ProvinciaID,
//    E.Aforo,
//    E.Imagen,
//    U.NombreUsuario AS Recinto,
//    E.MayorDe18,
//    E.Descripcion,
//    E.Precio,
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
            var eventos = await this.context.EventosDetalles.ToListAsync();

            return eventos;
        }

        public async Task<EventoDetalles> GetDetallesEventoAsync(int idevento)
        {
            return await this.context.EventosDetalles.FirstOrDefaultAsync(z => z.Id == idevento);
        }

        public async Task<List<TipoEvento>> GetTipoEventosAsync()
        {
            var tiposevento = await this.context.TiposEventos.ToListAsync();

            return tiposevento;
        }

        public async Task<List<EventoDetalles>> GetAllEventosTipoAsync(string tipo)
        {
            var eventos = await this.context.EventosDetalles
                .Where(a => a.TipoEvento == tipo)
                .ToListAsync();

            return eventos;
        }

        public async Task<List<EventoDetalles>> GetAllEventosArtistaAsync(int idartista)
        {
            var eventos = await this.context.EventosDetalles
                .Where(e => this.context.ArtistasEvento.Any(ae => ae.ArtistaID == idartista && ae.EventoID == e.Id))
                .ToListAsync();

            return eventos;
        }

        public async Task<List<EventoDetalles>> GetAllEventosProvinciasAsync(int idprovincia)
        {
            var eventos = await this.context.EventosDetalles
                .Where(a => a.ProvinciaID == idprovincia)
                .ToListAsync();

            return eventos;
        }

        public async Task CrearEventoAsync(Evento evento)
        {
            context.Eventos.Add(evento);
            await context.SaveChangesAsync();
        }

        public async Task AsignarEntradasAsync(int idevento, int iduser, string nombre, string correo, string dni)
        {
            AsistenciaEvento nuevaEntrada = new AsistenciaEvento()
            {
                UsuarioID = iduser,
                EventoID = idevento,
                Nombre = nombre,
                Correo = correo,
                Dni = dni
            };
            context.AsistenciasEventos.Add(nuevaEntrada);
        }

        public async Task RestarEntrada(int idevento)
        {
            // Obtener el evento por su ID
            var evento = await context.Eventos.FindAsync(idevento);

            // Verificar si se encontró el evento
            if (evento != null)
            {
                // Verificar si hay entradas disponibles para restar
                if (evento.EntradasVendidas < evento.Aforo)
                {
                    // Restar una entrada
                    evento.EntradasVendidas++;

                    // Guardar los cambios en la base de datos
                    await context.SaveChangesAsync();
                }
                else
                {
                    throw new InvalidOperationException("El aforo ya está completo.");
                }
            }
            else
            {
                throw new InvalidOperationException("El evento no existe.");
            }
        }


    }
}
