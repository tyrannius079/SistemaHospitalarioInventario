package com.hospital.inventario.services.interfaces;

import com.hospital.inventario.beans.UsuarioBean;
import java.util.List;

public interface IUsuarioServices {
    List<UsuarioBean> getUsuarios();
    UsuarioBean validarLogin(String dni, String password);
}
