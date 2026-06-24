package com.hospital.inventario.beans;

import java.sql.Date;

public class ProformaBean {
    private int idProforma;
    private int idProveedor;
    private Date fechaEmision;
    private double montoTotal;
    private int tiempoEntregaDias;
    private String estado;

    public ProformaBean() {
    }

    public ProformaBean(int idProforma, int idProveedor, Date fechaEmision, double montoTotal,
                        int tiempoEntregaDias, String estado) {
        this.idProforma = idProforma;
        this.idProveedor = idProveedor;
        this.fechaEmision = fechaEmision;
        this.montoTotal = montoTotal;
        this.tiempoEntregaDias = tiempoEntregaDias;
        this.estado = estado;
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

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
}
