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
        List<Evento> eventos =
            await this.repo.GetAllEventosAsync();
        return View(eventos);
    }
}
