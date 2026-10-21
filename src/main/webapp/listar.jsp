<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Consultas Académicas - Ejercicio 6</title>
    </head>
    <body>
        <h1>Resultados de las Consultas (Ejercicio 6)</h1>
        <hr>

        <h3>1. Mesas de examen del turno de Julio (Alumno y Nota)</h3>
        <table border="1" cellpadding="5">
            <thead>
                <tr>
                    <th>Nombre del Alumno</th>
                    <th>Nota Obtenida</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="ex" items="${examenesJulio}">
                    <tr>
                        <td>${ex[0]}</td>
                        <td>${ex[1]}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <h3>2. Alumnos que no rindieron ninguna materia en el año en curso</h3>
        <ul>
            <c:forEach var="alu" items="${alumnosSinExamen}">
                <li>${alu.nombre} (Registro: ${alu.registro})</li>
            </c:forEach>
        </ul>

        <h3>3. Docentes que dictan más de dos materias</h3>
        <ul>
            <c:forEach var="docNombre" items="${docentesMasDeDos}">
                <li>${docNombre}</li>
            </c:forEach>
        </ul>

        <br>
        <a href="index.jsp">Volver al Menú Principal</a>
    </body>
</html>