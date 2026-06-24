package com.hospital.inventario.beans;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class InsumoBeanTest {
    private static final String CODE_TEXT = "CODE-1"; // Placeholder value for setter/getter verification.
    private static final String NAME_TEXT = "Insumo"; // Placeholder value for setter/getter verification.
    private static final String DESC_TEXT = "Descripcion"; // Placeholder value for setter/getter verification.
    private static final String UNIT_TEXT = "UND"; // Placeholder value for setter/getter verification.
    private static final String STATE_TEXT = "A"; // Placeholder value for setter/getter verification.
    private static final String CODE_TEXT_2 = "C-2"; // Placeholder value for constructor verification.
    private static final String NAME_TEXT_2 = "Nombre"; // Placeholder value for constructor verification.
    private static final String DESC_TEXT_2 = "Detalle"; // Placeholder value for constructor verification.
    private static final String UNIT_TEXT_2 = "BOX"; // Placeholder value for constructor verification.
    private static final String STATE_TEXT_2 = "I"; // Placeholder value for constructor verification.

    @Test
    void settersAndGettersPersistValues() {
        InsumoBean bean = new InsumoBean();
        bean.setIdInsumo(11);
        bean.setCodigo(CODE_TEXT);
        bean.setNombre(NAME_TEXT);
        bean.setDescripcion(DESC_TEXT);
        bean.setUnidadMedida(UNIT_TEXT);
        bean.setStockActual(20);
        bean.setStockMinimo(5);
        bean.setPrecioUnitario(12.75);
        bean.setIdCategoria(3);
        bean.setEstado(STATE_TEXT);

        assertEquals(11, bean.getIdInsumo());
        assertEquals(CODE_TEXT, bean.getCodigo());
        assertEquals(NAME_TEXT, bean.getNombre());
        assertEquals(DESC_TEXT, bean.getDescripcion());
        assertEquals(UNIT_TEXT, bean.getUnidadMedida());
        assertEquals(20, bean.getStockActual());
        assertEquals(5, bean.getStockMinimo());
        assertEquals(12.75, bean.getPrecioUnitario());
        assertEquals(3, bean.getIdCategoria());
        assertEquals(STATE_TEXT, bean.getEstado());
    }

    @Test
    void constructorAssignsFields() {
        InsumoBean bean = new InsumoBean(1, CODE_TEXT_2, NAME_TEXT_2, DESC_TEXT_2, UNIT_TEXT_2, 9, 2, 5.5, 4, STATE_TEXT_2);

        assertEquals(1, bean.getIdInsumo());
        assertEquals(CODE_TEXT_2, bean.getCodigo());
        assertEquals(NAME_TEXT_2, bean.getNombre());
        assertEquals(DESC_TEXT_2, bean.getDescripcion());
        assertEquals(UNIT_TEXT_2, bean.getUnidadMedida());
        assertEquals(9, bean.getStockActual());
        assertEquals(2, bean.getStockMinimo());
        assertEquals(5.5, bean.getPrecioUnitario());
        assertEquals(4, bean.getIdCategoria());
        assertEquals(STATE_TEXT_2, bean.getEstado());
    }
}
