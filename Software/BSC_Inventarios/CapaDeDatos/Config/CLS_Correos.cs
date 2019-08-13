﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CapaDeDatos
{

    public class CLS_Correos : ConexionBase
    {
        public string CorreoRemitente { get; set; }
        public string CorreoUsuario { get; set; }
        public string CorreoContrasenia { get; set; }
        public string CorreoServidorSalida { get; set; }
        public string CorreoServidorEntrada { get; set; }
        public int CorreoCifradoSSL { get; set; }
        public int CorreoPuertoSalida { get; set; }
        public string CorreoNombre { get; set; }
        public int IdCorreo { get; set; }
        public int ReportesId { get; set; }

        public void MtdSeleccionar()
        {
            TipoDato _dato = new TipoDato();
            Conexion _conexion = new Conexion(cadenaConexion);

            Exito = true;
            try
            {
                _conexion.NombreProcedimiento = "SP_BSC_Correos_Select";
                _conexion.EjecutarDataset();

                if (_conexion.Exito)
                {
                    Datos = _conexion.Datos;
                    Mensaje = _conexion.Mensaje;
                }
                else
                {
                    Mensaje = _conexion.Mensaje;
                    Exito = false;
                }
            }
            catch (Exception e)
            {
                Mensaje = e.Message;
                Exito = false;
            }
        }
        public void MtdSeleccionarCorreosDestino()
        {
            TipoDato _dato = new TipoDato();
            Conexion _conexion = new Conexion(cadenaConexion);

            Exito = true;
            try
            {
                _conexion.NombreProcedimiento = "SP_BSC_CorreosDestino_Select";
                _conexion.EjecutarDataset();

                if (_conexion.Exito)
                {
                    Datos = _conexion.Datos;
                    Mensaje = _conexion.Mensaje;
                }
                else
                {
                    Mensaje = _conexion.Mensaje;
                    Exito = false;
                }
            }
            catch (Exception e)
            {
                Mensaje = e.Message;
                Exito = false;
            }


        }
        public void MtdSeleccionarEspecifica()
        {
            TipoDato _dato = new TipoDato();
            Conexion _conexion = new Conexion(cadenaConexion);

            Exito = true;
            try
            {
                _conexion.NombreProcedimiento = "SP_BSC_CorreosEspecifico_Select";
                _dato.CadenaTexto = CorreoNombre;
                _conexion.agregarParametro(EnumTipoDato.CadenaTexto, _dato, "CorreoNombre");
                _dato.Entero = ReportesId;
                _conexion.agregarParametro(EnumTipoDato.Entero, _dato, "ReportesId");
                _conexion.EjecutarDataset();

                if (_conexionR.Exito)
                {
                    Datos = _conexion.Datos;
                    Mensaje = _conexion.Mensaje;
                }
                else
                {
                    Mensaje = _conexion.Mensaje;
                    Exito = false;
                }
            }
            catch (Exception e)
            {
                Mensaje = e.Message;
                Exito = false;
            }

        }
        public void MtdSeleccionarCorreosReportes()
        {
            TipoDato _dato = new TipoDato();
            Conexion _conexion = new Conexion(cadenaConexion);

            Exito = true;
            try
            {
                _conexion.NombreProcedimiento = "SP_BSC_CorreosDestinoReportes_Select";
                _dato.Entero = ReportesId;
                _conexion.agregarParametro(EnumTipoDato.Entero, _dato, "ReportesId");
                _conexion.EjecutarDataset();

                if (_conexion.Exito)
                {
                    Datos = _conexion.Datos;
                    Mensaje = _conexion.Mensaje;
                }
                else
                {
                    Mensaje = _conexion.Mensaje;
                    Exito = false;
                }
            }
            catch (Exception e)
            {
                Mensaje = e.Message;
                Exito = false;
            }

        }
        public void MtdInsertar()
        {
            TipoDato _dato = new TipoDato();
            Conexion _conexion = new Conexion(cadenaConexion);

            Exito = true;
            try
            {
                _conexion.NombreProcedimiento = "SP_BSC_Correos_Insert";
                _dato.CadenaTexto = CorreoRemitente;
                _conexion.agregarParametro(EnumTipoDato.CadenaTexto, _dato, "CorreoRemitente");
                _dato.CadenaTexto = CorreoUsuario;
                _conexion.agregarParametro(EnumTipoDato.CadenaTexto, _dato, "CorreoUsuario");
                _dato.CadenaTexto = CorreoContrasenia;
                _conexion.agregarParametro(EnumTipoDato.CadenaTexto, _dato, "CorreoContrasenia");
                _dato.Entero = CorreoPuertoSalida;
                _conexion.agregarParametro(EnumTipoDato.Entero, _dato, "CorreoPuertoSalida");
                _dato.CadenaTexto = CorreoServidorSalida;
                _conexion.agregarParametro(EnumTipoDato.CadenaTexto, _dato, "CorreoServidorSalida");
                _dato.CadenaTexto = CorreoServidorEntrada;
                _conexion.agregarParametro(EnumTipoDato.CadenaTexto, _dato, "CorreoServidorEntrada");
                _dato.Entero = CorreoCifradoSSL;
                _conexion.agregarParametro(EnumTipoDato.Entero, _dato, "CorreoCifradoSSL");

                _conexion.EjecutarNonQuery();
                Exito = _conexion.Exito;
                Mensaje = _conexionR.Mensaje;
            }
            catch (Exception e)
            {
                Mensaje = e.Message;
                Exito = false;
            }

        }
        public void MtdInsertarCorreoDestino()
        {
            TipoDato _dato = new TipoDato();
            Conexion _conexion = new Conexion(cadenaConexion);

            Exito = true;
            try
            {
                _conexion.NombreProcedimiento = "SP_BSC_CorreosDestino_Insert";
                _dato.CadenaTexto = CorreoNombre;
                _conexion.agregarParametro(EnumTipoDato.CadenaTexto, _dato, "CorreoNombre");
                _dato.Entero = ReportesId;
                _conexion.agregarParametro(EnumTipoDato.Entero, _dato, "ReportesId");
                _conexion.EjecutarNonQuery();
                Exito = _conexion.Exito;
                Mensaje = _conexion.Mensaje;
            }
            catch (Exception e)
            {
                Mensaje = e.Message;
                Exito = false;
            }

        }
        public void MtdModificar()
        {
            TipoDato _dato = new TipoDato();
            Conexion _conexion = new Conexion(cadenaConexion);

            Exito = true;
            try
            {
                _conexion.NombreProcedimiento = "SP_BSC_Correos_Update";
                _dato.CadenaTexto = CorreoRemitente;
                _conexion.agregarParametro(EnumTipoDato.CadenaTexto, _dato, "CorreoRemitente");
                _dato.CadenaTexto = CorreoUsuario;
                _conexion.agregarParametro(EnumTipoDato.CadenaTexto, _dato, "CorreoUsuario");
                _dato.CadenaTexto = CorreoContrasenia;
                _conexion.agregarParametro(EnumTipoDato.CadenaTexto, _dato, "CorreoContrasenia");
                _dato.Entero = CorreoPuertoSalida;
                _conexion.agregarParametro(EnumTipoDato.Entero, _dato, "CorreoPuertoSalida");
                _dato.CadenaTexto = CorreoServidorSalida;
                _conexion.agregarParametro(EnumTipoDato.CadenaTexto, _dato, "CorreoServidorSalida");
                _dato.CadenaTexto = CorreoServidorEntrada;
                _conexion.agregarParametro(EnumTipoDato.CadenaTexto, _dato, "CorreoServidorEntrada");
                _dato.Entero = CorreoCifradoSSL;
                _conexion.agregarParametro(EnumTipoDato.Entero, _dato, "CorreoCifradoSSL");
                
                _conexion.EjecutarNonQuery();
                Exito = _conexion.Exito;
                Mensaje = _conexion.Mensaje;
            }
            catch (Exception e)
            {
                Mensaje = e.Message;
                Exito = false;
            }

        }
        public void MtdEliminar()
        {
            TipoDato _dato = new TipoDato();
            Conexion _conexion = new Conexion(cadenaConexion);
            Exito = true;
            try
            {
                _conexion.NombreProcedimiento = "SP_BSC_CorreosDestino_Delete";
                _dato.Entero = IdCorreo;
                _conexion.agregarParametro(EnumTipoDato.Entero, _dato, "IdCorreo");
                _conexion.EjecutarNonQuery();
                Exito = _conexion.Exito;
                if (_conexion.Exito)
                {
                    Datos = _conexion.Datos;
                    Mensaje = _conexion.Mensaje;
                }
                else
                {
                    Mensaje = _conexion.Mensaje;
                    Exito = false;
                }
            }
            catch (Exception e)
            {
                Mensaje = e.Message;
                Exito = false;
            }

        }
        public void MtdSeleccionarReportes()
        {
            TipoDato _dato = new TipoDato();
            Conexion _conexion = new Conexion(cadenaConexion);

            Exito = true;
            try
            {
                _conexion.NombreProcedimiento = "SP_BSC_CorreosReportes_Select";
                _conexion.EjecutarDataset();

                if (_conexion.Exito)
                {
                    Datos = _conexion.Datos;
                    Mensaje = _conexion.Mensaje;
                }
                else
                {
                    Mensaje = _conexion.Mensaje;
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