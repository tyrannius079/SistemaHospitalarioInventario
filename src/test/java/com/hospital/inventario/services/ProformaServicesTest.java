package com.hospital.inventario.services;

import com.hospital.inventario.beans.ProformaBean;
import com.hospital.inventario.dao.ProformaDAO;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Arrays;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class ProformaServicesTest {

    @Mock
    private ProformaDAO proformaDAO;

    private ProformaServices proformaServices;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        proformaServices = new ProformaServices(proformaDAO);
    }

    @Test
    void testGetProformas() {
        when(proformaDAO.getProformas()).thenReturn(Arrays.asList(new ProformaBean()));
        assertEquals(1, proformaServices.getProformas().size());
    }

    @Test
    void testRegistrarProforma() {
        ProformaBean p = new ProformaBean();
        when(proformaDAO.registrarProforma(p)).thenReturn(true);
        assertTrue(proformaServices.registrarProforma(p));
    }
}
