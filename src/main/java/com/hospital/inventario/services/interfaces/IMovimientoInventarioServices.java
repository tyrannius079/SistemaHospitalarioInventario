package com.hospital.inventario.services.interfaces;

import com.hospital.inventario.beans.MovimientoInventarioBean;

import java.util.List;

public interface IMovimientoInventarioServices {
    List<MovimientoInventarioBean> getMovimientos();
    boolean registrarMovimiento(MovimientoInventarioBean bean);
    List<MovimientoInventarioBean> consultarMovimientos(int idInsumo);
}
