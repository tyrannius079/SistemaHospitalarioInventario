package com.hospital.inventario.services;

import com.hospital.inventario.beans.ProveedorBean;
import com.hospital.inventario.dao.ProveedorDAO;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Arrays;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class ProveedorServicesTest {

    @Mock
    private ProveedorDAO proveedorDAO;

    private ProveedorServices proveedorServices;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        proveedorServices = new ProveedorServices(proveedorDAO);
    }

    @Test
    void testGetProveedores() {
        when(proveedorDAO.getProveedores()).thenReturn(Arrays.asList(new ProveedorBean()));
        assertEquals(1, proveedorServices.getProveedores().size());
    }

    @Test
    void testRegistrarProveedor() {
        ProveedorBean p = new ProveedorBean();
        when(proveedorDAO.registrarProveedor(p)).thenReturn(true);
        assertTrue(proveedorServices.registrarProveedor(p));
    }
}
