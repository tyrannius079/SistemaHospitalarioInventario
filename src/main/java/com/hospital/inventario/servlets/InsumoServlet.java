package com.hospital.inventario.servlets;

import com.hospital.inventario.beans.InsumoBean;
import com.hospital.inventario.services.InsumoServices;
import com.hospital.inventario.services.CategoriaServices;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/insumo")
public class InsumoServlet extends HttpServlet {
    private final InsumoServices insumoServices = new InsumoServices();
    private final CategoriaServices categoriaServices = new CategoriaServices();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setAttribute("insumos", insumoServices.getInsumos());
        request.setAttribute("categorias", categoriaServices.getCategorias());
        request.getRequestDispatcher("/insumos.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("create".equals(action)) {
            InsumoBean bean = new InsumoBean();
            bean.setNombre(request.getParameter("nombre"));
            bean.setDescripcion(request.getParameter("descripcion"));
            bean.setUnidadMedida(request.getParameter("presentacion"));
            bean.setStockActual(0); // Stock inicia en 0
            try {
                bean.setStockMinimo(Integer.parseInt(request.getParameter("stockMinimo")));
            } catch (NumberFormatException e) {
                bean.setStockMinimo(10);
            }
            bean.setPrecioUnitario(0.0); // Se define al registrar entrada
            try {
                bean.setIdCategoria(Integer.parseInt(request.getParameter("idCategoria")));
            } catch (NumberFormatException e) {
                bean.setIdCategoria(1);
            }
            insumoServices.registrarInsumo(bean);
        }
        // Redirect-after-POST
        response.sendRedirect(request.getContextPath() + "/insumo");
    }
}
