package com.hospital.inventario.services;

import com.hospital.inventario.beans.ProformaBean;
import com.hospital.inventario.dao.ProformaDAO;
import com.hospital.inventario.services.interfaces.IProformaServices;

import java.util.List;

public class ProformaServices implements IProformaServices {
    private final ProformaDAO proformaDAO = new ProformaDAO();

    @Override
    public List<ProformaBean> getProformas() {
        return proformaDAO.getProformas();
    }

    @Override
    public boolean registrarProforma(ProformaBean bean) {
        return proformaDAO.registrarProforma(bean);
    }

    @Override
    public List<ProformaBean> compararProformas(int idSolicitud) {
        return proformaDAO.compararProformas(idSolicitud);
    }
}
