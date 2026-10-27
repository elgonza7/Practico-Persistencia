package sesion;

import entidad.Examen;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

/**
 * @author zeus
 */
@Stateless
public class ExamenFacade extends AbstractFacade<Examen> {

    @PersistenceContext(unitName = "AppAlumnosPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ExamenFacade() {
        super(Examen.class);
    }

    /** Mesas de examen del turno de julio (JPQL). */
    public List<Examen> findTurnoJulio() {
        return em.createQuery(
                "SELECT e FROM Examen e WHERE EXTRACT(MONTH FROM e.examenPK.fecha) = 7"
                + " ORDER BY e.examenPK.fecha, e.alumno.nombre", Examen.class)
                .getResultList();
    }
}
