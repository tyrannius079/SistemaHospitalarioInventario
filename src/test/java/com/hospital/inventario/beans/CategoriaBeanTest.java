package com.hospital.inventario.beans;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class CategoriaBeanTest {
    private static final String SAMPLE_TEXT = "sample"; // Placeholder value for setter/getter verification.
    private static final String NAME_TEXT = "Med"; // Placeholder value for constructor verification.
    private static final String DESC_TEXT = "Cat"; // Placeholder value for constructor verification.
    private static final String STATE_TEXT = "I"; // Placeholder value for constructor verification.

    @Test
    void settersAndGettersPersistValues() {
        CategoriaBean bean = new CategoriaBean();
        bean.setIdCategoria(10);
        bean.setNombre(SAMPLE_TEXT);
        bean.setDescripcion("desc-" + SAMPLE_TEXT);
        bean.setEstado("A");

        assertEquals(10, bean.getIdCategoria());
        assertEquals(SAMPLE_TEXT, bean.getNombre());
        assertEquals("desc-" + SAMPLE_TEXT, bean.getDescripcion());
        assertEquals("A", bean.getEstado());
    }

    @Test
    void constructorAssignsFields() {
        CategoriaBean bean = new CategoriaBean(2, NAME_TEXT, DESC_TEXT, STATE_TEXT);

        assertEquals(2, bean.getIdCategoria());
        assertEquals(NAME_TEXT, bean.getNombre());
        assertEquals(DESC_TEXT, bean.getDescripcion());
        assertEquals(STATE_TEXT, bean.getEstado());
    }
}
