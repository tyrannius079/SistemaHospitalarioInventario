package com.hospital.inventario.dao;

import com.hospital.inventario.beans.InsumoBean;
import com.hospital.inventario.util.ConexionBD;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class InsumoDAO {
    private static final Logger logger = LoggerFactory.getLogger(InsumoDAO.class);

    public InsumoBean consultarInsumo(int idInsumo) {
        String sql = "SELECT * FROM TB_Insumo WHERE idInsumo = ?";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idInsumo);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    InsumoBean bean = new InsumoBean();
                    bean.setIdInsumo(rs.getInt("idInsumo"));
                    bean.setCodigo(rs.getString("codigo"));
                    bean.setNombre(rs.getString("nombre"));
                    bean.setDescripcion(rs.getString("descripcion"));
                    bean.setUnidadMedida(rs.getString("unidadMedida"));
                    bean.setStockActual(rs.getInt("stockActual"));
                    bean.setStockMinimo(rs.getInt("stockMinimo"));
                    bean.setPrecioUnitario(rs.getDouble("precioUnitario"));
                    bean.setIdCategoria(rs.getInt("idCategoria"));
                    bean.setEstado(rs.getString("estado"));
                    return bean;
                }
            }
        } catch (SQLException e) {
            logger.error("Error SQL detectado en InsumoDAO (null).", e);
            return null;
        }
        return null;
    }

    public List<InsumoBean> getInsumos() {
        List<InsumoBean> lista = new ArrayList<>();
        String sql = "SELECT * FROM TB_Insumo ORDER BY idInsumo DESC";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                InsumoBean bean = new InsumoBean();
                bean.setIdInsumo(rs.getInt("idInsumo"));
                bean.setCodigo(rs.getString("codigo"));
                bean.setNombre(rs.getString("nombre"));
                bean.setDescripcion(rs.getString("descripcion"));
                bean.setUnidadMedida(rs.getString("unidadMedida"));
                bean.setStockActual(rs.getInt("stockActual"));
                bean.setStockMinimo(rs.getInt("stockMinimo"));
                bean.setPrecioUnitario(rs.getDouble("precioUnitario"));
                bean.setIdCategoria(rs.getInt("idCategoria"));
                bean.setEstado(rs.getString("estado"));
                lista.add(bean);
            }
        } catch (SQLException e) {
            logger.error("Error SQL detectado en InsumoDAO (lista).", e);
            return lista;
        }
        return lista;
    }

    public boolean registrarInsumo(InsumoBean bean) {
        String sql = "INSERT INTO TB_Insumo (codigo, nombre, descripcion, unidadMedida, stockActual, "
                + "stockMinimo, precioUnitario, idCategoria, estado) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, bean.getCodigo());
            ps.setString(2, bean.getNombre());
            ps.setString(3, bean.getDescripcion());
            ps.setString(4, bean.getUnidadMedida());
            ps.setInt(5, bean.getStockActual());
            ps.setInt(6, bean.getStockMinimo());
            ps.setDouble(7, bean.getPrecioUnitario());
            ps.setInt(8, bean.getIdCategoria());
            ps.setString(9, bean.getEstado());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.error("Error SQL detectado en InsumoDAO.", e);
            return false;
        }
    }

    public boolean actualizarStock(int idInsumo, int cantidad) {
        String sql = "UPDATE TB_Insumo SET stockActual = stockActual + ? WHERE idInsumo = ?";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cantidad);
            ps.setInt(2, idInsumo);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.error("Error SQL detectado en InsumoDAO.", e);
            return false;
        }
    }
}
