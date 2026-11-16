<%-- 
    Document   : principal
    Created on : 12 may. 2026, 4:04:58 p. m.
    Author     : hardc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    String usuario = (String)session.getAttribute("usuario");

    if(usuario == null){

        response.sendRedirect("login.jsp");

    }

%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Panel Principal</title>

    <style>

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family: Arial, sans-serif;
        }

        body{
            background:#f4f6f9;
        }

        header{
            background:#003366;
            color:white;
            padding:20px;
            text-align:center;
        }

        nav{
            background:#0055a5;
            padding:15px;
            text-align:center;
        }

        nav a{
            color:white;
            text-decoration:none;
            margin:0 15px;
            font-weight:bold;
        }

        nav a:hover{
            color:yellow;
        }

        .contenedor{
            padding:40px;
        }

        .cards{
            display:flex;
            justify-content:center;
            gap:30px;
            flex-wrap:wrap;
        }

        .card{
            background:white;
            width:280px;
            padding:30px;
            border-radius:15px;
            box-shadow:0px 5px 15px rgba(0,0,0,0.2);
            text-align:center;
        }

        .card h2{
            color:#003366;
            margin-bottom:15px;
        }

        .card p{
            margin-bottom:20px;
        }

        .btn{
            background:#0055a5;
            color:white;
            padding:10px 20px;
            text-decoration:none;
            border-radius:8px;
        }

        .btn:hover{
            background:#003366;
        }

    </style>

</head>

<body>

    <header>
        <h1>SISTEMA AHORROPERU</h1>
        <p>Gestión de préstamos y asociados</p>
    </header>

    <nav>

        <a href="Principal.jsp">Inicio</a>
        <a href="AsociadosServlet">Asociados</a>
        <a href="PrestamosServlet">Préstamos</a>
        <a href="CuotasServlet">Cuotas</a>
        <a href="ReportesServlet">Reportes</a>
        <a href="logout.jsp">Cerrar Sesión</a>

    </nav>

    <div class="contenedor">

        <div class="cards">

            <div class="card">

                <h2>Asociados</h2>

                <p>
                    Registrar y administrar asociados.
                </p>

                <a href="AsociadosServlet" class="btn">
                    Ingresar
                </a>

            </div>

            <div class="card">

                <h2>Préstamos</h2>

                <p>
                    Gestionar solicitudes de préstamos.
                </p>

                <a href="PrestamosServlet" class="btn">
                    Ingresar
                </a>

            </div>

            <div class="card">

                <h2>Reportes</h2>

                <p>
                    Visualizar reportes y estadísticas.
                </p>

                <a href="ReportesServlet" class="btn">
                    Ingresar
                </a>

            </div>

        </div>

    </div>

</body>
</html>
