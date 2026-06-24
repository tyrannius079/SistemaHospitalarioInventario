package com.hospital.inventario.dao;

import com.hospital.inventario.beans.PresupuestoBean;
import com.hospital.inventario.util.ConexionBD;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

public class PresupuestoDAO {

    public List<PresupuestoBean> getPresupuestos() {
        List<PresupuestoBean> lista = new ArrayList<>();
        String sql = "SELECT * FROM TB_Presupuesto";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                PresupuestoBean bean = new PresupuestoBean();
                bean.setIdPresupuesto(rs.getInt("idPresupuesto"));
                bean.setPeriodo(rs.getString("periodo"));
                bean.setMontoTotal(rs.getDouble("montoTotal"));
                bean.setMontoDisponible(rs.getDouble("montoDisponible"));
                bean.setEstado(rs.getString("estado"));
                lista.add(bean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public PresupuestoBean consultarPresupuesto(int idPresupuesto) {
        try (Connection conn = ConexionBD.getConnection()) {
            return consultarPresupuesto(conn, idPresupuesto);
        } catch (SQLException e) {
            return null;
        }
    }

    public PresupuestoBean consultarPresupuesto(Connection conn, int idPresupuesto) throws SQLException {
        String sql = "SELECT * FROM TB_Presupuesto WHERE idPresupuesto = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idPresupuesto);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    PresupuestoBean bean = new PresupuestoBean();
                    bean.setIdPresupuesto(rs.getInt("idPresupuesto"));
                    bean.setPeriodo(rs.getString("periodo"));
                    bean.setMontoTotal(rs.getDouble("montoTotal"));
                    bean.setMontoDisponible(rs.getDouble("montoDisponible"));
                    bean.setEstado(rs.getString("estado"));
                    return bean;
                }
            }
        }
        return null;
    }

    public boolean actualizarDisponible(int idPresupuesto, double nuevoDisponible) {
        try (Connection conn = ConexionBD.getConnection()) {
            return actualizarDisponible(conn, idPresupuesto, nuevoDisponible);
        } catch (SQLException e) {
            return false;
        }
    }

    public boolean actualizarDisponible(Connection conn, int idPresupuesto, double nuevoDisponible) throws SQLException {
        String sql = "UPDATE TB_Presupuesto SET montoDisponible = ? WHERE idPresupuesto = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDouble(1, nuevoDisponible);
            ps.setInt(2, idPresupuesto);
            return ps.executeUpdate() > 0;
        }
    }
}
