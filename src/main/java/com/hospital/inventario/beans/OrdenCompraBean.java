package com.hospital.inventario.beans;

import java.sql.Date;
import java.util.List;

public class OrdenCompraBean {
    private int idOrdenCompra;
    private int idSolicitud;
    private int idProforma;
    private int idProveedor;
    private int idUsuario;
    private int idPresupuesto;
    private Date fechaEmision;
    private double total;
    private int idEstado;
    private String nombreEstado;
    private String observaciones;
    private List<DetalleOrdenCompraBean> detalles;

    public OrdenCompraBean() {
    }

    public OrdenCompraBean(int idOrdenCompra, int idSolicitud, int idProforma, int idProveedor,
                           int idUsuario, int idPresupuesto, Date fechaEmision, double total,
                           String observaciones) {
        this.idOrdenCompra = idOrdenCompra;
        this.idSolicitud = idSolicitud;
        this.idProforma = idProforma;
        this.idProveedor = idProveedor;
        this.idUsuario = idUsuario;
        this.idPresupuesto = idPresupuesto;
        this.fechaEmision = fechaEmision;
        this.total = total;
        this.observaciones = observaciones;
    }

    public int getIdOrdenCompra() {
        return idOrdenCompra;
    }

    public void setIdOrdenCompra(int idOrdenCompra) {
        this.idOrdenCompra = idOrdenCompra;
    }

    public int getIdSolicitud() {
        return idSolicitud;
    }

    public void setIdSolicitud(int idSolicitud) {
        this.idSolicitud = idSolicitud;
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

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public int getIdPresupuesto() {
        return idPresupuesto;
    }

    public void setIdPresupuesto(int idPresupuesto) {
        this.idPresupuesto = idPresupuesto;
    }

    public Date getFechaEmision() {
        return fechaEmision;
    }

    public void setFechaEmision(Date fechaEmision) {
        this.fechaEmision = fechaEmision;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
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

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public List<DetalleOrdenCompraBean> getDetalles() {
        return detalles;
    }

    public void setDetalles(List<DetalleOrdenCompraBean> detalles) {
        this.detalles = detalles;
    }
}
