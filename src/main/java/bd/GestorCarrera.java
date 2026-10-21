package bd;

import entidad.Carrera;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class GestorCarrera {
    private Connection con = new Conexion().getConnection();

    public List<Carrera> listarCarreras() {
        List<Carrera> lista = new ArrayList<>();
        try {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM carrera");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Carrera c = new Carrera();
                c.setIdcarrera(rs.getInt("idcarrera"));
                c.setNombre(rs.getString("nombre"));
                lista.add(c);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return lista;
    }
}