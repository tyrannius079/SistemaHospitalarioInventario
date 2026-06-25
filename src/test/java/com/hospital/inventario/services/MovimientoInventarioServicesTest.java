package com.hospital.inventario.services;

import com.hospital.inventario.beans.MovimientoInventarioBean;
import com.hospital.inventario.dao.MovimientoInventarioDAO;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Arrays;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class MovimientoInventarioServicesTest {

    @Mock
    private MovimientoInventarioDAO movimientoDAO;

    private MovimientoInventarioServices movimientoServices;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        movimientoServices = new MovimientoInventarioServices(movimientoDAO);
    }

    @Test
    void testGetMovimientos() {
        when(movimientoDAO.getMovimientos()).thenReturn(Arrays.asList(new MovimientoInventarioBean()));
        assertEquals(1, movimientoServices.getMovimientos().size());
    }

    @Test
    void testRegistrarMovimiento() {
        assertFalse(movimientoServices.registrarMovimiento(null));
        
        MovimientoInventarioBean m = new MovimientoInventarioBean();
        m.setCantidad(0);
        assertFalse(movimientoServices.registrarMovimiento(m));
        
        m.setCantidad(5);
        m.setTipoMovimiento(null);
        assertFalse(movimientoServices.registrarMovimiento(m));
        
        m.setTipoMovimiento("ENTRADA");
        when(movimientoDAO.registrarMovimiento(m)).thenReturn(true);
        assertTrue(movimientoServices.registrarMovimiento(m));
    }
}
