<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@taglib prefix="fn" uri="jakarta.tags.functions"%>
<c:set var="titulo" value="Materias"/>
<c:set var="seccion" value="materias"/>
<c:set var="editando" value="${not empty materiaEditar}"/>
<%@include file="/WEB-INF/jspf/encabezado.jspf"%>

<div class="encabezado-pagina">
    <div>
        <div class="migas"><a href="Inicio">Inicio</a><span class="sep">/</span>Materias</div>
        <h1>Gestión de materias</h1>
        <p>Alta, edición y baja de las materias del sistema.</p>
    </div>
</div>

<c:if test="${not empty param.ok}">
    <div class="alerta ok">
        <svg class="ico"><use href="#i-ok"/></svg>
        <span class="texto">
            <c:choose>
                <c:when test="${param.ok == 'creada'}">Materia agregada correctamente.</c:when>
                <c:when test="${param.ok == 'editada'}">Cambios guardados.</c:when>
                <c:otherwise>Materia eliminada.</c:otherwise>
            </c:choose>
        </span>
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
        <div class="card-titulo tono-3">
            <span class="stat-ico"><svg class="ico"><use href="#i-${editando ? 'editar' : 'mas'}"/></svg></span>
            <div>
                <h2>${editando ? 'Editar materia' : 'Nueva materia'}</h2>
                <p>${editando ? 'Modificá el nombre y guardá los cambios.' : 'Cargá el código y el nombre de la materia.'}</p>
            </div>
        </div>
        <c:if test="${editando}"><span class="badge">Editando #${materiaEditar.idmateria}</span></c:if>
    </div>
    <form action="MateriaManejador" method="POST" class="form-inline">
        <input type="hidden" name="action" value="${editando ? 'editar' : 'agregar'}">
        <div class="campo">
            <label for="idmateria">ID materia</label>
            <input type="number" id="idmateria" name="idmateria" min="1" placeholder="Ej: 4"
                   value="${editando ? materiaEditar.idmateria : fn:escapeXml(param.idmateria)}" ${editando ? 'readonly' : ''} required>
        </div>
        <div class="campo">
            <label for="nombre">Nombre</label>
            <input type="text" id="nombre" name="nombre" maxlength="100" placeholder="Ej: Álgebra"
                   value="${editando ? fn:escapeXml(materiaEditar.nombre) : fn:escapeXml(param.nombre)}" required>
        </div>
        <div class="form-acciones" style="margin-top: 0;">
            <button type="submit" class="btn btn-primario">
                <svg class="ico"><use href="#i-${editando ? 'ok' : 'mas'}"/></svg>${editando ? 'Guardar cambios' : 'Agregar'}
            </button>
            <c:if test="${editando}"><a class="btn btn-secundario" href="MateriaManejador">Cancelar</a></c:if>
        </div>
    </form>
</div>

<div class="card">
    <div class="card-header">
        <div class="card-titulo tono-1">
            <span class="stat-ico"><svg class="ico"><use href="#i-libro"/></svg></span>
            <div>
                <h2>Listado de materias</h2>
                <p>${listaMaterias.size()} materia(s) registradas</p>
            </div>
        </div>
        <c:if test="${not empty listaMaterias}">
            <label class="buscador">
                <svg class="ico"><use href="#i-buscar"/></svg>
                <input type="search" placeholder="Buscar materia…" data-filtro="#tablaMaterias" aria-label="Buscar materias">
            </label>
        </c:if>
    </div>
    <c:choose>
        <c:when test="${empty listaMaterias}">
            <div class="vacio">
                <span class="icono-vacio"><svg class="ico"><use href="#i-libro"/></svg></span>
                <strong>Todavía no hay materias</strong>
                Agregá la primera con el formulario de arriba.
            </div>
        </c:when>
        <c:otherwise>
            <div class="tabla-wrap">
                <table>
                    <thead>
                        <tr>
                            <th style="width: 90px;">ID</th>
                            <th>Nombre</th>
                            <th class="der">Acciones</th>
                        </tr>
                    </thead>
                    <tbody id="tablaMaterias">
                        <c:forEach var="mat" items="${listaMaterias}">
                            <tr data-buscar="${mat.idmateria} ${fn:escapeXml(mat.nombre)}"
                                class="${editando && materiaEditar.idmateria == mat.idmateria ? 'resaltada' : ''}">
                                <td class="num">#${mat.idmateria}</td>
                                <td><strong style="font-weight: 600;"><c:out value="${mat.nombre}"/></strong></td>
                                <td class="acciones">
                                    <a class="btn btn-secundario btn-chico" href="MateriaManejador?action=editar&id=${mat.idmateria}">
                                        <svg class="ico"><use href="#i-editar"/></svg>Editar
                                    </a>
                                    <form action="MateriaManejador" method="POST"
                                          data-confirmar="¿Eliminar la materia &quot;${fn:escapeXml(mat.nombre)}&quot;?">
                                        <input type="hidden" name="action" value="eliminar">
                                        <input type="hidden" name="idmateria" value="${mat.idmateria}">
                                        <button type="submit" class="btn btn-peligro btn-chico">
                                            <svg class="ico"><use href="#i-borrar"/></svg>Eliminar
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="vacio sin-resultados" hidden>Ninguna materia coincide con la búsqueda.</div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@include file="/WEB-INF/jspf/pie.jspf"%>
