package com.hospital.inventario.services;

import com.hospital.inventario.beans.PresupuestoBean;
import com.hospital.inventario.dao.PresupuestoDAO;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Arrays;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class PresupuestoServicesTest {

    @Mock
    private PresupuestoDAO presupuestoDAO;

    private PresupuestoServices presupuestoServices;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        presupuestoServices = new PresupuestoServices(presupuestoDAO);
    }

    @Test
    void testGetPresupuestos() {
        when(presupuestoDAO.getPresupuestos()).thenReturn(Arrays.asList(new PresupuestoBean()));
        assertEquals(1, presupuestoServices.getPresupuestos().size());
    }

    @Test
    void testConsultarPresupuesto() {
        PresupuestoBean p = new PresupuestoBean(); p.setIdPresupuesto(1);
        when(presupuestoDAO.consultarPresupuesto(1)).thenReturn(p);
        assertNotNull(presupuestoServices.consultarPresupuesto(1));
    }
}
