package sesion;

import entidad.Facultad;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

/**
 * @author zeus
 */
@Stateless
public class FacultadFacade extends AbstractFacade<Facultad> {

    @PersistenceContext(unitName = "AppAlumnosPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public FacultadFacade() {
        super(Facultad.class);
    }
}
