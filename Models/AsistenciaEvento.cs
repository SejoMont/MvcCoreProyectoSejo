using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace MvcCoreProyectoSejo.Models
{
    [Table("AsistenciasEventos")]
    public class AsistenciaEvento
    {
        [Key]
        [Column("AsistenciaID")]
        public int AsistenciaID { get; set; }

        [Column("UsuarioID")]
        public int UsuarioID { get; set; }

        [ForeignKey("UsuarioID")]
        public Usuario Usuario { get; set; }

        [Column("EventoID")]
        public int EventoID { get; set; }

        [ForeignKey("EventoID")]
        public Evento Evento { get; set; }

        [Column("FechaAsistencia")]
        public DateTime FechaAsistencia { get; set; }
    }
}
