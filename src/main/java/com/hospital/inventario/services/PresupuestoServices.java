package com.hospital.inventario.services;

import com.hospital.inventario.beans.PresupuestoBean;
import com.hospital.inventario.dao.PresupuestoDAO;
import com.hospital.inventario.services.interfaces.IPresupuestoServices;

import java.util.List;

public class PresupuestoServices implements IPresupuestoServices {
    private final PresupuestoDAO presupuestoDAO;

    public PresupuestoServices() {
        this.presupuestoDAO = new PresupuestoDAO();
    }

    public PresupuestoServices(PresupuestoDAO presupuestoDAO) {
        this.presupuestoDAO = presupuestoDAO;
    }

    @Override
    public List<PresupuestoBean> getPresupuestos() {
        return presupuestoDAO.getPresupuestos();
    }

    @Override
    public PresupuestoBean consultarPresupuesto(int idPresupuesto) {
        return presupuestoDAO.consultarPresupuesto(idPresupuesto);
    }

    @Override
    public boolean registrarPresupuesto(PresupuestoBean bean) {
        // Reglas de negocio básicas
        if (bean == null || bean.getMontoTotal() <= 0 || bean.getPeriodo() == null || bean.getPeriodo().trim().isEmpty()) {
            return false;
        }
        
        // Al registrar, el disponible inicia igual al total
        bean.setMontoDisponible(bean.getMontoTotal());
        
        if (bean.getEstado() == null || bean.getEstado().trim().isEmpty()) {
            bean.setEstado("ACTIVO");
        }
        
        return presupuestoDAO.registrarPresupuesto(bean);
    }
}
