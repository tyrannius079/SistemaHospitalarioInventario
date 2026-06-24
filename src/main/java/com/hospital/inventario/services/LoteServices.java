package com.hospital.inventario.services;

import com.hospital.inventario.beans.LoteBean;
import com.hospital.inventario.dao.LoteDAO;
import com.hospital.inventario.services.interfaces.ILoteServices;

import java.sql.Date;
import java.util.List;

public class LoteServices implements ILoteServices {
    private final LoteDAO loteDAO = new LoteDAO();

    @Override
    public List<LoteBean> getLotes() {
        return loteDAO.getLotes();
    }

    @Override
    public boolean registrarLote(LoteBean bean) {
        if (bean == null || bean.getCantidadInicial() <= 0) {
            return false;
        }
        if (bean.getFechaIngreso() == null) {
            bean.setFechaIngreso(new Date(System.currentTimeMillis()));
        }
        if (bean.getEstado() == null || bean.getEstado().isEmpty()) {
            bean.setEstado("A");
        }
        return loteDAO.registrarLote(bean);
    }

    @Override
    public List<LoteBean> verificarVencimientos() {
        return loteDAO.verificarVencimientos();
    }
}
