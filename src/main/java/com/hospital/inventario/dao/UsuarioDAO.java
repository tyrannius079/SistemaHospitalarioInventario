package com.hospital.inventario.dao;

import com.hospital.inventario.beans.UsuarioBean;
import com.hospital.inventario.util.ConexionBD;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {

    public List<UsuarioBean> getUsuarios() {
        List<UsuarioBean> lista = new ArrayList<>();
        String sql = "SELECT * FROM TB_Usuario";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                UsuarioBean bean = new UsuarioBean();
                bean.setIdUsuario(rs.getInt("idUsuario"));
                bean.setNombre(rs.getString("nombres") + " " + rs.getString("apellidos"));
                bean.setRol(rs.getString("rol"));
                lista.add(bean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public UsuarioBean validarLogin(String dni, String password) {
        String sql = "SELECT * FROM TB_Usuario WHERE dni = ? AND password = ? AND estado = 'A'";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, dni);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    UsuarioBean bean = new UsuarioBean();
                    bean.setIdUsuario(rs.getInt("idUsuario"));
                    bean.setNombre(rs.getString("nombres") + " " + rs.getString("apellidos"));
                    bean.setRol(rs.getString("rol"));
                    return bean;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
