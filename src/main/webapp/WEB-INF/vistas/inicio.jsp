<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="titulo" value="Inicio"/>
<c:set var="seccion" value="inicio"/>
<%@include file="/WEB-INF/jspf/encabezado.jspf"%>

<section class="hero">
    <div>
        <span class="eyebrow">Gestión académica</span>
        <h1>Bienvenido al Sistema Académico</h1>
        <p>Explorá las facultades y sus carreras, inscribí alumnos, administrá las materias y revisá los reportes de exámenes.</p>
        <div class="hero-acciones">
            <a class="btn btn-blanco" href="Agregar"><svg class="ico"><use href="#i-alta"/></svg>Inscribir alumno</a>
            <a class="btn btn-vidrio" href="Listar"><svg class="ico"><use href="#i-grafico"/></svg>Ver consultas</a>
        </div>
    </div>
    <div class="hero-arte" aria-hidden="true"><svg class="ico"><use href="#i-gorro"/></svg></div>
</section>

<div class="stats">
    <a class="stat tono-1" href="Alumnos">
        <span class="stat-ico"><svg class="ico"><use href="#i-alumnos"/></svg></span>
        <div><span class="valor">${totalAlumnos}</span><span class="etiqueta">Alumnos</span></div>
    </a>
    <div class="stat tono-2">
        <span class="stat-ico"><svg class="ico"><use href="#i-gorro"/></svg></span>
        <div><span class="valor">${totalCarreras}</span><span class="etiqueta">Carreras</span></div>
    </div>
    <a class="stat tono-3" href="MateriaManejador">
        <span class="stat-ico"><svg class="ico"><use href="#i-libro"/></svg></span>
        <div><span class="valor">${totalMaterias}</span><span class="etiqueta">Materias</span></div>
    </a>
    <a class="stat tono-4" href="Docentes">
        <span class="stat-ico"><svg class="ico"><use href="#i-docente"/></svg></span>
        <div><span class="valor">${totalDocentes}</span><span class="etiqueta">Docentes</span></div>
    </a>
</div>

<h2 class="seccion"><svg class="ico"><use href="#i-edificio"/></svg>Facultades <span class="badge gris contador">${facultades.size()}</span></h2>
<c:choose>
    <c:when test="${empty facultades}">
        <div class="card vacio">
            <span class="icono-vacio"><svg class="ico"><use href="#i-vacio"/></svg></span>
            <strong>No hay facultades cargadas</strong>
            Cargalas en la base de datos para verlas acá.
        </div>
    </c:when>
    <c:otherwise>
        <div class="grilla" style="margin-bottom: 40px;">
            <c:forEach var="facu" items="${facultades}" varStatus="st">
                <a class="tile tono-${(st.index % 4) + 1}" href="Facultad?codigoFacu=${facu.idfacultad}">
                    <span class="icono"><svg class="ico"><use href="#i-edificio"/></svg></span>
                    <strong><c:out value="${facu.nombre}"/></strong>
                    <span>Facultad N° ${facu.idfacultad}</span>
                    <span class="flecha">Ver carreras <svg class="ico"><use href="#i-flecha"/></svg></span>
                </a>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

<h2 class="seccion"><svg class="ico"><use href="#i-flecha"/></svg>Accesos rápidos</h2>
<div class="grilla">
    <a class="tile tono-1" href="Alumnos">
        <span class="icono"><svg class="ico"><use href="#i-alumnos"/></svg></span>
        <strong>Alumnos</strong>
        <span>Listado completo con carrera y facultad.</span>
        <span class="flecha">Ir <svg class="ico"><use href="#i-flecha"/></svg></span>
    </a>
    <a class="tile tono-2" href="Agregar">
        <span class="icono"><svg class="ico"><use href="#i-alta"/></svg></span>
        <strong>Inscribir alumno</strong>
        <span>Dar de alta un alumno en una carrera.</span>
        <span class="flecha">Ir <svg class="ico"><use href="#i-flecha"/></svg></span>
    </a>
    <a class="tile tono-3" href="MateriaManejador">
        <span class="icono"><svg class="ico"><use href="#i-libro"/></svg></span>
        <strong>Materias</strong>
        <span>Alta, edición y baja de materias.</span>
        <span class="flecha">Ir <svg class="ico"><use href="#i-flecha"/></svg></span>
    </a>
    <a class="tile tono-4" href="Listar">
        <span class="icono"><svg class="ico"><use href="#i-grafico"/></svg></span>
        <strong>Consultas</strong>
        <span>Turno de julio, alumnos sin exámenes y docentes.</span>
        <span class="flecha">Ir <svg class="ico"><use href="#i-flecha"/></svg></span>
    </a>
</div>

<%@include file="/WEB-INF/jspf/pie.jspf"%>
