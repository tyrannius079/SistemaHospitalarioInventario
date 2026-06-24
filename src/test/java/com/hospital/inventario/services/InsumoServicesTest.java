package com.hospital.inventario.services;

import com.hospital.inventario.beans.InsumoBean;
import com.hospital.inventario.dao.InsumoDAO;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class InsumoServicesTest {

    @Mock
    private InsumoDAO insumoDAO;

    private InsumoServices insumoServices;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        insumoServices = new InsumoServices(insumoDAO);
    }

    @Test
    void testGetInsumos() {
        InsumoBean i = new InsumoBean(); i.setNombre("Paracetamol");
        when(insumoDAO.getInsumos()).thenReturn(Arrays.asList(i));
        
        List<InsumoBean> insumos = insumoServices.getInsumos();
        assertFalse(insumos.isEmpty());
        assertEquals("Paracetamol", insumos.get(0).getNombre());
    }

    @Test
    void testRegistrarInsumo() {
        InsumoBean i = new InsumoBean();
        when(insumoDAO.registrarInsumo(i)).thenReturn(true);
        assertTrue(insumoServices.registrarInsumo(i));
    }

    @Test
    void testActualizarStock() {
        when(insumoDAO.actualizarStock(1, 10)).thenReturn(true);
        
        // Regla de negocio en Service: cantidad > 0
        assertFalse(insumoServices.actualizarStock(1, -5));
        assertFalse(insumoServices.actualizarStock(1, 0));
        assertTrue(insumoServices.actualizarStock(1, 10));
    }

    @Test
    void testConsultarInsumo() {
        InsumoBean i = new InsumoBean(); i.setIdInsumo(1);
        when(insumoDAO.consultarInsumo(1)).thenReturn(i);
        
        assertNotNull(insumoServices.consultarInsumo(1));
    }
}
