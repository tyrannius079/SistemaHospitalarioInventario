package com.hospital.inventario.beans;

public class PresupuestoBean {
    private int idPresupuesto;
    private String periodo;
    private double montoTotal;
    private double montoDisponible;
    private String estado;

    public PresupuestoBean() {
    }

    public PresupuestoBean(int idPresupuesto, String periodo, double montoTotal, double montoDisponible,
                           String estado) {
        this.idPresupuesto = idPresupuesto;
        this.periodo = periodo;
        this.montoTotal = montoTotal;
        this.montoDisponible = montoDisponible;
        this.estado = estado;
    }

    public int getIdPresupuesto() {
        return idPresupuesto;
    }

    public void setIdPresupuesto(int idPresupuesto) {
        this.idPresupuesto = idPresupuesto;
    }

    public String getPeriodo() {
        return periodo;
    }

    public void setPeriodo(String periodo) {
        this.periodo = periodo;
    }

    public double getMontoTotal() {
        return montoTotal;
    }

    public void setMontoTotal(double montoTotal) {
        this.montoTotal = montoTotal;
    }

    public double getMontoDisponible() {
        return montoDisponible;
    }

    public void setMontoDisponible(double montoDisponible) {
        this.montoDisponible = montoDisponible;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
}
