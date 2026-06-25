package com.hospital.inventario.servlets;

import com.hospital.inventario.services.ProformaServices;
import com.hospital.inventario.services.ProveedorServices;
import com.hospital.inventario.services.InsumoServices;
import com.hospital.inventario.services.CategoriaServices;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/proforma")
public class ProformaServlet extends HttpServlet {
    private final ProformaServices proformaServices = new ProformaServices();
    private final ProveedorServices proveedorServices = new ProveedorServices();
    private final InsumoServices insumoServices = new InsumoServices();
    private final CategoriaServices categoriaServices = new CategoriaServices();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if ("comparar".equals(action)) {
            request.setAttribute("proveedores", proveedorServices.getProveedores());
            request.setAttribute("categorias", categoriaServices.getCategorias());
            // En un caso real se cruzaria informacion entre proformas y detalles
            request.getRequestDispatcher("/compararProformas.jsp").forward(request, response);
        } else {
            // default: nueva
            request.setAttribute("proveedores", proveedorServices.getProveedores());
            request.setAttribute("insumos", insumoServices.getInsumos());
            request.getRequestDispatcher("/registrarProforma.jsp").forward(request, response);
        }
    }
}
