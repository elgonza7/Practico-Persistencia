package bd;

import entidad.Facultad;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class GestorFacultad {
    private Connection con = new Conexion().getConnection();

    public List<Facultad> listarFacultades() {
        List<Facultad> lista = new ArrayList<>();
        try {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM facultad");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Facultad f = new Facultad();
                f.setIdfacultad(rs.getInt("idfacultad"));
                f.setNombre(rs.getString("nombre"));
                lista.add(f);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return lista;
    }

    public Facultad buscarFacultad(int id) {
        Facultad f = null;
        try {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM facultad WHERE idfacultad = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                f = new Facultad();
                f.setIdfacultad(rs.getInt("idfacultad"));
                f.setNombre(rs.getString("nombre"));
                PreparedStatement psCarreras = con.prepareStatement("SELECT * FROM carrera WHERE facultad_idfacultad = ?");
                psCarreras.setInt(1, id);
                ResultSet rsCarreras = psCarreras.executeQuery();
                
                List<entidad.Carrera> carreras = new ArrayList<>();
                while (rsCarreras.next()) {
                    entidad.Carrera c = new entidad.Carrera();
                    c.setIdcarrera(rsCarreras.getInt("idcarrera"));
                    c.setNombre(rsCarreras.getString("nombre"));
                    carreras.add(c);
                }
                f.setCarreraCollection(carreras); 
            }
        } catch (Exception e) { e.printStackTrace(); }
        return f;
    }
}