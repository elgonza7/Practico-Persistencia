package sesion;

import entidad.Alumno;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Root;
import java.time.LocalDate;
import java.util.List;

/**
 * @author zeus
 */
@Stateless
public class AlumnoFacade extends AbstractFacade<Alumno> {

    @PersistenceContext(unitName = "AppAlumnosPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public AlumnoFacade() {
        super(Alumno.class);
    }

    /** Listado de alumnos ordenado por nombre (Criteria API, como en el Tema 6). */
    public List<Alumno> findAllOrdenado() {
        CriteriaBuilder cb = em.getCriteriaBuilder();
        CriteriaQuery<Alumno> cq = cb.createQuery(Alumno.class);
        Root<Alumno> a = cq.from(Alumno.class);
        cq.select(a).orderBy(cb.asc(a.get("nombre")));
        return em.createQuery(cq).getResultList();
    }

    /** Alumnos que no rindieron ninguna materia en el año en curso (JPQL). */
    public List<Alumno> findSinExamenesAnioActual() {
        return em.createQuery(
                "SELECT a FROM Alumno a WHERE NOT EXISTS ("
                + " SELECT e FROM Examen e WHERE e.alumno = a"
                + " AND EXTRACT(YEAR FROM e.examenPK.fecha) = :anio)"
                + " ORDER BY a.nombre", Alumno.class)
                .setParameter("anio", LocalDate.now().getYear())
                .getResultList();
    }
}
