﻿using Microsoft.AspNetCore.Mvc;
using MvcCoreProyectoSejo.Extensions;
using MvcCoreProyectoSejo.Helpers;
using MvcCoreProyectoSejo.Models;
using MvcCoreProyectoSejo.Repository;

namespace MvcCoreProyectoSejo.Controllers
{
    public class UsuariosController : Controller
    {
        private UsuariosRepository repo;
        private EventosRepository eventosRepo;

        private HelperMails helperMails;
        private HelperPathProvider helperPathProvider;

        public UsuariosController(UsuariosRepository repo, EventosRepository eventosRepo, HelperMails helperMails, HelperPathProvider helperPathProvider)
        {
            this.repo = repo;
            this.eventosRepo = eventosRepo;
            this.helperMails = helperMails;
            this.helperPathProvider = helperPathProvider;
        }

        public async Task<IActionResult> Details(int iduser)
        {
            UsuarioDetalles usuarioDetalles = await this.repo.GetUsuarioDetalles(iduser);
            List<EventoDetalles> eventos = await this.eventosRepo.GetAllEventosArtistaAsync(iduser);

            ViewData["Eventos"] = eventos;

            return View(usuarioDetalles);
        }
        public IActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Login(string correo, string password)
        {
            bool loginSuccess = await repo.LogInUserAsync(correo, password);
            if (loginSuccess)
            {
                Usuario user = repo.GetUser(correo);
                HttpContext.Session.SetObject("CurrentUser", user);
                return RedirectToAction("Index", "Eventos", new { iduser = user.UsuarioID });
            }
            else
            {
                ViewData["Mensaje"] = "Credenciales incorrectas. Por favor, inténtalo de nuevo.";
                return View();
            }
        }

        public IActionResult Registro()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Registro(string nombre, string password, string confirmPassword, string correo)
        {
            if (!string.IsNullOrEmpty(correo) && repo.EmailExists(correo))
            {
                ViewData["Mensaje"] = "El correo electrónico ya está en uso. Por favor, utiliza otro.";
                return View();
            }

            if (password != confirmPassword)
            {
                ViewData["Mensaje"] = "Las contraseñas no coinciden. Por favor, inténtalo de nuevo.";
                return View();
            }

            // Llamar al método RegisterUserAsync con la contraseña tal como está
            Usuario user = await repo.RegisterUserAsync(nombre, correo, password, 1);

            // Verificar si el usuario se creó correctamente
            if (user != null)
            {
                HttpContext.Session.SetObject("CurrentUser", user);

                string serverUrl = this.helperPathProvider.MapUrlServerPath();
                //https://localhost:8555/Usuarios/ActivateUser/TOKEN??? 
                serverUrl = serverUrl + "/Usuarios/ActivateUser/?token=" + user.TokenMail;
                string mensaje = "<h3>Usuario registrado</h3>";
                mensaje += "<p>Debe activar su cuenta con nosotros pulsando el siguiente enlace</p>";
                mensaje += "<p><a href='" + serverUrl + "'>" + serverUrl + "</a></p>";
                mensaje += "<p>Muchas gracias</p>";
                await this.helperMails.SendMailAsync(correo, "Registro Usuario", mensaje);

                return RedirectToAction("Login");
            }
            else
            {
                // Manejar la situación en la que el usuario no se creó correctamente
                ViewData["Mensaje"] = "No se pudo crear el usuario correctamente. Por favor, inténtalo de nuevo.";
                return View();
            }
        }


        public async Task<IActionResult> ActivateUser(string token)
        {
            await this.repo.ActivateUserAsync(token);
            ViewData["MENSAJE"] = "Cuenta activada correctamente";
            return RedirectToAction("Index", "Eventos");
        }

        public IActionResult Logout()
        {
            HttpContext.Session.Remove("CurrentUser");
            return RedirectToAction("Login");
        }
    }
}
