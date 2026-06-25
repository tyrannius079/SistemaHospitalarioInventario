package com.hospital.inventario.beans;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class ProveedorBeanTest {

    @Test
    void testGettersAndSetters() {
        ProveedorBean bean = new ProveedorBean();
        bean.setIdProveedor(1);
        bean.setRazonSocial("Distribuidora Medica SAC");
        bean.setRuc("20541236589");
        bean.setDireccion("Av. Los Incas 1234");
        bean.setTelefono("987654321");
        bean.setEmail("ventas@distmedica.com");
        bean.setEstado("ACTIVO");

        assertEquals(1, bean.getIdProveedor());
        assertEquals("Distribuidora Medica SAC", bean.getRazonSocial());
        assertEquals("20541236589", bean.getRuc());
        assertEquals("Av. Los Incas 1234", bean.getDireccion());
        assertEquals("987654321", bean.getTelefono());
        assertEquals("ventas@distmedica.com", bean.getEmail());
        assertEquals("ACTIVO", bean.getEstado());
    }

    @Test
    void testCodigoFormateado() {
        ProveedorBean bean = new ProveedorBean();
        bean.setIdProveedor(3);
        assertEquals("PRV-0003", bean.getCodigo());
    }

    @Test
    void testConstructorVacio() {
        ProveedorBean bean = new ProveedorBean();
        assertNotNull(bean);
        assertEquals(0, bean.getIdProveedor());
        assertNull(bean.getRazonSocial());
    }
}
