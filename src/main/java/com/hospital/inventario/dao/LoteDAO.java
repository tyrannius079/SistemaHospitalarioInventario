package com.hospital.inventario.dao;

import com.hospital.inventario.beans.LoteBean;
import com.hospital.inventario.util.ConexionBD;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class LoteDAO {

    public boolean registrarLote(LoteBean bean) {
        String sql = "INSERT INTO TB_Lote (numeroLote, idInsumo, fechaIngreso, fechaVencimiento, "
                + "cantidadInicial, cantidadActual, estado) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, bean.getNumeroLote());
            ps.setInt(2, bean.getIdInsumo());
            ps.setDate(3, bean.getFechaIngreso());
            ps.setDate(4, bean.getFechaVencimiento());
            ps.setInt(5, bean.getCantidadInicial());
            ps.setInt(6, bean.getCantidadActual());
            ps.setString(7, bean.getEstado());
            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        bean.setIdLote(rs.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            return false;
        }
        return false;
    }

    public List<LoteBean> getLotes() {
        List<LoteBean> lista = new ArrayList<>();
        String sql = "SELECT * FROM TB_Lote ORDER BY idLote DESC";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(mapLote(rs));
            }
        } catch (SQLException e) {
            return lista;
        }
        return lista;
    }

    public List<LoteBean> verificarVencimientos() {
        List<LoteBean> lista = new ArrayList<>();
        String sql = "SELECT * FROM TB_Lote WHERE fechaVencimiento <= DATE_ADD(CURDATE(), INTERVAL 30 DAY)";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(mapLote(rs));
            }
        } catch (SQLException e) {
            return lista;
        }
        return lista;
    }

    private LoteBean mapLote(ResultSet rs) throws SQLException {
        LoteBean bean = new LoteBean();
        bean.setIdLote(rs.getInt("idLote"));
        bean.setNumeroLote(rs.getString("numeroLote"));
        bean.setIdInsumo(rs.getInt("idInsumo"));
        Date fechaIngreso = rs.getDate("fechaIngreso");
        Date fechaVencimiento = rs.getDate("fechaVencimiento");
        bean.setFechaIngreso(fechaIngreso);
        bean.setFechaVencimiento(fechaVencimiento);
        bean.setCantidadInicial(rs.getInt("cantidadInicial"));
        bean.setCantidadActual(rs.getInt("cantidadActual"));
        bean.setEstado(rs.getString("estado"));
        return bean;
    }
}
