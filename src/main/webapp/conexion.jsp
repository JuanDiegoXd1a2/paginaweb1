<%-- 
    Document   : conexion
    Created on : 12 may. 2026, 4:14:27 p. m.
    Author     : hardc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="conexion.Conexion"%>
<%@page import="java.sql.Connection"%>

<%

    Conexion cn = new Conexion();

    Connection con = cn.conectar();

    if(con != null){

        out.println("SI CONECTA A MYSQL");

    }else{

        out.println("NO CONECTA");

    }

%>