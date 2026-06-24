package com.hospital.inventario.dao;

import com.hospital.inventario.beans.ProveedorBean;
import com.hospital.inventario.util.ConexionBD;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProveedorDAO {

    public boolean existeProveedor(int idProveedor) {
        String sql = "SELECT 1 FROM TB_Proveedor WHERE idProveedor = ?";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idProveedor);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            return false;
        }
    }

    public ProveedorBean consultarProveedor(int idProveedor) {
        String sql = "SELECT * FROM TB_Proveedor WHERE idProveedor = ?";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idProveedor);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ProveedorBean bean = new ProveedorBean();
                    bean.setIdProveedor(rs.getInt("idProveedor"));
                    bean.setRazonSocial(rs.getString("razonSocial"));
                    bean.setRuc(rs.getString("ruc"));
                    bean.setDireccion(rs.getString("direccion"));
                    bean.setTelefono(rs.getString("telefono"));
                    bean.setEmail(rs.getString("email"));
                    bean.setEstado(rs.getString("estado"));
                    return bean;
                }
            }
        } catch (SQLException e) {
            return null;
        }
        return null;
    }

    public List<ProveedorBean> getProveedores() {
        List<ProveedorBean> lista = new ArrayList<>();
        String sql = "SELECT * FROM TB_Proveedor ORDER BY idProveedor DESC";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ProveedorBean bean = new ProveedorBean();
                bean.setIdProveedor(rs.getInt("idProveedor"));
                bean.setRazonSocial(rs.getString("razonSocial"));
                bean.setRuc(rs.getString("ruc"));
                bean.setDireccion(rs.getString("direccion"));
                bean.setTelefono(rs.getString("telefono"));
                bean.setEmail(rs.getString("email"));
                bean.setEstado(rs.getString("estado"));
                lista.add(bean);
            }
        } catch (SQLException e) {
            return lista;
        }
        return lista;
    }

    public boolean registrarProveedor(ProveedorBean bean) {
        String sql = "INSERT INTO TB_Proveedor (razonSocial, ruc, direccion, telefono, email, estado) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, bean.getRazonSocial());
            ps.setString(2, bean.getRuc());
            ps.setString(3, bean.getDireccion());
            ps.setString(4, bean.getTelefono());
            ps.setString(5, bean.getEmail());
            ps.setString(6, bean.getEstado());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            return false;
        }
    }
}
