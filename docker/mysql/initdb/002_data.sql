-- ==========================================================
-- SCRIPT DE POBLACIÓN INICIAL (DATA DE PRUEBA) - SIGINV PRO
-- ADAPTADO A: 001_schema.sql
-- ==========================================================
SET NAMES 'utf8mb4';
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
TRUNCATE TABLE TB_Rol;
TRUNCATE TABLE TB_Estado;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. CATÁLOGOS BASE
INSERT INTO TB_Rol (nombre, descripcion, estado) VALUES
('ADMINISTRADOR', 'Control total del sistema', 1),
('JEFE DE ALMACÉN', 'Gestión de inventarios y compras', 1),
('TÉCNICO', 'Operador de inventario', 1);

INSERT INTO TB_Estado (nombre, contexto) VALUES
('PENDIENTE', 'COMPRAS'),
('APROBADA', 'COMPRAS'),
('VIGENTE', 'COMPRAS'),
('EMITIDA', 'COMPRAS'),
('RECEPCIONADA', 'COMPRAS'),
('CANCELADA', 'COMPRAS');

-- 2. USUARIOS
INSERT INTO TB_Usuario (dni, nombres, apellidos, email, password, idRol, estado) VALUES
('71234567', 'Juan', 'Perez', 'jperez@hospital.gob.pe', '123456', 1, 1),
('40556677', 'Maria', 'Ramos', 'mramos@hospital.gob.pe', '123456', 2, 1),
('72345678', 'Maria', 'Gomez', 'mgomez@hospital.gob.pe', '123456', 2, 1);

-- 2. CATEGORIAS
INSERT INTO TB_Categoria (nombre, descripcion, estado) VALUES
('MED', 'Medicamentos', 'Insumos farmaceuticos y medicinas', 1),
('MAT', 'Material Medico', 'Consumibles, gasas, jeringas, etc.', 1),
('EQP', 'Equipos', 'Equipos medicos menores', 1);

-- 3. PROVEEDORES
INSERT INTO TB_Proveedor (ruc, razonSocial, contacto, telefono, email, direccion, estado) VALUES
('20111111111', 'PharmaSalud S.A.C.', 'Luis Miranda', '987654321', 'ventas@pharmasalud.pe', 'Av. La Marina 123', 1),
('20222222222', 'Medicos Global EIRL', 'Andrea Suaste', '912345678', 'ventas@medicglobal.pe', 'Av. Brasil 456', 1);

-- 4. INSUMOS 
-- Asumiendo que idCategoria 1 = Farmacos y 2 = Material Medico
INSERT INTO TB_Insumo (codigo, nombre, descripcion, unidadMedida, stockActual, stockMinimo, precioUnitario, idCategoria, estado) VALUES
('INS-002', 'Ibuprofeno 400mg', 'Caja de 100 tabletas', 'CAJA', 150, 50, 18.00, 1, 1),
('INS-003', 'Jeringa 5ml', 'Caja de 50 jeringas descartables', 'CAJA', 200, 100, 15.50, 2, 1);

-- 5. PRESUPUESTOS
INSERT INTO TB_Presupuesto (periodo, montoTotal, montoDisponible, estado) VALUES
('2026-1', 500000.00, 150000.00, 1),
('2026-2', 800000.00, 780000.00, 1);

-- Dependencias DUMMY requeridas para OrdenCompra
-- 6. SOLICITUD DE COMPRA
INSERT INTO TB_SolicitudCompra (idUsuario, fechaSolicitud, urgencia, motivo, idEstado) VALUES
(2, CURDATE(), 'NORMAL', 'Reabastecimiento de rutina', 2),
(2, CURDATE(), 'ALTA', 'Stock crítico en UCI', 2);

-- 7. PROFORMA
INSERT INTO TB_Proforma (idProveedor, fechaEmision, montoTotal, tiempoEntregaDias, idEstado) VALUES
(1, CURDATE(), 12500.00, 5, 3),
(2, CURDATE(), 13950.00, 2, 3);

-- 8. ÓRDENES DE COMPRA 
-- Requiere idSolicitud (1, 2) e idProforma (1, 2)
INSERT INTO TB_OrdenCompra (idSolicitud, idProforma, idProveedor, idUsuario, idPresupuesto, fechaEmision, total, idEstado, observaciones) VALUES
(1, 1, 2, 1, 1, '2026-06-20', 12500.00, 5, 'OC-2026-0014 (Ref)'),
(2, 2, 1, 2, 1, '2026-06-24', 13950.00, 4, 'OC-2026-0015 (Ref)');

-- 9. LOTES SANITARIOS (Para el panel de alertas de vencimiento)
-- Asumiendo idInsumo 3 = Suero (INS-0005)
INSERT INTO TB_Lote (numeroLote, idInsumo, fechaIngreso, fechaVencimiento, cantidadInicial, cantidadActual, estado) VALUES
('L-998822', 3, '2025-06-01', DATE_ADD(CURDATE(), INTERVAL 25 DAY), 500, 45, 1);

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
