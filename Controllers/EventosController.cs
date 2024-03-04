using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MvcCoreProyectoSejo.Models;
using MvcCoreProyectoSejo.Repository;

public class EventosController : Controller
{
    private EventosRepository repo;

    public EventosController(EventosRepository repo)
    {
        this.repo = repo;
    }

    public async Task<IActionResult> Index()
    {
        List<EventoDetalles> eventos = await this.repo.GetAllEventosAsync();
        List<TipoEvento> tipoEventos = await this.repo.GetTipoEventosAsync();

        ViewData["TipoEventos"] = tipoEventos;

        return View(eventos);
    }

    public async Task<IActionResult> Details(int id)
    {
        EventoDetalles eventoDetalles = await this.repo.GetDetallesEventoAsync(id);
        List<UsuarioDetalles> artistas = await this.repo.GetAllArtistasEventoAsync(id);

        ViewData["Artistas"] = artistas;

        return View(eventoDetalles);
    }

    public async Task<IActionResult> TipoEvento(string tipo)
    {
        List<EventoDetalles> eventos = await this.repo.GetAllEventosTipoAsync(tipo);
        List<TipoEvento> tipoEventos = await this.repo.GetTipoEventosAsync();

        ViewData["TipoEventos"] = tipoEventos;

        return View(eventos);
    }

    public async Task<IActionResult> DetalleUsers(int iduser)
    {
        UsuarioDetalles usuarioDetalles = await this.repo.GetUsuarioDetalles(iduser);

        return View(usuarioDetalles);
    }
}
