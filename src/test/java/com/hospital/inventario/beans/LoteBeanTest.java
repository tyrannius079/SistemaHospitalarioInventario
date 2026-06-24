package com.hospital.inventario.beans;

import org.junit.jupiter.api.Test;

import java.sql.Date;

import static org.junit.jupiter.api.Assertions.assertEquals;

class LoteBeanTest {
    private static final String DATE_TEXT = "2026-05-21"; // Placeholder value for date verification.
    private static final String DATE_TEXT_2 = "2026-12-01"; // Placeholder value for date verification.
    private static final String LOTE_TEXT = "L-1"; // Placeholder value for setter/getter verification.
    private static final String LOTE_TEXT_2 = "L-2"; // Placeholder value for constructor verification.
    private static final String STATE_TEXT = "A"; // Placeholder value for setter/getter verification.
    private static final String STATE_TEXT_2 = "I"; // Placeholder value for constructor verification.

    @Test
    void settersAndGettersPersistValues() {
        LoteBean bean = new LoteBean();
        Date ingreso = Date.valueOf(DATE_TEXT);
        Date vencimiento = Date.valueOf(DATE_TEXT_2);

        bean.setIdLote(7);
        bean.setNumeroLote(LOTE_TEXT);
        bean.setIdInsumo(9);
        bean.setFechaIngreso(ingreso);
        bean.setFechaVencimiento(vencimiento);
        bean.setCantidadInicial(100);
        bean.setCantidadActual(80);
        bean.setEstado(STATE_TEXT);

        assertEquals(7, bean.getIdLote());
        assertEquals(LOTE_TEXT, bean.getNumeroLote());
        assertEquals(9, bean.getIdInsumo());
        assertEquals(ingreso, bean.getFechaIngreso());
        assertEquals(vencimiento, bean.getFechaVencimiento());
        assertEquals(100, bean.getCantidadInicial());
        assertEquals(80, bean.getCantidadActual());
        assertEquals(STATE_TEXT, bean.getEstado());
    }

    @Test
    void constructorAssignsFields() {
        Date ingreso = Date.valueOf(DATE_TEXT);
        Date vencimiento = Date.valueOf(DATE_TEXT_2);

        LoteBean bean = new LoteBean(1, LOTE_TEXT_2, 2, ingreso, vencimiento, 5, 3, STATE_TEXT_2);

        assertEquals(1, bean.getIdLote());
        assertEquals(LOTE_TEXT_2, bean.getNumeroLote());
        assertEquals(2, bean.getIdInsumo());
        assertEquals(ingreso, bean.getFechaIngreso());
        assertEquals(vencimiento, bean.getFechaVencimiento());
        assertEquals(5, bean.getCantidadInicial());
        assertEquals(3, bean.getCantidadActual());
        assertEquals(STATE_TEXT_2, bean.getEstado());
    }
}
