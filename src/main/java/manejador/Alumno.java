package manejador;



public class Alumno {
    private int idAlumno;
    private String nombre;
    private String registro;
    private int idCarrera; // Llave foránea

    public Alumno() {}

    public Alumno(int idAlumno, String nombre, String registro, int idCarrera) {
        this.idAlumno = idAlumno;
        this.nombre = nombre;
        this.registro = registro;
        this.idCarrera = idCarrera;
    }

    public int getIdAlumno() { return idAlumno; }
    public void setIdAlumno(int idAlumno) { this.idAlumno = idAlumno; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public String getRegistro() { return registro; }
    public void setRegistro(String registro) { this.registro = registro; }
    public int getIdCarrera() { return idCarrera; }
    public void setIdCarrera(int idCarrera) { this.idCarrera = idCarrera; }
}