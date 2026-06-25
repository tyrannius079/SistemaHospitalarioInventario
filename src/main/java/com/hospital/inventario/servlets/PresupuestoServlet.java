package com.hospital.inventario.servlets;

import com.hospital.inventario.beans.PresupuestoBean;
import com.hospital.inventario.services.PresupuestoServices;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/presupuestos")
public class PresupuestoServlet extends HttpServlet {
    private final PresupuestoServices presupuestoServices = new PresupuestoServices();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Cargar todos los presupuestos para pintarlos en la tabla
        request.setAttribute("presupuestos", presupuestoServices.getPresupuestos());
        request.getRequestDispatcher("/GestionarPresupuestos.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuarioLogueado") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String periodo = request.getParameter("periodo");
        double montoTotal;
        try {
            montoTotal = Double.parseDouble(request.getParameter("montoTotal"));
        } catch (NumberFormatException e) {
            montoTotal = 0;
        }

        PresupuestoBean bean = new PresupuestoBean();
        bean.setPeriodo(periodo);
        bean.setMontoTotal(montoTotal);
        // El servicio se encarga de igualar montoDisponible = montoTotal

        if (presupuestoServices.registrarPresupuesto(bean)) {
            // Éxito: recargar la página para ver la lista actualizada
            response.sendRedirect(request.getContextPath() + "/presupuestos");
        } else {
            // Fallo: redirigir con error
            request.setAttribute("error", "Error al crear la partida presupuestal. Verifique los datos.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
