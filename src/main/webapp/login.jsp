<%-- 
    Document   : login
    Created on : 12 may. 2026, 4:29:50 p. m.
    Author     : hardc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login - AHORROPERU</title>

    <style>

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family: Arial, sans-serif;
        }

        body{
            height:100vh;
            display:flex;
            justify-content:center;
            align-items:center;
            background:linear-gradient(to right, #003366, #0055a5);
        }

        .login{
            background:white;
            width:350px;
            padding:40px;
            border-radius:15px;
            box-shadow:0px 5px 15px rgba(0,0,0,0.3);
        }

        .login h1{
            text-align:center;
            color:#003366;
            margin-bottom:10px;
        }

        .login p{
            text-align:center;
            color:gray;
            margin-bottom:25px;
        }

        .grupo{
            margin-bottom:20px;
        }

        .grupo label{
            display:block;
            margin-bottom:8px;
            font-weight:bold;
            color:#003366;
        }

        .grupo input{
            width:100%;
            padding:12px;
            border:1px solid #ccc;
            border-radius:8px;
        }

        .grupo input:focus{
            border:1px solid #0055a5;
            outline:none;
        }

        .btn{
            width:100%;
            padding:12px;
            background:#0055a5;
            color:white;
            border:none;
            border-radius:8px;
            cursor:pointer;
            font-size:16px;
        }

        .btn:hover{
            background:#003366;
        }

    </style>

</head>

<body>

    <div class="login">

        <h1>AHORROPERU</h1>
        <p>Inicio de Sesión</p>

        <form action="LoginServlet" method="post">

            <div class="grupo">
                <label>Usuario</label>
                <input type="text" name="usuario" required>
            </div>

            <div class="grupo">
                <label>Contraseña</label>
                <input type="password" name="clave" required>
            </div>

            <input type="submit" value="Ingresar" class="btn">

        </form>

    </div>

</body>
</html>