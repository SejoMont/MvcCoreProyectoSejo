using Microsoft.EntityFrameworkCore;
using MvcCoreProyectoSejo.Models;

namespace MvcCoreProyectoSejo.Repository
{
    public class EventosRepository
    {
        private EventosContext context;

        public EventosRepository(EventosContext context)
        {
            this.context = context;
        }

        public async Task<List<Evento>> GetAllEventosAsync()
        {
            string sql = "select * from eventos";
            var consulta = this.context.Eventos
                .FromSqlRaw(sql);
            return await consulta.ToListAsync();
        }

 
    }
}
