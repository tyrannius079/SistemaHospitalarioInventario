package com.hospital.inventario.servlets;

import com.hospital.inventario.beans.ProformaBean;
import com.hospital.inventario.beans.DetalleProformaBean;
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
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

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
        } else if ("detalles_json".equals(action)) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            try (PrintWriter out = response.getWriter()) {
                String idProformaStr = request.getParameter("idProforma");
                if (idProformaStr != null && !idProformaStr.isEmpty()) {
                    int idProforma = Integer.parseInt(idProformaStr);
                    List<DetalleProformaBean> detalles = proformaServices.obtenerDetallesPorProforma(idProforma);
                    
                    StringBuilder json = new StringBuilder("[");
                    for (int i = 0; i < detalles.size(); i++) {
                        DetalleProformaBean det = detalles.get(i);
                        json.append(String.format("{\"idInsumo\":%d, \"nombreInsumo\":\"%s\", \"codigoInsumo\":\"%s\", \"cantidad\":%d, \"precioUnitario\":%.2f}",
                                det.getIdInsumo(), det.getNombreInsumo(), det.getCodigoInsumo(), det.getCantidad(), det.getPrecioUnitario()));
                        if (i < detalles.size() - 1) json.append(",");
                    }
                    json.append("]");
                    out.print(json.toString());
                } else {
                    out.print("[]");
                }
            }
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
            
            // Extract details
            String[] idInsumos = request.getParameterValues("idInsumo[]");
            String[] cantidades = request.getParameterValues("cantidad[]");
            String[] precios = request.getParameterValues("precioUnitario[]");
            
            List<DetalleProformaBean> detalles = new ArrayList<>();
            if (idInsumos != null && cantidades != null && precios != null) {
                for (int i = 0; i < idInsumos.length; i++) {
                    if (idInsumos[i] == null || idInsumos[i].isEmpty()) continue;
                    
                    DetalleProformaBean det = new DetalleProformaBean();
                    det.setIdInsumo(Integer.parseInt(idInsumos[i]));
                    det.setCantidad(Integer.parseInt(cantidades[i]));
                    det.setPrecioUnitario(Double.parseDouble(precios[i]));
                    det.setSubtotal(det.getCantidad() * det.getPrecioUnitario());
                    detalles.add(det);
                }
            }
            bean.setDetalles(detalles);
            
            if (proformaServices.registrarProforma(bean)) {
                request.setAttribute("message", "La proforma del proveedor ha sido registrada correctamente.");
                request.getRequestDispatcher("/confirmacion.jsp").forward(request, response);
                return;
            } else {
                request.setAttribute("error", "Ocurrió un error al registrar la proforma.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Datos de formulario inválidos.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }
    }
}
