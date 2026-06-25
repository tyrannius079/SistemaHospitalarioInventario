package com.hospital.inventario.services;

import com.hospital.inventario.beans.MovimientoInventarioBean;
import com.hospital.inventario.dao.MovimientoInventarioDAO;
import com.hospital.inventario.services.interfaces.IMovimientoInventarioServices;

import java.util.List;

public class MovimientoInventarioServices implements IMovimientoInventarioServices {
    private final MovimientoInventarioDAO movimientoDAO;

    public MovimientoInventarioServices() {
        this.movimientoDAO = new MovimientoInventarioDAO();
    }

    public MovimientoInventarioServices(MovimientoInventarioDAO movimientoDAO) {
        this.movimientoDAO = movimientoDAO;
    }

    @Override
    public List<MovimientoInventarioBean> getMovimientos() {
        return movimientoDAO.getMovimientos();
    }

    @Override
    public boolean registrarMovimiento(MovimientoInventarioBean bean) {
        if (bean == null || bean.getCantidad() <= 0 || bean.getTipoMovimiento() == null) {
            return false;
        }
        return movimientoDAO.registrarMovimiento(bean);
    }

    @Override
    public List<MovimientoInventarioBean> consultarMovimientos(int idInsumo) {
        return movimientoDAO.consultarMovimientos(idInsumo);
    }
}
