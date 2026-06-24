package com.hospital.inventario.servlets;

import com.hospital.inventario.beans.LoteBean;
import com.hospital.inventario.beans.MovimientoInventarioBean;
import com.hospital.inventario.services.InsumoServices;
import com.hospital.inventario.services.LoteServices;
import com.hospital.inventario.services.MovimientoInventarioServices;
import com.hospital.inventario.services.OrdenCompraServices;

import com.hospital.inventario.services.UsuarioServices;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;

@WebServlet("/inventario")
public class InventarioServlet extends HttpServlet {
    private final OrdenCompraServices ordenCompraServices = new OrdenCompraServices();
    private final LoteServices loteServices = new LoteServices();
    private final MovimientoInventarioServices movimientoServices = new MovimientoInventarioServices();
    private final InsumoServices insumoServices = new InsumoServices();
    private final UsuarioServices usuarioServices = new UsuarioServices();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("listar".equals(action)) {
            request.setAttribute("movimientos", movimientoServices.getMovimientos());
            request.getRequestDispatcher("/ConsultarEntradas.jsp").forward(request, response);
        } else {
            request.setAttribute("ordenes", ordenCompraServices.getOrdenes());
            request.setAttribute("insumos", insumoServices.getInsumos());
            request.setAttribute("usuarios", usuarioServices.getUsuarios());
            request.getRequestDispatcher("/RegistrarEntrada.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        int idOrdenCompra = parseInt(request.getParameter("idOrdenCompra"));
        int idInsumo = parseInt(request.getParameter("idInsumo"));
        int cantidad = parseInt(request.getParameter("cantidad"));
        int idUsuario = parseInt(request.getParameter("idUsuario"));
        String numeroLote = safeText(request.getParameter("numeroLote"));
        String fechaVencimientoStr = request.getParameter("fechaVencimiento");
        String observaciones = safeText(request.getParameter("observaciones"));

        if (idOrdenCompra <= 0 || idInsumo <= 0 || cantidad <= 0 || idUsuario <= 0) {
            request.setAttribute("error", "Datos incompletos o invalidos.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        if (!ordenCompraServices.existeOrdenCompra(idOrdenCompra)) {
            request.setAttribute("error", "Orden de compra no valida.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        Date fechaVencimiento = parseDate(fechaVencimientoStr);
        LoteBean lote = new LoteBean();
        lote.setNumeroLote(numeroLote);
        lote.setIdInsumo(idInsumo);
        lote.setFechaIngreso(new Date(System.currentTimeMillis()));
        lote.setFechaVencimiento(fechaVencimiento);
        lote.setCantidadInicial(cantidad);
        lote.setCantidadActual(cantidad);
        lote.setEstado("A");

        if (!loteServices.registrarLote(lote)) {
            request.setAttribute("error", "No se pudo registrar el lote.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        MovimientoInventarioBean mov = new MovimientoInventarioBean();
        mov.setIdInsumo(idInsumo);
        mov.setIdLote(lote.getIdLote());
        mov.setIdOrdenCompra(idOrdenCompra);
        mov.setIdUsuario(idUsuario);
        mov.setFechaMovimiento(new Timestamp(System.currentTimeMillis()));
        mov.setTipoMovimiento("ENTRADA");
        mov.setCantidad(cantidad);
        mov.setObservaciones(observaciones);

        if (!movimientoServices.registrarMovimiento(mov)) {
            request.setAttribute("error", "No se pudo registrar el movimiento.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        if (!insumoServices.actualizarStock(idInsumo, cantidad)) {
            request.setAttribute("error", "No se pudo actualizar el stock.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        request.setAttribute("message", "Entrada registrada con ID movimiento: " + mov.getIdMovimiento());
        request.getRequestDispatcher("/confirmacion.jsp").forward(request, response);
    }

    private int parseInt(String value) {
        try {
            return Integer.parseInt(value);
        } catch (Exception e) {
            return 0;
        }
    }

    private Date parseDate(String value) {
        try {
            if (value == null || value.isEmpty()) {
                return new Date(System.currentTimeMillis());
            }
            return Date.valueOf(value);
        } catch (Exception e) {
            return new Date(System.currentTimeMillis());
        }
    }

    private String safeText(String value) {
        return value == null ? "" : value.trim();
    }
}
