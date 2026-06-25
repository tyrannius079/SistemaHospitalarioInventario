package com.hospital.inventario.beans;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class UsuarioBeanTest {

    @Test
    void testGettersAndSetters() {
        UsuarioBean bean = new UsuarioBean();
        bean.setIdUsuario(1);
        bean.setNombre("Juan Perez");
        bean.setIdRol(1);
        bean.setNombreRol("ADMINISTRADOR");
        bean.setDni("12345678");
        bean.setCorreo("juan@hospital.com");
        bean.setEstado("ACTIVO");

        assertEquals(1, bean.getIdUsuario());
        assertEquals("Juan Perez", bean.getNombre());
        assertEquals(1, bean.getIdRol());
        assertEquals("ADMINISTRADOR", bean.getNombreRol());
        assertEquals("12345678", bean.getDni());
        assertEquals("juan@hospital.com", bean.getCorreo());
        assertEquals("ACTIVO", bean.getEstado());
    }

    @Test
    void testConstructorConParametros() {
        UsuarioBean bean = new UsuarioBean(1, "Maria", 2, "ALMACENERO", "87654321", "maria@hospital.com", "ACTIVO");
        assertEquals(1, bean.getIdUsuario());
        assertEquals("Maria", bean.getNombre());
        assertEquals(2, bean.getIdRol());
        assertEquals("ALMACENERO", bean.getNombreRol());
        assertEquals("87654321", bean.getDni());
        assertEquals("maria@hospital.com", bean.getCorreo());
        assertEquals("ACTIVO", bean.getEstado());
    }
}
