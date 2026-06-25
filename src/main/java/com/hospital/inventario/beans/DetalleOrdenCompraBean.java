package com.hospital.inventario.beans;

public class DetalleOrdenCompraBean {
    private int idDetalle;
    private int idOrdenCompra;
    private int idInsumo;
    private int cantidad;
    private double precioUnitario;
    private double subtotal;
    
    // Campos transitorios para UI
    private String nombreInsumo;
    private String codigoInsumo;

    public DetalleOrdenCompraBean() {
    }

    public DetalleOrdenCompraBean(int idDetalle, int idOrdenCompra, int idInsumo, int cantidad,
                                  double precioUnitario, double subtotal) {
        this.idDetalle = idDetalle;
        this.idOrdenCompra = idOrdenCompra;
        this.idInsumo = idInsumo;
        this.cantidad = cantidad;
        this.precioUnitario = precioUnitario;
        this.subtotal = subtotal;
    }

    public int getIdDetalle() {
        return idDetalle;
    }

    public void setIdDetalle(int idDetalle) {
        this.idDetalle = idDetalle;
    }

    public int getIdOrdenCompra() {
        return idOrdenCompra;
    }

    public void setIdOrdenCompra(int idOrdenCompra) {
        this.idOrdenCompra = idOrdenCompra;
    }

    public int getIdInsumo() {
        return idInsumo;
    }

    public void setIdInsumo(int idInsumo) {
        this.idInsumo = idInsumo;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public double getPrecioUnitario() {
        return precioUnitario;
    }

    public void setPrecioUnitario(double precioUnitario) {
        this.precioUnitario = precioUnitario;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }

    public String getNombreInsumo() {
        return nombreInsumo;
    }

    public void setNombreInsumo(String nombreInsumo) {
        this.nombreInsumo = nombreInsumo;
    }

    public String getCodigoInsumo() {
        return codigoInsumo;
    }

    public void setCodigoInsumo(String codigoInsumo) {
        this.codigoInsumo = codigoInsumo;
    }
}
