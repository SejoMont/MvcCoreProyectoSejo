

#region VIEWS Y PROCEDURES
//CREATE VIEW VISTA_DETALLE_USUARIO AS
//SELECT
//    U.UsuarioID,
//    U.NombreUsuario,
//    U.FotoPerfil,
//    U.Correo,
//    U.Telefono,
//    U.ProvinciaID,
//    U.Descripcion,
//    R.NombreRol,
//    AE.EventoID
//FROM Usuarios U
//INNER JOIN ArtistasEvento AE ON U.UsuarioID = AE.ArtistaID
//INNER JOIN Roles R ON U.RolID = R.RolID;

//CREATE PROCEDURE SP_ARTISTAS_EVENTO(@idevento INT)
//AS
//BEGIN
//    SELECT *
//    FROM VISTA_DETALLE_USUARIO
//    WHERE EventoID = @idevento;
//END;

//CREATE PROCEDURE SP_USUARIO_DETALLE
//    (@idusuario INT)
//AS
//BEGIN
//    SELECT *
//    FROM VISTA_DETALLE_USUARIO
//    WHERE UsuarioID = @idusuario;
//END;
#endregion

using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using MvcCoreProyectoSejo.Helpers;
using MvcCoreProyectoSejo.Models;

namespace MvcCoreProyectoSejo.Repository
{
    public class UsuariosRepository
    {
        private EventosContext context;

        public UsuariosRepository(EventosContext context)
        {
            this.context = context;
        }
        public async Task<List<UsuarioDetalles>> GetAllArtistasEventoAsync(int idevento)
        {
            string sql = "SP_ARTISTAS_EVENTO @idevento";
            SqlParameter pamId = new SqlParameter("@idevento", idevento);
            var consulta = this.context.UsuariosDetalles.FromSqlRaw(sql, pamId);
            return await consulta.ToListAsync();
        }

        public async Task<UsuarioDetalles> GetUsuarioDetalles(int iduser)
        {
            string sql = "SP_USUARIO_DETALLE @idusuario";
            SqlParameter pamId = new SqlParameter("@idusuario", iduser);
            var consulta = this.context.UsuariosDetalles.FromSqlRaw(sql, pamId);
            UsuarioDetalles usuarioDetalles = consulta.AsEnumerable().FirstOrDefault();
            return usuarioDetalles;
        }
        //---------------------- Registro / Login ----------------------//
        public bool EmailExists(string email)
        {
            var consulta = from u in context.Usuarios
                           where u.Correo == email
                           select u;

            return consulta.Any();
        }

        public async Task<Usuario> RegisterUserAsync(string nombre, string email
             , string password, int rol)
        {
            Usuario user = new Usuario();
            user.NombreUsuario = nombre;
            user.Correo = email;
            user.RolID = rol;
            user.ProvinciaID = 1;
            user.Telefono = "";
            user.FotoPerfil = "";
            user.Descripcion = "";
            user.Activo = false;
            //CADA USUARIO TENDRA UN SALT DISTINTO 
            user.Salt = HelperTools.GenerateSalt();
            //GUARDAMOS EL PASSWORD EN BYTE[] 
            user.Password =
                HelperCryptography.EncryptPassword(password, user.Salt);
            user.Activo = false;
            user.TokenMail = HelperTools.GenerateTokenMail();
            this.context.Usuarios.Add(user);
            await this.context.SaveChangesAsync();
            return user;
        }

        public async Task ActivateUserAsync(string token)
        {
            // Buscamos el usuario por su token
            Usuario user = await this.context.Usuarios.FirstOrDefaultAsync(x => x.TokenMail == token);

            user.Activo = true;

            user.TokenMail = "";

            await this.context.SaveChangesAsync();
        }

        public async Task<bool> LogInUserAsync(string correo, string password)
        {
            var usuario = await context.Usuarios.FirstOrDefaultAsync(u => u.Correo == correo);

            if (usuario != null)
            {
                string salt = usuario.Salt;
                byte[] temp = HelperCryptography.EncryptPassword(password, salt);
                byte[] passUser = usuario.Password;
                bool response = HelperTools.CompareArrays(temp, passUser);

                return response;
            }
            else
            {
                return false;
            }
        }
        public Usuario GetUser(string correo)
        {
            var usuario = (from u in context.Usuarios
                           where u.Correo == correo
                           select u).FirstOrDefault();

            return usuario;
        }
    }
}