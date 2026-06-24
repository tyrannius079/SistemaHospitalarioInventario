package com.hospital.inventario.beans;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class DetalleOrdenCompraBeanTest {
    private static final double PRICE = 12.5;
    private static final double SUBTOTAL = 50.0;

    @Test
    void settersAndGettersPersistValues() {
        DetalleOrdenCompraBean bean = new DetalleOrdenCompraBean();
        bean.setIdDetalle(1);
        bean.setIdOrdenCompra(2);
        bean.setIdInsumo(3);
        bean.setCantidad(4);
        bean.setPrecioUnitario(PRICE);
        bean.setSubtotal(SUBTOTAL);

        assertEquals(1, bean.getIdDetalle());
        assertEquals(2, bean.getIdOrdenCompra());
        assertEquals(3, bean.getIdInsumo());
        assertEquals(4, bean.getCantidad());
        assertEquals(PRICE, bean.getPrecioUnitario());
        assertEquals(SUBTOTAL, bean.getSubtotal());
    }

    @Test
    void constructorAssignsFields() {
        DetalleOrdenCompraBean bean = new DetalleOrdenCompraBean(5, 6, 7, 8, 9.5, 76.0);

        assertEquals(5, bean.getIdDetalle());
        assertEquals(6, bean.getIdOrdenCompra());
        assertEquals(7, bean.getIdInsumo());
        assertEquals(8, bean.getCantidad());
        assertEquals(9.5, bean.getPrecioUnitario());
        assertEquals(76.0, bean.getSubtotal());
    }
}
