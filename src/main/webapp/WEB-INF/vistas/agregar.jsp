<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@taglib prefix="fn" uri="jakarta.tags.functions"%>
<c:set var="titulo" value="Inscribir alumno"/>
<c:set var="seccion" value="alumnos"/>
<%@include file="/WEB-INF/jspf/encabezado.jspf"%>

<div class="encabezado-pagina">
    <div>
        <div class="migas"><a href="Inicio">Inicio</a><span class="sep">/</span><a href="Alumnos">Alumnos</a><span class="sep">/</span>Inscribir</div>
        <h1>Inscribir nuevo alumno</h1>
        <p>Completá los datos y elegí la carrera a la que se inscribe.</p>
    </div>
</div>

<c:if test="${not empty error}">
    <div class="alerta error">
        <svg class="ico"><use href="#i-alerta"/></svg><span class="texto"><c:out value="${error}"/></span>
        <button class="alerta-cerrar" type="button" aria-label="Cerrar"><svg class="ico"><use href="#i-cerrar"/></svg></button>
    </div>
</c:if>

<div class="form-layout">
    <div class="card">
        <div class="card-header">
            <div class="card-titulo tono-2">
                <span class="stat-ico"><svg class="ico"><use href="#i-alta"/></svg></span>
                <div>
                    <h2>Datos del alumno</h2>
                    <p>Todos los campos son obligatorios.</p>
                </div>
            </div>
        </div>
        <form action="Agregar" method="POST">
            <div class="form-grid">
                <div class="campo">
                    <label for="idalumno">ID alumno</label>
                    <input type="number" id="idalumno" name="idalumno" min="1" value="${fn:escapeXml(param.idalumno)}" placeholder="Ej: 15" required>
                </div>
                <div class="campo">
                    <label for="registro">Registro</label>
                    <input type="text" id="registro" name="registro" maxlength="6" value="${fn:escapeXml(param.registro)}" placeholder="Ej: 123456" required>
                    <small>Hasta 6 caracteres.</small>
                </div>
                <div class="campo ancho">
                    <label for="nombre">Nombre completo</label>
                    <input type="text" id="nombre" name="nombre" maxlength="45" value="${fn:escapeXml(param.nombre)}" placeholder="Ej: Juan Pérez" required>
                </div>
                <div class="campo ancho">
                    <label for="idcarrera">Carrera</label>
                    <select id="idcarrera" name="idcarrera" required>
                        <option value="">Seleccioná una carrera</option>
                        <c:forEach var="car" items="${listaCarreras}">
                            <option value="${car.idcarrera}" ${param.idCarrera == car.idcarrera || param.idcarrera == car.idcarrera ? 'selected' : ''}>
                                <c:out value="${car.nombre}"/> — <c:out value="${car.facultadIdfacultad.nombre}"/>
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-acciones">
                <button type="submit" class="btn btn-primario"><svg class="ico"><use href="#i-ok"/></svg>Guardar alumno</button>
                <a class="btn btn-secundario" href="Alumnos">Cancelar</a>
            </div>
        </form>
    </div>

    <aside class="card ayuda">
        <h3><svg class="ico"><use href="#i-alerta"/></svg>Antes de guardar</h3>
        <ul>
            <li>El <b>ID</b> identifica al alumno y no se puede repetir.</li>
            <li>El <b>registro</b> admite hasta 6 caracteres.</li>
            <li>Si venís desde una facultad, la carrera ya queda elegida.</li>
        </ul>
    </aside>
</div>

<%@include file="/WEB-INF/jspf/pie.jspf"%>
