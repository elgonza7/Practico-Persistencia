<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Carreras de ${facultad.nombre}</title>
    </head>
    <body>
        <h2>Carreras de la Facultad: ${facultad.nombre}</h2>
        <hr>
        <ul>
            <c:forEach var="car" items="${facultad.carreraCollection}">
                <li>
                    ${car.nombre} - <a href="Agregar?idCarrera=${car.idcarrera}">Agregar Alumno</a>
                </li>
            </c:forEach>
        </ul>
        <br>
        <a href="index.jsp">Volver al inicio</a>
    </body>
</html>