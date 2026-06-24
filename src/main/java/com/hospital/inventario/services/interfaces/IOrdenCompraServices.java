package com.hospital.inventario.services.interfaces;

import com.hospital.inventario.beans.OrdenCompraBean;

import java.util.List;

public interface IOrdenCompraServices {
    List<OrdenCompraBean> getOrdenes();
    boolean registrarOrden(OrdenCompraBean bean);
    boolean modificarOrden(OrdenCompraBean bean);
    OrdenCompraBean consultarOrden(int idOrdenCompra);
}
