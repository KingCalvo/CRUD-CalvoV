import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.ArrayList;

public class List extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        ArrayList<String[]> alumnos = new ArrayList<>();
        StringBuilder logs = new StringBuilder();
        
        try {
            // Conexión a la base de datos
            String url = "jdbc:postgresql://127.0.0.1/demo";
            String usuario = "calvoubuntu";
            String password = "8641";
            
            logs.append("<p>Driver registrado</p>");
            logs.append("<p>Conectando a... ").append(url).append("</p>");
            
            Class.forName("org.postgresql.Driver");
            Connection conexion = DriverManager.getConnection(url, usuario, password);
            
            // Query para obtener los datos
            String query = "SELECT * FROM alumnos";
            logs.append("<p>Ejecutando consulta: ").append(query).append("</p>");
            
            PreparedStatement stmt = conexion.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            
            logs.append("<p>Consulta ejecutada exitosamente. Procesando resultados...</p>");
            
            // Almacenar los resultados en una lista
            while (rs.next()) {
                String[] alumno = {
                    rs.getString("id"),
                    rs.getString("nombre_alumno"),
                    rs.getString("apellido_paterno"),
                    rs.getString("apellido_materno"),
                    rs.getString("edad"),
                    rs.getString("correo_institucional"),
                    rs.getString("carrera"),
                    rs.getString("turno")
                };
                alumnos.add(alumno);
            }
            
            logs.append("<p>Resultados procesados exitosamente.</p>");
            
            rs.close();
            stmt.close();
            conexion.close();
            logs.append("<p>Conexión cerrada correctamente.</p>");
            
        } catch (Exception e) {
            logs.append("<p>Error durante la operación: ").append(e.getMessage()).append("</p>");
            e.printStackTrace(out);
        }
        
        // Pasar logs y la lista de alumnos a la página JSP
        request.setAttribute("logs", logs.toString());
        request.setAttribute("alumnos", alumnos);
        RequestDispatcher dispatcher = request.getRequestDispatcher("listAlumnos.jsp");
        dispatcher.forward(request, response);
    }
}
