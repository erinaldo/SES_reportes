﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaDeDatos
{
    public class CLS_Usuarios_Insert : ConexionBase
    {

        public string UsuariosLogin { get; set; }
        public string UsuariosNombre { get; set; }
        public string UsuariosPassword { get; set; }
        public string UsuariosClase { get; set; }
        public int UsuariosActivo { get; set; }

        public void MtdInsertarUsuarios()
        {
            TipoDato _dato = new TipoDato();
            Exito = true;
            try
            {
                _conexion.NombreProcedimiento = "SP_BSC_Usuarios_Insert";
                _dato.CadenaTexto = UsuariosLogin;
                _conexion.agregarParametro(EnumTipoDato.CadenaTexto, _dato, "UsuariosLogin");
                _dato.CadenaTexto = UsuariosNombre;
                _conexion.agregarParametro(EnumTipoDato.CadenaTexto, _dato, "UsuariosNombre");
                _dato.CadenaTexto = UsuariosPassword;
                _conexion.agregarParametro(EnumTipoDato.CadenaTexto, _dato, "UsuariosPassword");
                _dato.CadenaTexto = UsuariosClase;
                _conexion.agregarParametro(EnumTipoDato.CadenaTexto, _dato, "UsuariosClase");
                _dato.Entero = UsuariosActivo;
                _conexion.agregarParametro(EnumTipoDato.Entero, _dato, "UsuariosActivo");
                _conexion.EjecutarDataset();

                if (_conexion.Exito)
                {
                    Datos = _conexion.Datos;
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