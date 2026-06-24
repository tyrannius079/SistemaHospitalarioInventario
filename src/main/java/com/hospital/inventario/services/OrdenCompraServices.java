package com.hospital.inventario.services;

import com.hospital.inventario.beans.DetalleOrdenCompraBean;
import com.hospital.inventario.beans.OrdenCompraBean;
import com.hospital.inventario.beans.PresupuestoBean;
import com.hospital.inventario.dao.OrdenCompraDAO;
import com.hospital.inventario.dao.PresupuestoDAO;
import com.hospital.inventario.dao.ProveedorDAO;
import com.hospital.inventario.services.interfaces.IOrdenCompraServices;
import com.hospital.inventario.util.ConexionBD;

import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

public class OrdenCompraServices implements IOrdenCompraServices {
    private final OrdenCompraDAO ordenCompraDAO;
    private final ProveedorDAO proveedorDAO;
    private final PresupuestoDAO presupuestoDAO;

    public OrdenCompraServices() {
        this.ordenCompraDAO = new OrdenCompraDAO();
        this.proveedorDAO = new ProveedorDAO();
        this.presupuestoDAO = new PresupuestoDAO();
    }

    public OrdenCompraServices(OrdenCompraDAO ordenCompraDAO, ProveedorDAO proveedorDAO, PresupuestoDAO presupuestoDAO) {
        this.ordenCompraDAO = ordenCompraDAO;
        this.proveedorDAO = proveedorDAO;
        this.presupuestoDAO = presupuestoDAO;
    }

    @Override
    public List<OrdenCompraBean> getOrdenes() {
        return ordenCompraDAO.getOrdenes();
    }

    @Override
    public boolean registrarOrden(OrdenCompraBean bean) {
        if (bean == null || bean.getDetalles() == null || bean.getDetalles().isEmpty()) {
            return false;
        }
        if (!proveedorDAO.existeProveedor(bean.getIdProveedor())) {
            return false;
        }

        double total = 0.0;
        for (DetalleOrdenCompraBean detalle : bean.getDetalles()) {
            if (detalle.getCantidad() <= 0 || detalle.getPrecioUnitario() <= 0) {
                return false;
            }
            double subtotal = detalle.getCantidad() * detalle.getPrecioUnitario();
            detalle.setSubtotal(subtotal);
            total += subtotal;
        }
        bean.setTotal(total);

        if (bean.getFechaEmision() == null) {
            bean.setFechaEmision(new Date(System.currentTimeMillis()));
        }
        if (bean.getEstado() == null || bean.getEstado().isEmpty()) {
            bean.setEstado("EMITIDA");
        }

        try (Connection conn = ConexionBD.getConnection()) {
            conn.setAutoCommit(false);
            try {
                PresupuestoBean presupuesto = presupuestoDAO.consultarPresupuesto(conn, bean.getIdPresupuesto());
                if (presupuesto == null || presupuesto.getMontoDisponible() < total) {
                    conn.rollback();
                    return false;
                }

                int idOrden = ordenCompraDAO.registrarOrden(bean, conn);
                if (idOrden <= 0) {
                    conn.rollback();
                    return false;
                }

                boolean detallesOk = ordenCompraDAO.registrarDetalles(idOrden, bean.getDetalles(), conn);
                if (!detallesOk) {
                    conn.rollback();
                    return false;
                }

                double nuevoDisponible = presupuesto.getMontoDisponible() - total;
                if (!presupuestoDAO.actualizarDisponible(conn, bean.getIdPresupuesto(), nuevoDisponible)) {
                    conn.rollback();
                    return false;
                }

                conn.commit();
                bean.setIdOrdenCompra(idOrden);
                return true;
            } catch (Exception e) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    // Ignore rollback errors
                }
                return false;
            }
        } catch (SQLException e) {
            return false;
        }
    }

    @Override
    public boolean modificarOrden(OrdenCompraBean bean) {
        return ordenCompraDAO.modificarOrden(bean);
    }

    @Override
    public OrdenCompraBean consultarOrden(int idOrdenCompra) {
        return ordenCompraDAO.consultarOrden(idOrdenCompra);
    }

    public boolean existeOrdenCompra(int idOrdenCompra) {
        return ordenCompraDAO.existeOrdenCompra(idOrdenCompra);
    }
}
