﻿using System.Linq;
using System;
using System.Collections.Generic;
using System.Reflection;
using System.IO;
using System.Net.Mail;
using System.Net.Mime;
using DevExpress.XtraEditors;

namespace CapaDeDatos
{

    public class CLS_Email : ConexionBase
    {
        public string EmailRemitente { get; set; }
        public string EmailUsuario { get; set; }
        public string EmailPass { get; set; }
        public string EmailServidorSalida { get; set; }
        public string EmailServidorEntrada { get; set; }
        public int EmailPuerto { get; set; }
        public string EmailDestino { get; set; }
        public string EmailAsunto { get; set; }
        public string EmailMensaje { get; set; }
        public Boolean EmailSSL { get; set; }
        public string UnSoloEmail { get; set; }
        public string Elementos { get; set; }
        public string vFolio { get;  set; }
        public string vProveedorId { get;  set; }
        public string vNombreProveedor { get;  set; }
        public string vRutaArchivos { get;  set; }

        public void Enviar_Email()
        {
            MailMessage objMail = new MailMessage();
            string Servidor = EmailServidorSalida;
            objMail.From = new MailAddress(EmailRemitente); //Remitente
            objMail.To.Add(EmailDestino.Trim()); //Email a enviar 
            objMail.Subject = EmailAsunto;
            objMail.IsBodyHtml = true; //Formato Html del email
            objMail.Body = EmailMensaje;
            SmtpClient SmtpMail = new SmtpClient();
            SmtpMail.Host = Servidor; //el nombre del servidor de correo
            SmtpMail.EnableSsl = EmailSSL;
            SmtpMail.Port = EmailPuerto; //asignamos el numero de puerto
            SmtpMail.UseDefaultCredentials = false;
            SmtpMail.Credentials = new System.Net.NetworkCredential(EmailUsuario, EmailPass);
            SmtpMail.Send(objMail); //Enviamos el correo
        }

        public void MtdEnvioCorreo(string body, string correoDestinatario)
        {
            this.Exito = true;

            CLS_Correos ParmGen = new CLS_Correos();
            ParmGen.MtdSeleccionar();
            
            if (ParmGen.Exito)
            {
                EmailRemitente = ParmGen.Datos.Rows[0][0].ToString();
                EmailUsuario = ParmGen.Datos.Rows[0][1].ToString();
                EmailPass =ParmGen.Datos.Rows[0][2].ToString();
                EmailPuerto = Convert.ToInt32(ParmGen.Datos.Rows[0][6].ToString());
                EmailServidorSalida = ParmGen.Datos.Rows[0][3].ToString();
                EmailServidorEntrada = ParmGen.Datos.Rows[0][4].ToString();
                EmailSSL = Convert.ToBoolean(ParmGen.Datos.Rows[0][5].ToString());
                EmailDestino = correoDestinatario;
                EmailMensaje = body;
                EmailAsunto = EmailAsunto;
                Enviar_Email();
            }
        } 

