package bd;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import modelo.Materia;

public class GestorMateria {
    // Asume que tienes una clase Conexion con un método getConnection()
    private Connection con;

    public GestorMateria() {
        this.con = new Conexion().getConnection(); 
    }

    // LEER (Read)
    public List<Materia> listarMaterias() {
        List<Materia> lista = new ArrayList<>();
        try {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM materia");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                lista.add(new Materia(rs.getInt("idmateria"), rs.getString("nombre")));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return lista;
    }

    // CREAR (Create)
    public boolean agregarMateria(Materia m) {
        try {
            PreparedStatement ps = con.prepareStatement("INSERT INTO materia (idmateria, nombre) VALUES (?, ?)");
            ps.setInt(1, m.getIdMateria());
            ps.setString(2, m.getNombre());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    // ACTUALIZAR (Update)
    public boolean editarMateria(Materia m) {
        try {
            PreparedStatement ps = con.prepareStatement("UPDATE materia SET nombre=? WHERE idmateria=?");
            ps.setString(1, m.getNombre());
            ps.setInt(2, m.getIdMateria());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    // ELIMINAR (Delete)
    public boolean eliminarMateria(int id) {
        try {
            PreparedStatement ps = con.prepareStatement("DELETE FROM materia WHERE idmateria=?");
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }
}