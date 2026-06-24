package com.hospital.inventario.beans;

import java.sql.Date;

public class SolicitudCompraBean {
    private int idSolicitud;
    private int idUsuario;
    private Date fechaSolicitud;
    private String urgencia;
    private String motivo;
    private String estado;

    public SolicitudCompraBean() {
    }

    public SolicitudCompraBean(int idSolicitud, int idUsuario, Date fechaSolicitud, String urgencia,
                               String motivo, String estado) {
        this.idSolicitud = idSolicitud;
        this.idUsuario = idUsuario;
        this.fechaSolicitud = fechaSolicitud;
        this.urgencia = urgencia;
        this.motivo = motivo;
        this.estado = estado;
    }

    public int getIdSolicitud() {
        return idSolicitud;
    }

    public void setIdSolicitud(int idSolicitud) {
        this.idSolicitud = idSolicitud;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public Date getFechaSolicitud() {
        return fechaSolicitud;
    }

    public void setFechaSolicitud(Date fechaSolicitud) {
        this.fechaSolicitud = fechaSolicitud;
    }

    public String getUrgencia() {
        return urgencia;
    }

    public void setUrgencia(String urgencia) {
        this.urgencia = urgencia;
    }

    public String getMotivo() {
        return motivo;
    }

    public void setMotivo(String motivo) {
        this.motivo = motivo;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
}
