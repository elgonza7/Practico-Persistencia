<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@taglib prefix="fn" uri="jakarta.tags.functions"%>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<c:set var="titulo" value="Consultas"/>
<c:set var="seccion" value="consultas"/>
<%@include file="/WEB-INF/jspf/encabezado.jspf"%>

<div class="encabezado-pagina">
    <div>
        <div class="migas"><a href="Inicio">Inicio</a><span class="sep">/</span>Consultas</div>
        <h1>Consultas académicas</h1>
        <p>Resultados de las consultas JPQL del ejercicio 6.</p>
    </div>
</div>

<div class="stats">
    <div class="stat tono-1">
        <span class="stat-ico"><svg class="ico"><use href="#i-calendario"/></svg></span>
        <div><span class="valor">${examenesJulio.size()}</span><span class="etiqueta">Exámenes en julio</span></div>
    </div>
    <div class="stat tono-3">
        <span class="stat-ico"><svg class="ico"><use href="#i-alumnos"/></svg></span>
        <div><span class="valor">${alumnosSinExamen.size()}</span><span class="etiqueta">Sin exámenes este año</span></div>
    </div>
    <div class="stat tono-4">
        <span class="stat-ico"><svg class="ico"><use href="#i-docente"/></svg></span>
        <div><span class="valor">${docentesMasDeDos.size()}</span><span class="etiqueta">Docentes con +2 materias</span></div>
    </div>
    <c:set var="aprobados" value="0"/>
    <c:forEach var="ex" items="${examenesJulio}">
        <c:if test="${not empty ex.nota && ex.nota >= 4}"><c:set var="aprobados" value="${aprobados + 1}"/></c:if>
    </c:forEach>
    <div class="stat tono-2">
        <span class="stat-ico"><svg class="ico"><use href="#i-ok"/></svg></span>
        <div><span class="valor">${aprobados}</span><span class="etiqueta">Aprobados en julio</span></div>
    </div>
</div>

<!-- 1. Turno de julio -->
<div class="card">
    <div class="card-header">
        <div class="card-titulo tono-1">
            <span class="stat-ico"><svg class="ico"><use href="#i-calendario"/></svg></span>
            <div>
                <h2>Mesas de examen del turno de julio</h2>
                <p>Alumno, materia y nota obtenida.</p>
            </div>
        </div>
        <span class="badge gris">${examenesJulio.size()} resultado(s)</span>
    </div>
    <c:choose>
        <c:when test="${empty examenesJulio}">
            <div class="vacio">
                <span class="icono-vacio"><svg class="ico"><use href="#i-vacio"/></svg></span>
                No hay exámenes registrados en julio.
            </div>
        </c:when>
        <c:otherwise>
            <div class="tabla-wrap">
                <table>
                    <thead>
                        <tr>
                            <th>Alumno</th>
                            <th>Materia</th>
                            <th>Fecha</th>
                            <th class="der">Nota</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="ex" items="${examenesJulio}">
                            <tr>
                                <td>
                                    <div class="celda-persona">
                                        <span class="avatar">${fn:toUpperCase(fn:substring(ex.alumno.nombre, 0, 1))}</span>
                                        <c:out value="${ex.alumno.nombre}"/>
                                    </div>
                                </td>
                                <td><span class="chip"><svg class="ico"><use href="#i-libro"/></svg><c:out value="${ex.materia.nombre}"/></span></td>
                                <td class="num"><fmt:formatDate value="${ex.examenPK.fecha}" pattern="dd/MM/yyyy"/></td>
                                <td class="acciones">
                                    <c:choose>
                                        <c:when test="${empty ex.nota}"><span class="badge gris">Sin nota</span></c:when>
                                        <c:when test="${ex.nota >= 4}"><span class="nota ok" title="Aprobado">${ex.nota}</span></c:when>
                                        <c:otherwise><span class="nota mal" title="Desaprobado">${ex.nota}</span></c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- 2. Alumnos sin exámenes -->
<div class="card">
    <div class="card-header">
        <div class="card-titulo tono-3">
            <span class="stat-ico"><svg class="ico"><use href="#i-alumnos"/></svg></span>
            <div>
                <h2>Alumnos sin exámenes en el año en curso</h2>
                <p>No rindieron ninguna materia este año.</p>
            </div>
        </div>
        <span class="badge gris">${alumnosSinExamen.size()} alumno(s)</span>
    </div>
    <c:choose>
        <c:when test="${empty alumnosSinExamen}">
            <div class="vacio">
                <span class="icono-vacio"><svg class="ico"><use href="#i-ok"/></svg></span>
                Todos los alumnos rindieron al menos una materia este año.
            </div>
        </c:when>
        <c:otherwise>
            <ul class="lista">
                <c:forEach var="alu" items="${alumnosSinExamen}">
                    <li>
                        <div class="persona tono-3">
                            <span class="avatar">${fn:toUpperCase(fn:substring(alu.nombre, 0, 1))}</span>
                            <div>
                                <c:out value="${alu.nombre}"/>
                                <small><c:out value="${alu.carreraIdcarrera.nombre}"/> · <c:out value="${alu.carreraIdcarrera.facultadIdfacultad.nombre}"/></small>
                            </div>
                        </div>
                        <span class="badge gris">Registro <c:out value="${alu.registro}"/></span>
                    </li>
                </c:forEach>
            </ul>
        </c:otherwise>
    </c:choose>
</div>

<!-- 3. Docentes con más de dos materias -->
<div class="card">
    <div class="card-header">
        <div class="card-titulo tono-4">
            <span class="stat-ico"><svg class="ico"><use href="#i-docente"/></svg></span>
            <div>
                <h2>Docentes que dictan más de dos materias</h2>
                <p>Con las materias que tienen a cargo.</p>
            </div>
        </div>
        <span class="badge gris">${docentesMasDeDos.size()} docente(s)</span>
    </div>
    <c:choose>
        <c:when test="${empty docentesMasDeDos}">
            <div class="vacio">
                <span class="icono-vacio"><svg class="ico"><use href="#i-vacio"/></svg></span>
                Ningún docente dicta más de dos materias.
            </div>
        </c:when>
        <c:otherwise>
            <ul class="lista">
                <c:forEach var="doc" items="${docentesMasDeDos}">
                    <li>
                        <div class="persona tono-4">
                            <span class="avatar">${fn:toUpperCase(fn:substring(doc.nombre, 0, 1))}</span>
                            <div>
                                <c:out value="${doc.nombre}"/>
                                <small>${empty doc.cargo ? 'Sin cargo' : doc.cargo} · ${doc.materiaCollection.size()} materias</small>
                            </div>
                        </div>
                        <div class="chips">
                            <c:forEach var="mat" items="${doc.materiaCollection}">
                                <span class="chip"><svg class="ico"><use href="#i-libro"/></svg><c:out value="${mat.nombre}"/></span>
                            </c:forEach>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </c:otherwise>
    </c:choose>
</div>

<%@include file="/WEB-INF/jspf/pie.jspf"%>
