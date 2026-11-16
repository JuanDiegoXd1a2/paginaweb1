<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Préstamos</title>
    <style>
        *{ margin:0; padding:0; box-sizing:border-box; font-family: Arial; }
        body{ background:#f4f6f9; }
        header{ background:#003366; color:white; padding:20px; text-align:center; }
        .contenedor{ width:90%; margin:auto; margin-top:30px; }
        .formulario{ background:white; padding:20px; border-radius:10px; margin-bottom:30px; box-shadow:0px 5px 10px rgba(0,0,0,0.2); }
        .grupo{ margin-bottom:15px; }
        .grupo label{ display:block; margin-bottom:5px; font-weight:bold; }
        .grupo input, .grupo select{ width:100%; padding:10px; border:1px solid #ccc; border-radius:5px; }
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
    <h1>MÓDULO PRÉSTAMOS</h1>
</header>

<div class="contenedor">

    <% String error = (String) request.getAttribute("error");
       if (error != null) { %>
        <div class="error"><%= error %></div>
    <% } %>

    <div class="formulario">
        <form method="post" action="PrestamosServlet">
            <div class="grupo">
                <label>Asociado</label>
                <select name="id_asociado" required>
                    <option value="">Seleccione</option>
                    <%
                        List<Map<String, Object>> asociados =
                            (List<Map<String, Object>>) request.getAttribute("listaAsociados");
                        if (asociados != null) {
                            for (Map<String, Object> a : asociados) {
                    %>
                    <option value="<%= a.get("id_asociado") %>">
                        <%= a.get("nombres") %> <%= a.get("apellidos") %>
                    </option>
                    <%      }
                        } %>
                </select>
            </div>
            <div class="grupo"><label>Monto</label><input type="number" step="0.01" name="monto" required></div>
            <div class="grupo"><label>Interés (%)</label><input type="number" step="0.01" name="interes" required></div>
            <div class="grupo"><label>Cantidad Cuotas</label><input type="number" name="cuotas" required></div>
            <div class="grupo"><label>Fecha</label><input type="date" name="fecha" required></div>
            <div class="grupo">
                <label>Estado</label>
                <select name="estado">
                    <option>Aprobado</option>
                    <option>Pendiente</option>
                    <option>Rechazado</option>
                </select>
            </div>
            <input type="submit" value="Guardar" class="btn">
        </form>
    </div>

    <table>
        <tr>
            <th>ID</th><th>Asociado</th><th>Monto</th><th>Interés</th>
            <th>Cuotas</th><th>Fecha</th><th>Estado</th>
        </tr>
        <%
            List<Map<String, Object>> prestamos =
                (List<Map<String, Object>>) request.getAttribute("listaPrestamos");
            if (prestamos != null) {
                for (Map<String, Object> p : prestamos) {
        %>
        <tr>
            <td><%= p.get("id_prestamo") %></td>
            <td><%= p.get("asociado") %></td>
            <td>S/. <%= p.get("monto") %></td>
            <td><%= p.get("interes") %>%</td>
            <td><%= p.get("cantidad_cuotas") %></td>
            <td><%= p.get("fecha") %></td>
            <td><%= p.get("estado") %></td>
        </tr>
        <%  }
            } %>
    </table>

    <a href="Principal.jsp" class="volver">Volver</a>
</div>
</body>
</html>
