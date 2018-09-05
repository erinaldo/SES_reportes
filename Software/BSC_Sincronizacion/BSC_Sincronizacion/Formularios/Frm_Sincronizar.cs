﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using DevExpress.XtraEditors;
using CapaDeDatos;

namespace BSC_Sincronizacion
{
    public partial class Frm_Sincronizar : DevExpress.XtraEditors.XtraForm
    {
        public int ArticulosActualizados { get; set; }
        public int ArticulosError { get; set; }

        public Frm_Sincronizar()
        {
            InitializeComponent();
        }
        private string DosCero(string sVal)
        {
            string str = "";
            if (sVal.Length == 1)
            {
                return (str = "0" + sVal);
            }
            return sVal;
        }

        private void limpiarFormulario()
        {
            lEstatus.Text = "";
            pbProgreso.Position = 0;

            int xRow2 = 0;
            for (int i = 0; i < GValCatalogos.RowCount; i++)
            {
                xRow2 = GValCatalogos.GetVisibleRowHandle(i);
                GValCatalogos.SetRowCellValue(xRow2, "Column1", false);

            }

        }

        private void MakeFirstTable()
        {
            DataTable table = new DataTable("FirstTable");
            DataColumn column;
            table.Reset();
            // DataRow row;
            column = new DataColumn();
            column.DataType = typeof(string);
            column.ColumnName = "Column0";
            column.AutoIncrement = false;
            column.Caption = "Catalogos";
            column.ReadOnly = false;
            column.Unique = false;

            table.Columns.Add(column);

            column = new DataColumn();
            column.DataType = typeof(Boolean);
            column.ColumnName = "Column1";
            column.AutoIncrement = false;
            column.Caption = "Reenviar";
            column.ReadOnly = false;
            column.Unique = false;

            table.Columns.Add(column);

            column = new DataColumn();
            column.DataType = typeof(string);
            column.ColumnName = "Column2";
            column.AutoIncrement = false;
            column.Caption = "Total Articulos";
            column.ReadOnly = false;
            column.Unique = false;

            table.Columns.Add(column);

            column = new DataColumn();
            column.DataType = typeof(string);
            column.ColumnName = "Column3";
            column.AutoIncrement = false;
            column.Caption = "Total Actualizados";
            column.ReadOnly = false;
            column.Unique = false;

            table.Columns.Add(column);

            column = new DataColumn();
            column.DataType = typeof(string);
            column.ColumnName = "Column4";
            column.AutoIncrement = false;
            column.Caption = "Status";
            column.ReadOnly = false;
            column.Unique = false;

            table.Columns.Add(column);

            GCatalogos.DataSource = table;

        }
        private void Frm_Sincronizar_Shown(object sender, EventArgs e)
        {
            this.ClientSize = new Size(672, 712);
            dtFechaInicio.EditValue = DateTime.Now;
            dtFechaFin.EditValue = DateTime.Now;
            MakeFirstTable();
            LlenarListaCatalogo();
            pbProgreso.Position = 0;
            lEstatus.Text = string.Empty;
        }

        private void LlenarListaCatalogo()
        {
            CLSTablasSincronizarCentral gst = new CLSTablasSincronizarCentral();

            gst.MtdSeleccionarCatalogos();
            if (gst.Exito)
            {
                string vCatalogos = string.Empty;
                Boolean VActualiza = false;
                string vTotalArticulos = string.Empty;
                string vTotalActualizados = string.Empty;
                string vStatus = string.Empty;

                for (int x = 0; x < gst.Datos.Rows.Count; x++)
                {
                    vCatalogos = gst.Datos.Rows[x][0].ToString();
                    VActualiza = false;
                    vTotalArticulos = "0";
                    vTotalActualizados = "0";
                    vStatus = "No Actualizado";
                    CreatNewRow(vCatalogos, VActualiza, vTotalArticulos, vTotalActualizados, vStatus);
                }
            }
        }
        private void CreatNewRow(string vCatalogos, Boolean VActualiza, string vTotalArticulos, string vTotalActualizados, String vStatus)
        {
            GValCatalogos.AddNewRow();

            int rowHandle = GValCatalogos.GetRowHandle(GValCatalogos.DataRowCount);
            if (GValCatalogos.IsNewItemRow(rowHandle))
            {
                GValCatalogos.SetRowCellValue(rowHandle, GValCatalogos.Columns[0], vCatalogos);
                GValCatalogos.SetRowCellValue(rowHandle, GValCatalogos.Columns[1], VActualiza);
                GValCatalogos.SetRowCellValue(rowHandle, GValCatalogos.Columns[2], vTotalArticulos);
                GValCatalogos.SetRowCellValue(rowHandle, GValCatalogos.Columns[3], vTotalActualizados);
                GValCatalogos.SetRowCellValue(rowHandle, GValCatalogos.Columns[4], vStatus);
            }
        }

