package com.hospital.inventario.beans;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class PresupuestoBeanTest {
    private static final String PERIOD_TEXT = "2026"; // Placeholder value for setter/getter verification.
    private static final String PERIOD_TEXT_2 = "2027"; // Placeholder value for constructor verification.
    private static final String STATE_TEXT = "A"; // Placeholder value for setter/getter verification.
    private static final String STATE_TEXT_2 = "I"; // Placeholder value for constructor verification.

    @Test
    void settersAndGettersPersistValues() {
        PresupuestoBean bean = new PresupuestoBean();
        bean.setIdPresupuesto(1);
        bean.setPeriodo(PERIOD_TEXT);
        bean.setMontoTotal(500.5);
        bean.setMontoDisponible(200.0);
        bean.setEstado(STATE_TEXT);

        assertEquals(1, bean.getIdPresupuesto());
        assertEquals(PERIOD_TEXT, bean.getPeriodo());
        assertEquals(500.5, bean.getMontoTotal());
        assertEquals(200.0, bean.getMontoDisponible());
        assertEquals(STATE_TEXT, bean.getEstado());
    }

    @Test
    void constructorAssignsFields() {
        PresupuestoBean bean = new PresupuestoBean(2, PERIOD_TEXT_2, 1000.0, 750.0, STATE_TEXT_2);

        assertEquals(2, bean.getIdPresupuesto());
        assertEquals(PERIOD_TEXT_2, bean.getPeriodo());
        assertEquals(1000.0, bean.getMontoTotal());
        assertEquals(750.0, bean.getMontoDisponible());
        assertEquals(STATE_TEXT_2, bean.getEstado());
    }
}
