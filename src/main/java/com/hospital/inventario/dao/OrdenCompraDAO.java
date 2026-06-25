package com.hospital.inventario.dao;

import com.hospital.inventario.beans.DetalleOrdenCompraBean;
import com.hospital.inventario.beans.OrdenCompraBean;
import com.hospital.inventario.util.ConexionBD;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class OrdenCompraDAO {
    private static final Logger logger = LoggerFactory.getLogger(OrdenCompraDAO.class);

    public int registrarOrden(OrdenCompraBean bean, Connection conn) throws SQLException {
        String sql = "INSERT INTO TB_OrdenCompra (idSolicitud, idProforma, idProveedor, idUsuario, "
                + "idPresupuesto, fechaEmision, total, idEstado, observaciones) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, bean.getIdSolicitud());
            ps.setInt(2, bean.getIdProforma());
            ps.setInt(3, bean.getIdProveedor());
            ps.setInt(4, bean.getIdUsuario());
            ps.setInt(5, bean.getIdPresupuesto());
            ps.setDate(6, bean.getFechaEmision());
            ps.setDouble(7, bean.getTotal());
            ps.setInt(8, bean.getIdEstado());
            ps.setString(9, bean.getObservaciones());
            int rows = ps.executeUpdate();
            if (rows == 0) {
                return -1;
            }
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return -1;
    }

    public boolean registrarDetalles(int idOrdenCompra, List<DetalleOrdenCompraBean> detalles, Connection conn)
            throws SQLException {
        String sql = "INSERT INTO TB_DetalleOrdenCompra (idOrdenCompra, idInsumo, cantidad, precioUnitario, subtotal) "
                + "VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            for (DetalleOrdenCompraBean detalle : detalles) {
                ps.setInt(1, idOrdenCompra);
                ps.setInt(2, detalle.getIdInsumo());
                ps.setInt(3, detalle.getCantidad());
                ps.setDouble(4, detalle.getPrecioUnitario());
                ps.setDouble(5, detalle.getSubtotal());
                ps.addBatch();
            }
            int[] results = ps.executeBatch();
            return results.length == detalles.size();
        }
    }

    public boolean existeOrdenCompra(int idOrdenCompra) {
        String sql = "SELECT 1 FROM TB_OrdenCompra WHERE idOrdenCompra = ?";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idOrdenCompra);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            logger.error("Error SQL detectado en OrdenCompraDAO.", e);
            return false;
        }
    }

    public OrdenCompraBean consultarOrden(int idOrdenCompra) {
        String sql = "SELECT o.*, e.nombre AS nombreEstado FROM TB_OrdenCompra o JOIN TB_Estado e ON o.idEstado = e.idEstado WHERE o.idOrdenCompra = ?";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idOrdenCompra);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    OrdenCompraBean bean = new OrdenCompraBean();
                    bean.setIdOrdenCompra(rs.getInt("idOrdenCompra"));
                    bean.setIdSolicitud(rs.getInt("idSolicitud"));
                    bean.setIdProforma(rs.getInt("idProforma"));
                    bean.setIdProveedor(rs.getInt("idProveedor"));
                    bean.setIdUsuario(rs.getInt("idUsuario"));
                    bean.setIdPresupuesto(rs.getInt("idPresupuesto"));
                    bean.setFechaEmision(rs.getDate("fechaEmision"));
                    bean.setTotal(rs.getDouble("total"));
                    bean.setIdEstado(rs.getInt("idEstado"));
                    bean.setNombreEstado(rs.getString("nombreEstado"));
                    bean.setObservaciones(rs.getString("observaciones"));
                    return bean;
                }
            }
        } catch (SQLException e) {
            logger.error("Error SQL detectado en OrdenCompraDAO (null).", e);
            return null;
        }
        return null;
    }

    public List<OrdenCompraBean> getOrdenes() {
        List<OrdenCompraBean> lista = new ArrayList<>();
        String sql = "SELECT o.*, e.nombre AS nombreEstado FROM TB_OrdenCompra o JOIN TB_Estado e ON o.idEstado = e.idEstado ORDER BY o.idOrdenCompra DESC";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                OrdenCompraBean bean = new OrdenCompraBean();
                bean.setIdOrdenCompra(rs.getInt("idOrdenCompra"));
                bean.setIdSolicitud(rs.getInt("idSolicitud"));
                bean.setIdProforma(rs.getInt("idProforma"));
                bean.setIdProveedor(rs.getInt("idProveedor"));
                bean.setIdUsuario(rs.getInt("idUsuario"));
                bean.setIdPresupuesto(rs.getInt("idPresupuesto"));
                bean.setFechaEmision(rs.getDate("fechaEmision"));
                bean.setTotal(rs.getDouble("total"));
                bean.setIdEstado(rs.getInt("idEstado"));
                bean.setNombreEstado(rs.getString("nombreEstado"));
                bean.setObservaciones(rs.getString("observaciones"));
                lista.add(bean);
            }
        } catch (SQLException e) {
            logger.error("Error SQL detectado en OrdenCompraDAO (lista).", e);
            return lista;
        }
        return lista;
    }

    public boolean modificarOrden(OrdenCompraBean bean) {
        String sql = "UPDATE TB_OrdenCompra SET idEstado = ?, observaciones = ? WHERE idOrdenCompra = ?";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bean.getIdEstado());
            ps.setString(2, bean.getObservaciones());
            ps.setInt(3, bean.getIdOrdenCompra());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.error("Error SQL detectado en OrdenCompraDAO.", e);
            return false;
        }
    }
}