        private void btnSincronizar_Click(object sender, EventArgs e)
        {
            ModificaActualizaCentral();
        }

        private void btnDataBase_Click(object sender, EventArgs e)
        {
            Frm_Conexiones frm = new Frm_Conexiones();
            frm.ShowDialog();
        }

        private void ModificaActualizaCentral()
        {
            RecorreGrid();
        }

        private void chkTodos_CheckedChanged(object sender, EventArgs e)
        {
            if (chkTodos.Checked == true)
            {
                int xRow = 0;
                for (int i = 0; i < GValCatalogos.RowCount; i++)
                {
                    xRow = GValCatalogos.GetVisibleRowHandle(i);
                    GValCatalogos.SetRowCellValue(xRow, "Column1", true);
                }
            }
            else
            {
                int xRow = 0;
                for (int i = 0; i < GValCatalogos.RowCount; i++)
                {
                    xRow = GValCatalogos.GetVisibleRowHandle(i);
                    GValCatalogos.SetRowCellValue(xRow, "Column1", false);

                }
            }
        }
        private string RecorreGrid()
        {
            int xRow = 0;
            string Cadena = string.Empty;

            for (int i = 0; i < GValCatalogos.RowCount; i++)
            {
                xRow = GValCatalogos.GetVisibleRowHandle(i);

                if (Convert.ToBoolean(GValCatalogos.GetRowCellValue(xRow, "Column1")))
                {
                    pbProgreso.Position = 0;
                    switch (GValCatalogos.GetRowCellValue(xRow, "Column0").ToString())
                    {
                        case "Articulo":
                            AplicaCambiosArticulo(xRow);
                            break;
                        case "ArticuloMedidas":
                            AplicaCambiosArticuloMedidas(xRow);
                            break;
                        case "Caja":
                            AplicaCambiosCaja(xRow);
                            break;
                        case "Cliente":
                            AplicaCambiosCliente()
                            break;
                        case "CCliente":
                            AplicaCambiosCCliente(xRow);
                            break;
                        case "ComprasSugeridas":

                            break;
                        case "CondicionesPagos":

                            break;
                        case "CProveedor":

                            break;
                        case "Documentos":

                            break;
                        case "EntradaMercanciaTipo":

                            break;
                        case "Familia":

                            break;
                        case "FormasdePago":

                            break;
                        case "Iva":

                            break;
                        case "Localidad":

                            break;
                        case "Medidas":

                            break;
                        case "MetodoPagos":

                            break;
                        case "Moneda":

                            break;
                        case "Proveedor":

                            break;
                        case "Roles":

                            break;
                        case "SalidaMercanciaTipo":

                            break;
                        case "Sucursales":

                            break;
                        case "Tarifa":

                            break;
                        case "Usuarios":

                            break;
                        case "Vendedor":

                            break;
                    }
                }
            }
            return Cadena;
        }
        /******* Articulos *****/
        private void AplicaCambiosArticulo(int Fila)
        {
            CLSArticulosLocal SelArt = new CLSArticulosLocal();
            SelArt.FechaInicio = dtFechaInicio.DateTime.Year.ToString() + DosCero(dtFechaInicio.DateTime.Month.ToString()) + DosCero(dtFechaInicio.DateTime.Day.ToString());
            SelArt.FechaFin = dtFechaFin.DateTime.Year.ToString() + DosCero(dtFechaFin.DateTime.Month.ToString()) + DosCero(dtFechaFin.DateTime.Day.ToString());
            SelArt.MtdSeleccionarArticulos();
            if (SelArt.Exito == true)
            {
                ArticulosActualizados = 0;
                pbProgreso.Properties.Maximum = SelArt.Datos.Rows.Count;
                GValCatalogos.SetRowCellValue(Fila, GValCatalogos.Columns[2], SelArt.Datos.Rows.Count);
                for (int i = 0; i < SelArt.Datos.Rows.Count; i++)
                {
                    Application.DoEvents();
                    lEstatus.Text = "Actualizando Articulos " + ArticulosActualizados + " de " + SelArt.Datos.Rows.Count;
                    SincronizaArticulos(SelArt.Datos.Rows[i][0].ToString(), SelArt.Datos.Rows[i][1].ToString());
                    pbProgreso.Position = ArticulosActualizados;
                }
                lEstatus.Text = "Actualizando Articulos " + ArticulosActualizados + " de " + SelArt.Datos.Rows.Count;
                GValCatalogos.SetRowCellValue(Fila, GValCatalogos.Columns[3], ArticulosActualizados);
                if (SelArt.Datos.Rows.Count == ArticulosActualizados)
                {
                    GValCatalogos.SetRowCellValue(Fila, GValCatalogos.Columns[4], "Done");
                }
                else
                {
                    GValCatalogos.SetRowCellValue(Fila, GValCatalogos.Columns[4], "Failed");
                }
            }
        }
        private void SincronizaArticulos(string Codigo, string Descripcion)
        {
            CLS_Articulo_Central UdpArt = new CLS_Articulo_Central();
            UdpArt.ArticuloCodigo = Codigo;
            UdpArt.ArticuloDescripcion = Descripcion;
            UdpArt.MtdActualizarArticulo();
            if (UdpArt.Exito == true)
            {
                ArticulosActualizados++;
            }
        }
        /******* ArticulosMedidas *****/
        private void AplicaCambiosArticuloMedidas(int Fila)
        {
            CLSArticuloMedidasLocal SelArt = new CLSArticuloMedidasLocal();
            SelArt.FechaInicio = dtFechaInicio.DateTime.Year.ToString() + DosCero(dtFechaInicio.DateTime.Month.ToString()) + DosCero(dtFechaInicio.DateTime.Day.ToString());
            SelArt.FechaFin = dtFechaFin.DateTime.Year.ToString() + DosCero(dtFechaFin.DateTime.Month.ToString()) + DosCero(dtFechaFin.DateTime.Day.ToString());
            SelArt.MtdSeleccionarArticuloMedidas();
            if (SelArt.Exito == true)
            {
                ArticulosActualizados = 1;
                pbProgreso.Properties.Maximum = SelArt.Datos.Rows.Count;
                GValCatalogos.SetRowCellValue(Fila, GValCatalogos.Columns[2], SelArt.Datos.Rows.Count);
                GValCatalogos.SetRowCellValue(Fila, GValCatalogos.Columns[4], "Procesando");
                for (int i = 0; i < SelArt.Datos.Rows.Count; i++)
                {
                    Application.DoEvents();
                    GValCatalogos.SetRowCellValue(Fila, GValCatalogos.Columns[3], ArticulosActualizados);
                    lEstatus.Text = "Codigo Articulo - Medidas [" + SelArt.Datos.Rows[i][0].ToString() + "]";
                    SincronizaArticulosMedidas(SelArt.Datos.Rows[i][0].ToString(), SelArt.Datos.Rows[i][1].ToString());

                    pbProgreso.Position = i + 1;
                }
                if (ArticulosError == 0)
                {
                    GValCatalogos.SetRowCellValue(Fila, GValCatalogos.Columns[4], "Actualizados");
                }
                else
                {
                    GValCatalogos.SetRowCellValue(Fila, GValCatalogos.Columns[4], "Con Errores");
                }

            }

        }
        private void SincronizaArticulosMedidas(string Codigo, string MedidaId)
        {
            CLS_ArticuloMedida_Central UdpArt = new CLS_ArticuloMedida_Central();
            UdpArt.ArticuloCodigo = Codigo;
            UdpArt.MedidasId = Convert.ToInt32(MedidaId);

            UdpArt.MtdActualizarArticuloMedidas();
            if (UdpArt.Exito == true)
            {
                ArticulosActualizados++;
            }
            else
            {
                ArticulosError++;
            }
        }
        /******* Caja *****/
        private void AplicaCambiosCaja(int Fila)
        {
            CLSCajaLocal SelArt = new CLSCajaLocal();
            SelArt.FechaInicio = dtFechaInicio.DateTime.Year.ToString() + DosCero(dtFechaInicio.DateTime.Month.ToString()) + DosCero(dtFechaInicio.DateTime.Day.ToString());
            SelArt.FechaFin = dtFechaFin.DateTime.Year.ToString() + DosCero(dtFechaFin.DateTime.Month.ToString()) + DosCero(dtFechaFin.DateTime.Day.ToString());
            SelArt.MtdSeleccionarCaja();
            if (SelArt.Exito == true)
            {
                ArticulosActualizados = 1;
                pbProgreso.Properties.Maximum = SelArt.Datos.Rows.Count;
                GValCatalogos.SetRowCellValue(Fila, GValCatalogos.Columns[2], SelArt.Datos.Rows.Count);
                GValCatalogos.SetRowCellValue(Fila, GValCatalogos.Columns[4], "Procesando");
                for (int i = 0; i < SelArt.Datos.Rows.Count; i++)
                {
                    Application.DoEvents();
                    GValCatalogos.SetRowCellValue(Fila, GValCatalogos.Columns[3], ArticulosActualizados);
                    lEstatus.Text = "Codigo Caja [" + SelArt.Datos.Rows[i][0].ToString() + "]";
                    SincronizaCaja(SelArt.Datos.Rows[i][0].ToString(), SelArt.Datos.Rows[i][1].ToString(), SelArt.Datos.Rows[i][2].ToString(), SelArt.Datos.Rows[i][3].ToString(),
                        SelArt.Datos.Rows[i][4].ToString(), SelArt.Datos.Rows[i][5].ToString(), SelArt.Datos.Rows[i][6].ToString(), SelArt.Datos.Rows[i][7].ToString(),
                        SelArt.Datos.Rows[i][8].ToString(), Convert.ToDateTime( SelArt.Datos.Rows[i][9]), SelArt.Datos.Rows[i][10].ToString(), SelArt.Datos.Rows[i][11].ToString(),
                        SelArt.Datos.Rows[i][12].ToString(), SelArt.Datos.Rows[i][13].ToString(), SelArt.Datos.Rows[i][14].ToString(), SelArt.Datos.Rows[i][15].ToString(),
                        SelArt.Datos.Rows[i][16].ToString()
                        );

                    pbProgreso.Position = i + 1;
                }
                if (ArticulosError == 0)
                {
                    GValCatalogos.SetRowCellValue(Fila, GValCatalogos.Columns[4], "Actualizados");
                }
                else
                {
                    GValCatalogos.SetRowCellValue(Fila, GValCatalogos.Columns[4], "Con Errores");
                }
            }
        }
        private void SincronizaCaja(string CajaId, string SucursalesId, string CajaNumero, string CajaDescripcion, string CajaReciboInicial, string CajaFondo, string CajaMontoEfectivo,
            string CajaMontoTarjeta, string CajaMontoVale, DateTime CajaFecha, string CajaUltimoTicket, string CajaUltimaDevolucion, string CajaUltimaCancelacion,
            string CajaUltimoCorte, string CajaUltimoRetiro, string CajaUltimoTicketMayoreo, string CajaUltimoDevolucionMayoreo)
        {
            CLS_Caja_Central UdpArt = new CLS_Caja_Central();



            UdpArt.CajaId = Convert.ToInt32(CajaId);
            UdpArt.SucursalesId = Convert.ToInt32(SucursalesId);
            UdpArt.CajaNumero = Convert.ToInt32(CajaNumero);
            UdpArt.CajaDescripcion = CajaDescripcion;
            UdpArt.CajaReciboInicial = Convert.ToInt32(CajaReciboInicial);
            UdpArt.CajaFondo = Convert.ToDecimal(CajaFondo);
            UdpArt.CajaMontoEfectivo = Convert.ToDecimal(CajaMontoEfectivo);
            UdpArt.CajaMontoTarjeta = Convert.ToDecimal(CajaMontoTarjeta);
            UdpArt.CajaMontoVale = Convert.ToDecimal(CajaMontoVale);
            UdpArt.CajaFecha = CajaFecha.Date.Year.ToString() + DosCero(CajaFecha.Date.Month.ToString()) + DosCero(CajaFecha.Date.Day.ToString());            
            UdpArt.CajaUltimoTicket = Convert.ToInt32(CajaUltimoTicket);
            UdpArt.CajaUltimaDevolucion = Convert.ToInt32(CajaUltimaDevolucion);
            UdpArt.CajaUltimaCancelacion = Convert.ToInt32(CajaUltimaCancelacion);
            UdpArt.CajaUltimoCorte = Convert.ToInt32(CajaUltimoCorte);
            UdpArt.CajaUltimoRetiro = Convert.ToInt32(CajaUltimoRetiro);
            UdpArt.CajaUltimoTicketMayoreo = Convert.ToInt32(CajaUltimoTicketMayoreo);
            UdpArt.CajaUltimoDevolucionMayoreo = Convert.ToInt32(CajaUltimoDevolucionMayoreo);
           

            UdpArt.MtdActualizarCaja();

            if (UdpArt.Exito == true)
            {
                ArticulosActualizados++;
            }
        }
        /******* CCliente *****/
        private void AplicaCambiosCCliente(int Fila)
        {
            CLSCClienteLocal SelArt = new CLSCClienteLocal();
            SelArt.FechaInicio = dtFechaInicio.DateTime.Year.ToString() + DosCero(dtFechaInicio.DateTime.Month.ToString()) + DosCero(dtFechaInicio.DateTime.Day.ToString());
            SelArt.FechaFin = dtFechaFin.DateTime.Year.ToString() + DosCero(dtFechaFin.DateTime.Month.ToString()) + DosCero(dtFechaFin.DateTime.Day.ToString());
            SelArt.MtdSeleccionarCCliente();
            if (SelArt.Exito == true)
            {
                ArticulosActualizados = 1;
                pbProgreso.Properties.Maximum = SelArt.Datos.Rows.Count;
                GValCatalogos.SetRowCellValue(Fila, GValCatalogos.Columns[2], SelArt.Datos.Rows.Count);
                GValCatalogos.SetRowCellValue(Fila, GValCatalogos.Columns[4], "Procesando");
                for (int i = 0; i < SelArt.Datos.Rows.Count; i++)
                {
                    Application.DoEvents();
                    GValCatalogos.SetRowCellValue(Fila, GValCatalogos.Columns[3], ArticulosActualizados);
                    lEstatus.Text = "Codigo CCliente [" + SelArt.Datos.Rows[i][0].ToString() + "]";
                    SincronizaCCliente(SelArt.Datos.Rows[i][0].ToString(), SelArt.Datos.Rows[i][1].ToString(), Convert.ToDateTime(SelArt.Datos.Rows[i][2]), SelArt.Datos.Rows[i][3].ToString(),
                        SelArt.Datos.Rows[i][4].ToString(), SelArt.Datos.Rows[i][5].ToString()
                        );

                    pbProgreso.Position = i + 1;
                }
                if (ArticulosError == 0)
                {
                    GValCatalogos.SetRowCellValue(Fila, GValCatalogos.Columns[4], "Actualizados");
                }
                else
                {
                    GValCatalogos.SetRowCellValue(Fila, GValCatalogos.Columns[4], "Con Errores");
                }
            }
        }
        private void SincronizaCCliente(string CClienteId, string CClienteNombre, DateTime CClienteFecha, String CClienteActivo, string CClientePadreId, string CClienteTieneElementos)
        {
            CLS_CCliente_Central UdpArt = new CLS_CCliente_Central();


            UdpArt.CClienteId = Convert.ToInt32(CClienteId);
            UdpArt.CClienteNombre = CClienteNombre;
            UdpArt.CClienteFecha = CClienteFecha.Date.Year.ToString() + DosCero(CClienteFecha.Date.Month.ToString()) + DosCero(CClienteFecha.Date.Day.ToString());  
            UdpArt.CClienteActivo = CClienteActivo;
            if (CClientePadreId != String.Empty)
            {
                UdpArt.CClientePadreId = Convert.ToInt32(CClientePadreId);
            }
            else
            {
                UdpArt.CClientePadreId = null;
            }
            if (Convert.ToBoolean( CClienteTieneElementos)==false) {
                UdpArt.CClienteTieneElementos = 0;
            }
            else
            {
                UdpArt.CClienteTieneElementos = 1;
            }
            
            


            UdpArt.MtdActualizarCCliente();

            if (UdpArt.Exito == true)
            {
                ArticulosActualizados++;
            }
        }
        /******* Cliente *****/
        private void AplicaCambiosCliente(int Fila)
        {
            CLSClienteLocal SelArt = new CLSClienteLocal();
            SelArt.FechaInicio = dtFechaInicio.DateTime.Year.ToString() + DosCero(dtFechaInicio.DateTime.Month.ToString()) + DosCero(dtFechaInicio.DateTime.Day.ToString());
            SelArt.FechaFin = dtFechaFin.DateTime.Year.ToString() + DosCero(dtFechaFin.DateTime.Month.ToString()) + DosCero(dtFechaFin.DateTime.Day.ToString());
            SelArt.MtdSeleccionarCliente();
            if (SelArt.Exito == true)
            {
                ArticulosActualizados = 1;
                pbProgreso.Properties.Maximum = SelArt.Datos.Rows.Count;
                GValCatalogos.SetRowCellValue(Fila, GValCatalogos.Columns[2], SelArt.Datos.Rows.Count);
                GValCatalogos.SetRowCellValue(Fila, GValCatalogos.Columns[4], "Procesando");
                for (int i = 0; i < SelArt.Datos.Rows.Count; i++)
                {
                    Application.DoEvents();
                    GValCatalogos.SetRowCellValue(Fila, GValCatalogos.Columns[3], ArticulosActualizados);
                    lEstatus.Text = "Codigo Cliente [" + SelArt.Datos.Rows[i][0].ToString() + "]";
                    SincronizaCliente(SelArt.Datos.Rows[i][0].ToString(), SelArt.Datos.Rows[i][1].ToString(), Convert.ToDateTime(SelArt.Datos.Rows[i][2]), SelArt.Datos.Rows[i][3].ToString(),
                        SelArt.Datos.Rows[i][4].ToString(), SelArt.Datos.Rows[i][5].ToString(), SelArt.Datos.Rows[i][6].ToString(), SelArt.Datos.Rows[i][7].ToString(),
                        SelArt.Datos.Rows[i][8].ToString(), SelArt.Datos.Rows[i][9].ToString(), SelArt.Datos.Rows[i][10].ToString(), Convert.ToDateTime(SelArt.Datos.Rows[i][11]),
                        SelArt.Datos.Rows[i][12].ToString(), SelArt.Datos.Rows[i][13].ToString(), SelArt.Datos.Rows[i][14].ToString(), SelArt.Datos.Rows[i][15].ToString(),
                        SelArt.Datos.Rows[i][16].ToString(), SelArt.Datos.Rows[i][17].ToString(), SelArt.Datos.Rows[i][18].ToString(), SelArt.Datos.Rows[i][19].ToString(),
                        SelArt.Datos.Rows[i][20].ToString(), SelArt.Datos.Rows[i][21].ToString(), SelArt.Datos.Rows[i][22].ToString(), SelArt.Datos.Rows[i][23].ToString(),
                        SelArt.Datos.Rows[i][24].ToString(), SelArt.Datos.Rows[i][25].ToString(), SelArt.Datos.Rows[i][26].ToString(), SelArt.Datos.Rows[i][27].ToString(),
                        SelArt.Datos.Rows[i][28].ToString()
                        );

                    pbProgreso.Position = i + 1;
                }
                if (ArticulosError == 0)
                {
                    GValCatalogos.SetRowCellValue(Fila, GValCatalogos.Columns[4], "Actualizados");
                }
                else
                {
                    GValCatalogos.SetRowCellValue(Fila, GValCatalogos.Columns[4], "Con Errores");
                }
            }
        }
        private void SincronizaCliente(string ClienteId, string ClienteNombre, DateTime ClienteFecha, string ClientePaterno, string ClienteMaterno, string ClienteRfc, string ClienteCalle,
            string ClienteNInterior, string ClienteNExterior, string ClienteColonia, string LocalidadId, DateTime ClienteFechaActualizacion, string ClienteTelefono1,
            string ClienteTelefono2, string ClienteTelefono3, string ClienteEmail, string ClienteEmailFiscal, string ClienteTipoPersona, string ClienteActivo, string CClienteId,
            string ClienteImpresion, string ClienteLimiteCredito, string ClienteSobregiro, string VendedorId, string CondicionesPagosId, string ClienteTieneCredito,
            string ClienteDescuento, string ClienteObservaciones, string ClienteSaldoActual)
        {
            CLS_Cliente_Central UdpArt = new CLS_Cliente_Central();



            UdpArt.ClienteId = Convert.ToInt32(ClienteId);
            UdpArt.ClienteNombre = ClienteNombre;
            UdpArt.ClienteFecha = ClienteFecha.Date.Year.ToString() + DosCero(ClienteFecha.Date.Month.ToString()) + DosCero(ClienteFecha.Date.Day.ToString());
            UdpArt.ClientePaterno = ClientePaterno;
            UdpArt.ClienteMaterno = ClienteMaterno;
            UdpArt.ClienteRfc = ClienteRfc;
            UdpArt.ClienteCalle = ClienteCalle;
            UdpArt.ClienteNInterior = ClienteNInterior;
            UdpArt.ClienteNExterior = ClienteNExterior;
            UdpArt.ClienteColonia = ClienteColonia;
            UdpArt.LocalidadId = Convert.ToInt32(LocalidadId);
            UdpArt.ClienteFechaActualizacion = ClienteFechaActualizacion.Date.Year.ToString() + DosCero(ClienteFechaActualizacion.Date.Month.ToString()) + DosCero(ClienteFechaActualizacion.Date.Day.ToString());
            UdpArt.ClienteTelefono1 = ClienteTelefono1;
            UdpArt.ClienteTelefono2 = ClienteTelefono2;
            UdpArt.ClienteTelefono3 = ClienteTelefono3;
            UdpArt.ClienteEmail = ClienteEmail;
            UdpArt.ClienteEmailFiscal = ClienteEmailFiscal;
            UdpArt.ClienteTipoPersona = ClienteTipoPersona;
            UdpArt.ClienteActivo = ClienteActivo;
            UdpArt.CClienteId = Convert.ToInt32(CClienteId);
            UdpArt.ClienteImpresion = Convert.ToInt32(ClienteImpresion);
            UdpArt.ClienteLimiteCredito = Convert.ToDecimal(ClienteLimiteCredito);
            UdpArt.ClienteSobregiro = Convert.ToDecimal(ClienteSobregiro);
            UdpArt.VendedorId = Convert.ToInt32(VendedorId);
            UdpArt.CondicionesPagosId = Convert.ToInt32(CondicionesPagosId);
            UdpArt.ClienteTieneCredito = Convert.ToInt32(ClienteTieneCredito);
            UdpArt.ClienteDescuento = Convert.ToDecimal(ClienteDescuento);
            UdpArt.ClienteObservaciones = ClienteObservaciones);
            UdpArt.ClienteSaldoActual = Convert.ToDecimal(ClienteSaldoActual);

            UdpArt.MtdActualizarCliente();

            if (UdpArt.Exito == true)
            {
                ArticulosActualizados++;
            }
        }

    }
}