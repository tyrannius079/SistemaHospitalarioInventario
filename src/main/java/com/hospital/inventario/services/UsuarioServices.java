package com.hospital.inventario.services;

import com.hospital.inventario.beans.UsuarioBean;
import com.hospital.inventario.dao.UsuarioDAO;
import com.hospital.inventario.services.interfaces.IUsuarioServices;

import java.util.List;

public class UsuarioServices implements IUsuarioServices {
    private final UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    public List<UsuarioBean> getUsuarios() {
        return usuarioDAO.getUsuarios();
    }

    @Override
    public UsuarioBean validarLogin(String dni, String password) {
        return usuarioDAO.validarLogin(dni, password);
    }
}
