package com.hospital.inventario.services.interfaces;

import com.hospital.inventario.beans.PresupuestoBean;
import java.util.List;

public interface IPresupuestoServices {
    List<PresupuestoBean> getPresupuestos();
    PresupuestoBean consultarPresupuesto(int idPresupuesto);
    boolean registrarPresupuesto(PresupuestoBean bean);
}
