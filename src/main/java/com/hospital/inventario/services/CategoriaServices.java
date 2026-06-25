package com.hospital.inventario.services;

import com.hospital.inventario.beans.CategoriaBean;
import com.hospital.inventario.dao.CategoriaDAO;
import java.util.List;

public class CategoriaServices {
    private final CategoriaDAO dao;

    public CategoriaServices() {
        this.dao = new CategoriaDAO();
    }

    public CategoriaServices(CategoriaDAO dao) {
        this.dao = dao;
    }

    public List<CategoriaBean> getCategorias() {
        return dao.getCategorias();
    }

    public boolean registrarCategoria(CategoriaBean bean) {
        return dao.registrarCategoria(bean);
    }
}
