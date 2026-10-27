package config;

import jakarta.annotation.sql.DataSourceDefinition;
import jakarta.ejb.Singleton;
import jakarta.ejb.Startup;

/**
 * Declara el DataSource de PostgreSQL dentro de la aplicación, así GlassFish crea el pool
 * al desplegar sin configurar nada en la consola. El driver viaja en WEB-INF/lib.
 * La unidad de persistencia (persistence.xml) lo usa por su nombre JNDI.
 */
@Singleton
@Startup
@DataSourceDefinition(
        name = "java:app/jdbc/bdalumnos",
        className = "org.postgresql.ds.PGSimpleDataSource",
        serverName = "localhost",
        portNumber = 5432,
        databaseName = "bdalumnos",
        user = "postgres",
        password = "123")
public class ConfiguracionBD {
}
