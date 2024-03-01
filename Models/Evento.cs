using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MvcCoreProyectoSejo.Models
{
    [Table("Eventos")]
    public class Evento
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("EventoID")]
        public int Id { get; set; }

        [Column("NombreEvento")]
        [StringLength(100)]
        [Required]
        public string NombreEvento { get; set; }

        [Column("TipoEventoID")]
        public int TipoEventoID { get; set; }

        [Column("Fecha")]
        [Required]
        public DateTime Fecha { get; set; }

        [Column("Hora")]
        [Required]
        public TimeSpan Hora { get; set; }

        [Column("Ubicacion")]
        public string Ubicacion { get; set; }

        [Column("Provincia")]
        public int Provincia { get; set; }

        [Column("Aforo")]
        [Required]
        public int Aforo { get; set; }

        [Column("Imagen")]
        public string Imagen { get; set; }

        [Column("Recinto")]
        public int Recinto { get; set; }

        [Column("MayorDe18")]
        [Required]
        public bool MayorDe18 { get; set; }

        [Column("Descripcion")]
        public string Descripcion { get; set; }

        [Column("LinkMapsProvincia")]
        public string LinkMapsProvincia { get; set; }

        [ForeignKey("TipoEventoID")]
        public TipoEvento TipoEvento { get; set; }

        [ForeignKey("Provincia")]
        public Provincia ProvinciaEvento { get; set; }

        [ForeignKey("Recinto")]
        public Usuario RecintoUsuario { get; set; }

    }
}