package com.hospital.inventario.dao;

import com.hospital.inventario.beans.MovimientoInventarioBean;
import com.hospital.inventario.util.ConexionBD;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MovimientoInventarioDAO {
    private static final Logger logger = LoggerFactory.getLogger(MovimientoInventarioDAO.class);

    public boolean registrarMovimiento(MovimientoInventarioBean bean) {
        String sql = "INSERT INTO TB_MovimientoInventario (idInsumo, idLote, idOrdenCompra, idUsuario, "
                + "fechaMovimiento, tipoMovimiento, cantidad, observaciones) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, bean.getIdInsumo());
            if (bean.getIdLote() != null) {
                ps.setInt(2, bean.getIdLote());
            } else {
                ps.setNull(2, Types.INTEGER);
            }
            if (bean.getIdOrdenCompra() != null) {
                ps.setInt(3, bean.getIdOrdenCompra());
            } else {
                ps.setNull(3, Types.INTEGER);
            }
            ps.setInt(4, bean.getIdUsuario());
            ps.setTimestamp(5, bean.getFechaMovimiento());
            ps.setString(6, bean.getTipoMovimiento());
            ps.setInt(7, bean.getCantidad());
            ps.setString(8, bean.getObservaciones());
            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        bean.setIdMovimiento(rs.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            logger.error("Error SQL detectado en MovimientoInventarioDAO.", e);
            return false;
        }
        return false;
    }

    public List<MovimientoInventarioBean> getMovimientos() {
        List<MovimientoInventarioBean> lista = new ArrayList<>();
        String sql = "SELECT * FROM TB_MovimientoInventario ORDER BY idMovimiento DESC";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(mapMovimiento(rs));
            }
        } catch (SQLException e) {
            logger.error("Error SQL detectado en MovimientoInventarioDAO (lista).", e);
            return lista;
        }
        return lista;
    }

    public List<MovimientoInventarioBean> consultarMovimientos(int idInsumo) {
        List<MovimientoInventarioBean> lista = new ArrayList<>();
        String sql = "SELECT * FROM TB_MovimientoInventario WHERE idInsumo = ? ORDER BY idMovimiento DESC";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idInsumo);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapMovimiento(rs));
                }
            }
        } catch (SQLException e) {
            logger.error("Error SQL detectado en MovimientoInventarioDAO (lista).", e);
            return lista;
        }
        return lista;
    }

    private MovimientoInventarioBean mapMovimiento(ResultSet rs) throws SQLException {
        MovimientoInventarioBean bean = new MovimientoInventarioBean();
        bean.setIdMovimiento(rs.getInt("idMovimiento"));
        bean.setIdInsumo(rs.getInt("idInsumo"));
        int idLote = rs.getInt("idLote");
        bean.setIdLote(rs.wasNull() ? null : idLote);
        int idOrdenCompra = rs.getInt("idOrdenCompra");
        bean.setIdOrdenCompra(rs.wasNull() ? null : idOrdenCompra);
        bean.setIdUsuario(rs.getInt("idUsuario"));
        bean.setFechaMovimiento(rs.getTimestamp("fechaMovimiento"));
        bean.setTipoMovimiento(rs.getString("tipoMovimiento"));
        bean.setCantidad(rs.getInt("cantidad"));
        bean.setObservaciones(rs.getString("observaciones"));
        return bean;
    }
}
