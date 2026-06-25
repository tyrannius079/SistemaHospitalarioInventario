package com.hospital.inventario.services.interfaces;

import com.hospital.inventario.beans.OrdenCompraBean;
import com.hospital.inventario.beans.DetalleOrdenCompraBean;

import java.util.List;

public interface IOrdenCompraServices {
    List<OrdenCompraBean> getOrdenes();
    boolean registrarOrdenCompra(OrdenCompraBean bean, List<DetalleOrdenCompraBean> detalles);
    boolean actualizarEstadoOrden(int idOrdenCompra, int idEstado);
    List<DetalleOrdenCompraBean> getDetallesPorOrden(int idOrdenCompra);
    OrdenCompraBean consultarOrden(int idOrdenCompra);
}
