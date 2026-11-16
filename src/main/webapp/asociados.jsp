<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Protección de sesión
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Asociados</title>
    <style>
        *{ margin:0; padding:0; box-sizing:border-box; font-family: Arial; }
        body{ background:#f4f6f9; }
        header{ background:#003366; color:white; padding:20px; text-align:center; }
        .contenedor{ width:90%; margin:auto; margin-top:30px; }
        .formulario{ background:white; padding:20px; border-radius:10px; margin-bottom:30px; box-shadow:0px 5px 10px rgba(0,0,0,0.2); }
        .grupo{ margin-bottom:15px; }
        .grupo label{ display:block; margin-bottom:5px; font-weight:bold; }
        .grupo input{ width:100%; padding:10px; border:1px solid #ccc; border-radius:5px; }
        .btn{ background:#0055a5; color:white; padding:10px 20px; border:none; border-radius:5px; cursor:pointer; }
        .btn:hover{ background:#003366; }
        .error{ background:#ffe0e0; color:#c00; padding:10px; border-radius:5px; margin-bottom:15px; }
        table{ width:100%; border-collapse:collapse; background:white; box-shadow:0px 5px 10px rgba(0,0,0,0.2); }
        th{ background:#003366; color:white; padding:12px; }
        td{ padding:10px; text-align:center; border-bottom:1px solid #ccc; }
        .volver{ display:inline-block; margin-top:20px; text-decoration:none; background:#003366; color:white; padding:10px 20px; border-radius:5px; }
    </style>
</head>
<body>

<header>
    <h1>MÓDULO ASOCIADOS</h1>
</header>

<div class="contenedor">

    <% String error = (String) request.getAttribute("error");
       if (error != null) { %>
        <div class="error"><%= error %></div>
    <% } %>

    <!-- FORMULARIO apunta al Servlet -->
    <div class="formulario">
        <form method="post" action="AsociadosServlet">
            <div class="grupo"><label>DNI</label><input type="text" name="dni" maxlength="8" required></div>
            <div class="grupo"><label>Nombres</label><input type="text" name="nombres" required></div>
            <div class="grupo"><label>Apellidos</label><input type="text" name="apellidos" required></div>
            <div class="grupo"><label>Teléfono</label><input type="text" name="telefono"></div>
            <div class="grupo"><label>Dirección</label><input type="text" name="direccion"></div>
            <div class="grupo"><label>Correo</label><input type="email" name="correo"></div>
            <input type="submit" value="Guardar" class="btn">
        </form>
    </div>

    <!-- TABLA: datos vienen del Servlet, sin lógica de BD aquí -->
    <table>
        <tr>
            <th>ID</th><th>DNI</th><th>Nombres</th><th>Apellidos</th>
            <th>Teléfono</th><th>Dirección</th><th>Correo</th>
        </tr>
        <%
            List<Map<String, Object>> lista =
                (List<Map<String, Object>>) request.getAttribute("listaAsociados");
            if (lista != null) {
                for (Map<String, Object> fila : lista) {
        %>
        <tr>
            <td><%= fila.get("id_asociado") %></td>
            <td><%= fila.get("dni") %></td>
            <td><%= fila.get("nombres") %></td>
            <td><%= fila.get("apellidos") %></td>
            <td><%= fila.get("telefono") %></td>
            <td><%= fila.get("direccion") %></td>
            <td><%= fila.get("correo") %></td>
        </tr>
        <%  }
            } %>
    </table>

    <a href="Principal.jsp" class="volver">Volver</a>

</div>
</body>
</html>
