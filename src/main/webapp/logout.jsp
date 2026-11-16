<%-- 
    Document   : logout
    Created on : 12 may. 2026, 6:01:28 p. m.
    Author     : hardc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    session.invalidate();

    response.sendRedirect("login.jsp");

%>