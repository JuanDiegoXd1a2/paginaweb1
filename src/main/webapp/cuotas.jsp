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
    <title>Cuotas</title>
    <style>
        *{ margin:0; padding:0; box-sizing:border-box; font-family: Arial; }
        body{ background:#f4f6f9; }
        header{ background:#003366; color:white; padding:20px; text-align:center; }
        .contenedor{ width:90%; margin:auto; margin-top:30px; }
        table{ width:100%; border-collapse:collapse; background:white; box-shadow:0px 5px 10px rgba(0,0,0,0.2); }
        th{ background:#003366; color:white; padding:12px; }
        td{ padding:10px; text-align:center; border-bottom:1px solid #ccc; }
        .volver{ display:inline-block; margin-top:20px; text-decoration:none; background:#003366; color:white; padding:10px 20px; border-radius:5px; }
        .estado-pagado{ color:green; font-weight:bold; }
        .estado-pendiente{ color:orange; font-weight:bold; }
    </style>
</head>
<body>

<header>
    <h1>MÓDULO CUOTAS</h1>
</header>

<div class="contenedor">
    <table>
        <tr>
            <th>ID</th><th>Préstamo</th><th>N° Cuota</th>
            <th>Monto</th><th>Fecha Pago</th><th>Estado</th>
        </tr>
        <%
            List<Map<String, Object>> lista =
                (List<Map<String, Object>>) request.getAttribute("listaCuotas");
            if (lista != null) {
                for (Map<String, Object> c : lista) {
                    String estado = (String) c.get("estado");
        %>
        <tr>
            <td><%= c.get("id_cuota") %></td>
            <td><%= c.get("id_prestamo") %></td>
            <td><%= c.get("numero_cuota") %></td>
            <td>S/. <%= c.get("monto_cuota") %></td>
            <td><%= c.get("fecha_pago") %></td>
            <td>
                <span class="<%= "Pagado".equals(estado) ? "estado-pagado" : "estado-pendiente" %>">
                    <%= estado %>
                </span>
            </td>
        </tr>
        <%  }
            } %>
    </table>
    <a href="Principal.jsp" class="volver">Volver</a>
</div>
</body>
</html>
