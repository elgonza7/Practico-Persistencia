<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@taglib prefix="fn" uri="jakarta.tags.functions"%>
<c:set var="titulo" value="Docentes"/>
<c:set var="seccion" value="docentes"/>
<%@include file="/WEB-INF/jspf/encabezado.jspf"%>

<div class="encabezado-pagina">
    <div>
        <div class="migas"><a href="Inicio">Inicio</a><span class="sep">/</span>Docentes</div>
        <h1>Docentes</h1>
        <p>Alta de docentes y las materias que dictan.</p>
    </div>
</div>

<c:if test="${param.ok == 'docente'}">
    <div class="alerta ok">
        <svg class="ico"><use href="#i-ok"/></svg><span class="texto">Docente agregado correctamente.</span>
        <button class="alerta-cerrar" type="button" aria-label="Cerrar"><svg class="ico"><use href="#i-cerrar"/></svg></button>
    </div>
</c:if>
<c:if test="${not empty error}">
    <div class="alerta error">
        <svg class="ico"><use href="#i-alerta"/></svg><span class="texto"><c:out value="${error}"/></span>
        <button class="alerta-cerrar" type="button" aria-label="Cerrar"><svg class="ico"><use href="#i-cerrar"/></svg></button>
    </div>
</c:if>

<div class="card">
    <div class="card-header">
        <div class="card-titulo tono-4">
            <span class="stat-ico"><svg class="ico"><use href="#i-mas"/></svg></span>
            <div>
                <h2>Nuevo docente</h2>
                <p>El ID se genera automáticamente.</p>
            </div>
        </div>
    </div>
    <form action="Docentes" method="POST">
        <div class="form-grid">
            <div class="campo">
                <label for="nombre">Nombre completo</label>
                <input type="text" id="nombre" name="nombre" maxlength="100" placeholder="Ej: María López"
                       value="${fn:escapeXml(param.nombre)}" required>
            </div>
            <div class="campo">
                <label for="cargo">Cargo</label>
                <select id="cargo" name="cargo">
                    <option value="">Sin cargo</option>
                    <c:forEach var="cg" items="${['TITULAR', 'ADJUNTO', 'JTP']}">
                        <option value="${cg}" ${param.cargo == cg ? 'selected' : ''}>${cg}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="campo ancho">
                <label>Materias que dicta</label>
                <c:choose>
                    <c:when test="${empty listaMaterias}">
                        <small>No hay materias cargadas. <a href="MateriaManejador">Agregá una</a>.</small>
                    </c:when>
                    <c:otherwise>
                        <div class="chips">
                            <c:forEach var="mat" items="${listaMaterias}">
                                <c:set var="marcada" value="false"/>
                                <c:forEach var="sel" items="${paramValues.materias}">
                                    <c:if test="${sel == mat.idmateria}"><c:set var="marcada" value="true"/></c:if>
                                </c:forEach>
                                <label class="chip chip-check">
                                    <input type="checkbox" name="materias" value="${mat.idmateria}" ${marcada ? 'checked' : ''}>
                                    <svg class="ico"><use href="#i-libro"/></svg><c:out value="${mat.nombre}"/>
                                </label>
                            </c:forEach>
                        </div>
                        <small>Opcional. Podés elegir varias.</small>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <div class="form-acciones">
            <button type="submit" class="btn btn-primario"><svg class="ico"><use href="#i-ok"/></svg>Guardar docente</button>
        </div>
    </form>
</div>

<div class="card">
    <div class="card-header">
        <div class="card-titulo tono-1">
            <span class="stat-ico"><svg class="ico"><use href="#i-docente"/></svg></span>
            <div>
                <h2>Listado de docentes</h2>
                <p>${docentes.size()} docente(s) registrados</p>
            </div>
        </div>
        <c:if test="${not empty docentes}">
            <label class="buscador">
                <svg class="ico"><use href="#i-buscar"/></svg>
                <input type="search" placeholder="Buscar por nombre, cargo o materia…" data-filtro="#tablaDocentes" aria-label="Buscar docentes">
            </label>
        </c:if>
    </div>
    <c:choose>
        <c:when test="${empty docentes}">
            <div class="vacio">
                <span class="icono-vacio"><svg class="ico"><use href="#i-vacio"/></svg></span>
                <strong>Todavía no hay docentes</strong>
                Agregá el primero con el formulario de arriba.
            </div>
        </c:when>
        <c:otherwise>
            <div class="tabla-wrap">
                <table>
                    <thead>
                        <tr>
                            <th>Docente</th>
                            <th>Cargo</th>
                            <th>Materias</th>
                        </tr>
                    </thead>
                    <tbody id="tablaDocentes">
                        <c:forEach var="doc" items="${docentes}">
                            <c:set var="textoMaterias" value=""/>
                            <c:forEach var="mat" items="${doc.materiaCollection}">
                                <c:set var="textoMaterias" value="${textoMaterias} ${mat.nombre}"/>
                            </c:forEach>
                            <tr data-buscar="${fn:escapeXml(doc.nombre)} ${doc.cargo} ${fn:escapeXml(textoMaterias)}">
                                <td>
                                    <div class="celda-persona tono-4">
                                        <span class="avatar">${fn:toUpperCase(fn:substring(doc.nombre, 0, 1))}</span>
                                        <div><c:out value="${doc.nombre}"/><div class="num" style="font-size:.8rem;">ID ${doc.iddocente}</div></div>
                                    </div>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${empty doc.cargo}"><span class="badge gris">Sin cargo</span></c:when>
                                        <c:otherwise><span class="badge">${doc.cargo}</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${empty doc.materiaCollection}"><span class="num">—</span></c:when>
                                        <c:otherwise>
                                            <div class="chips">
                                                <c:forEach var="mat" items="${doc.materiaCollection}">
                                                    <span class="chip"><svg class="ico"><use href="#i-libro"/></svg><c:out value="${mat.nombre}"/></span>
                                                </c:forEach>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="vacio sin-resultados" hidden>Ningún docente coincide con la búsqueda.</div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@include file="/WEB-INF/jspf/pie.jspf"%>
