package manejador;

import entidad.Materia;
import jakarta.ejb.EJB;
import jakarta.ejb.EJBException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import sesion.MateriaFacade;

/**
 * Controlador del ABM de materias. GET muestra la vista; POST agrega, edita o elimina
 * y redirige (patrón Post/Redirect/Get) con un mensaje en ?ok=...
 */
@WebServlet(name = "MateriaManejador", urlPatterns = {"/MateriaManejador"})
public class MateriaManejador extends HttpServlet {

    private static final String VISTA = "/WEB-INF/vistas/materias.jsp";

    @EJB
    private MateriaFacade materiaFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if ("editar".equals(request.getParameter("action"))) {
            // Precarga el formulario con la materia a editar
            request.setAttribute("materiaEditar", materiaFacade.find(parsearId(request.getParameter("id"))));
        }
        mostrar(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        int id = parsearId(request.getParameter("idmateria"));
        String nombre = request.getParameter("nombre") == null ? "" : request.getParameter("nombre").trim();

        try {
            switch (action == null ? "" : action) {
                case "agregar":
                    if (materiaFacade.find(id) != null) {
                        error(request, response, "Ya existe una materia con el ID " + id + ".");
                        return;
                    }
                    materiaFacade.create(new Materia(id, nombre));
                    response.sendRedirect("MateriaManejador?ok=creada");
                    return;

                case "editar":
                    Materia m = materiaFacade.find(id);
                    if (m != null) {
                        m.setNombre(nombre);
                        materiaFacade.edit(m);
                    }
                    response.sendRedirect("MateriaManejador?ok=editada");
                    return;

                case "eliminar":
                    Materia aBorrar = materiaFacade.find(id);
                    if (aBorrar != null) {
                        if (materiaFacade.contarUsos(id) > 0) {
                            error(request, response, "No se puede eliminar \"" + aBorrar.getNombre()
                                    + "\": tiene exámenes o docentes asociados.");
                            return;
                        }
                        materiaFacade.remove(aBorrar);
                    }
                    response.sendRedirect("MateriaManejador?ok=eliminada");
                    return;

                default:
                    response.sendRedirect("MateriaManejador");
            }
        } catch (EJBException e) {
            error(request, response, "No se pudo guardar la materia. Verificá los datos (el nombre admite hasta 100 caracteres).");
        }
    }

    private void error(HttpServletRequest request, HttpServletResponse response, String mensaje)
            throws ServletException, IOException {
        request.setAttribute("error", mensaje);
        mostrar(request, response);
    }

    private void mostrar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Operación LEER obligatoria antes de ir a la vista
        request.setAttribute("listaMaterias", materiaFacade.findAllOrdenado());
        request.getRequestDispatcher(VISTA).forward(request, response);
    }

    private int parsearId(String valor) {
        try {
            return Integer.parseInt(valor);
        } catch (NumberFormatException e) {
            return -1;
        }
    }
}
