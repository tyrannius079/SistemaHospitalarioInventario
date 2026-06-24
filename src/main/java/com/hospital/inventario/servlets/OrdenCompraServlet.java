package com.hospital.inventario.servlets;

import com.hospital.inventario.beans.DetalleOrdenCompraBean;
import com.hospital.inventario.beans.OrdenCompraBean;
import com.hospital.inventario.services.OrdenCompraServices;
import com.hospital.inventario.services.ProveedorServices;
import com.hospital.inventario.services.ProformaServices;
import com.hospital.inventario.services.InsumoServices;
import com.hospital.inventario.services.PresupuestoServices;
import com.hospital.inventario.services.UsuarioServices;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/orden-compra")
public class OrdenCompraServlet extends HttpServlet {
    private final OrdenCompraServices ordenCompraServices = new OrdenCompraServices();

    private final ProveedorServices proveedorServices = new ProveedorServices();
    private final ProformaServices proformaServices = new ProformaServices();
    private final InsumoServices insumoServices = new InsumoServices();
    private final PresupuestoServices presupuestoServices = new PresupuestoServices();
    private final UsuarioServices usuarioServices = new UsuarioServices();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("listar".equals(action)) {
            request.setAttribute("ordenes", ordenCompraServices.getOrdenes());
            request.getRequestDispatcher("/ConsultarOrdenes.jsp").forward(request, response);
        } else {
            request.setAttribute("proveedores", proveedorServices.getProveedores());
            request.setAttribute("proformas", proformaServices.getProformas());
            request.setAttribute("insumos", insumoServices.getInsumos());
            request.setAttribute("presupuestos", presupuestoServices.getPresupuestos());
            request.setAttribute("usuarios", usuarioServices.getUsuarios());
            request.getRequestDispatcher("/RegistrarOrdenCompra.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if ("actualizar".equals(action)) {
            int idOrdenCompra = parseInt(request.getParameter("idOrdenCompra"));
            String estado = safeText(request.getParameter("estado"));
            
            OrdenCompraBean bean = new OrdenCompraBean();
            bean.setIdOrdenCompra(idOrdenCompra);
            bean.setEstado(estado);
            bean.setObservaciones("Estado actualizado a " + estado);
            
            boolean ok = ordenCompraServices.modificarOrden(bean);
            if (ok) {
                response.sendRedirect(request.getContextPath() + "/orden-compra?action=listar");
            } else {
                request.setAttribute("error", "No se pudo actualizar el estado de la orden.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            }
            return;
        }

        OrdenCompraBean bean = new OrdenCompraBean();
        bean.setIdSolicitud(parseInt(request.getParameter("idSolicitud")));
        bean.setIdProforma(parseInt(request.getParameter("idProforma")));
        bean.setIdProveedor(parseInt(request.getParameter("idProveedor")));
        bean.setIdUsuario(parseInt(request.getParameter("idUsuario")));
        bean.setIdPresupuesto(parseInt(request.getParameter("idPresupuesto")));
        bean.setFechaEmision(parseDate(request.getParameter("fechaEmision")));
        bean.setEstado(safeText(request.getParameter("estado")));
        bean.setObservaciones(safeText(request.getParameter("observaciones")));

        List<DetalleOrdenCompraBean> detalles = buildDetalles(request);
        bean.setDetalles(detalles);

        if (detalles.isEmpty()) {
            request.setAttribute("error", "Debe registrar al menos un detalle valido.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        boolean ok = ordenCompraServices.registrarOrden(bean);
        if (ok) {
            request.setAttribute("message", "Orden registrada con ID: " + bean.getIdOrdenCompra());
            request.getRequestDispatcher("/confirmacion.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "No se pudo registrar la orden.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private List<DetalleOrdenCompraBean> buildDetalles(HttpServletRequest request) {
        List<DetalleOrdenCompraBean> detalles = new ArrayList<>();
        String[] idInsumoArr = request.getParameterValues("idInsumo");
        String[] cantidadArr = request.getParameterValues("cantidad");
        String[] precioArr = request.getParameterValues("precioUnitario");

        if (idInsumoArr == null || cantidadArr == null || precioArr == null) {
            return detalles;
        }

        int length = Math.min(idInsumoArr.length, Math.min(cantidadArr.length, precioArr.length));
        for (int i = 0; i < length; i++) {
            int idInsumo = parseInt(idInsumoArr[i]);
            int cantidad = parseInt(cantidadArr[i]);
            double precioUnitario = parseDouble(precioArr[i]);
            if (idInsumo <= 0 || cantidad <= 0 || precioUnitario <= 0) {
                continue;
            }
            DetalleOrdenCompraBean detalle = new DetalleOrdenCompraBean();
            detalle.setIdInsumo(idInsumo);
            detalle.setCantidad(cantidad);
            detalle.setPrecioUnitario(precioUnitario);
            detalles.add(detalle);
        }
        return detalles;
    }

    private int parseInt(String value) {
        try {
            return Integer.parseInt(value);
        } catch (Exception e) {
            return 0;
        }
    }

    private double parseDouble(String value) {
        try {
            return Double.parseDouble(value);
        } catch (Exception e) {
            return 0.0;
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
