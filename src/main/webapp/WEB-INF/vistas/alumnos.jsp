<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@taglib prefix="fn" uri="jakarta.tags.functions"%>
<c:set var="titulo" value="Alumnos"/>
<c:set var="seccion" value="alumnos"/>
<%@include file="/WEB-INF/jspf/encabezado.jspf"%>

<div class="encabezado-pagina">
    <div>
        <div class="migas"><a href="Inicio">Inicio</a><span class="sep">/</span>Alumnos</div>
        <h1>Alumnos</h1>
        <p>Listado ordenado por nombre, con su carrera y facultad.</p>
    </div>
    <a class="btn btn-primario" href="Agregar"><svg class="ico"><use href="#i-mas"/></svg>Inscribir alumno</a>
</div>

<c:if test="${param.ok == 'alumno'}">
    <div class="alerta ok">
        <svg class="ico"><use href="#i-ok"/></svg><span class="texto">Alumno inscripto correctamente.</span>
        <button class="alerta-cerrar" type="button" aria-label="Cerrar"><svg class="ico"><use href="#i-cerrar"/></svg></button>
    </div>
</c:if>

<div class="card">
    <div class="card-header">
        <div class="card-titulo tono-1">
            <span class="stat-ico"><svg class="ico"><use href="#i-alumnos"/></svg></span>
            <div>
                <h2>Listado de alumnos</h2>
                <p>${alumnos.size()} alumno(s) registrados</p>
            </div>
        </div>
        <c:if test="${not empty alumnos}">
            <label class="buscador">
                <svg class="ico"><use href="#i-buscar"/></svg>
                <input type="search" placeholder="Buscar por nombre, registro o carrera…" data-filtro="#tablaAlumnos" aria-label="Buscar alumnos">
            </label>
        </c:if>
    </div>
    <c:choose>
        <c:when test="${empty alumnos}">
            <div class="vacio">
                <span class="icono-vacio"><svg class="ico"><use href="#i-vacio"/></svg></span>
                <strong>Todavía no hay alumnos</strong>
                <a href="Agregar">Inscribí el primero</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="tabla-wrap">
                <table>
                    <thead>
                        <tr>
                            <th>Alumno</th>
                            <th>Registro</th>
                            <th>Carrera</th>
                            <th>Facultad</th>
                        </tr>
                    </thead>
                    <tbody id="tablaAlumnos">
                        <c:forEach var="alu" items="${alumnos}">
                            <tr data-buscar="${fn:escapeXml(alu.nombre)} ${fn:escapeXml(alu.registro)} ${fn:escapeXml(alu.carreraIdcarrera.nombre)} ${fn:escapeXml(alu.carreraIdcarrera.facultadIdfacultad.nombre)}"
                                class="${param.ok == 'alumno' && alu.idalumno == param.id ? 'resaltada' : ''}">
                                <td>
                                    <div class="celda-persona">
                                        <span class="avatar">${fn:toUpperCase(fn:substring(alu.nombre, 0, 1))}</span>
                                        <div><c:out value="${alu.nombre}"/><div class="num" style="font-size:.8rem;">ID ${alu.idalumno}</div></div>
                                    </div>
                                </td>
                                <td><span class="badge gris"><c:out value="${empty alu.registro ? '—' : alu.registro}"/></span></td>
                                <td><c:out value="${alu.carreraIdcarrera.nombre}"/></td>
                                <td>
                                    <a class="chip" href="Facultad?codigoFacu=${alu.carreraIdcarrera.facultadIdfacultad.idfacultad}">
                                        <svg class="ico"><use href="#i-edificio"/></svg><c:out value="${alu.carreraIdcarrera.facultadIdfacultad.nombre}"/>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="vacio sin-resultados" hidden>Ningún alumno coincide con la búsqueda.</div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@include file="/WEB-INF/jspf/pie.jspf"%>
