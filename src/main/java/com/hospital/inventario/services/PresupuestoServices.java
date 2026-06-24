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
}
