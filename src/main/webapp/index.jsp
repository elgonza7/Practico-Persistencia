<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Menú Principal - AppAlumnos</title>
    </head>
    <body>
        <h1>Bienvenido al Sistema Académico</h1>
        <hr>
        
        <ul>
            <li>
                <a href="#"><p class="opcion">Facultades</p></a>
                <ul>
                    <c:forEach var="facu" items="${facultades}">
                        <li><a href="Facultad?codigoFacu=${facu.getIdfacultad()}">${facu.getNombre()}</a></li>
                    </c:forEach>
                </ul>
            </li>
            <li>
                <a href="Listar">Ver Consultas Ejercicio 6</a>
            </li>
        </ul>
    </body>
</html>