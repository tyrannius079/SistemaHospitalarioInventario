package com.hospital.inventario.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ConexionBD {
    private static final Logger logger = LoggerFactory.getLogger(ConexionBD.class);
    private static final String DEFAULT_URL = "jdbc:mysql://localhost:3306/hospitaldb?useSSL=false&serverTimezone=UTC";
    private static final String DEFAULT_USER = "hospital";
    private static final String DEFAULT_PASSWORD = "hospital";

    private static String getEnv(String name, String fallback) {
        String value = System.getenv(name);
        return (value == null || value.isEmpty()) ? fallback : value;
    }

    public static Connection getConnection() throws SQLException {
        String url = getEnv("DB_URL", DEFAULT_URL);
        String user = getEnv("DB_USER", DEFAULT_USER);
        String password = getEnv("DB_PASSWORD", DEFAULT_PASSWORD);
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("JDBC driver not found", e);
        }
        return DriverManager.getConnection(url, user, password);
    }

    public static void closeQuietly(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("Error al establecer conexión con la base de datos.", e);
            }
        }
    }
}
