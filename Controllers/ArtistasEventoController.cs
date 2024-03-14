using Microsoft.AspNetCore.Mvc;
using MvcCoreProyectoSejo.Models;
using MvcCoreProyectoSejo.Repository;

namespace MvcCoreProyectoSejo.Controllers
{
    public class ArtistasEventoController : Controller
    {
        private ArtistasEventoRepository repo;
        private EventosRepository eventosRepository;
        private UsuariosRepository usuariosRepository;

        public ArtistasEventoController(ArtistasEventoRepository repo, EventosRepository eventosRepository, UsuariosRepository usuariosRepository)
        {
            this.repo = repo;
            this.eventosRepository = eventosRepository;
            this.usuariosRepository = usuariosRepository;
        }
        public async Task<IActionResult> AddArtistaToEvento(int idevento)
        {
            EventoDetalles evento = await this.eventosRepository.GetDetallesEventoAsync(idevento);
            List<UsuarioDetalles> artistas = await this.usuariosRepository.GetAllArtistas();

            ViewData["Evento"] = evento;

            return View(artistas);
        }

        [HttpPost]
        public async Task<IActionResult> AddArtistaToEvento(int idevento, int idartista)
        {
            await this.repo.AddArtistaToEvento(idevento, idartista);
            return RedirectToAction("Index", "Eventos");
        }
    }
}
