USE hospitaldb;

-- 1. Usuarios
INSERT INTO TB_Usuario (dni, nombre, correo, password, rol, estado) VALUES
('71234567', 'Juan Pérez', 'jperez@hospital.gob.pe', '123456', 'ADMINISTRADOR', 'ACTIVO'),
('40556677', 'María Ramos', 'mramos@hospital.gob.pe', '123456', 'JEFE DE ALMACÉN', 'ACTIVO');

-- 2. Categorias (para poder insertar insumos)
INSERT INTO TB_Categoria (nombre, descripcion) VALUES
('Medicamentos Generales', 'Uso común y general'),
('Antibióticos', 'Tratamiento de infecciones bacterianas');

-- 3. Insumos
INSERT INTO TB_Insumo (codigo, idCategoria, nombre, descripcion, unidadMedida, stockMinimo, stockActual, estado) VALUES
('INS-0001', 1, 'Paracetamol 500mg', 'Tabletas', 'Caja x 100', 50, 120, 'ACTIVO'),
('INS-0002', 2, 'Amoxicilina 250mg', 'Cápsulas', 'Caja x 50', 20, 5, 'ACTIVO'),
('INS-0005', 1, 'Suero Fisiológico 1L', 'Bolsa', 'Unidad', 10, 45, 'ACTIVO');

-- 4. Proveedores
INSERT INTO TB_Proveedor (ruc, razonSocial, contacto, telefono, correo, direccion, estado) VALUES
('20123456789', 'Distribuidora Médica S.A.C.', 'Carlos Ruiz', '999888777', 'ventas@medicaperu.com', 'Av. La Marina 123', 'ACTIVO'),
('20987654321', 'Insumos Hospitalarios Perú', 'Ana Soto', '999111222', 'contacto@ihp.com.pe', 'Av. Arequipa 456', 'ACTIVO');

-- 5. Proformas
INSERT INTO TB_Proforma (idProveedor, montoTotal, fechaRecepcion, estado) VALUES
(1, 58.50, CURDATE(), 'PENDIENTE'),
(1, 1500.00, CURDATE(), 'PENDIENTE');

-- 6. Presupuestos
INSERT INTO TB_Presupuesto (periodo, montoTotal, montoDisponible, estado) VALUES
('2026-1', 500000.00, 150000.00, 'ACTIVO'),
('2026-2', 800000.00, 780000.00, 'ACTIVO');

-- 7. Lotes (Alertas Vencimiento)
INSERT INTO TB_Lote (idInsumo, numeroLote, fechaVencimiento, cantidadInicial, cantidadActual, estado) VALUES
(3, 'L-998822', DATE_ADD(CURDATE(), INTERVAL 20 DAY), 100, 45, 'ACTIVO');
