package com.hospital.inventario.services.interfaces;

import com.hospital.inventario.beans.ProveedorBean;

import java.util.List;

public interface IProveedorServices {
    List<ProveedorBean> getProveedores();
    boolean registrarProveedor(ProveedorBean bean);
    ProveedorBean consultarProveedor(int idProveedor);
}
