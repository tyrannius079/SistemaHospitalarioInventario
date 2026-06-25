package com.hospital.inventario.services;

import com.hospital.inventario.beans.LoteBean;
import com.hospital.inventario.dao.LoteDAO;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Arrays;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class LoteServicesTest {

    @Mock
    private LoteDAO loteDAO;

    private LoteServices loteServices;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        loteServices = new LoteServices(loteDAO);
    }

    @Test
    void testGetLotes() {
        LoteBean l = new LoteBean(); l.setNumeroLote("L01");
        when(loteDAO.getLotes()).thenReturn(Arrays.asList(l));
        assertEquals(1, loteServices.getLotes().size());
    }

    @Test
    void testRegistrarLoteValidations() {
        assertFalse(loteServices.registrarLote(null));
        
        LoteBean l = new LoteBean();
        l.setCantidadInicial(0);
        assertFalse(loteServices.registrarLote(l)); // Cantidad <= 0
        
        l.setCantidadInicial(10);
        when(loteDAO.registrarLote(l)).thenReturn(true);
        assertTrue(loteServices.registrarLote(l));
        assertEquals("A", l.getEstado(), "Estado debe setearse a 'A' si estaba nulo");
        assertNotNull(l.getFechaIngreso(), "Fecha Ingreso se debe autogenerar si es nula");
    }

    @Test
    void testVerificarVencimientos() {
        when(loteDAO.verificarVencimientos()).thenReturn(Arrays.asList(new LoteBean()));
        assertFalse(loteServices.verificarVencimientos().isEmpty());
    }
}
