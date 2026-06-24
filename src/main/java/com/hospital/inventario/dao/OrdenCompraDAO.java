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

public class OrdenCompraDAO {

    public int registrarOrden(OrdenCompraBean bean, Connection conn) throws SQLException {
        String sql = "INSERT INTO TB_OrdenCompra (idSolicitud, idProforma, idProveedor, idUsuario, "
                + "idPresupuesto, fechaEmision, total, estado, observaciones) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, bean.getIdSolicitud());
            ps.setInt(2, bean.getIdProforma());
            ps.setInt(3, bean.getIdProveedor());
            ps.setInt(4, bean.getIdUsuario());
            ps.setInt(5, bean.getIdPresupuesto());
            ps.setDate(6, bean.getFechaEmision());
            ps.setDouble(7, bean.getTotal());
            ps.setString(8, bean.getEstado());
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
            return false;
        }
    }

    public OrdenCompraBean consultarOrden(int idOrdenCompra) {
        String sql = "SELECT * FROM TB_OrdenCompra WHERE idOrdenCompra = ?";
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
                    bean.setEstado(rs.getString("estado"));
                    bean.setObservaciones(rs.getString("observaciones"));
                    return bean;
                }
            }
        } catch (SQLException e) {
            return null;
        }
        return null;
    }

    public List<OrdenCompraBean> getOrdenes() {
        List<OrdenCompraBean> lista = new ArrayList<>();
        String sql = "SELECT * FROM TB_OrdenCompra ORDER BY idOrdenCompra DESC";
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
                bean.setEstado(rs.getString("estado"));
                bean.setObservaciones(rs.getString("observaciones"));
                lista.add(bean);
            }
        } catch (SQLException e) {
            return lista;
        }
        return lista;
    }

    public boolean modificarOrden(OrdenCompraBean bean) {
        String sql = "UPDATE TB_OrdenCompra SET estado = ?, observaciones = ? WHERE idOrdenCompra = ?";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, bean.getEstado());
            ps.setString(2, bean.getObservaciones());
            ps.setInt(3, bean.getIdOrdenCompra());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            return false;
        }
    }
}
