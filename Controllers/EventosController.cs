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

    [HttpGet]
    public async Task<IActionResult> Index(int? iduser, [FromQuery] FiltroEvento filtro)
    {
        List<EventoDetalles> eventos = new List<EventoDetalles>();
        List<TipoEvento> tipoEventos = await this.repo.GetTipoEventosAsync();
        List<Provincia> provincias = await this.provinciasRepo.GetAllProvinciassAsync();

        if (iduser != null)
        {
            UsuarioDetalles user = await this.userRepo.GetUsuarioDetalles(iduser ?? 0);
            ViewData["UsuarioDetalle"] = user;
        }

        if (filtro != null && filtro.TieneFiltros())
        {
            eventos = await this.repo.BuscarEventosPorFiltros(filtro);
        }
        else
        {
            eventos = await this.repo.GetAllEventosAsync();
        }

        ViewData["TipoEventos"] = tipoEventos;
        ViewData["Provincias"] = provincias;

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

    public async Task<IActionResult> Comprar(int idevento)
    {
        EventoDetalles evento = await this.repo.GetDetallesEventoAsync(idevento);

        return View(evento);
    }
    [HttpPost]
    public async Task<IActionResult> Comprar(int nentradas, List<AsistenciaEvento> entradas)
    {

        foreach (var entrada in entradas)
        {
            await repo.AsignarEntradasAsync(entrada.EventoID, entrada.UsuarioID, entrada.Nombre, entrada.Correo, entrada.Dni);
            await repo.RestarEntrada(entrada.EventoID);
        }

        return RedirectToAction("Index");
    }


    [HttpPost]
    public async Task<IActionResult> CrearEvento(string NombreEvento, int TipoEventoID, DateTime Fecha, string Ubicacion, int Provincia, int Aforo, string Imagen, int Recinto, bool MayorDe18, string Descripcion, string LinkMapsProvincia, int Precio)
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
