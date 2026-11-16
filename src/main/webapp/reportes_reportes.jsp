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
    <title>Reportes Asociados</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body style="background:#f4f6f9;">

<div class="container mt-5 d-flex justify-content-center">
    <div class="card shadow p-4 w-75">
        <div class="border rounded p-3 mb-4 bg-light text-center">
            <h3>Historial de Movimientos</h3>
        </div>

        <!-- Formulario apunta al ReportesServlet (POST) -->
        <form method="post" action="ReportesServlet">
            <div class="row">
                <div class="col-md-6">
                    <label for="dni">DNI</label>
                    <input type="text" class="form-control" id="dni" name="dni"
                           maxlength="8" required placeholder="Ingrese su DNI">
                </div>
                <div class="col-md-6">
                    <label for="correo">Correo del asociado</label>
                    <input type="email" class="form-control" id="correo" name="correo"
                           placeholder="Ingrese su correo">
                </div>
            </div>
            <div class="row mt-4">
                <div class="col-md-4">
                    <button type="submit" class="btn btn-primary w-100">Generar Reporte</button>
                </div>
                <div class="col-md-4">
                    <button type="button" class="btn btn-danger w-100"
                            onclick="window.open('https://docs.google.com/spreadsheets/d/1v8H9CWcuvZGnj7K9tXrqK04hkU7ganHKc9qnxEElhd4/edit?gid=24489620#gid=24489620')">
                        Exportar Reporte
                    </button>
                </div>
                <div class="col-md-4">
                    <a href="Principal.jsp" class="btn btn-secondary w-100">¡Volver!</a>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>
