package com.hospital.inventario.services.interfaces;

import com.hospital.inventario.beans.LoteBean;

import java.util.List;

public interface ILoteServices {
    List<LoteBean> getLotes();
    boolean registrarLote(LoteBean bean);
    List<LoteBean> verificarVencimientos();
}
