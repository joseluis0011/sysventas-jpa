<%-- 
    Document   : main_Vendedor
    Created on : 01/06/2018, 11:00:56 PM
    Author     : JOSE LUIS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sistema de Ventas</title>
        <link rel="shortcut icon" type="image/x-icon" href="img/logo.ico">
        <%@include file="WEB-INF/template/headerMain.jspf" %>
    </head>
    <body onload="deshabilitaRetroceso()">
        <%@include file="WEB-INF/template/headerVendedor.jspf" %>    
        <div class="container" id="contenido">
            <h1>Bienvenido al Sistema de Ventas...!</h1>
        </div>
        <%@include file="WEB-INF/template/footerMain.jspf" %>
    </body>
</html>
