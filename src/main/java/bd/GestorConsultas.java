package bd;

import entidad.Alumno;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class GestorConsultas {
    private Connection con = new Conexion().getConnection();
    public List<String[]> listarExamenesJulio() {
        List<String[]> lista = new ArrayList<>();
        String sql = "SELECT a.nombre, e.nota FROM examen e " +
                     "JOIN alumno a ON e.alumno_idalumno = a.idalumno " +
                     "WHERE EXTRACT(MONTH FROM e.fecha) = 7";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                lista.add(new String[]{rs.getString("nombre"), String.valueOf(rs.getInt("nota"))});
            }
        } catch (Exception e) { e.printStackTrace(); }
        return lista;
    }
    public List<Alumno> alumnosSinExamenesAnioActual() {
        List<Alumno> lista = new ArrayList<>();
        String sql = "SELECT * FROM alumno a WHERE a.idalumno NOT IN (" +
                     "SELECT e.alumno_idalumno FROM examen e " +
                     "WHERE EXTRACT(YEAR FROM e.fecha) = EXTRACT(YEAR FROM CURRENT_DATE))";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Alumno a = new Alumno();
                a.setIdalumno(rs.getInt("idalumno"));
                a.setNombre(rs.getString("nombre"));
                a.setRegistro(rs.getString("registro"));
                lista.add(a);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return lista;
    }
    public List<String> docentesConMasDeDosMaterias() {
        List<String> lista = new ArrayList<>();
        String sql = "SELECT d.nombre FROM docente d " +
                     "JOIN docente_materia dm ON d.iddocente = dm.docente_id " +
                     "GROUP BY d.iddocente, d.nombre HAVING COUNT(dm.materia_id) > 2";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                lista.add(rs.getString("nombre"));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return lista;
    }
}