﻿using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MvcCoreProyectoSejo.Models
{
    public class EventoDetalles
    {
        [Column("EventoID")]
        public int Id { get; set; }

        [Column("NombreEvento")]
        [StringLength(100)]
        [Required]
        public string NombreEvento { get; set; }

        [Column("TipoEvento")]
        public string TipoEvento { get; set; }

        [Column("Fecha")]
        [Required]
        public DateTime Fecha { get; set; }

        [Column("Hora")]
        [Required]
        public TimeSpan Hora { get; set; }

        [Column("Ubicacion")]
        public string Ubicacion { get; set; }

        [Column("Provincia")]
        public string Provincia { get; set; }

        [Column("Aforo")]
        [Required]
        public int Aforo { get; set; }

        [Column("Imagen")]
        public string Imagen { get; set; }

        [Column("Recinto")]
        public string Recinto { get; set; }

        [Column("MayorDe18")]
        [Required]
        public bool MayorDe18 { get; set; }

        [Column("Descripcion")]
        public string Descripcion { get; set; }

        [Column("LinkMapsProvincia")]
        public string LinkMapsProvincia { get; set; }
    }
}
