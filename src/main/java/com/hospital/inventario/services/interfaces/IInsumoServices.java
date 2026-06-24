package com.hospital.inventario.services.interfaces;

import com.hospital.inventario.beans.InsumoBean;

import java.util.List;

public interface IInsumoServices {
    List<InsumoBean> getInsumos();
    boolean registrarInsumo(InsumoBean bean);
    boolean actualizarStock(int idInsumo, int cantidad);
    InsumoBean consultarInsumo(int idInsumo);
}
