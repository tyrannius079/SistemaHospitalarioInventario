package com.hospital.inventario.dao;

import com.hospital.inventario.beans.CategoriaBean;
import com.hospital.inventario.util.ConexionBD;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CategoriaDAO {
    private static final Logger logger = LoggerFactory.getLogger(CategoriaDAO.class);

    public List<CategoriaBean> getCategorias() {
        List<CategoriaBean> lista = new ArrayList<>();
        String sql = "SELECT idCategoria, nombre, descripcion, estado FROM TB_Categoria";
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                CategoriaBean cat = new CategoriaBean();
                cat.setIdCategoria(rs.getInt("idCategoria"));
                cat.setNombre(rs.getString("nombre"));
                cat.setDescripcion(rs.getString("descripcion"));
                
                int estadoId = rs.getInt("estado");
                cat.setEstado(estadoId == 1 ? "ACTIVO" : "INACTIVO");
                
                lista.add(cat);
            }
        } catch (SQLException e) {
            logger.error("Error SQL detectado en CategoriaDAO (lista).", e);
        }
        return lista;
    }

    public boolean registrarCategoria(CategoriaBean bean) {
        String sql = "INSERT INTO TB_Categoria (nombre, descripcion, estado) VALUES (?, ?, 1)";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, bean.getNombre());
            ps.setString(2, bean.getDescripcion());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.error("Error SQL detectado en CategoriaDAO.", e);
            return false;
        }
    }
}
