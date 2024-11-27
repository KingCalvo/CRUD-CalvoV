import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

public class Delete extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Obtener el ID del alumno a eliminar
        String id = request.getParameter("id");

        try {
            // Conexión a la base de datos
            String url = "jdbc:postgresql://127.0.0.1/demo";
            String usuario = "calvoubuntu";
            String password = "8641";

            Class.forName("org.postgresql.Driver");
            Connection conexion = DriverManager.getConnection(url, usuario, password);

            // Consulta de eliminación
            String query = "DELETE FROM alumnos WHERE id=?";
            PreparedStatement stmt = conexion.prepareStatement(query);
            stmt.setInt(1, Integer.parseInt(id));

            int filasEliminadas = stmt.executeUpdate();

            if (filasEliminadas > 0) {
                out.println("<p>Registro eliminado exitosamente.</p>");
            } else {
                out.println("<p>Error al eliminar el registro.</p>");
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
