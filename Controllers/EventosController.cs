using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MvcCoreProyectoSejo.Models;
using MvcCoreProyectoSejo.Repository;

public class EventosController : Controller
{
    private EventosRepository repo;
    private UsuariosRepository userRepo;

    public EventosController(EventosRepository repo, UsuariosRepository userRepo)
    {
        this.repo = repo;
        this.userRepo = userRepo;
    }

    public async Task<IActionResult> Index()
    {
        List<EventoDetalles> eventos = await this.repo.GetAllEventosAsync();
        List<TipoEvento> tipoEventos = await this.repo.GetTipoEventosAsync();

        ViewData["TipoEventos"] = tipoEventos;

        return View(eventos);
    }


    public async Task<IActionResult> TipoEvento(string tipo)
    {
        List<EventoDetalles> eventos = await this.repo.GetAllEventosTipoAsync(tipo);
        List<TipoEvento> tipoEventos = await this.repo.GetTipoEventosAsync();

        ViewData["TipoEventos"] = tipoEventos;

        return View(eventos);
    }

    public async Task<IActionResult> Details(int id)
    {
        EventoDetalles eventoDetalles = await this.repo.GetDetallesEventoAsync(id);
        List<ArtistaDetalles> artistas = await this.userRepo.GetAllArtistasEventoAsync(id);

        ViewData["Artistas"] = artistas;

        return View(eventoDetalles);
    }

}
