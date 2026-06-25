package com.hospital.inventario.services;

import com.hospital.inventario.beans.UsuarioBean;
import com.hospital.inventario.dao.UsuarioDAO;
import com.hospital.inventario.services.interfaces.IUsuarioServices;

import java.util.List;

public class UsuarioServices implements IUsuarioServices {
    private final UsuarioDAO usuarioDAO;

    public UsuarioServices() {
        this.usuarioDAO = new UsuarioDAO();
    }

    public UsuarioServices(UsuarioDAO usuarioDAO) {
        this.usuarioDAO = usuarioDAO;
    }

    @Override
    public List<UsuarioBean> getUsuarios() {
        return usuarioDAO.getUsuarios();
    }

    @Override
    public UsuarioBean validarLogin(String dni, String password) {
        return usuarioDAO.validarLogin(dni, password);
    }

    @Override
    public boolean crearUsuario(UsuarioBean bean, String rawPassword) {
        return usuarioDAO.crearUsuario(bean, rawPassword);
    }

    @Override
    public boolean editarUsuario(UsuarioBean bean) {
        return usuarioDAO.editarUsuario(bean);
    }

    @Override
    public boolean desactivarUsuario(String dni) {
        return usuarioDAO.desactivarUsuario(dni);
    }
}
