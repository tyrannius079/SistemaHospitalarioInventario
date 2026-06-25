package com.hospital.inventario.services;

import com.hospital.inventario.beans.DetalleOrdenCompraBean;
import com.hospital.inventario.beans.OrdenCompraBean;
import com.hospital.inventario.dao.OrdenCompraDAO;
import com.hospital.inventario.dao.PresupuestoDAO;
import com.hospital.inventario.dao.ProveedorDAO;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.ArrayList;
import java.util.Arrays;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class OrdenCompraServicesTest {

    @Mock
    private OrdenCompraDAO ordenCompraDAO;
    @Mock
    private ProveedorDAO proveedorDAO;
    @Mock
    private PresupuestoDAO presupuestoDAO;

    private OrdenCompraServices ordenCompraServices;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        ordenCompraServices = new OrdenCompraServices(ordenCompraDAO, proveedorDAO, presupuestoDAO);
    }

    @Test
    void testGetOrdenes() {
        when(ordenCompraDAO.getOrdenes()).thenReturn(Arrays.asList(new OrdenCompraBean()));
        assertEquals(1, ordenCompraServices.getOrdenes().size());
    }

    @Test
    void testRegistrarOrdenValidations() {
        assertFalse(ordenCompraServices.registrarOrden(null));
        
        OrdenCompraBean o = new OrdenCompraBean();
        assertFalse(ordenCompraServices.registrarOrden(o)); // sin detalles
        
        o.setDetalles(new ArrayList<>());
        assertFalse(ordenCompraServices.registrarOrden(o)); // detalles vacio

        DetalleOrdenCompraBean det = new DetalleOrdenCompraBean();
        det.setCantidad(0);
        o.getDetalles().add(det);
        when(proveedorDAO.existeProveedor(anyInt())).thenReturn(true);
        assertFalse(ordenCompraServices.registrarOrden(o)); // detalle con cant 0
        
        det.setCantidad(10);
        det.setPrecioUnitario(10.5);
        o.setIdProveedor(1);
        when(proveedorDAO.existeProveedor(1)).thenReturn(false);
        assertFalse(ordenCompraServices.registrarOrden(o)); // proveedor no existe
    }

    @Test
    void testModificarOrden() {
        OrdenCompraBean o = new OrdenCompraBean();
        when(ordenCompraDAO.modificarOrden(o)).thenReturn(true);
        assertTrue(ordenCompraServices.modificarOrden(o));
    }
}
