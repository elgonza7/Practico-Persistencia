package manejador;

import bd.GestorCarrera;
import bd.GestorFacultad;
import bd.GestorConsultas;
import entidad.Facultad;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "Manejador", loadOnStartup = 1, urlPatterns = {"/Agregar", "/Listar", "/Facultad"})
public class Manejador extends HttpServlet {

    private GestorFacultad gestorFacu = new GestorFacultad();
    private GestorCarrera gestorCarrera = new GestorCarrera();
    private GestorConsultas gestorConsultas = new GestorConsultas();
    @Override
    public void init() throws ServletException {
        getServletContext().setAttribute("facultades", gestorFacu.listarFacultades());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String url = "";
        String action = request.getServletPath();

        switch (action) {
            case "/Facultad":
                Integer nroFacultad = Integer.parseInt(request.getParameter("codigoFacu"));
                Facultad miFacu = gestorFacu.buscarFacultad(nroFacultad);
                
                getServletContext().setAttribute("facultad", miFacu);
                url = "carrearas.jsp";
                break;
                
            case "/Agregar":
                request.setAttribute("listaCarreras", gestorCarrera.listarCarreras());
                url = "agregar.jsp"; 
                break;
            case "/Listar":
             request.setAttribute("examenesJulio", gestorConsultas.listarExamenesJulio());
             request.setAttribute("alumnosSinExamen", gestorConsultas.alumnosSinExamenesAnioActual());
             request.setAttribute("docentesMasDeDos", gestorConsultas.docentesConMasDeDosMaterias());
             url = "listar.jsp";
             break;
        }

        request.getRequestDispatcher(url).forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("index.jsp");
    }
}