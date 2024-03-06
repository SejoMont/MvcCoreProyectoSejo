using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MvcCoreProyectoSejo.Models
{
    public class AsistenciaEvento
    {
        [Key]
        [Column("AsistenciaID")]
        public int AsistenciaID { get; set; }

        [Column("UsuarioID")]
        public int UsuarioID { get; set; }

        [Column("EventoID")]
        public int EventoID { get; set; }

        [Column("NombreEntrada")]
        public string NombreEntrada { get; set; }

        [Column("CorreoEntrada")]
        public string CorreoEntrada { get; set; }

        [Column("DNIEntrada")]
        public string DNIEntrada { get; set; }

        [Column("QRImagen")]
        public string QRImagen { get; set; }
    }
}
