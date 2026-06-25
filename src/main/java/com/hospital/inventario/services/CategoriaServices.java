package com.hospital.inventario.services;

import com.hospital.inventario.beans.CategoriaBean;
import com.hospital.inventario.dao.CategoriaDAO;
import java.util.List;

public class CategoriaServices {
    private final CategoriaDAO dao = new CategoriaDAO();

    public List<CategoriaBean> getCategorias() {
        return dao.getCategorias();
    }
}
