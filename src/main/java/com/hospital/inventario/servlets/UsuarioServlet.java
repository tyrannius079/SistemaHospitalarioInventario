package com.hospital.inventario.servlets;

import com.hospital.inventario.beans.UsuarioBean;
import com.hospital.inventario.services.UsuarioServices;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/usuario")
public class UsuarioServlet extends HttpServlet {
    private final UsuarioServices usuarioServices = new UsuarioServices();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("usuarios", usuarioServices.getUsuarios());
        request.getRequestDispatcher("/usuarios.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            action = "listar";
        }

        switch (action) {
            case "crear":
                crearUsuario(request, response);
                break;
            case "editar":
                editarUsuario(request, response);
                break;
            case "desactivar":
                desactivarUsuario(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/usuario");
        }
    }

    private void crearUsuario(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        UsuarioBean bean = new UsuarioBean();
        bean.setDni(safeText(request.getParameter("dni")));
        bean.setNombre(safeText(request.getParameter("nombre")));
        bean.setCorreo(safeText(request.getParameter("correo")));
        try {
            bean.setIdRol(Integer.parseInt(safeText(request.getParameter("rol"))));
        } catch (NumberFormatException e) {
            bean.setIdRol(3); // default técnico
        }
        String password = safeText(request.getParameter("password"));

        boolean ok = usuarioServices.crearUsuario(bean, password);
        if (ok) {
            response.sendRedirect(request.getContextPath() + "/usuario");
        } else {
            request.setAttribute("error", "Error al registrar el usuario.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private void editarUsuario(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        UsuarioBean bean = new UsuarioBean();
        bean.setDni(safeText(request.getParameter("dni")));
        bean.setNombre(safeText(request.getParameter("nombre")));
        bean.setCorreo(safeText(request.getParameter("correo")));
        try {
            bean.setIdRol(Integer.parseInt(safeText(request.getParameter("rol"))));
        } catch (NumberFormatException e) {
            bean.setIdRol(3); // default técnico
        }

        boolean ok = usuarioServices.editarUsuario(bean);
        
        if (ok) {
            response.sendRedirect(request.getContextPath() + "/usuario");
        } else {
            request.setAttribute("error", "Error al actualizar el usuario.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private void desactivarUsuario(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String dni = safeText(request.getParameter("dni"));
        boolean ok = usuarioServices.desactivarUsuario(dni);
        if (ok) {
            response.sendRedirect(request.getContextPath() + "/usuario");
        } else {
            request.setAttribute("error", "Error al desactivar el usuario.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private String safeText(String value) {
        return value == null ? "" : value.trim();
    }
}
