<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Actualizar - Formulario</title>
    <script src="https://cdn.tailwindcss.com"></script>
  </head>
  <body
    class="bg-white text-black flex flex-col items-center min-h-screen pt-20"
  >
  <%
  String id = request.getParameter("id");

  if (id == null || id.isEmpty()) {
%>
  <div class="error-message">
      <p>Error: No se proporcionó un ID válido.</p>
  </div>
<%
  } else {
      // Inicializamos las variables
      String nombre = "", apellidoPaterno = "", apellidoMaterno = "", fechaNacimiento = "", sexo = "", domicilio = "", codigoPostal = "", ciudad = "", entidadFederativa = "", telefonoCelular = "", telefonoCasa = "", numeroControl = "", correoInstitucional = "", carrera = "", turno = "", correoPersonal = "", curp = "", comentariosAdicionales = ""; 
      boolean recibirInfo = false; 
      int edad = 0, semestre = 0; 

      try {
          // Paso 1: Registrar el driver
          Class.forName("org.postgresql.Driver");

          // Paso 2: Establecer la conexión
          String url = "jdbc:postgresql://127.0.0.1/demo";
          String usuario = "calvoubuntu";
          String password = "8641";
          Connection conexion = DriverManager.getConnection(url, usuario, password);

          // Paso 3: Preparar la consulta SQL para cargar datos
          String query = "SELECT * FROM alumnos WHERE id = ?";
          PreparedStatement stmt = conexion.prepareStatement(query);
          stmt.setInt(1, Integer.parseInt(id)); // Convertir id a entero
          ResultSet rs = stmt.executeQuery();

          if (rs.next()) {
              // Asignar valores a las variables
              nombre = rs.getString("nombre_alumno");
              apellidoPaterno = rs.getString("apellido_paterno");
              apellidoMaterno = rs.getString("apellido_materno");
              edad = rs.getInt("edad"); // Integer
              fechaNacimiento = rs.getDate("fecha_nacimiento").toString(); // Convertir Date a String
              sexo = rs.getString("sexo");
              domicilio = rs.getString("domicilio");
              codigoPostal = rs.getString("codigo_postal");
              ciudad = rs.getString("ciudad");
              entidadFederativa = rs.getString("entidad_federativa");
              telefonoCelular = rs.getString("telefono_celular");
              telefonoCasa = rs.getString("telefono_casa");
              numeroControl = rs.getString("numero_control");
              semestre = rs.getInt("semestre"); // Integer
              correoInstitucional = rs.getString("correo_institucional");
              carrera = rs.getString("carrera");
              turno = rs.getString("turno");
              correoPersonal = rs.getString("correo_personal");
              curp = rs.getString("curp");
              comentariosAdicionales = rs.getString("comentarios_adicionales");
              recibirInfo = rs.getBoolean("recibir_info");


              // Imprimir todos los datos en una tabla para mejor visualización
%>
    <!-- Header -->
    <header
      class="fixed top-0 left-0 right-0 w-full bg-[#1B396A] px-4 py-1 shadow-md flex items-center justify-between z-50 h-16 border-b-2 border-blue-950"
    >
      <div class="flex items-center w-1/3">
        <img
          src="public/LogoTec.png"
          alt="Logo Institución 2"
          class="w-32 h-auto"
        />
      </div>
      <div class="text-center flex-grow">
        <h1 class="text-4xl font-bold text-white">Formulario</h1>
      </div>
      <div class="flex items-center justify-end w-1/3">
        <img
          src="public/itcuautla.png"
          alt="Logo Institución 1"
          class="max-w-[4rem] h-auto"
        />
      </div>
    </header>

    <!-- Main Content -->
    <main class="flex-grow flex justify-center items-start w-full">
      <form
        class="w-[1400px] h-auto p-2 bg-[#ffffff] rounded-lg grid grid-cols-1 md:grid-cols-2"
        action="actualizar"
        method="POST"
        value="<%= id %>"
      > 
        <input type="hidden" name="id" value="<%= id %>">
        <!-- Datos personales -->
        <fieldset
          id="datos-personales"
          class="border-2 border-[#172554] rounded-lg p-2 mb-0 shadow-md"
        >
          <legend class="text-2xl font-bold mb-4 text-center">
            Datos personales
          </legend>
          <div class="flex flex-wrap -mx-2">
            <!-- Inputs de Datos Personales -->
            <div class="w-full md:w-1/2 px-2 mb-4">
              <label for="nombre-alumno" class="block font-semibold mb-1"
                >Nombre del alumno: <span class="text-red-700"> *</span></label
              >
              <input
                type="text"
                id="nombre-alumno"
                name="nombre-alumno"
                placeholder="Escribe tu nombre"
                class="w-full px-4 py-2 border rounded focus:ring focus:ring-blue-300"
                required
                pattern="[a-zA-Z\s]{1,50}"
                maxlength="50"
                value="<%= nombre != null ? nombre : "" %>"
              />
            </div>
            <div class="w-full md:w-1/2 px-2 mb-4">
              <label for="apellido-paterno" class="block font-semibold mb-1"
                >Apellido paterno: <span class="text-red-700"> *</span></label
              >
              <input
                type="text"
                id="apellido-paterno"
                name="apellido-paterno"
                placeholder="Escribe tu apellido paterno"
                class="w-full px-4 py-2 border rounded focus:ring focus:ring-blue-300"
                required
                pattern="[a-zA-Z\s]{1,50}"
                maxlength="50"
                value="<%= apellidoPaterno != null ? apellidoPaterno : "" %>"
              />
            </div>
            <div class="w-full md:w-1/2 px-2 mb-4">
              <label for="apellido-materno" class="block font-semibold mb-1"
                >Apellido materno: <span class="text-red-700"> *</span></label
              >
              <input
                type="text"
                id="apellido-materno"
                name="apellido-materno"
                placeholder="Escribe tu apellido materno"
                class="w-full px-4 py-2 border rounded focus:ring focus:ring-blue-300"
                required
                pattern="[a-zA-Z\s]{1,50}"
                maxlength="50"
                value="<%= apellidoMaterno != null ? apellidoMaterno : "" %>"
              />
            </div>
            <div class="w-full md:w-1/2 px-2 mb-4">
              <label for="edad" class="block font-semibold mb-1"
                >Edad: <span class="text-red-700"> *</span></label
              >
              <input
                type="number"
                id="edad"
                name="edad"
                placeholder="Escribe tu edad"
                class="w-full px-4 py-2 border rounded focus:ring focus:ring-blue-300"
                required
                min="18"
                max="99"
                value="<%= edad != 0 ? edad : "" %>"
              />
            </div>
            <div class="w-full md:w-1/2 px-2 mb-4">
              <label for="fecha-nacimiento" class="block font-semibold mb-1"
                >Fecha de nacimiento:
                <span class="text-red-700"> *</span></label
              >
              <input
                type="date"
                id="fecha-nacimiento"
                name="fecha-nacimiento"
                class="w-full px-4 py-2 border rounded focus:ring focus:ring-blue-300"
                required
                min="1925-11-13"
                max="2006-11-12"
                value="<%= fechaNacimiento != null ? fechaNacimiento : "" %>"
              />
            </div>
            <div class="w-full md:w-1/2 px-2 mb-4">
              <label class="block font-semibold mb-1"
                >Sexo: <span class="text-red-700"> *</span></label
              >
              <div class="flex items-center">
                <input
                  type="radio"
                  id="masculino"
                  name="sexo"
                  value="masculino"
                  class="mr-2"
                  required
                  <%= "masculino".equals(sexo) ? "checked" : "" %>
                />
                <label for="masculino" class="mr-4">Masculino </label>
                <input
                  type="radio"
                  id="femenino"
                  name="sexo"
                  value="femenino"
                  class="mr-2"
                  <%= "femenino".equals(sexo) ? "checked" : "" %>
                />
                <label for="femenino" class="mr-4">Femenino</label>
                <input
                  type="radio"
                  id="otro"
                  name="sexo"
                  value="otro"
                  class="mr-2"
                  <%= "otro".equals(sexo) ? "checked" : "" %>
                />
                <label for="otro">Otro</label>
              </div>
            </div>
            <div class="w-full md:w-1/2 px-2 mb-4">
              <label for="domicilio" class="block font-semibold mb-1"
                >Domicilio: <span class="text-red-700"> *</span></label
              >
              <input
                type="text"
                id="domicilio"
                name="domicilio"
                placeholder="Escribe tu domicilio"
                class="w-full px-4 py-2 border rounded focus:ring focus:ring-blue-300"
                required
                value="<%= domicilio != null ? domicilio : "" %>"
              />
            </div>
            <div class="w-full md:w-1/2 px-2 mb-4">
              <label for="codigo-postal" class="block font-semibold mb-1"
                >Código Postal: <span class="text-red-700"> *</span></label
              >
              <input
                type="text"
                id="codigo-postal"
                name="codigo-postal"
                placeholder="Escribe tu código postal"
                class="w-full px-4 py-2 border rounded focus:ring focus:ring-blue-300"
                required
                pattern="\d{5}"
                maxlength="5"
                value="<%= codigoPostal != null ? codigoPostal : "" %>"
              />
            </div>
            <div class="w-full md:w-1/2 px-2 mb-4">
              <label for="ciudad" class="block font-semibold mb-1"
                >Ciudad: <span class="text-red-700"> *</span></label
              >
              <input
                type="text"
                id="ciudad"
                name="ciudad"
                placeholder="Escribe tu ciudad"
                class="w-full px-4 py-2 border rounded focus:ring focus:ring-blue-300"
                required
                pattern="[a-zA-Z\s]{1,50}"
                maxlength="50"
                value="<%= ciudad != null ? ciudad : "" %>"
              />
            </div>
            <div class="w-full md:w-1/2 px-2 mb-4">
              <label for="entidad-federativa" class="block font-semibold mb-1"
                >Entidad Federativa: <span class="text-red-700"> *</span></label
              >
              <input
                type="text"
                id="entidad-federativa"
                name="entidad-federativa"
                placeholder="Escribe tu estado"
                class="w-full px-4 py-2 border rounded focus:ring focus:ring-blue-300"
                required
                pattern="[a-zA-Z\s]{1,50}"
                maxlength="50"
                value="<%= entidadFederativa != null ? entidadFederativa : "" %>"
              />
            </div>
            <div class="w-full md:w-1/2 px-2 mb-4">
              <label for="telefono-celular" class="block font-semibold mb-1"
                >Teléfono celular: <span class="text-red-700"> *</span></label
              >
              <input
                type="tel"
                id="telefono-celular"
                name="telefono-celular"
                placeholder="10 dígitos"
                class="w-full px-4 py-2 border rounded focus:ring focus:ring-blue-300"
                required
                pattern="\d{10}"
                maxlength="10"
                value="<%= telefonoCelular != null ? telefonoCelular : "" %>"
              />
            </div>
            <div class="w-full md:w-1/2 px-2 mb-4">
              <label for="telefono-casa" class="block font-semibold mb-1"
                >Teléfono de casa:</label
              >
              <input
                type="tel"
                id="telefono-casa"
                name="telefono-casa"
                placeholder="10 dígitos"
                class="w-full px-4 py-2 border rounded focus:ring focus:ring-blue-300"
                pattern="\d{10}"
                maxlength="10"
                value="<%= telefonoCasa != null ? telefonoCasa : "" %>"
              />
            </div>
          </div>
        </fieldset>

        <!-- Información académica -->
        <fieldset
          id="datos-academicos"
          class="border-2 border-[#172554] rounded-lg p-2 mb-0 shadow-md ml-3"
        >
          <legend class="text-2xl font-bold mb-4 text-center">
            Información académica
          </legend>

          <div class="flex flex-wrap -mx-2">
            <!-- Número de control -->
            <div class="w-full md:w-1/2 px-2 mb-4">
              <label for="numero-control" class="block font-semibold mb-1"
                >Número de control: <span class="text-red-700"> *</span></label
              >
              <input
                type="text"
                id="numero-control"
                name="numero-control"
                placeholder="Escribe tu número de control"
                class="w-full px-4 py-2 border rounded focus:ring focus:ring-blue-300"
                required
                pattern="\d{1,8}"
                maxlength="8"
                value="<%= numeroControl != null ? numeroControl : "" %>"
              />
            </div>
            <!-- Semestre -->
            <div class="w-full md:w-1/2 px-2 mb-4">
              <label for="semestre" class="block font-semibold mb-1"
                >Semestre: <span class="text-red-700"> *</span></label
              >
              <select
                id="semestre"
                name="semestre"
                class="w-full px-4 py-2 border rounded focus:ring focus:ring-blue-300"
              >
                <option value="" disabled selected>
                  Selecciona tu semestre
                </option>
                <% for (int i = 1; i <= 10; i++) { %>
                  <option value="<%= i %>" <%= (semestre == i) ? "selected" : "" %>><%= i %></option>
                <% } %>
              </select>
            </div>
          </div>

          <div class="flex flex-wrap -mx-2">
            <!-- Correo institucional -->
            <div class="w-full md:w-1/2 px-2 mb-4">
              <label for="correo-institucional" class="block font-semibold mb-1"
                >Correo institucional:
                <span class="text-red-700"> *</span></label
              >
              <input
                type="email"
                id="correo-institucional"
                name="correo-institucional"
                placeholder="ejemplo@institucion.mx"
                class="w-full px-4 py-2 border rounded focus:ring focus:ring-blue-300"
                required
                value="<%= correoInstitucional != null ? correoInstitucional : "" %>"
              />
            </div>
            <!-- Carrera -->
            <div class="w-full md:w-1/2 px-2 mb-4">
              <label for="carrera" class="block font-semibold mb-1"
                >Carrera: <span class="text-red-700"> *</span></label
              >
              <select
                id="carrera"
                name="carrera"
                class="w-full px-4 py-2 border rounded focus:ring focus:ring-blue-300"
              >
                <option value="" disabled selected>
                  Selecciona tu carrera
                </option>
                <option value="ing-electronica" <%= "ing-electronica".equals(carrera) ? "selected" : "" %>>Ing. Electrónica</option>
                <option value="ing-industrial" <%= "ing-industrial".equals(carrera) ? "selected" : "" %>>Ing. Industrial</option>
                <option value="ing-mecatronica" <%= "ing-mecatronica".equals(carrera) ? "selected" : "" %>>Ing. Mecatrónica</option>
                <option value="ing-sistemas" <%= "ing-sistemas".equals(carrera) ? "selected" : "" %>>
                  Ing. Sistemas Computacionales
                </option>
                <option value="contador-publico" <%= "contador-publico".equals(carrera) ? "selected" : "" %>>Contador Público</option>
                <option value="ing-gestion-empresarial" <%= "ing-gestion-empresarial".equals(carrera) ? "selected" : "" %>>
                  Ing. Gestión Empresarial
                </option>
                <option value="ing-civil" <%= "ing-civil".equals(carrera) ? "selected" : "" %>>Ing. Civil</option>
              </select>
            </div>
          </div>

          <div class="flex flex-wrap -mx-2">
            <!-- Repetir correo institucional -->
            <div class="w-full md:w-1/2 px-2 mb-4">
              <label
                for="correo-institucional-repetir"
                class="block font-semibold mb-1"
                >Repetir correo institucional:
                <span class="text-red-700"> *</span></label
              >
              <input
                type="email"
                id="correo-institucional-repetir"
                name="correo-institucional-repetir"
                placeholder="Repite tu correo"
                class="w-full px-4 py-2 border rounded focus:ring focus:ring-blue-300"
                required
              />
            </div>
            <!-- Turno -->
            <div class="w-full md:w-1/2 px-2 mb-4">
              <label for="turno" class="block font-semibold mb-1"
                >Turno: <span class="text-red-700"> *</span></label
              >
              <select
                  id="turno"
                  name="turno"
                  class="w-full px-4 py-2 border rounded focus:ring focus:ring-blue-300"
              >
                  <option value="" disabled selected>Selecciona tu turno</option>
                  <option value="matutino" <%= "matutino".equals(turno) ? "selected" : "" %>>Matutino</option>
                  <option value="vespertino" <%= "vespertino".equals(turno) ? "selected" : "" %>>Vespertino</option>
              </select>

            </div>
          </div>
          <div class="flex flex-wrap -mx-2">
            <!-- correo personal -->
            <div class="w-full md:w-1/2 px-2 mb-4">
              <label for="correo-personal" class="block font-semibold mb-1"
                >Correo personal: <span class="text-red-700"> *</span></label
              >
              <input
                type="email"
                id="correo-personal"
                name="correo-personal"
                placeholder="correo@ejemplo.com"
                class="w-full px-4 py-2 border rounded focus:ring focus:ring-blue-300"
                required
                value="<%= correoPersonal != null ? correoPersonal : "" %>"
              />
            </div>
            <!-- CURP -->
            <div class="w-full md:w-1/2 px-2 mb-4">
              <label for="curp" class="block font-semibold mb-1"
                >CURP: <span class="text-red-700"> *</span></label
              >
              <input
                type="text"
                id="curp"
                name="curp"
                placeholder="Escribe tu CURP"
                class="w-full px-4 py-2 border rounded focus:ring focus:ring-blue-300"
                required
                pattern="[A-Z0-9]{18}"
                minlength="18"
                maxlength="18"
                style="text-transform: uppercase"
                value="<%= curp != null ? curp : "" %>"
              />
            </div>
          </div>

          <div class="flex flex-wrap -mx-2">
            <!-- Comentarios adicionales -->
            <div class="w-full px-2 mb-4">
              <label
                for="comentarios-adicionales"
                class="block font-semibold mb-1"
                >Comentarios adicionales:</label
              >
              <textarea
                  id="comentarios-adicionales"
                  name="comentarios-adicionales"
                  placeholder="Escribe tus comentarios adicionales aquí"
                  class="w-full px-4 py-2 border rounded focus:ring focus:ring-blue-300"
                  rows="4"
              ><%= comentariosAdicionales != null ? comentariosAdicionales : "" %></textarea>

            </div>

            <!-- Checkbox para recibir información -->
            <div class="w-full px-2 mb-4 flex items-center">
              <input
                type="checkbox"
                id="recibirInfo"
                name="recibirInfo"
                class="mr-2"
                <%= recibirInfo ? "checked" : "" %>
              />
              <label for="recibirInfo" class="font-semibold"
                >¿Quieres recibir más información por correo?</label
              >
            </div>
          </div>
        </fieldset>

        <div class="col-span-2 text-center mt-8">
          <button
            type="submit"
            class="px-6 py-2 bg-[#1B396A] text-white font-semibold rounded hover:bg-blue-700"
          >
            Actualizar
          </button>
        </div>
      </form>
      <%
                    } else {
        %>
                        <div class="error-message">
                            <p>Error: No se encontró el registro con ID: <%= id %>.</p>
                        </div>
        <%
                    }

                    // Cerrar conexión y recursos
                    rs.close();
                    stmt.close();
                    conexion.close();
                } catch (Exception e) {
        %>
                    <div class="error-message">
                        <p>Error: <%= e.getMessage() %></p>
                    </div>
        <%
                }
            }
        %>
    </main>
  </body>
</html>
