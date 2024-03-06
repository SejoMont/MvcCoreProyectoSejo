using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MvcCoreProyectoSejo.Models
{
    public class UsuarioDetalles
    {
        [Key]
        [Column("UsuarioID")]
        public int UsuarioID { get; set; }

        [Column("NombreUsuario")]
        [Required]
        public string NombreUsuario { get; set; }

        [Column("FotoPerfil")]
        public string FotoPerfil { get; set; }

        [Column("Correo")]
        public string Correo { get; set; }

        [Column("Telefono")]
        public string Telefono { get; set; }

        [Column("ProvinciaID")]
        public int ProvinciaID { get; set; }

        [Column("NombreProvincia")]
        public string NombreProvincia { get; set; }  // Nueva propiedad para el nombre de la provincia

        [Column("Descripcion")]
        public string Descripcion { get; set; }

        [Column("NombreRol")]
        public string NombreRol { get; set; }

        [Column("EventoID")]
        public int EventoID { get; set; }
    }
}
