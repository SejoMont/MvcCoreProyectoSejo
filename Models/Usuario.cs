using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MvcCoreProyectoSejo.Models
{
    [Table("Usuarios")]
    public class Usuario
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("UsuarioID")]
        public int Id { get; set; }

        [Column("NombreUsuario")]
        [StringLength(50)]
        [Required]
        public string NombreUsuario { get; set; }

        [Column("FotoPerfil")]
        public string FotoPerfil { get; set; }

        [Column("Correo")]
        [StringLength(100)]
        [Required]
        public string Correo { get; set; }

        [Column("Telefono")]
        [StringLength(15)]
        [Required]
        public string Telefono { get; set; }

        [Column("ProvinciaID")]
        public int? ProvinciaID { get; set; }

        [Column("Descripcion")]
        public string Descripcion { get; set; }

        [Column("RolID")]
        public int RolID { get; set; }

        [ForeignKey("RolID")]
        public Rol Rol { get; set; }

        [ForeignKey("ProvinciaID")]
        public Provincia Provincia { get; set; }
    }
}
