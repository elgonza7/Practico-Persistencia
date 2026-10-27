<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="titulo" value="${facultad.nombre}"/>
<c:set var="seccion" value="inicio"/>
<%@include file="/WEB-INF/jspf/encabezado.jspf"%>

<div class="encabezado-pagina">
    <div>
        <div class="migas"><a href="Inicio">Inicio</a><span class="sep">/</span>Facultades<span class="sep">/</span><c:out value="${facultad.nombre}"/></div>
        <h1><c:out value="${facultad.nombre}"/></h1>
        <p>Carreras que se dictan en esta facultad.</p>
    </div>
    <a class="btn btn-secundario" href="Inicio"><svg class="ico"><use href="#i-volver"/></svg>Volver al inicio</a>
</div>

<div class="card">
    <div class="card-header">
        <div class="card-titulo tono-2">
            <span class="stat-ico"><svg class="ico"><use href="#i-gorro"/></svg></span>
            <div>
                <h2>Carreras</h2>
                <p>${carreras.size()} carrera(s)</p>
            </div>
        </div>
    </div>
    <c:choose>
        <c:when test="${empty carreras}">
            <div class="vacio">
                <span class="icono-vacio"><svg class="ico"><use href="#i-vacio"/></svg></span>
                <strong>Sin carreras</strong>
                Esta facultad no tiene carreras cargadas.
            </div>
        </c:when>
        <c:otherwise>
            <ul class="lista">
                <c:forEach var="car" items="${carreras}" varStatus="st">
                    <li>
                        <div class="persona tono-${(st.index % 4) + 1}">
                            <span class="avatar"><svg class="ico"><use href="#i-gorro"/></svg></span>
                            <div>
                                <c:out value="${car.nombre}"/>
                                <small>Código ${car.idcarrera} · ${car.alumnoCollection.size()} alumno(s)</small>
                            </div>
                        </div>
                        <a class="btn btn-secundario btn-chico" href="Agregar?idCarrera=${car.idcarrera}">
                            <svg class="ico"><use href="#i-alta"/></svg>Inscribir alumno
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </c:otherwise>
    </c:choose>
</div>

<%@include file="/WEB-INF/jspf/pie.jspf"%>
