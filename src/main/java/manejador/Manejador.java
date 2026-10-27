package manejador;

import entidad.Alumno;
import entidad.Carrera;
import entidad.Facultad;
import jakarta.ejb.EJB;
import jakarta.ejb.EJBException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import sesion.AlumnoFacade;
import sesion.CarreraFacade;
import sesion.DocenteFacade;
import sesion.ExamenFacade;
import sesion.FacultadFacade;
import sesion.MateriaFacade;

/**
 * Controlador (MVC): recibe la petición, delega en los Session Beans y elige la vista.
 * Las vistas están en WEB-INF/vistas, así que solo se llega a ellas pasando por acá.
 */
@WebServlet(name = "Manejador", urlPatterns = {"/Inicio", "/Facultad", "/Alumnos", "/Agregar", "/Listar"})
public class Manejador extends HttpServlet {

    private static final String VISTAS = "/WEB-INF/vistas/";

    @EJB
    private FacultadFacade facultadFacade;
    @EJB
    private CarreraFacade carreraFacade;
    @EJB
    private AlumnoFacade alumnoFacade;
    @EJB
    private ExamenFacade examenFacade;
    @EJB
    private DocenteFacade docenteFacade;
    @EJB
    private MateriaFacade materiaFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String vista;

        switch (request.getServletPath()) {
            case "/Facultad":
                Facultad miFacu = buscarFacultad(request.getParameter("codigoFacu"));
                if (miFacu == null) {
                    response.sendRedirect("Inicio");
                    return;
                }
                request.setAttribute("facultad", miFacu);
                request.setAttribute("carreras", carreraFacade.findByFacultad(miFacu));
                vista = "carreras.jsp";
                break;

            case "/Alumnos":
                request.setAttribute("alumnos", alumnoFacade.findAllOrdenado());
                vista = "alumnos.jsp";
                break;

            case "/Agregar":
                request.setAttribute("listaCarreras", carreraFacade.findAll());
                vista = "agregar.jsp";
                break;

            case "/Listar":
                request.setAttribute("examenesJulio", examenFacade.findTurnoJulio());
                request.setAttribute("alumnosSinExamen", alumnoFacade.findSinExamenesAnioActual());
                request.setAttribute("docentesMasDeDos", docenteFacade.findConMasDeDosMaterias());
                vista = "consultas.jsp";
                break;

            default: // "/Inicio"
                request.setAttribute("facultades", facultadFacade.findAll());
                request.setAttribute("totalAlumnos", alumnoFacade.count());
                request.setAttribute("totalCarreras", carreraFacade.count());
                request.setAttribute("totalMaterias", materiaFacade.count());
                request.setAttribute("totalDocentes", docenteFacade.count());
                vista = "inicio.jsp";
        }

        request.getRequestDispatcher(VISTAS + vista).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        if ("/Agregar".equals(request.getServletPath())) {
            try {
                Alumno alumno = new Alumno(Integer.parseInt(request.getParameter("idalumno")),
                        request.getParameter("nombre").trim());
                alumno.setRegistro(request.getParameter("registro").trim());
                Carrera carrera = carreraFacade.find(Integer.parseInt(request.getParameter("idcarrera")));
                alumno.setCarreraIdcarrera(carrera);
                alumnoFacade.create(alumno);
                response.sendRedirect("Alumnos?ok=alumno&id=" + alumno.getIdalumno());
            } catch (NumberFormatException | EJBException e) {
                request.setAttribute("error", "No se pudo guardar el alumno. Verificá que el ID no exista y que los datos sean válidos.");
                request.setAttribute("listaCarreras", carreraFacade.findAll());
                request.getRequestDispatcher(VISTAS + "agregar.jsp").forward(request, response);
            }
            return;
        }
        response.sendRedirect("Inicio");
    }

    private Facultad buscarFacultad(String codigo) {
        try {
            return facultadFacade.find(Integer.parseInt(codigo));
        } catch (NumberFormatException e) {
            return null;
        }
    }
}
