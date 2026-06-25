package com.hospital.inventario.services;

import com.hospital.inventario.beans.UsuarioBean;
import com.hospital.inventario.dao.UsuarioDAO;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class UsuarioServicesTest {

    @Mock
    private UsuarioDAO usuarioDAO;

    private UsuarioServices usuarioServices;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        usuarioServices = new UsuarioServices(usuarioDAO);
    }

    @Test
    void testGetUsuarios() {
        UsuarioBean u1 = new UsuarioBean(); 
        u1.setNombre("Juan");
        when(usuarioDAO.getUsuarios()).thenReturn(Arrays.asList(u1));

        List<UsuarioBean> lista = usuarioServices.getUsuarios();
        assertEquals(1, lista.size());
        assertEquals("Juan", lista.get(0).getNombre());
        verify(usuarioDAO, times(1)).getUsuarios();
    }

    @Test
    void testValidarLogin() {
        UsuarioBean u1 = new UsuarioBean(); 
        u1.setNombre("Juan");
        when(usuarioDAO.validarLogin("12345678", "password123")).thenReturn(u1);

        UsuarioBean result = usuarioServices.validarLogin("12345678", "password123");
        assertNotNull(result);
        assertEquals("Juan", result.getNombre());
        
        UsuarioBean nullResult = usuarioServices.validarLogin("12345678", "wrong");
        assertNull(nullResult);
    }
}
