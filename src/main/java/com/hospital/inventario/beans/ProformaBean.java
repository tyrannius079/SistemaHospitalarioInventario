package com.hospital.inventario.beans;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class ProformaBean {
    private int idProforma;
    private int idProveedor;
    private Date fechaEmision;
    private double montoTotal;
    private int tiempoEntregaDias;
    private int idEstado;
    private String nombreEstado;
    private String razonSocialProveedor;
    private String resumenInsumos;
    
    private List<DetalleProformaBean> detalles = new ArrayList<>();

    public ProformaBean() {
    }

    public ProformaBean(int idProforma, int idProveedor, Date fechaEmision, double montoTotal,
                        int tiempoEntregaDias, int idEstado) {
        this.idProforma = idProforma;
        this.idProveedor = idProveedor;
        this.fechaEmision = fechaEmision;
        this.montoTotal = montoTotal;
        this.tiempoEntregaDias = tiempoEntregaDias;
        this.idEstado = idEstado;
    }

    public int getIdProforma() {
        return idProforma;
    }

    public void setIdProforma(int idProforma) {
        this.idProforma = idProforma;
    }

    public int getIdProveedor() {
        return idProveedor;
    }

    public void setIdProveedor(int idProveedor) {
        this.idProveedor = idProveedor;
    }

    public Date getFechaEmision() {
        return fechaEmision;
    }

    public void setFechaEmision(Date fechaEmision) {
        this.fechaEmision = fechaEmision;
    }

    public double getMontoTotal() {
        return montoTotal;
    }

    public void setMontoTotal(double montoTotal) {
        this.montoTotal = montoTotal;
    }

    public int getTiempoEntregaDias() {
        return tiempoEntregaDias;
    }

    public void setTiempoEntregaDias(int tiempoEntregaDias) {
        this.tiempoEntregaDias = tiempoEntregaDias;
    }

    public int getIdEstado() {
        return idEstado;
    }

    public void setIdEstado(int idEstado) {
        this.idEstado = idEstado;
    }

    public String getNombreEstado() {
        return nombreEstado;
    }

    public void setNombreEstado(String nombreEstado) {
        this.nombreEstado = nombreEstado;
    }

    public String getRazonSocialProveedor() {
        return razonSocialProveedor;
    }

    public void setRazonSocialProveedor(String razonSocialProveedor) {
        this.razonSocialProveedor = razonSocialProveedor;
    }

    public List<DetalleProformaBean> getDetalles() {
        return detalles;
    }

    public void setDetalles(List<DetalleProformaBean> detalles) {
        this.detalles = detalles;
    }

    public String getResumenInsumos() {
        return resumenInsumos;
    }

    public void setResumenInsumos(String resumenInsumos) {
        this.resumenInsumos = resumenInsumos;
    }

    public String getCodigoFormateado() {
        if (idProforma <= 0) return "Generado Automáticamente";
        return String.format("PROF-2026-%04d", idProforma);
    }
}
