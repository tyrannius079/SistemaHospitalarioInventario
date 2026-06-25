package com.hospital.inventario.servlets;

import com.hospital.inventario.beans.CategoriaBean;
import com.hospital.inventario.services.CategoriaServices;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/categoria")
public class CategoriaServlet extends HttpServlet {
    private final CategoriaServices categoriaServices = new CategoriaServices();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setAttribute("categorias", categoriaServices.getCategorias());
        request.getRequestDispatcher("/categorias.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");

        if ("create".equals(action)) {
            CategoriaBean bean = new CategoriaBean();
            bean.setNombre(nombre);
            bean.setDescripcion(descripcion);
            bean.setEstado("ACTIVO");
            categoriaServices.registrarCategoria(bean);
        }
        // Redirect-after-POST para evitar reenvio de formulario
        response.sendRedirect(request.getContextPath() + "/categoria");
    }
}
