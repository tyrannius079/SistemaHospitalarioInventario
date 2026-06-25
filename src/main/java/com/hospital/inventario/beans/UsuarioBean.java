package com.hospital.inventario.beans;

public class UsuarioBean {
    private int idUsuario;
    private String nombre;
    private int idRol;
    private String nombreRol;
    private String dni;
    private String correo;
    private String estado;

    public UsuarioBean() {
    }

    public UsuarioBean(int idUsuario, String nombre, int idRol, String nombreRol, String dni, String correo, String estado) {
        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.idRol = idRol;
        this.nombreRol = nombreRol;
        this.dni = dni;
        this.correo = correo;
        this.estado = estado;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getIdRol() {
        return idRol;
    }

    public void setIdRol(int idRol) {
        this.idRol = idRol;
    }

    public String getNombreRol() {
        return nombreRol;
    }

    public void setNombreRol(String nombreRol) {
        this.nombreRol = nombreRol;
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
}