        public void SendMailPrueba()
        {
            EmailMensaje = "Configuracion Correcta de los Datos";
            CLS_Correos ParmGen = new CLS_Correos();
            ParmGen.MtdSeleccionar();
            this.Exito = true;
            if (ParmGen.Exito)
            {
                EmailRemitente = ParmGen.Datos.Rows[0][0].ToString();
                EmailUsuario = ParmGen.Datos.Rows[0][1].ToString();
                EmailPass = ParmGen.Datos.Rows[0][2].ToString();
                EmailPuerto = Convert.ToInt32(ParmGen.Datos.Rows[0][6].ToString());
                EmailServidorSalida = ParmGen.Datos.Rows[0][3].ToString();
                EmailServidorEntrada = ParmGen.Datos.Rows[0][4].ToString();
                EmailSSL = Convert.ToBoolean(ParmGen.Datos.Rows[0][5].ToString());
            }
            // se define la lista de destinatarios
            //
            CLS_Correos emailboletin = new CLS_Correos();
            //se selecciona el listado de usuarios a los cuales se les envía el correo
            emailboletin.MtdSeleccionarCorreosDestino();
            List<string> destinatarios = new List<string>();
            if (emailboletin.Exito)
            {
                if (emailboletin.Datos.Rows.Count > 0)
                {
                    for (int x = 0; x < emailboletin.Datos.Rows.Count; x++)
                    {
                        destinatarios.Add(emailboletin.Datos.Rows[x][0].ToString());
                    }
                }
            }
            MailMessage mail = new MailMessage()
            {
                From = new MailAddress(EmailRemitente),
                Subject = "Prueba Configuracion Backup",
                IsBodyHtml = true
            };
            mail.Body = EmailMensaje;
            //
            // se asignan los destinatarios
            //
            foreach (string item in destinatarios)
            {
                mail.To.Add(new MailAddress(item));
            }
            //
            // se define el smtp
            //
            try
            {
                SmtpClient smtp = new SmtpClient();
                smtp.Host = EmailServidorSalida;
                smtp.Port = EmailPuerto;
                smtp.EnableSsl = EmailSSL;
                smtp.UseDefaultCredentials = true;
                smtp.Credentials = new System.Net.NetworkCredential(EmailUsuario, EmailPass);
                smtp.Send(mail);
                XtraMessageBox.Show("Se han enviado el Correo con Exito");
            }
            catch(Exception ex)
            {
                XtraMessageBox.Show(ex.Message);
            }
        }

