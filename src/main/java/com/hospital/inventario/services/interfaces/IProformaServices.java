package com.hospital.inventario.services.interfaces;

import com.hospital.inventario.beans.ProformaBean;

import java.util.List;

public interface IProformaServices {
    List<ProformaBean> getProformas();
    boolean registrarProforma(ProformaBean bean);
    List<ProformaBean> compararProformas(int idSolicitud);
}
