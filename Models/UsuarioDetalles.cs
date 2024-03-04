using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace MvcCoreProyectoSejo.Models
{
    public class UsuarioDetalles
    {
        [Key]
        [Column("UsuarioID")]
        public int UsuarioID { get; set; }

        [Column("NombreUsuario")]
        [StringLength(50)]
        public string NombreUsuario { get; set; }

        [Column("FotoPerfil")]
        public string FotoPerfil { get; set; }

        [Column("Correo")]
        [StringLength(100)]
        public string Correo { get; set; }

        [Column("Telefono")]
        [StringLength(15)]
        public string Telefono { get; set; }

        [Column("ProvinciaID")]
        public int ProvinciaID { get; set; }

        [Column("Descripcion")]
        public string Descripcion { get; set; }

        [Column("NombreRol")]
        [StringLength(20)]
        public string NombreRol { get; set; }
    }
}
