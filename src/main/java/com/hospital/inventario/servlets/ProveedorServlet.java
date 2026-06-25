package com.hospital.inventario.servlets;

import com.hospital.inventario.beans.ProveedorBean;
import com.hospital.inventario.services.ProveedorServices;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/proveedor")
public class ProveedorServlet extends HttpServlet {
    private final ProveedorServices proveedorServices = new ProveedorServices();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setAttribute("proveedores", proveedorServices.getProveedores());
        request.getRequestDispatcher("/proveedores.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("create".equals(action)) {
            ProveedorBean bean = new ProveedorBean();
            bean.setRuc(request.getParameter("ruc"));
            bean.setRazonSocial(request.getParameter("razonSocial"));
            bean.setDireccion(request.getParameter("direccion"));
            bean.setTelefono(request.getParameter("telefono"));
            bean.setEmail(request.getParameter("email"));
            proveedorServices.registrarProveedor(bean);
        }
        // Redirect-after-POST
        response.sendRedirect(request.getContextPath() + "/proveedor");
    }
}
