package com.hospital.inventario.services;

import com.hospital.inventario.beans.InsumoBean;
import com.hospital.inventario.dao.InsumoDAO;
import com.hospital.inventario.services.interfaces.IInsumoServices;

import java.util.List;

public class InsumoServices implements IInsumoServices {
    private final InsumoDAO insumoDAO = new InsumoDAO();

    @Override
    public List<InsumoBean> getInsumos() {
        return insumoDAO.getInsumos();
    }

    @Override
    public boolean registrarInsumo(InsumoBean bean) {
        return insumoDAO.registrarInsumo(bean);
    }

    @Override
    public boolean actualizarStock(int idInsumo, int cantidad) {
        if (cantidad <= 0) {
            return false;
        }
        return insumoDAO.actualizarStock(idInsumo, cantidad);
    }

    @Override
    public InsumoBean consultarInsumo(int idInsumo) {
        return insumoDAO.consultarInsumo(idInsumo);
    }
}
