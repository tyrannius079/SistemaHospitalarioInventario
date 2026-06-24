package com.hospital.inventario.beans;

import org.junit.jupiter.api.Test;

import java.sql.Date;
import java.util.Collections;

import static org.junit.jupiter.api.Assertions.assertEquals;

class OrdenCompraBeanTest {
    private static final String DATE_TEXT = "2026-05-21"; // Placeholder value for date verification.
    private static final String DATE_TEXT_2 = "2026-06-01"; // Placeholder value for date verification.
    private static final String STATE_TEXT = "A"; // Placeholder value for setter/getter verification.
    private static final String STATE_TEXT_2 = "I"; // Placeholder value for constructor verification.
    private static final String OBS_TEXT = "obs"; // Placeholder value for setter/getter verification.
    private static final String OBS_TEXT_2 = "obs2"; // Placeholder value for constructor verification.

    @Test
    void settersAndGettersPersistValues() {
        OrdenCompraBean bean = new OrdenCompraBean();
        Date fecha = Date.valueOf(DATE_TEXT);
        DetalleOrdenCompraBean detalle = new DetalleOrdenCompraBean();
        detalle.setIdDetalle(1);

        bean.setIdOrdenCompra(10);
        bean.setIdSolicitud(11);
        bean.setIdProforma(12);
        bean.setIdProveedor(13);
        bean.setIdUsuario(14);
        bean.setIdPresupuesto(15);
        bean.setFechaEmision(fecha);
        bean.setTotal(99.9);
        bean.setEstado(STATE_TEXT);
        bean.setObservaciones(OBS_TEXT);
        bean.setDetalles(Collections.singletonList(detalle));

        assertEquals(10, bean.getIdOrdenCompra());
        assertEquals(11, bean.getIdSolicitud());
        assertEquals(12, bean.getIdProforma());
        assertEquals(13, bean.getIdProveedor());
        assertEquals(14, bean.getIdUsuario());
        assertEquals(15, bean.getIdPresupuesto());
        assertEquals(fecha, bean.getFechaEmision());
        assertEquals(99.9, bean.getTotal());
        assertEquals(STATE_TEXT, bean.getEstado());
        assertEquals(OBS_TEXT, bean.getObservaciones());
        assertEquals(1, bean.getDetalles().size());
        assertEquals(1, bean.getDetalles().get(0).getIdDetalle());
    }

    @Test
    void constructorAssignsFields() {
        Date fecha = Date.valueOf(DATE_TEXT_2);

        OrdenCompraBean bean = new OrdenCompraBean(1, 2, 3, 4, 5, 6, fecha, 77.7, STATE_TEXT_2, OBS_TEXT_2);

        assertEquals(1, bean.getIdOrdenCompra());
        assertEquals(2, bean.getIdSolicitud());
        assertEquals(3, bean.getIdProforma());
        assertEquals(4, bean.getIdProveedor());
        assertEquals(5, bean.getIdUsuario());
        assertEquals(6, bean.getIdPresupuesto());
        assertEquals(fecha, bean.getFechaEmision());
        assertEquals(77.7, bean.getTotal());
        assertEquals(STATE_TEXT_2, bean.getEstado());
        assertEquals(OBS_TEXT_2, bean.getObservaciones());
    }
}
