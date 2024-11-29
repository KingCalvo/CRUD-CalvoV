import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

public class Actualizar extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            // Recuperar los valores enviados desde el formulario
            String id = request.getParameter("id");  // Suponiendo que el ID venga en la solicitud
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

            // Conexión a la base de datos
            String url = "jdbc:postgresql://127.0.0.1/demo";
            String usuario = "calvoubuntu";
            String password = "8641";

            Class.forName("org.postgresql.Driver");
            Connection conexion = DriverManager.getConnection(url, usuario, password);

            // Query de actualización
            String query = "UPDATE alumnos SET "
                + "nombre_alumno = ?, apellido_paterno = ?, apellido_materno = ?, edad = ?, "
                + "fecha_nacimiento = ?, sexo = ?, domicilio = ?, codigo_postal = ?, ciudad = ?, "
                + "entidad_federativa = ?, telefono_celular = ?, telefono_casa = ?, numero_control = ?, "
                + "semestre = ?, correo_institucional = ?, carrera = ?, turno = ?, correo_personal = ?, "
                + "curp = ?, comentarios_adicionales = ?, recibir_info = ? WHERE id = ?;";


            PreparedStatement stmt = conexion.prepareStatement(query);

            // Asignar valores al PreparedStatement
            stmt.setString(1, nombre);
            stmt.setString(2, apellidoPaterno);
            stmt.setString(3, apellidoMaterno);
            stmt.setInt(4, Integer.parseInt(edadParam));
            stmt.setDate(5, java.sql.Date.valueOf(fechaNacimiento));
            stmt.setString(6, sexo);
            stmt.setString(7, domicilio);
            stmt.setString(8, codigoPostal);
            stmt.setString(9, ciudad);
            stmt.setString(10, entidadFederativa);
            stmt.setString(11, telefonoCelular);
            stmt.setString(12, telefonoCasa);
            stmt.setString(13, numeroControl);
            stmt.setInt(14, Integer.parseInt(semestreParam));
            stmt.setString(15, correoInstitucional);
            stmt.setString(16, carrera);
            stmt.setString(17, turno);
            stmt.setString(18, correoPersonal);
            stmt.setString(19, curp);
            stmt.setString(20, comentariosAdicionales);
            stmt.setBoolean(21, recibirInfo);
            stmt.setInt(22, Integer.parseInt(id)); // ID al final


            // Ejecutar la actualización
            int filasAfectadas = stmt.executeUpdate();
            if (filasAfectadas > 0) {
                out.println("<p>Registro actualizado exitosamente.</p>");
                // Redirigir al servlet List para que recupere los registros actualizados
                response.sendRedirect("listAlumnos");

            } else {
                out.println("<p>Error: No se pudo actualizar el registro.</p>");
            }

            // Cerrar recursos
            stmt.close();
            conexion.close();

        } catch (Exception e) {
            // Manejo de errores
            out.println("<p>Ocurrió un error: " + e.getMessage() + "</p>");
            e.printStackTrace(out);
        } finally {
            out.close();
        }
    }
}
