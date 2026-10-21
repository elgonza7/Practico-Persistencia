<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Agregar Alumno</title>
    </head>
    <body>
        <h2>Inscribir Nuevo Alumno</h2>
        <hr>
        
        <form action="Agregar" method="POST">
            <label>ID Alumno:</label><br>
            <input type="number" name="idalumno" required><br><br>

            <label>Nombre:</label><br>
            <input type="text" name="nombre" required><br><br>
            
            <label>Registro:</label><br>
            <input type="text" name="registro" required><br><br>
            
            <label>Carrera:</label><br>
            <select name="idcarrera" required>
                <option value="">-- Seleccione una carrera --</option>
                <c:forEach var="car" items="${listaCarreras}">
                    <option value="${car.idcarrera}" ${param.idCarrera == car.idcarrera ? 'selected' : ''}>
                        ${car.nombre}
                    </option>
                </c:forEach>
            </select><br><br>
            
            <button type="submit">Guardar Alumno</button>
        </form>
        
        <br>
        <a href="index.jsp">Volver al inicio</a>
    </body>
</html>