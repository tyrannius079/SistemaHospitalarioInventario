package com.hospital.inventario.servlets;

import com.hospital.inventario.beans.InsumoBean;
import com.hospital.inventario.beans.LoteBean;
import com.hospital.inventario.services.InsumoServices;
import com.hospital.inventario.services.LoteServices;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/alertas")
public class AlertasServlet extends HttpServlet {
    private final InsumoServices insumoServices = new InsumoServices();
    private final LoteServices loteServices = new LoteServices();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Obtener insumos en alerta de stock
        List<InsumoBean> insumos = insumoServices.getInsumos();
        List<InsumoBean> alertasStock = insumos.stream()
                .filter(insumo -> insumo.getStockActual() <= insumo.getStockMinimo())
                .collect(Collectors.toList());

        // 2. Obtener lotes por vencer (<= 30 días) o ya vencidos
        List<LoteBean> alertasVencimiento = loteServices.verificarVencimientos();

        request.setAttribute("alertasStock", alertasStock);
        request.setAttribute("alertasVencimiento", alertasVencimiento);

        request.getRequestDispatcher("/ConsultarAlertas.jsp").forward(request, response);
    }
}
