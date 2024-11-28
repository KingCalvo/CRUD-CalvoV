<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Lista de Alumnos</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-white text-black flex flex-col items-center min-h-screen pt-20">
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
                <h1 class="text-4xl font-bold text-white">Lista de Alumnos</h1>
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
        <div class="container bg-white rounded-lg p-6 mt-20">
            <h1 class="text-2xl font-bold mb-4 text-center">Lista de Alumnos</h1>
            <table class="table-auto w-full border-collapse border border-gray-300">
                <thead>
                    <tr class="bg-[#1B396A] text-white">
                        <th class="border border-gray-300 px-4 py-2">ID</th>
                        <th class="border border-gray-300 px-4 py-2">Nombre</th>
                        <th class="border border-gray-300 px-4 py-2">Apellido Paterno</th>
                        <th class="border border-gray-300 px-4 py-2">Apellido Materno</th>
                        <th class="border border-gray-300 px-4 py-2">Edad</th>
                        <th class="border border-gray-300 px-4 py-2">Correo Institucional</th>
                        <th class="border border-gray-300 px-4 py-2">Carrera</th>
                        <th class="border border-gray-300 px-4 py-2">Turno</th>
                        <th class="border border-gray-300 px-4 py-2">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        ArrayList<String[]> alumnos = (ArrayList<String[]>) request.getAttribute("alumnos");
                        if (alumnos != null && !alumnos.isEmpty()) {
                            for (String[] alumno : alumnos) {
                    %>
                    <tr class="text-center">
                        <td class="border border-gray-300 px-4 py-2"><%= alumno[0] %></td>
                        <td class="border border-gray-300 px-4 py-2"><%= alumno[1] %></td>
                        <td class="border border-gray-300 px-4 py-2"><%= alumno[2] %></td>
                        <td class="border border-gray-300 px-4 py-2"><%= alumno[3] %></td>
                        <td class="border border-gray-300 px-4 py-2"><%= alumno[4] %></td>
                        <td class="border border-gray-300 px-4 py-2"><%= alumno[5] %></td>
                        <td class="border border-gray-300 px-4 py-2"><%= alumno[6] %></td>
                        <td class="border border-gray-300 px-4 py-2"><%= alumno[7] %></td>
                        <td class="border border-gray-300 px-4 py-2 flex items-center justify-center gap-2">
                            <!-- Ícono para eliminar -->
                            <a href="Delete?id=<%= alumno[0] %>">
                                <img
                                    src="public/basura.png"
                                    alt="Eliminar"
                                    title="Eliminar"
                                    class="w-8 h-8 cursor-pointer"
                                />
                            </a>
                            <!-- Ícono para editar -->
                            <a href="Update?id=<%= alumno[0] %>">
                                <img
                                    src="public/editar.png"
                                    alt="Editar"
                                    title="Editar"
                                    class="w-8 h-8 cursor-pointer"
                                />
                            </a>
                        </td>
                    </tr>
                    <% 
                            }
                        } else { 
                    %>
                    <tr>
                        <td colspan="9" class="text-center border border-gray-300 px-4 py-2">No hay registros</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </body>
</html>
