using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace MvcCoreProyectoSejo.Models
{
    [Table("Resenas")]
    public class Resena
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("ResenaID")]
        public int Id { get; set; }

        [Column("UsuarioID")]
        public int UsuarioID { get; set; }

        [Column("RolReviewId")]
        public int RolReviewId { get; set; }

        [Column("Comentario")]
        public string Comentario { get; set; }

        [Column("Puntuacion")]
        [Range(1, 5)]
        public int Puntuacion { get; set; }

        [Column("FechaResena")]
        public DateTime FechaResena { get; set; }

        [ForeignKey("UsuarioID")]
        public Usuario Usuario { get; set; }

        [ForeignKey("RolReviewId")]
        public Usuario RolReview { get; set; }
    }

}
