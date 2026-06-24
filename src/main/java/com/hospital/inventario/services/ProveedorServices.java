package com.hospital.inventario.services;

import com.hospital.inventario.beans.ProveedorBean;
import com.hospital.inventario.dao.ProveedorDAO;
import com.hospital.inventario.services.interfaces.IProveedorServices;

import java.util.List;

public class ProveedorServices implements IProveedorServices {
    private final ProveedorDAO proveedorDAO = new ProveedorDAO();

    @Override
    public List<ProveedorBean> getProveedores() {
        return proveedorDAO.getProveedores();
    }

    @Override
    public boolean registrarProveedor(ProveedorBean bean) {
        return proveedorDAO.registrarProveedor(bean);
    }

    @Override
    public ProveedorBean consultarProveedor(int idProveedor) {
        return proveedorDAO.consultarProveedor(idProveedor);
    }
}
