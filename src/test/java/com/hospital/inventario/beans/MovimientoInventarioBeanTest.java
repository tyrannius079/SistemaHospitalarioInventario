package com.hospital.inventario.beans;

import org.junit.jupiter.api.Test;

import java.sql.Timestamp;

import static org.junit.jupiter.api.Assertions.assertEquals;

class MovimientoInventarioBeanTest {
    private static final String TS_TEXT = "2026-05-21 10:15:30"; // Placeholder value for timestamp verification.
    private static final String TS_TEXT_2 = "2026-06-01 09:00:00"; // Placeholder value for timestamp verification.
    private static final String TIPO_TEXT = "ENTRADA"; // Placeholder value for setter/getter verification.
    private static final String TIPO_TEXT_2 = "SALIDA"; // Placeholder value for constructor verification.
    private static final String OBS_TEXT = "obs"; // Placeholder value for setter/getter verification.
    private static final String OBS_TEXT_2 = "obs2"; // Placeholder value for constructor verification.

    @Test
    void settersAndGettersPersistValues() {
        MovimientoInventarioBean bean = new MovimientoInventarioBean();
        Timestamp fecha = Timestamp.valueOf(TS_TEXT);

        bean.setIdMovimiento(1);
        bean.setIdInsumo(2);
        bean.setIdLote(3);
        bean.setIdOrdenCompra(4);
        bean.setIdUsuario(5);
        bean.setFechaMovimiento(fecha);
        bean.setTipoMovimiento(TIPO_TEXT);
        bean.setCantidad(6);
        bean.setObservaciones(OBS_TEXT);

        assertEquals(1, bean.getIdMovimiento());
        assertEquals(2, bean.getIdInsumo());
        assertEquals(3, bean.getIdLote());
        assertEquals(4, bean.getIdOrdenCompra());
        assertEquals(5, bean.getIdUsuario());
        assertEquals(fecha, bean.getFechaMovimiento());
        assertEquals(TIPO_TEXT, bean.getTipoMovimiento());
        assertEquals(6, bean.getCantidad());
        assertEquals(OBS_TEXT, bean.getObservaciones());
    }

    @Test
    void constructorAssignsFields() {
        Timestamp fecha = Timestamp.valueOf(TS_TEXT_2);

        MovimientoInventarioBean bean = new MovimientoInventarioBean(7, 8, 9, 10, 11, fecha, TIPO_TEXT_2, 12, OBS_TEXT_2);

        assertEquals(7, bean.getIdMovimiento());
        assertEquals(8, bean.getIdInsumo());
        assertEquals(9, bean.getIdLote());
        assertEquals(10, bean.getIdOrdenCompra());
        assertEquals(11, bean.getIdUsuario());
        assertEquals(fecha, bean.getFechaMovimiento());
        assertEquals(TIPO_TEXT_2, bean.getTipoMovimiento());
        assertEquals(12, bean.getCantidad());
        assertEquals(OBS_TEXT_2, bean.getObservaciones());
    }
}
