package com.hospital.inventario.dao;

import com.hospital.inventario.beans.CategoriaBean;
import com.hospital.inventario.util.ConexionBD;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoriaDAO {

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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
}
