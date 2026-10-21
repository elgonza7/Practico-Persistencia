package entidad;

import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.Collection;

@Entity
@Table(name = "docente")
public class Docente implements Serializable {

    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "iddocente")
    private Integer iddocente;

    @Basic(optional = false)
    @Column(name = "nombre")
    private String nombre;

    @Basic(optional = false)
    @Column(name = "cargo")
    private String cargo;

    @JoinTable(name = "docente_materia", joinColumns = {
        @JoinColumn(name = "docente_iddocente", referencedColumnName = "iddocente")}, inverseJoinColumns = {
        @JoinColumn(name = "materia_idmateria", referencedColumnName = "idmateria")})
    @ManyToMany
    private Collection<Materia> materiaCollection;

    public Docente() {
    }

    public Docente(Integer iddocente, String nombre, String cargo) {
        this.iddocente = iddocente;
        this.nombre = nombre;
        this.cargo = cargo;
    }

    public Integer getIddocente() { return iddocente; }
    public void setIddocente(Integer iddocente) { this.iddocente = iddocente; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getCargo() { return cargo; }
    public void setCargo(String cargo) { this.cargo = cargo; }

    public Collection<Materia> getMateriaCollection() { return materiaCollection; }
    public void setMateriaCollection(Collection<Materia> materiaCollection) { this.materiaCollection = materiaCollection; }
}