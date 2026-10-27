package sesion;

import entidad.Materia;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

/**
 * @author zeus
 */
@Stateless
public class MateriaFacade extends AbstractFacade<Materia> {

    @PersistenceContext(unitName = "AppAlumnosPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public MateriaFacade() {
        super(Materia.class);
    }

    public List<Materia> findAllOrdenado() {
        return em.createQuery("SELECT m FROM Materia m ORDER BY m.idmateria", Materia.class)
                .getResultList();
    }

    /**
     * Cantidad de exámenes y docentes que referencian a la materia (JPQL).
     * Materia tiene cascade ALL sobre sus exámenes, así que hay que chequear esto
     * antes de borrarla para no eliminar exámenes sin querer.
     */
    public long contarUsos(int idmateria) {
        long examenes = em.createQuery(
                "SELECT COUNT(e) FROM Examen e WHERE e.materia.idmateria = :id", Long.class)
                .setParameter("id", idmateria)
                .getSingleResult();
        long docentes = em.createQuery(
                "SELECT COUNT(d) FROM Docente d JOIN d.materiaCollection m WHERE m.idmateria = :id", Long.class)
                .setParameter("id", idmateria)
                .getSingleResult();
        return examenes + docentes;
    }
}
