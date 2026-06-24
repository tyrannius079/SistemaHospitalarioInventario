package com.hospital.inventario.beans;

import java.sql.Timestamp;

public class MovimientoInventarioBean {
    private int idMovimiento;
    private int idInsumo;
    private Integer idLote;
    private Integer idOrdenCompra;
    private int idUsuario;
    private Timestamp fechaMovimiento;
    private String tipoMovimiento;
    private int cantidad;
    private String observaciones;

    public MovimientoInventarioBean() {
    }

    public MovimientoInventarioBean(int idMovimiento, int idInsumo, Integer idLote,
                                    Integer idOrdenCompra, int idUsuario, Timestamp fechaMovimiento,
                                    String tipoMovimiento, int cantidad, String observaciones) {
        this.idMovimiento = idMovimiento;
        this.idInsumo = idInsumo;
        this.idLote = idLote;
        this.idOrdenCompra = idOrdenCompra;
        this.idUsuario = idUsuario;
        this.fechaMovimiento = fechaMovimiento;
        this.tipoMovimiento = tipoMovimiento;
        this.cantidad = cantidad;
        this.observaciones = observaciones;
    }

    public int getIdMovimiento() {
        return idMovimiento;
    }

    public void setIdMovimiento(int idMovimiento) {
        this.idMovimiento = idMovimiento;
    }

    public int getIdInsumo() {
        return idInsumo;
    }

    public void setIdInsumo(int idInsumo) {
        this.idInsumo = idInsumo;
    }

    public Integer getIdLote() {
        return idLote;
    }

    public void setIdLote(Integer idLote) {
        this.idLote = idLote;
    }

    public Integer getIdOrdenCompra() {
        return idOrdenCompra;
    }

    public void setIdOrdenCompra(Integer idOrdenCompra) {
        this.idOrdenCompra = idOrdenCompra;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public Timestamp getFechaMovimiento() {
        return fechaMovimiento;
    }

    public void setFechaMovimiento(Timestamp fechaMovimiento) {
        this.fechaMovimiento = fechaMovimiento;
    }

    public String getTipoMovimiento() {
        return tipoMovimiento;
    }

    public void setTipoMovimiento(String tipoMovimiento) {
        this.tipoMovimiento = tipoMovimiento;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }
}
