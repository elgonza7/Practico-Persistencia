package sesion;

import entidad.Docente;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

/**
 * @author zeus
 */
@Stateless
public class DocenteFacade extends AbstractFacade<Docente> {

    @PersistenceContext(unitName = "AppAlumnosPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public DocenteFacade() {
        super(Docente.class);
    }

    public List<Docente> findAllOrdenado() {
        return em.createQuery("SELECT d FROM Docente d ORDER BY d.nombre", Docente.class)
                .getResultList();
    }

    /** Docentes que dictan más de dos materias (JPQL). */
    public List<Docente> findConMasDeDosMaterias() {
        return em.createQuery(
                "SELECT d FROM Docente d WHERE SIZE(d.materiaCollection) > 2 ORDER BY d.nombre", Docente.class)
                .getResultList();
    }
}
