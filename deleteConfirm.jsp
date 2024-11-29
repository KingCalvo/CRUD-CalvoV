<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ page import="java.sql.*" %> <%@ page
import="java.io.*" %> <%@ page import="javax.servlet.http.*" %> <%@ page
import="javax.servlet.*" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Confirmar eliminación</title>
    <script src="https://cdn.tailwindcss.com"></script>
  </head>
  <body class="bg-gray-100 flex justify-center items-center min-h-screen">
    <div class="container bg-white rounded-lg shadow-lg p-6">
      <h2 class="text-2xl font-bold mb-4 text-center">
        ¿Estás seguro de que deseas eliminar este registro?
      </h2>

      <% String id = request.getParameter("id"); if (id != null &&
      !id.isEmpty()) { %>
      <form action="deleteAlumno" method="POST">
        <input type="hidden" name="id" value="<%= id %>" />
        <div class="flex justify-center gap-4">
          <button
            type="submit"
            class="px-4 py-2 bg-red-500 text-white rounded-lg"
          >
            Eliminar
          </button>
          <a
            href="listAlumnos"
            class="px-4 py-2 bg-gray-500 text-white rounded-lg"
            >Cancelar</a
          >
        </div>
      </form>
      <% } else { %>
      <div class="error-message">
        <p>Error: No se ha proporcionado un ID válido.</p>
      </div>
      <% } %>
    </div>
  </body>
</html>
