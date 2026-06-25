package com.hospital.inventario.servlets;

import com.hospital.inventario.beans.InsumoBean;
import com.hospital.inventario.beans.LoteBean;
import com.hospital.inventario.beans.MovimientoInventarioBean;
import com.hospital.inventario.beans.OrdenCompraBean;
import com.hospital.inventario.services.InsumoServices;
import com.hospital.inventario.services.LoteServices;
import com.hospital.inventario.services.MovimientoInventarioServices;
import com.hospital.inventario.services.OrdenCompraServices;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private final OrdenCompraServices ordenCompraServices = new OrdenCompraServices();
    private final MovimientoInventarioServices movServices = new MovimientoInventarioServices();
    private final InsumoServices insumoServices = new InsumoServices();
    private final LoteServices loteServices = new LoteServices();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. KPIs
        List<OrdenCompraBean> ordenes = ordenCompraServices.getOrdenes();
        long totalOrdenesPendientes = ordenes.stream()
                .filter(o -> "EMITIDA".equalsIgnoreCase(o.getNombreEstado()) || "PENDIENTE".equalsIgnoreCase(o.getNombreEstado()))
                .count();

        List<MovimientoInventarioBean> movs = movServices.getMovimientos();
        LocalDate hoy = LocalDate.now();
        long entradasHoy = movs.stream()
                .filter(m -> "ENTRADA".equalsIgnoreCase(m.getTipoMovimiento()))
                .filter(m -> {
                    LocalDate fechaMov = m.getFechaMovimiento().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
                    return fechaMov.equals(hoy);
                })
                .count();

        List<InsumoBean> insumos = insumoServices.getInsumos();
        List<InsumoBean> insumosCriticos = insumos.stream()
                .filter(i -> i.getStockActual() <= i.getStockMinimo())
                .collect(Collectors.toList());
        long stockCritico = insumosCriticos.size();

        List<LoteBean> lotesVencimiento = loteServices.verificarVencimientos();
        long proximosVencer = lotesVencimiento.size();

        request.setAttribute("totalOrdenesPendientes", totalOrdenesPendientes);
        request.setAttribute("entradasHoy", entradasHoy);
        request.setAttribute("stockCritico", stockCritico);
        request.setAttribute("proximosVencer", proximosVencer);

        // 2. Alertas Recientes (Mezcla de top críticos y vencimientos para la vista)
        // Usamos insumosCriticos y lotesVencimiento
        request.setAttribute("alertasInsumos", insumosCriticos.stream().limit(5).collect(Collectors.toList()));
        request.setAttribute("alertasLotes", lotesVencimiento.stream().limit(5).collect(Collectors.toList()));

        // 3. Gráfico de Movimientos (Últimos 7 días)
        // Para simplificar el Chart.js, pasamos un string en formato JS array: "[45, 60, ...]"
        int[] entradasArray = new int[7];
        int[] salidasArray = new int[7];
        
        for (int i = 6; i >= 0; i--) {
            LocalDate dia = hoy.minusDays(i);
            int idx = 6 - i;
            
            entradasArray[idx] = (int) movs.stream()
                .filter(m -> "ENTRADA".equalsIgnoreCase(m.getTipoMovimiento()))
                .filter(m -> m.getFechaMovimiento().toInstant().atZone(ZoneId.systemDefault()).toLocalDate().equals(dia))
                .count();
                
            salidasArray[idx] = (int) movs.stream()
                .filter(m -> "SALIDA".equalsIgnoreCase(m.getTipoMovimiento()) || "AJUSTE".equalsIgnoreCase(m.getTipoMovimiento()))
                .filter(m -> m.getFechaMovimiento().toInstant().atZone(ZoneId.systemDefault()).toLocalDate().equals(dia))
                .count();
        }
        
        String arrEntradas = arrayToString(entradasArray);
        String arrSalidas = arrayToString(salidasArray);
        
        request.setAttribute("arrayEntradasChart", arrEntradas);
        request.setAttribute("arraySalidasChart", arrSalidas);

        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
    
    private String arrayToString(int[] arr) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < arr.length; i++) {
            sb.append(arr[i]);
            if (i < arr.length - 1) sb.append(", ");
        }
        sb.append("]");
        return sb.toString();
    }
}
