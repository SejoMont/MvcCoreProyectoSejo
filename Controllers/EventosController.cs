using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MvcCoreProyectoSejo.Models;
using MvcCoreProyectoSejo.Repository;

public class EventosController : Controller
{
    private EventosRepository repo;
    private UsuariosRepository userRepo;
    private ProvinciasRepository provinciasRepo;

    public EventosController(EventosRepository repo, UsuariosRepository userRepo, ProvinciasRepository provinciasRepo)
    {
        this.repo = repo;
        this.userRepo = userRepo;
        this.provinciasRepo = provinciasRepo;
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

    public IActionResult CrearEvento()
    {
        ViewData["Provincias"] = this.provinciasRepo.GetAllProvinciassAsync().Result;
        ViewData["TiposEventos"] = this.repo.GetTipoEventosAsync().Result;
        return View();
    }

    [HttpPost]
    public async Task<IActionResult> CrearEvento(string NombreEvento, int TipoEventoID, DateTime Fecha, string Ubicacion, int Provincia, int Aforo, string Imagen, int Recinto, bool MayorDe18, string Descripcion, string LinkMapsProvincia, decimal Precio)
    {
        try
        {
            // Mapear el modelo de vista a la entidad de Evento
            var nuevoEvento = new Evento
            {
                NombreEvento = NombreEvento,
                Fecha = Fecha,
                TipoEventoID = TipoEventoID,
                Ubicacion = Ubicacion,
                Provincia = Provincia,
                Aforo = Aforo,
                Imagen = Imagen,
                Recinto = Recinto,
                MayorDe18 = MayorDe18,
                Descripcion = Descripcion,
                LinkMapsProvincia = LinkMapsProvincia,
                EntradasVendidas = 0,
                AforoCompleto = false,
                Precio = Precio
            };

            // Llamar al repositorio para crear el evento (asincrónico)
            await this.repo.CrearEventoAsync(nuevoEvento);

            // Esperar hasta que la operación asincrónica se complete
            await Task.Delay(1);

            // Redirigir a la página de detalles del evento recién creado
            return RedirectToAction("Details", new { id = nuevoEvento.EventoID });
        }
        catch (Exception ex)
        {
            // Loguear la excepción o manejarla de alguna otra manera
            ModelState.AddModelError(string.Empty, "Error al procesar la solicitud. Por favor, inténtalo de nuevo.");
            return View("CrearEvento");
        }
    }

}
