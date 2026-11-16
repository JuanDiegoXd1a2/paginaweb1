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
    <title>Resultado Reporte</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body style="background:#f4f6f9;">

<div class="container mt-5">
    <div class="card shadow p-4">
        <div class="border rounded p-3 mb-4 bg-light text-center">
            <h2>Préstamos del Asociado: <%= request.getAttribute("dniBuscado") %></h2>
        </div>

        <table class="table table-bordered table-hover">
            <thead class="thead-dark">
                <tr>
                    <th>ID Prestamo</th><th>Asociado</th><th>Monto</th>
                    <th>Interés</th><th>Cantidad Cuotas</th><th>Fecha</th><th>Estado</th>
                </tr>
            </thead>
            <tbody>
            <%
                List<Map<String, Object>> historial =
                    (List<Map<String, Object>>) request.getAttribute("historial");

                if (historial == null || historial.isEmpty()) {
            %>
                <tr>
                    <td colspan="7" class="text-center">No se encontraron resultados</td>
                </tr>
            <%  } else {
                    for (Map<String, Object> fila : historial) {
            %>
                <tr>
                    <td><%= fila.get("id_prestamo") %></td>
                    <td><%= fila.get("asociado") %></td>
                    <td>S/. <%= fila.get("monto") %></td>
                    <td><%= fila.get("interes") %>%</td>
                    <td><%= fila.get("cantidad_cuotas") %></td>
                    <td><%= fila.get("fecha") %></td>
                    <td><%= fila.get("estado") %></td>
                </tr>
            <%  }
                } %>
            </tbody>
        </table>

        <div class="text-center mt-4">
            <a href="reportes_reportes.jsp" class="btn btn-primary">Volver</a>
        </div>
    </div>
</div>
</body>
</html>
