import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

public class Update extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Obtener parámetros del formulario
        String id = request.getParameter("id");
        String nombre = request.getParameter("nombre");
        String apellidoPaterno = request.getParameter("apellidoPaterno");
        String apellidoMaterno = request.getParameter("apellidoMaterno");
        String edad = request.getParameter("edad");
        String correoInstitucional = request.getParameter("correoInstitucional");
        String carrera = request.getParameter("carrera");
        String turno = request.getParameter("turno");

        try {
            // Conexión a la base de datos
            String url = "jdbc:postgresql://127.0.0.1/demo";
            String usuario = "calvoubuntu";
            String password = "8641";

            Class.forName("org.postgresql.Driver");
            Connection conexion = DriverManager.getConnection(url, usuario, password);

            // Consulta de actualización
            String query = "UPDATE alumnos SET nombre_alumno=?, apellido_paterno=?, apellido_materno=?, edad=?, correo_institucional=?, carrera=?, turno=? WHERE id=?";
            PreparedStatement stmt = conexion.prepareStatement(query);
            stmt.setString(1, nombre);
            stmt.setString(2, apellidoPaterno);
            stmt.setString(3, apellidoMaterno);
            stmt.setInt(4, Integer.parseInt(edad));
            stmt.setString(5, correoInstitucional);
            stmt.setString(6, carrera);
            stmt.setString(7, turno);
            stmt.setInt(8, Integer.parseInt(id));

            int filasActualizadas = stmt.executeUpdate();

            if (filasActualizadas > 0) {
                out.println("<p>Registro actualizado exitosamente.</p>");
            } else {
                out.println("<p>Error al actualizar el registro.</p>");
            }

            stmt.close();
            conexion.close();

        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
            e.printStackTrace(out);
        }

        // Redirigir a la lista de alumnos
        response.sendRedirect("List");
    }
}
