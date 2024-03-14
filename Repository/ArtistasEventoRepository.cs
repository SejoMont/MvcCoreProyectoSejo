using Microsoft.EntityFrameworkCore;
using MvcCoreProyectoSejo.Models;

namespace MvcCoreProyectoSejo.Repository
{
    public class ArtistasEventoRepository
    {
        private EventosContext context;

        public ArtistasEventoRepository(EventosContext context)
        {
            this.context = context;
        }

        public async Task AddArtistaToEvento(int idevento, int idartista)
        {
            ArtistaEvento artistaEvento = new ArtistaEvento
            {
                EventoID = idevento,
                ArtistaID = idartista
            };
            this.context.ArtistasEvento.Add(artistaEvento);
            await this.context.SaveChangesAsync();
        }
    }
}
