package manejador;

import bd.GestorMateria;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Materia;

@WebServlet(name = "MateriaManejador", urlPatterns = {"/MateriaManejador"})
public class MateriaManejador extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        GestorMateria gestor = new GestorMateria();
        String action = request.getParameter("action");

        if ("eliminar".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            gestor.eliminarMateria(id);
        }
        
        // Operación LEER obligatoria antes de ir a la vista
        request.setAttribute("listaMaterias", gestor.listarMaterias());
        request.getRequestDispatcher("materias.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        GestorMateria gestor = new GestorMateria();
        String action = request.getParameter("action");
        
        int id = Integer.parseInt(request.getParameter("idmateria"));
        String nombre = request.getParameter("nombre");
        Materia m = new Materia(id, nombre);

        if ("agregar".equals(action)) {
            gestor.agregarMateria(m);
        } else if ("editar".equals(action)) {
            gestor.editarMateria(m);
        }
        
        // Redirigir al GET para refrescar la tabla
        response.sendRedirect("MateriaManejador");
    }
}