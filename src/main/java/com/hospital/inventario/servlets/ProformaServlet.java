package com.hospital.inventario.servlets;

import com.hospital.inventario.beans.ProformaBean;
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
import java.sql.Date;

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
            request.getRequestDispatcher("/compararProformas.jsp").forward(request, response);
        } else {
            // default: nueva
            request.setAttribute("proveedores", proveedorServices.getProveedores());
            request.setAttribute("insumos", insumoServices.getInsumos());
            request.getRequestDispatcher("/registrarProforma.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            int idProveedor = Integer.parseInt(request.getParameter("idProveedor"));
            double montoTotal = 0;
            String totalParam = request.getParameter("montoTotal");
            if (totalParam != null && !totalParam.isEmpty()) {
                montoTotal = Double.parseDouble(totalParam);
            }

            ProformaBean bean = new ProformaBean();
            bean.setIdProveedor(idProveedor);
            bean.setFechaEmision(new Date(System.currentTimeMillis()));
            bean.setMontoTotal(montoTotal);
            bean.setTiempoEntregaDias(5); // valor por defecto
            bean.setIdEstado(1); // Estado inicial: PENDIENTE
            proformaServices.registrarProforma(bean);
        } catch (NumberFormatException e) {
            // Error de parseo, ignorar
        }

        // Redirect-after-POST
        response.sendRedirect(request.getContextPath() + "/proforma");
    }
}
