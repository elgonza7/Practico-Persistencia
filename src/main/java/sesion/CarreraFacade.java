package sesion;

import entidad.Carrera;
import entidad.Facultad;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

/**
 * @author zeus
 */
@Stateless
public class CarreraFacade extends AbstractFacade<Carrera> {

    @PersistenceContext(unitName = "AppAlumnosPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CarreraFacade() {
        super(Carrera.class);
    }

    public List<Carrera> findByFacultad(Facultad facultad) {
        return em.createQuery(
                "SELECT c FROM Carrera c WHERE c.facultadIdfacultad = :facultad ORDER BY c.nombre", Carrera.class)
                .setParameter("facultad", facultad)
                .getResultList();
    }
}
