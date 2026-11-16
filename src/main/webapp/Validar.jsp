<%@page import="java.sql.*"%>
<%@page import="conexion.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%

    String usuario = request.getParameter("usuario");
    String clave = request.getParameter("clave");

    Conexion cn = new Conexion();

    Connection con = cn.conectar();

    boolean acceso = false;

    if(con != null){

        try{

            String sql = "SELECT * FROM usuarios WHERE usuario=? AND clave=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, usuario);

            ps.setString(2, clave);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){

                acceso = true;

            }

        }catch(Exception e){

            out.println("Error: " + e);

        }

    }

    if(acceso){

        session.setAttribute("usuario", usuario);

        response.sendRedirect("Principal.jsp");

    }else{

%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error</title>
</head>

<body>

    <h1>Usuario o contraseña incorrectos</h1>

    <a href="login.jsp">
        Volver
    </a>

</body>
</html>

<%
    }
%>