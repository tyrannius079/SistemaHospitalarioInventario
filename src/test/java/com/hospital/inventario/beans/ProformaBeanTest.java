package com.hospital.inventario.beans;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class ProformaBeanTest {

    @Test
    void testGettersAndSetters() {
        ProformaBean bean = new ProformaBean();
        bean.setIdProforma(1);
        bean.setIdProveedor(3);
        bean.setMontoTotal(12500.00);
        bean.setTiempoEntregaDias(5);
        bean.setIdEstado(1);
        bean.setNombreEstado("PENDIENTE");
        bean.setRazonSocialProveedor("Distribuidora Medica SAC");

        assertEquals(1, bean.getIdProforma());
        assertEquals(3, bean.getIdProveedor());
        assertEquals(12500.00, bean.getMontoTotal());
        assertEquals(5, bean.getTiempoEntregaDias());
        assertEquals(1, bean.getIdEstado());
        assertEquals("PENDIENTE", bean.getNombreEstado());
        assertEquals("Distribuidora Medica SAC", bean.getRazonSocialProveedor());
    }

    @Test
    void testCodigoFormateado() {
        ProformaBean bean = new ProformaBean();
        bean.setIdProforma(7);
        assertEquals("PROF-2026-0007", bean.getCodigoFormateado());
    }

    @Test
    void testCodigoFormateadoNuevo() {
        ProformaBean bean = new ProformaBean();
        // idProforma defaults to 0
        assertEquals("Generado Automáticamente", bean.getCodigoFormateado());
    }

    @Test
    void testConstructorConParametros() {
        ProformaBean bean = new ProformaBean(1, 2, null, 5000.0, 3, 1);
        assertEquals(1, bean.getIdProforma());
        assertEquals(2, bean.getIdProveedor());
        assertEquals(5000.0, bean.getMontoTotal());
        assertEquals(3, bean.getTiempoEntregaDias());
        assertEquals(1, bean.getIdEstado());
    }
}
