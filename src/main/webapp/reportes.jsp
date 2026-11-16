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
    <title>Reportes</title>
    <style>
        *{ margin:0; padding:0; box-sizing:border-box; font-family: Arial; }
        body{ background:#f4f6f9; }
        header{ background:#003366; color:white; padding:20px; text-align:center; }
        .contenedor{ width:90%; margin:auto; margin-top:30px; }
        .cards{ display:flex; gap:20px; flex-wrap:wrap; margin-bottom:30px; }
        .card{ flex:1; min-width:250px; background:white; padding:25px; border-radius:10px; box-shadow:0px 5px 10px rgba(0,0,0,0.2); text-align:center; }
        .card h2{ color:#003366; margin-bottom:15px; }
        .card p{ font-size:30px; font-weight:bold; color:#0055a5; }
        table{ width:100%; border-collapse:collapse; background:white; box-shadow:0px 5px 10px rgba(0,0,0,0.2); margin-top:20px; }
        th{ background:#003366; color:white; padding:12px; }
        td{ padding:10px; text-align:center; border-bottom:1px solid #ccc; }
        .volver{ display:inline-block; margin-top:20px; text-decoration:none; background:#003366; color:white; padding:10px 20px; border-radius:5px; }
        .btn-naranja{ display:inline-block; margin-top:20px; margin-left:10px; text-decoration:none; background:#e67e22; color:white; padding:10px 20px; border-radius:5px; }
    </style>
</head>
<body>

<header>
    <h1>MÓDULO REPORTES</h1>
</header>

<div class="contenedor">

    <div class="cards">
        <div class="card">
            <h2>Total Asociados</h2>
            <p><%= request.getAttribute("totalAsociados") != null ? request.getAttribute("totalAsociados") : 0 %></p>
        </div>
        <div class="card">
            <h2>Total Préstamos</h2>
            <p><%= request.getAttribute("totalPrestamos") != null ? request.getAttribute("totalPrestamos") : 0 %></p>
        </div>
        <div class="card">
            <h2>Monto Total</h2>
            <p>S/. <%= request.getAttribute("montoTotal") != null ? request.getAttribute("montoTotal") : "0.0" %></p>
        </div>
    </div>

    <table>
        <tr>
            <th>ID</th><th>Asociado</th><th>Monto</th><th>Estado</th>
        </tr>
        <%
            List<Map<String, Object>> lista =
                (List<Map<String, Object>>) request.getAttribute("listaPrestamos");
            if (lista != null) {
                for (Map<String, Object> p : lista) {
        %>
        <tr>
            <td><%= p.get("id_prestamo") %></td>
            <td><%= p.get("asociado") %></td>
            <td>S/. <%= p.get("monto") %></td>
            <td><%= p.get("estado") %></td>
        </tr>
        <%  }
            } %>
    </table>

    <a href="Principal.jsp" class="volver">Volver</a>
    <a href="reportes_reportes.jsp" class="btn-naranja">Ver Reportes Especiales</a>
</div>
</body>
</html>
