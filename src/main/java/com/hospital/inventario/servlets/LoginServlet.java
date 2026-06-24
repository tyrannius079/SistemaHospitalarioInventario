package com.hospital.inventario.servlets;

import com.hospital.inventario.beans.UsuarioBean;
import com.hospital.inventario.services.UsuarioServices;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final UsuarioServices usuarioServices = new UsuarioServices();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("logout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String dni = request.getParameter("dni");
        String password = request.getParameter("password");

        if (dni == null || dni.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "DNI y contraseña son requeridos.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        UsuarioBean usuario = usuarioServices.validarLogin(dni.trim(), password);

        if (usuario != null) {
            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogueado", usuario);
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } else {
            request.setAttribute("error", "Credenciales incorrectas o usuario inactivo.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
