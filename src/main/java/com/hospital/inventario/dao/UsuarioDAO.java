package com.hospital.inventario.dao;

import com.hospital.inventario.beans.UsuarioBean;
import com.hospital.inventario.util.ConexionBD;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class UsuarioDAO {
    private static final Logger logger = LoggerFactory.getLogger(UsuarioDAO.class);

    public List<UsuarioBean> getUsuarios() {
        List<UsuarioBean> lista = new ArrayList<>();
        String sql = "SELECT u.*, r.nombre AS nombreRol FROM TB_Usuario u JOIN TB_Rol r ON u.idRol = r.idRol";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                UsuarioBean bean = new UsuarioBean();
                bean.setIdUsuario(rs.getInt("idUsuario"));
                bean.setDni(rs.getString("dni"));
                bean.setNombre(rs.getString("nombres") + " " + rs.getString("apellidos"));
                bean.setCorreo(rs.getString("email"));
                bean.setIdRol(rs.getInt("idRol"));
                bean.setNombreRol(rs.getString("nombreRol"));
                bean.setEstado(rs.getInt("estado") == 1 ? "ACTIVO" : "INACTIVO");
                lista.add(bean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public boolean crearUsuario(UsuarioBean bean, String rawPassword) {
        String sql = "INSERT INTO TB_Usuario (dni, nombres, apellidos, email, password, idRol, estado) VALUES (?, ?, ?, ?, ?, ?, 1)";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, bean.getDni());
            
            // Separar nombres y apellidos simple (idealmente vendrian separados, pero el UI los manda juntos)
            String[] partes = bean.getNombre().split(" ", 2);
            ps.setString(2, partes[0]);
            ps.setString(3, partes.length > 1 ? partes[1] : "");
            
            ps.setString(4, bean.getCorreo());
            ps.setString(5, rawPassword);
            ps.setInt(6, bean.getIdRol());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean editarUsuario(UsuarioBean bean) {
        String sql = "UPDATE TB_Usuario SET nombres = ?, apellidos = ?, email = ?, idRol = ? WHERE dni = ?";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            String[] partes = bean.getNombre().split(" ", 2);
            ps.setString(1, partes[0]);
            ps.setString(2, partes.length > 1 ? partes[1] : "");
            ps.setString(3, bean.getCorreo());
            ps.setInt(4, bean.getIdRol());
            ps.setString(5, bean.getDni());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean desactivarUsuario(String dni) {
        String sql = "UPDATE TB_Usuario SET estado = 0 WHERE dni = ?";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, dni);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public UsuarioBean validarLogin(String dni, String password) {
        String sql = "SELECT u.*, r.nombre AS nombreRol FROM TB_Usuario u JOIN TB_Rol r ON u.idRol = r.idRol WHERE u.dni = ? AND u.password = ? AND u.estado = 1";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, dni);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    UsuarioBean bean = new UsuarioBean();
                    bean.setIdUsuario(rs.getInt("idUsuario"));
                    bean.setNombre(rs.getString("nombres") + " " + rs.getString("apellidos"));
                    bean.setIdRol(rs.getInt("idRol"));
                    bean.setNombreRol(rs.getString("nombreRol"));
                    return bean;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
