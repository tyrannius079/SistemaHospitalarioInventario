-- ==========================================================
-- SCRIPT DE POBLACIÓN INICIAL (DATA DE PRUEBA) - SIGINV PRO
-- ADAPTADO A: 001_schema.sql
-- ==========================================================
USE hospitaldb;

-- Limpiar tablas por seguridad (si se re-ejecuta)
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE TB_MovimientoInventario;
TRUNCATE TABLE TB_DetalleOrdenCompra;
TRUNCATE TABLE TB_OrdenCompra;
TRUNCATE TABLE TB_Lote;
TRUNCATE TABLE TB_Insumo;
TRUNCATE TABLE TB_Presupuesto;
TRUNCATE TABLE TB_Proforma;
TRUNCATE TABLE TB_SolicitudCompra;
TRUNCATE TABLE TB_Proveedor;
TRUNCATE TABLE TB_Categoria;
TRUNCATE TABLE TB_Usuario;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. USUARIOS
INSERT INTO TB_Usuario (dni, nombres, apellidos, email, password, rol, estado) VALUES
('71234567', 'Juan', 'Pérez', 'jperez@hospital.gob.pe', '123456', 'ADMINISTRADOR', 'A'),
('40556677', 'María', 'Ramos', 'mramos@hospital.gob.pe', '123456', 'JEFE DE ALMACÉN', 'A'),
('45612378', 'Carlos', 'Gómez', 'cgomez@hospital.gob.pe', '123456', 'TÉCNICO', 'A');

-- 2. CATEGORÍAS
INSERT INTO TB_Categoria (nombre, descripcion, estado) VALUES
('Fármacos y medicinas', 'Medicamentos de uso común', 'A'),
('Material Médico', 'Jeringas, gasas, guantes, etc.', 'A');

-- 3. PROVEEDORES
INSERT INTO TB_Proveedor (razonSocial, ruc, direccion, telefono, email, estado) VALUES
('Distribuidora Médica S.A.C.', '20541236589', 'Av. La Marina 123', '987654321', 'ventas@distmedic.pe', 'A'),
('Insumos Hospitalarios Perú', '20456123789', 'Calle 2 Mz F', '912345678', 'contacto@ihp.pe', 'A');

-- 4. INSUMOS 
-- Asumiendo que idCategoria 1 = Fármacos y 2 = Material Médico
INSERT INTO TB_Insumo (codigo, nombre, descripcion, unidadMedida, stockActual, stockMinimo, precioUnitario, idCategoria, estado) VALUES
('INS-0001', 'Paracetamol 500mg', 'Medicamentos Generales', 'Caja x 100', 120, 50, 15.50, 1, 'A'),
('INS-0002', 'Amoxicilina 250mg', 'Antibióticos', 'Caja x 50', 5, 20, 25.00, 1, 'A'),
('INS-0005', 'Suero Fisiológico 1L', 'Soluciones Intravenosas', 'Unidad', 45, 100, 5.00, 2, 'A');

-- 5. PRESUPUESTOS
INSERT INTO TB_Presupuesto (periodo, montoTotal, montoDisponible, estado) VALUES
('2026-1', 500000.00, 150000.00, 'A'),
('2026-2', 800000.00, 780000.00, 'A');

-- Dependencias DUMMY requeridas para OrdenCompra
-- 6. SOLICITUD DE COMPRA
INSERT INTO TB_SolicitudCompra (idUsuario, fechaSolicitud, urgencia, motivo, estado) VALUES
(2, CURDATE(), 'NORMAL', 'Reabastecimiento de rutina', 'APROBADA'),
(2, CURDATE(), 'ALTA', 'Stock crítico en UCI', 'APROBADA');

-- 7. PROFORMA
INSERT INTO TB_Proforma (idProveedor, fechaEmision, montoTotal, tiempoEntregaDias, estado) VALUES
(1, CURDATE(), 12500.00, 5, 'VIGENTE'),
(2, CURDATE(), 13950.00, 2, 'VIGENTE');

-- 8. ÓRDENES DE COMPRA 
-- Requiere idSolicitud (1, 2) e idProforma (1, 2)
INSERT INTO TB_OrdenCompra (idSolicitud, idProforma, idProveedor, idUsuario, idPresupuesto, fechaEmision, total, estado, observaciones) VALUES
(1, 1, 2, 1, 1, '2026-06-20', 12500.00, 'RECEPCIONADA', 'OC-2026-0014 (Ref)'),
(2, 2, 1, 2, 1, '2026-06-24', 13950.00, 'EMITIDA', 'OC-2026-0015 (Ref)');

-- 9. LOTES SANITARIOS (Para el panel de alertas de vencimiento)
-- Asumiendo idInsumo 3 = Suero (INS-0005)
INSERT INTO TB_Lote (numeroLote, idInsumo, fechaIngreso, fechaVencimiento, cantidadInicial, cantidadActual, estado) VALUES
('L-998822', 3, '2025-06-01', DATE_ADD(CURDATE(), INTERVAL 25 DAY), 500, 45, 'A');

-- 10. DETALLE DE ORDENES DE COMPRA
-- Orden 1 (id 1): Paracetamol (1)
INSERT INTO TB_DetalleOrdenCompra (idOrdenCompra, idInsumo, cantidad, precioUnitario, subtotal) VALUES
(1, 1, 500, 15.50, 7750.00),
(1, 3, 200, 5.00, 1000.00);

-- 11. MOVIMIENTOS DE INVENTARIO
-- Simulamos Entradas y Salidas recientes
INSERT INTO TB_MovimientoInventario (idInsumo, idLote, idOrdenCompra, idUsuario, fechaMovimiento, tipoMovimiento, cantidad, observaciones) VALUES
(1, NULL, 1, 1, DATE_SUB(NOW(), INTERVAL 2 DAY), 'ENTRADA', 100, 'Recepción de OC parcial'),
(2, NULL, NULL, 2, DATE_SUB(NOW(), INTERVAL 1 DAY), 'SALIDA', 50, 'Destino: Emergencia - Pacientes febriles'),
(3, 1, NULL, 2, NOW(), 'AJUSTE', -5, 'Merma por frasco roto');
