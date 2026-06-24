package com.hospital.inventario.dao;

import com.hospital.inventario.beans.ProformaBean;
import com.hospital.inventario.util.ConexionBD;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ProformaDAO {
    private static final Logger logger = LoggerFactory.getLogger(ProformaDAO.class);

    public List<ProformaBean> getProformas() {
        List<ProformaBean> lista = new ArrayList<>();
        String sql = "SELECT * FROM TB_Proforma ORDER BY idProforma DESC";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ProformaBean bean = new ProformaBean();
                bean.setIdProforma(rs.getInt("idProforma"));
                bean.setIdProveedor(rs.getInt("idProveedor"));
                bean.setFechaEmision(rs.getDate("fechaEmision"));
                bean.setMontoTotal(rs.getDouble("montoTotal"));
                bean.setTiempoEntregaDias(rs.getInt("tiempoEntregaDias"));
                bean.setEstado(rs.getString("estado"));
                lista.add(bean);
            }
        } catch (SQLException e) {
            logger.error("Error SQL detectado en ProformaDAO (lista).", e);
            return lista;
        }
        return lista;
    }

    public boolean registrarProforma(ProformaBean bean) {
        String sql = "INSERT INTO TB_Proforma (idProveedor, fechaEmision, montoTotal, tiempoEntregaDias, estado) "
                + "VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bean.getIdProveedor());
            ps.setDate(2, bean.getFechaEmision());
            ps.setDouble(3, bean.getMontoTotal());
            ps.setInt(4, bean.getTiempoEntregaDias());
            ps.setString(5, bean.getEstado());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.error("Error SQL detectado en ProformaDAO.", e);
            return false;
        }
    }

    public List<ProformaBean> compararProformas(int idSolicitud) {
        return getProformas();
    }
}
