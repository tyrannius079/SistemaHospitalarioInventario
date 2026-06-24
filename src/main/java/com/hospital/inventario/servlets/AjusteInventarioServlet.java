package com.hospital.inventario.servlets;

import com.hospital.inventario.beans.InsumoBean;
import com.hospital.inventario.beans.MovimientoInventarioBean;
import com.hospital.inventario.beans.UsuarioBean;
import com.hospital.inventario.services.InsumoServices;
import com.hospital.inventario.services.MovimientoInventarioServices;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Timestamp;

@WebServlet("/ajuste-inventario")
public class AjusteInventarioServlet extends HttpServlet {
    private final InsumoServices insumoServices = new InsumoServices();
    private final MovimientoInventarioServices movimientoServices = new MovimientoInventarioServices();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("insumos", insumoServices.getInsumos());
        request.getRequestDispatcher("/RegistrarAjuste.jsp").forward(request, response);
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

        UsuarioBean usuario = (UsuarioBean) session.getAttribute("usuarioLogueado");
        int idInsumo = parseInt(request.getParameter("idInsumo"));
        int cantidad = parseInt(request.getParameter("cantidad"));
        String tipoMovimiento = safeText(request.getParameter("tipoMovimiento")); // "SALIDA" o "AJUSTE"
        String observaciones = safeText(request.getParameter("observaciones"));

        if (idInsumo <= 0 || cantidad <= 0 || (!"SALIDA".equals(tipoMovimiento) && !"AJUSTE".equals(tipoMovimiento))) {
            request.setAttribute("error", "Datos incompletos o invalidos para la salida/ajuste.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        InsumoBean insumo = insumoServices.consultarInsumo(idInsumo);
        if (insumo == null) {
            request.setAttribute("error", "Insumo no encontrado.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        // Regla de Negocio: Validar que no se retire más de lo que hay
        if (cantidad > insumo.getStockActual()) {
            request.setAttribute("error", "No hay suficiente stock. Solicitado: " + cantidad + ", Disponible: " + insumo.getStockActual());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        MovimientoInventarioBean mov = new MovimientoInventarioBean();
        mov.setIdInsumo(idInsumo);
        mov.setIdLote(null); // No se detalla lote en esta abstracción
        mov.setIdOrdenCompra(null);
        mov.setIdUsuario(usuario.getIdUsuario());
        mov.setFechaMovimiento(new Timestamp(System.currentTimeMillis()));
        mov.setTipoMovimiento(tipoMovimiento);
        mov.setCantidad(cantidad); // Cantidad siempre positiva
        mov.setObservaciones(observaciones);

        if (!movimientoServices.registrarMovimiento(mov)) {
            request.setAttribute("error", "Error interno al registrar en el historial de movimientos.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        // Restar el stock
        if (!insumoServices.actualizarStock(idInsumo, -cantidad)) {
            request.setAttribute("error", "Error interno al actualizar el stock.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        request.setAttribute("message", "Se descontó correctamente el stock. ID Movimiento: " + mov.getIdMovimiento());
        request.getRequestDispatcher("/confirmacion.jsp").forward(request, response);
    }

    private int parseInt(String value) {
        try {
            return Integer.parseInt(value);
        } catch (Exception e) {
            return 0;
        }
    }

    private String safeText(String value) {
        return value == null ? "" : value.trim();
    }
}
