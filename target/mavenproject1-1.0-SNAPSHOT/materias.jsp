<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Gestión de Materias</title>
</head>
<body>
    <h2>Registro de Materia</h2>
    <form action="MateriaManejador" method="POST">
        <!-- Usa action=agregar por defecto. Para editar, se cambiaría por JS o mandando otro parámetro -->
        <input type="hidden" name="action" value="agregar"> 
        
        <label>ID Materia:</label>
        <input type="number" name="idmateria" required>
        
        <label>Nombre:</label>
        <input type="text" name="nombre" required>
        
        <button type="submit">Guardar</button>
    </form>

    <hr>

    <h2>Lista de Materias</h2>
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="mat" items="${listaMaterias}">
                <tr>
                    <td>${mat.idMateria}</td>
                    <td>${mat.nombre}</td>
                    <td>
 
                        <a href="MateriaManejador?action=eliminar&id=${mat.idMateria}">Eliminar</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>