package com.hospital.inventario.dao;

import com.hospital.inventario.beans.ProformaBean;
import com.hospital.inventario.beans.DetalleProformaBean;
import com.hospital.inventario.util.ConexionBD;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ProformaDAO {
    private static final Logger logger = LoggerFactory.getLogger(ProformaDAO.class);

    public List<ProformaBean> getProformas() {
        List<ProformaBean> lista = new ArrayList<>();
        String sql = "SELECT p.*, e.nombre AS nombreEstado, prov.razonSocial, "
                + "GROUP_CONCAT(i.nombre SEPARATOR ', ') AS resumenInsumos "
                + "FROM TB_Proforma p "
                + "JOIN TB_Estado e ON p.idEstado = e.idEstado "
                + "JOIN TB_Proveedor prov ON p.idProveedor = prov.idProveedor "
                + "LEFT JOIN TB_DetalleProforma dp ON p.idProforma = dp.idProforma "
                + "LEFT JOIN TB_Insumo i ON dp.idInsumo = i.idInsumo "
                + "GROUP BY p.idProforma "
                + "ORDER BY p.idProforma DESC";
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
                bean.setIdEstado(rs.getInt("idEstado"));
                bean.setNombreEstado(rs.getString("nombreEstado"));
                bean.setRazonSocialProveedor(rs.getString("razonSocial"));
                bean.setResumenInsumos(rs.getString("resumenInsumos") != null ? rs.getString("resumenInsumos") : "Sin Insumos");
                lista.add(bean);
            }
        } catch (SQLException e) {
            logger.error("Error SQL detectado en ProformaDAO (lista).", e);
            return lista;
        }
        return lista;
    }

    public boolean registrarProforma(ProformaBean bean) {
        String sqlProforma = "INSERT INTO TB_Proforma (idProveedor, fechaEmision, montoTotal, tiempoEntregaDias, idEstado) VALUES (?, ?, ?, ?, ?)";
        String sqlDetalle = "INSERT INTO TB_DetalleProforma (idProforma, idInsumo, cantidad, precioUnitario, subtotal) VALUES (?, ?, ?, ?, ?)";
        
        Connection conn = null;
        try {
            conn = ConexionBD.getConnection();
            conn.setAutoCommit(false);
            
            int idProformaInsertada = 0;
            
            try (PreparedStatement ps = conn.prepareStatement(sqlProforma, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, bean.getIdProveedor());
                ps.setDate(2, bean.getFechaEmision());
                ps.setDouble(3, bean.getMontoTotal());
                ps.setInt(4, bean.getTiempoEntregaDias());
                ps.setInt(5, bean.getIdEstado());
                ps.executeUpdate();
                
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        idProformaInsertada = rs.getInt(1);
                    }
                }
            }
            
            if (idProformaInsertada > 0 && bean.getDetalles() != null && !bean.getDetalles().isEmpty()) {
                try (PreparedStatement psDet = conn.prepareStatement(sqlDetalle)) {
                    for (DetalleProformaBean det : bean.getDetalles()) {
                        psDet.setInt(1, idProformaInsertada);
                        psDet.setInt(2, det.getIdInsumo());
                        psDet.setInt(3, det.getCantidad());
                        psDet.setDouble(4, det.getPrecioUnitario());
                        psDet.setDouble(5, det.getSubtotal());
                        psDet.addBatch();
                    }
                    psDet.executeBatch();
                }
            }
            
            conn.commit();
            return true;
        } catch (SQLException e) {
            logger.error("Error SQL detectado al registrar proforma.", e);
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    logger.error("Error al hacer rollback", ex);
                }
            }
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    logger.error("Error al cerrar conexion", e);
                }
            }
        }
    }

    public List<DetalleProformaBean> obtenerDetallesPorProforma(int idProforma) {
        List<DetalleProformaBean> detalles = new ArrayList<>();
        String sql = "SELECT dp.*, i.nombre as nombreInsumo, i.codigo as codigoInsumo " +
                     "FROM TB_DetalleProforma dp " +
                     "JOIN TB_Insumo i ON dp.idInsumo = i.idInsumo " +
                     "WHERE dp.idProforma = ?";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idProforma);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    DetalleProformaBean det = new DetalleProformaBean();
                    det.setIdDetalle(rs.getInt("idDetalle"));
                    det.setIdProforma(rs.getInt("idProforma"));
                    det.setIdInsumo(rs.getInt("idInsumo"));
                    det.setCantidad(rs.getInt("cantidad"));
                    det.setPrecioUnitario(rs.getDouble("precioUnitario"));
                    det.setSubtotal(rs.getDouble("subtotal"));
                    det.setNombreInsumo(rs.getString("nombreInsumo"));
                    det.setCodigoInsumo(rs.getString("codigoInsumo"));
                    detalles.add(det);
                }
            }
        } catch (SQLException e) {
            logger.error("Error al obtener detalles de proforma.", e);
        }
        return detalles;
    }

    public List<ProformaBean> compararProformas(int idSolicitud) {
        return getProformas();
    }
}