        public void SendMailError()
        {
            CLS_Correos ParmGen = new CLS_Correos();
            ParmGen.MtdSeleccionar();
            this.Exito = true;
            if (ParmGen.Exito)
            {
                EmailRemitente = ParmGen.Datos.Rows[0][0].ToString();
                EmailUsuario = ParmGen.Datos.Rows[0][1].ToString();
                EmailPass = ParmGen.Datos.Rows[0][2].ToString();
                EmailPuerto = Convert.ToInt32(ParmGen.Datos.Rows[0][6].ToString());
                EmailServidorSalida = ParmGen.Datos.Rows[0][3].ToString();
                EmailServidorEntrada = ParmGen.Datos.Rows[0][4].ToString();
                EmailSSL = Convert.ToBoolean(ParmGen.Datos.Rows[0][5].ToString());
            }
            // se define la lista de destinatarios
            //
            CLS_Correos emailboletin = new CLS_Correos();
            //se selecciona el listado de usuarios a los cuales se les envía el correo
            emailboletin.MtdSeleccionarCorreosDestino();
            List<string> destinatarios = new List<string>();
            if (emailboletin.Exito)
            {
                if (emailboletin.Datos.Rows.Count > 0)
                {
                    for (int x = 0; x < emailboletin.Datos.Rows.Count; x++)
                    {
                        destinatarios.Add(emailboletin.Datos.Rows[x][0].ToString());
                    }
                }
            }
            MailMessage mail = new MailMessage()
            {
                From = new MailAddress(EmailRemitente),
                Subject = "Agent Backup DB",
                IsBodyHtml = true
            };
            mail.Body = EmailMensaje;
            //
            // se asignan los destinatarios
            //
            int i = 0;
            foreach (string item in destinatarios)
            {
                i++;
                mail.To.Add(new MailAddress(item));
            }
            //
            // se define el smtp
            //
            SmtpClient smtp = new SmtpClient();
            smtp.Host = EmailServidorSalida;
            smtp.Port = EmailPuerto;
            smtp.EnableSsl = EmailSSL;
            smtp.UseDefaultCredentials = false;
            smtp.Credentials = new System.Net.NetworkCredential(EmailUsuario, EmailPass);
            if (i > 0)
            {
                smtp.Send(mail);
            }
        }
        public void SendMailReportes(string Asunto, int ReportesId, string Archivos)
        {
            Exito = false;
            try
            {
                CLS_Correos ParmGen = new CLS_Correos();
                ParmGen.MtdSeleccionar();
                if (ParmGen.Exito)
                {
                    Crypto DesEncryp = new Crypto();
                    EmailRemitente = ParmGen.Datos.Rows[0]["CorreoRemitente"].ToString();
                    EmailUsuario = ParmGen.Datos.Rows[0]["CorreoUsuario"].ToString();
                    EmailPass = ParmGen.Datos.Rows[0]["CorreoContrasenia"].ToString();
                    EmailPuerto = Convert.ToInt32(ParmGen.Datos.Rows[0]["CorreoPuertoSalida"].ToString());
                    EmailServidorSalida = ParmGen.Datos.Rows[0]["CorreoServidorSalida"].ToString();
                    EmailServidorEntrada = ParmGen.Datos.Rows[0]["CorreoServidorEntrada"].ToString();
                    EmailSSL = Convert.ToBoolean(ParmGen.Datos.Rows[0]["CorreoCifradoSSL"].ToString());
                }
                MailMessage mail = new MailMessage()
                {
                    From = new MailAddress(EmailRemitente),
                    Subject = Asunto,
                    IsBodyHtml = true,
                };
                
                CLS_Correos EmailDestinos = new CLS_Correos();
                EmailDestinos.ReportesId = ReportesId;
                EmailDestinos.MtdSeleccionarCorreosReportes();
                List<string> destinatarios = new List<string>();
                if (EmailDestinos.Exito)
                {
                    if (EmailDestinos.Datos.Rows.Count > 0)
                    {
                        for (int x = 0; x < EmailDestinos.Datos.Rows.Count; x++)
                        {
                            destinatarios.Add(EmailDestinos.Datos.Rows[x]["CorreoNombre"].ToString());
                        }
                    }
                }

                foreach (string item in destinatarios)
                {
                    mail.To.Add(new MailAddress(item));
                }
                if (Archivos != string.Empty)
                {
                    mail.Attachments.Add(new Attachment(Archivos, System.Net.Mime.MediaTypeNames.Application.Pdf));
                }

                string htmlBody = "";
                Directory.CreateDirectory(@"C:\LiberaPedidos");
                const string path = @"C:\LiberaPedidos\MailHtmlBody.txt";
                const string pathImagen = @"C:\LiberaPedidos\Soneli.png";
                CuerpoHTML archivo = new CuerpoHTML();
                // aquí si se pone elementos SendMailBodyHTMLGestor
                archivo.vFolio = vFolio;
                archivo.vProveedorId = vProveedorId;
                archivo.vNombreProveedor = vNombreProveedor;
                archivo.vRutaArchivos = vRutaArchivos;
                archivo.CreaHTMLLiberaPedidos(path);
                
                if (File.Exists(path))
                {
                    using (StreamReader reader = new StreamReader(path))
                    {
                        htmlBody = reader.ReadToEnd();
                    }

                    AlternateView htmlView = AlternateView.CreateAlternateViewFromString(htmlBody, null, MediaTypeNames.Text.Html);

                    Assembly thisExe = Assembly.GetExecutingAssembly();
                    string[] cadena = thisExe.GetManifestResourceNames();

                    FileStream file = File.Open(pathImagen, FileMode.Open);
                    //System.IO.Stream file = thisExe.GetManifestResourceStream("CapaDatos.Properties.Resources.resources");

                    LinkedResource logo = new LinkedResource(file) { ContentId = "Soneli" };
                    htmlView.LinkedResources.Add(logo);

                    mail.AlternateViews.Add(htmlView);
                    //
                    // se define el smtp
                    //
                    SmtpClient smtp = new SmtpClient();
                    smtp.Host = EmailServidorSalida;
                    smtp.Port = EmailPuerto;
                    smtp.EnableSsl = EmailSSL;
                    smtp.Credentials = new System.Net.NetworkCredential(EmailUsuario, EmailPass);
                    smtp.Send(mail);
                    mail.Dispose();
                    Exito = true;
                }
                else
                {
                    XtraMessageBox.Show("No se ha definido Archivo HTML");
                }
            }
            catch (Exception ex)
            {
                Exito = false;
                Mensaje = ex.Message;
            }
        }
    }
}
