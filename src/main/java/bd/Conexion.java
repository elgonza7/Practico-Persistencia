package bd;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {
    private Connection con;

    public Conexion() {
        try {
            Class.forName("org.postgresql.Driver");
            String url = "jdbc:postgresql://localhost:5432/bdalumnos";
            String usuario = "postgres";
            String clave = "123";
            
            con = DriverManager.getConnection(url, usuario, clave);
            System.out.println("¡Conexión exitosa a PostgreSQL!");
            
        } catch (ClassNotFoundException e) {
            System.out.println("Error: Falta el driver de PostgreSQL. " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("Error conectando a la BD: " + e.getMessage());
        }
    }

    public Connection getConnection() {
        return con;
    }
}