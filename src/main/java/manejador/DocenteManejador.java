package manejador;

import entidad.Docente;
import entidad.Materia;
import jakarta.ejb.EJB;
import jakarta.ejb.EJBException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import sesion.DocenteFacade;
import sesion.MateriaFacade;

/**
 * Controlador de docentes: GET muestra el listado y el formulario; POST da de alta
 * un docente con las materias que dicta y redirige (Post/Redirect/Get).
 */
@WebServlet(name = "DocenteManejador", urlPatterns = {"/Docentes"})
public class DocenteManejador extends HttpServlet {

    private static final String VISTA = "/WEB-INF/vistas/docentes.jsp";
    // Valores permitidos por el CHECK de la tabla docente
    private static final Set<String> CARGOS = Set.of("TITULAR", "ADJUNTO", "JTP");

    @EJB
    private DocenteFacade docenteFacade;
    @EJB
    private MateriaFacade materiaFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        mostrar(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String nombre = request.getParameter("nombre") == null ? "" : request.getParameter("nombre").trim();
        String cargo = request.getParameter("cargo");

        if (nombre.isEmpty() || nombre.length() > 100) {
            error(request, response, "El nombre es obligatorio y admite hasta 100 caracteres.");
            return;
        }
        if (cargo != null && !cargo.isEmpty() && !CARGOS.contains(cargo)) {
            error(request, response, "El cargo debe ser TITULAR, ADJUNTO o JTP.");
            return;
        }

        List<Materia> materias = new ArrayList<>();
        String[] ids = request.getParameterValues("materias");
        if (ids != null) {
            for (String id : ids) {
                try {
                    Materia m = materiaFacade.find(Integer.parseInt(id));
                    if (m != null) {
                        materias.add(m);
                    }
                } catch (NumberFormatException e) {
                    // id inválido: se ignora
                }
            }
        }

        try {
            // El id lo genera la secuencia de la BD (IDENTITY)
            Docente docente = new Docente(null, nombre, cargo == null || cargo.isEmpty() ? null : cargo);
            docente.setMateriaCollection(materias);
            docenteFacade.create(docente);
            response.sendRedirect("Docentes?ok=docente");
        } catch (EJBException e) {
            error(request, response, "No se pudo guardar el docente. Verificá los datos.");
        }
    }

    private void error(HttpServletRequest request, HttpServletResponse response, String mensaje)
            throws ServletException, IOException {
        request.setAttribute("error", mensaje);
        mostrar(request, response);
    }

    private void mostrar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("docentes", docenteFacade.findAllOrdenado());
        request.setAttribute("listaMaterias", materiaFacade.findAllOrdenado());
        request.getRequestDispatcher(VISTA).forward(request, response);
    }
}
