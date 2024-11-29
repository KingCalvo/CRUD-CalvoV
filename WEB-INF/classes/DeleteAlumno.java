import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

public class DeleteAlumno extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        try {
            // Recuperar el ID del alumno que se va a eliminar
            String id = request.getParameter("id");

            // Conexión a la base de datos
            String url = "jdbc:postgresql://127.0.0.1/demo";
            String usuario = "calvoubuntu";
            String password = "8641";
            
            Class.forName("org.postgresql.Driver");
            Connection conexion = DriverManager.getConnection(url, usuario, password);

            // Query de eliminación
            String query = "DELETE FROM alumnos WHERE id = ?;";
            PreparedStatement stmt = conexion.prepareStatement(query);
            stmt.setInt(1, Integer.parseInt(id)); // Asignar el ID al PreparedStatement

            // Ejecutar la eliminación
            int filasEliminadas = stmt.executeUpdate();

            if (filasEliminadas > 0) {
                out.println("<p>El registro se eliminó correctamente.</p>");
            } else {
                out.println("<p>No se pudo eliminar el registro.</p>");
            }

            // Cerrar la conexión
            stmt.close();
            conexion.close();

            // Redirigir a listAlumnos.jsp para que se actualicen los registros
            response.sendRedirect("listAlumnos");

        } catch (Exception e) {
            out.println("<p>Error al eliminar el registro: " + e.getMessage() + "</p>");
            e.printStackTrace(out);
        } finally {
            out.close();
        }
    }
}
