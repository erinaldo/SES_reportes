﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaDeDatos
{
    public class CLSTicketMayoreoCentral : ConexionBase
    {

        public int TicketId { get; set; }
        public int CajaId { get; set; }
        public int UsuarioId { get; set; }
        public string TicketFecha { get; set; }
        public decimal TicketSubtotal0 { get; set; }
        public decimal TicketSubtotal16 { get; set; }
        public decimal TicketIva { get; set; }
        public decimal TicketTotal { get; set; }
        public int? CortesZRecibosId { get; set; }
       
        public int ClienteId { get; set; }






        public void MtdActualizarTicketMayoreo()
        {
            TipoDato _dato = new TipoDato();
            Exito = true;
            try
            {
                _conexionC.NombreProcedimiento = "SP_BSC_TicketMayoreo_General";
                _dato.Entero = TicketId;
                _conexionC.agregarParametro(EnumTipoDato.Entero, _dato, "TicketId");
                _dato.Entero = CajaId;
                _conexionC.agregarParametro(EnumTipoDato.Entero, _dato, "CajaId");
                _dato.Entero = UsuarioId;
                _conexionC.agregarParametro(EnumTipoDato.Entero, _dato, "UsuarioId");
                _dato.CadenaTexto = TicketFecha;
                _conexionC.agregarParametro(EnumTipoDato.CadenaTexto, _dato, "TicketFecha");
                _dato.DecimalValor = TicketSubtotal0;
                _conexionC.agregarParametro(EnumTipoDato.Tipodecimal, _dato, "TicketSubtotal0");
                _dato.DecimalValor = TicketSubtotal16;
                _conexionC.agregarParametro(EnumTipoDato.Tipodecimal, _dato, "TicketSubtotal16");
                _dato.DecimalValor = TicketIva;
                _conexionC.agregarParametro(EnumTipoDato.Tipodecimal, _dato, "TicketIva");
                _dato.DecimalValor = TicketTotal;
                _conexionC.agregarParametro(EnumTipoDato.Tipodecimal, _dato, "TicketTotal");
                _dato.Entero = CortesZRecibosId;
                _conexionC.agregarParametro(EnumTipoDato.Entero, _dato, "CortesZRecibosId");
                
                _dato.Entero = ClienteId;
                _conexionC.agregarParametro(EnumTipoDato.Entero, _dato, "ClienteId");
               

                _conexionC.EjecutarDataset();

                if (_conexionC.Exito)
                {
                    Datos = _conexionC.Datos;
                }
                else
                {
                    Mensaje = _conexionC.Mensaje;
                    Exito = false;
                }
            }
            catch (Exception e)
            {
                Mensaje = e.Message;
                Exito = false;
            }
        }

    }
}
