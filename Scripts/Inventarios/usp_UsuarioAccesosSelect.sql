
GO
/****** Object:  StoredProcedure [dbo].[usp_UsuarioAccesosSelect]    Script Date: 17/09/2019 05:38:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[usp_UsuarioAccesosSelect]
AS
BEGIN
	SET NOCOUNT ON;
SELECT        Usuarios.UsuariosId, RTRIM(Usuarios.UsuariosNombre) AS UsuariosNombre, RTRIM(Usuarios.UsuariosLogin) AS UsuariosLogin, RTRIM(Usuarios.UsuariosPassword) AS UsuariosPassword, 
                         RTRIM(Roles.RolesNombre) AS RolesNombre
FROM            Usuarios INNER JOIN
                         Roles ON Usuarios.RolesId = Roles.RolesId

END


