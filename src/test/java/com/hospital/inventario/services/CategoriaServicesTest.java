package com.hospital.inventario.services;

import com.hospital.inventario.beans.CategoriaBean;
import com.hospital.inventario.dao.CategoriaDAO;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Arrays;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class CategoriaServicesTest {

    @Mock
    private CategoriaDAO categoriaDAO;

    private CategoriaServices categoriaServices;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        categoriaServices = new CategoriaServices(categoriaDAO);
    }

    @Test
    void testGetCategorias() {
        when(categoriaDAO.getCategorias()).thenReturn(Arrays.asList(new CategoriaBean(), new CategoriaBean()));
        assertEquals(2, categoriaServices.getCategorias().size());
    }

    @Test
    void testGetCategoriasEmpty() {
        when(categoriaDAO.getCategorias()).thenReturn(Arrays.asList());
        assertTrue(categoriaServices.getCategorias().isEmpty());
    }

    @Test
    void testRegistrarCategoria() {
        CategoriaBean cat = new CategoriaBean();
        cat.setNombre("Reactivos");
        cat.setDescripcion("Reactivos de laboratorio");
        when(categoriaDAO.registrarCategoria(cat)).thenReturn(true);
        assertTrue(categoriaServices.registrarCategoria(cat));
    }

    @Test
    void testRegistrarCategoriaFalla() {
        CategoriaBean cat = new CategoriaBean();
        when(categoriaDAO.registrarCategoria(cat)).thenReturn(false);
        assertFalse(categoriaServices.registrarCategoria(cat));
    }
}
