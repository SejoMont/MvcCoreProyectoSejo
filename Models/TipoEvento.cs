using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace MvcCoreProyectoSejo.Models
{
    [Table("TiposEventos")]
    public class TipoEvento
    {
        [Key]
        [Column("TipoEventoID")]
        public int Id { get; set; }

        [Column("Tipo")]
        [StringLength(50)]
        public string Nombre { get; set; }
    }
}
