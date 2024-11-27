import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

public class Alta extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            // Recuperar los valores enviados desde el formulario
            String nombre = request.getParameter("nombre-alumno");
            String apellidoPaterno = request.getParameter("apellido-paterno");
            String apellidoMaterno = request.getParameter("apellido-materno");
            String edadParam = request.getParameter("edad");
            String fechaNacimiento = request.getParameter("fecha-nacimiento");
            String sexo = request.getParameter("sexo");
            String domicilio = request.getParameter("domicilio");
            String codigoPostal = request.getParameter("codigo-postal");
            String ciudad = request.getParameter("ciudad");
            String entidadFederativa = request.getParameter("entidad-federativa");
            String telefonoCelular = request.getParameter("telefono-celular");
            String telefonoCasa = request.getParameter("telefono-casa");
            String numeroControl = request.getParameter("numero-control");
            String semestreParam = request.getParameter("semestre");
            String correoInstitucional = request.getParameter("correo-institucional");
            String carrera = request.getParameter("carrera");
            String turno = request.getParameter("turno");
            String correoPersonal = request.getParameter("correo-personal");
            String curp = request.getParameter("curp");
            String comentariosAdicionales = request.getParameter("comentarios-adicionales");
            boolean recibirInfo = request.getParameter("recibirInfo") != null;

            // Imprimir todos los campos recibidos
            out.println("<h1>Datos recibidos del formulario:</h1>");
            out.println("<p>Nombre: " + nombre + "</p>");
            out.println("<p>Apellido Paterno: " + apellidoPaterno + "</p>");
            out.println("<p>Apellido Materno: " + apellidoMaterno + "</p>");
            out.println("<p>Edad: " + edadParam + "</p>");
            out.println("<p>Fecha de Nacimiento: " + fechaNacimiento + "</p>");
            out.println("<p>Sexo: " + sexo + "</p>");
            out.println("<p>Domicilio: " + domicilio + "</p>");
            out.println("<p>Código Postal: " + codigoPostal + "</p>");
            out.println("<p>Ciudad: " + ciudad + "</p>");
            out.println("<p>Entidad Federativa: " + entidadFederativa + "</p>");
            out.println("<p>Teléfono Celular: " + telefonoCelular + "</p>");
            out.println("<p>Teléfono Casa: " + telefonoCasa + "</p>");
            out.println("<p>Número de Control: " + numeroControl + "</p>");
            out.println("<p>Semestre: " + semestreParam + "</p>");
            out.println("<p>Correo Institucional: " + correoInstitucional + "</p>");
            out.println("<p>Carrera: " + carrera + "</p>");
            out.println("<p>Turno: " + turno + "</p>");
            out.println("<p>Correo Personal: " + correoPersonal + "</p>");
            out.println("<p>CURP: " + curp + "</p>");
            out.println("<p>Comentarios Adicionales: " + comentariosAdicionales + "</p>");
            out.println("<p>Recibir Información: " + recibirInfo + "</p>");

            // Validar que los campos obligatorios no sean nulos o vacíos
            StringBuilder errores = new StringBuilder();
            if (nombre == null || nombre.trim().isEmpty()) errores.append("Nombre, ");
            if (apellidoPaterno == null || apellidoPaterno.trim().isEmpty()) errores.append("Apellido Paterno, ");
            if (apellidoMaterno == null || apellidoMaterno.trim().isEmpty()) errores.append("Apellido Materno, ");
            if (edadParam == null || edadParam.trim().isEmpty()) errores.append("Edad, ");
            if (fechaNacimiento == null || fechaNacimiento.trim().isEmpty()) errores.append("Fecha de Nacimiento, ");
            if (sexo == null || sexo.trim().isEmpty()) errores.append("Sexo, ");
            if (domicilio == null || domicilio.trim().isEmpty()) errores.append("Domicilio, ");
            if (codigoPostal == null || codigoPostal.trim().isEmpty()) errores.append("Código Postal, ");
            if (ciudad == null || ciudad.trim().isEmpty()) errores.append("Ciudad, ");
            if (entidadFederativa == null || entidadFederativa.trim().isEmpty()) errores.append("Entidad Federativa, ");
            if (telefonoCelular == null || telefonoCelular.trim().isEmpty()) errores.append("Teléfono Celular, ");
            if (numeroControl == null || numeroControl.trim().isEmpty()) errores.append("Número de Control, ");
            if (semestreParam == null || semestreParam.trim().isEmpty()) errores.append("Semestre, ");
            if (correoInstitucional == null || correoInstitucional.trim().isEmpty()) errores.append("Correo Institucional, ");
            if (carrera == null || carrera.trim().isEmpty()) errores.append("Carrera, ");
            if (turno == null || turno.trim().isEmpty()) errores.append("Turno, ");
            if (correoPersonal == null || correoPersonal.trim().isEmpty()) errores.append("Correo Personal, ");
            if (curp == null || curp.trim().isEmpty()) errores.append("CURP, ");

            if (errores.length() > 0) {
                out.println("<h3>Errores encontrados:</h3>");
                out.println("<p>Faltan los siguientes campos: " + errores.substring(0, errores.length() - 2) + "</p>");
                return;
            }

            // Convertir valores necesarios
            int edad = Integer.parseInt(edadParam);
            int semestre = Integer.parseInt(semestreParam);

            // Conexión a la base de datos
            String url = "jdbc:postgresql://127.0.0.1/demo";
            String usuario = "calvoubuntu";
            String password = "8641";

            Class.forName("org.postgresql.Driver");
            Connection conexion = DriverManager.getConnection(url, usuario, password);
            out.println("<p>Conexión establecida con la base de datos.</p>");

            // Query de inserción
            String query = "INSERT INTO alumnos (nombre_alumno, apellido_paterno, apellido_materno, edad, fecha_nacimiento, " +
                           "sexo, domicilio, codigo_postal, ciudad, entidad_federativa, telefono_celular, telefono_casa, " +
                           "numero_control, semestre, correo_institucional, carrera, turno, correo_personal, curp, " +
                           "comentarios_adicionales, recibir_info) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conexion.prepareStatement(query);

            // Asignar valores al PreparedStatement
            stmt.setString(1, nombre);
            stmt.setString(2, apellidoPaterno);
            stmt.setString(3, apellidoMaterno);
            stmt.setInt(4, edad);
            stmt.setDate(5, java.sql.Date.valueOf(fechaNacimiento));
            stmt.setString(6, sexo);
            stmt.setString(7, domicilio);
            stmt.setString(8, codigoPostal);
            stmt.setString(9, ciudad);
            stmt.setString(10, entidadFederativa);
            stmt.setString(11, telefonoCelular);
            stmt.setString(12, telefonoCasa);
            stmt.setString(13, numeroControl);
            stmt.setInt(14, semestre);
            stmt.setString(15, correoInstitucional);
            stmt.setString(16, carrera);
            stmt.setString(17, turno);
            stmt.setString(18, correoPersonal);
            stmt.setString(19, curp);
            stmt.setString(20, comentariosAdicionales);
            stmt.setBoolean(21, recibirInfo);

            // Ejecutar la inserción
            int filasAfectadas = stmt.executeUpdate();
            if (filasAfectadas > 0) {
                out.println("<p>Registro insertado exitosamente.</p>");
            } else {
                out.println("<p>No se pudo insertar el registro.</p>");
            }

            // Cerrar recursos
            stmt.close();
            conexion.close();
            out.println("<p>Conexión cerrada exitosamente.</p>");

        } catch (Exception e) {
            // Manejo de errores
            out.println("<p>Ocurrió un error: " + e.getMessage() + "</p>");
            e.printStackTrace(out);
        } finally {
            out.close();
        }
    }
}
