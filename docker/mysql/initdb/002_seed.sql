USE hospitaldb;

INSERT INTO TB_Usuario (dni, nombres, apellidos, email, password, rol, estado)
VALUES
  ('12345678', 'Juan', 'Perez', 'juan.perez@hospital.local', '123456', 'JEFE_COMPRA', 'A'),
  ('87654321', 'Maria', 'Lopez', 'maria.lopez@hospital.local', '123456', 'TECNICO_ALMACEN', 'A'),
  ('99999999', 'Admin', 'Sistema', 'admin@hospital.local', 'admin123', 'ADMIN', 'A');

INSERT INTO TB_Proveedor (razonSocial, ruc, direccion, telefono, email, estado)
VALUES
  ('Proveedor Central SAC', '20123456789', 'Av Principal 123', '999888777', 'contacto@proveedor.local', 'A');

INSERT INTO TB_Categoria (nombre, descripcion, estado)
VALUES
  ('Materiales', 'Material medico general', 'A'),
  ('Proteccion', 'Insumos de proteccion', 'A');

INSERT INTO TB_Insumo (codigo, nombre, descripcion, unidadMedida, stockActual, stockMinimo, precioUnitario, idCategoria, estado)
VALUES
  ('INS-001', 'Guantes', 'Guantes de latex', 'Caja', 10, 5, 12.50, 1, 'A'),
  ('INS-002', 'Mascarillas', 'Mascarillas quirurgicas', 'Caja', 20, 10, 20.00, 2, 'A');

INSERT INTO TB_Presupuesto (periodo, montoTotal, montoDisponible, estado)
VALUES
  ('2026-1', 50000.00, 50000.00, 'A');

INSERT INTO TB_SolicitudCompra (idUsuario, fechaSolicitud, urgencia, motivo, estado)
VALUES
  (1, '2026-05-20', 'ALTA', 'Reabastecimiento', 'APROBADA');

INSERT INTO TB_Proforma (idProveedor, fechaEmision, montoTotal, tiempoEntregaDias, estado)
VALUES
  (1, '2026-05-20', 1000.00, 5, 'VIGENTE');

INSERT INTO TB_OrdenCompra (idSolicitud, idProforma, idProveedor, idUsuario, idPresupuesto, fechaEmision, total, estado, observaciones)
VALUES
  (1, 1, 1, 1, 1, '2026-05-20', 102.50, 'EMITIDA', 'Orden inicial');

INSERT INTO TB_DetalleOrdenCompra (idOrdenCompra, idInsumo, cantidad, precioUnitario, subtotal)
VALUES
  (1, 1, 5, 12.50, 62.50),
  (1, 2, 2, 20.00, 40.00);
