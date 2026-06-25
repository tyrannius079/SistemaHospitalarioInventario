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
('72345678', 'Rosa', 'Gomez', 'rgomez@hospital.gob.pe', '123456', 3, 1),
('45678901', 'Carlos', 'Lopez', 'clopez@hospital.gob.pe', '123456', 3, 1),
('12345678', 'Ana', 'Torres', 'atorres@hospital.gob.pe', '123456', 2, 1);

-- 3. CATEGORIAS (Corregido: 3 columnas, 3 valores por fila)
INSERT INTO TB_Categoria (nombre, descripcion, estado) VALUES
('Medicamentos', 'Insumos farmaceuticos y medicinas', 1),
('Material Medico', 'Consumibles, gasas, jeringas, etc.', 1),
('Equipos', 'Equipos medicos menores', 1),
('Reactivos', 'Reactivos de laboratorio', 1),
('Descartables', 'Materiales de un solo uso', 1);

-- 4. PROVEEDORES (Corregido: sin columna contacto)
INSERT INTO TB_Proveedor (ruc, razonSocial, telefono, email, direccion, estado) VALUES
('20111111111', 'PharmaSalud S.A.C.', '987654321', 'ventas@pharmasalud.pe', 'Av. La Marina 123', 1),
('20222222222', 'Medicos Global EIRL', '912345678', 'ventas@medicglobal.pe', 'Av. Brasil 456', 1),
('20333333333', 'LabEquip Peru S.A.', '923456789', 'info@labequip.com', 'Av. Benavides 789', 1),
('20444444444', 'Insumos Hospitalarios S.A.', '934567890', 'ventas@inhosp.pe', 'Calle Los Jazmines 101', 1),
('20555555555', 'Suministros Medicos SAC', '945678901', 'contacto@sumed.com.pe', 'Av. Grau 202', 1);

-- 5. INSUMOS 
INSERT INTO TB_Insumo (codigo, nombre, descripcion, unidadMedida, stockActual, stockMinimo, precioUnitario, idCategoria, estado) VALUES
('INS-0001', 'Paracetamol 500mg', 'Caja de 100 tabletas', 'CAJA', 150, 50, 18.00, 1, 1),
('INS-0002', 'Amoxicilina 500mg', 'Caja de 50 tabletas', 'CAJA', 80, 100, 25.50, 1, 1),
('INS-0003', 'Jeringa 5ml', 'Caja de 50 jeringas descartables', 'CAJA', 200, 100, 15.50, 2, 1),
('INS-0004', 'Gasa Esteril 10x10cm', 'Paquete de 100 unidades', 'PAQUETE', 500, 200, 10.00, 2, 1),
('INS-0005', 'Suero Fisiologico 1L', 'Frasco de 1 Litro', 'UNIDAD', 30, 50, 5.50, 1, 1),
('INS-0006', 'Termometro Digital', 'Termometro de uso clinico', 'UNIDAD', 45, 20, 12.00, 3, 1),
('INS-0007', 'Mascarilla KN95', 'Caja de 20 mascarillas', 'CAJA', 300, 150, 45.00, 5, 1),
('INS-0008', 'Reactivo Glucosa', 'Kit para 100 pruebas', 'KIT', 15, 10, 150.00, 4, 1),
('INS-0009', 'Alcohol 96% 1L', 'Frasco de 1 Litro', 'UNIDAD', 120, 50, 14.50, 2, 1),
('INS-0010', 'Guantes Quirurgicos Talla M', 'Caja de 50 pares', 'CAJA', 250, 100, 35.00, 5, 1);

-- 6. PRESUPUESTOS
INSERT INTO TB_Presupuesto (periodo, montoTotal, montoDisponible, estado) VALUES
('2026-1', 500000.00, 150000.00, 1),
('2026-2', 800000.00, 780000.00, 1),
('2026-3', 650000.00, 650000.00, 1);

-- 7. SOLICITUD DE COMPRA
INSERT INTO TB_SolicitudCompra (idUsuario, fechaSolicitud, urgencia, motivo, idEstado) VALUES
(2, DATE_SUB(CURDATE(), INTERVAL 15 DAY), 'NORMAL', 'Reabastecimiento de rutina', 2),
(2, DATE_SUB(CURDATE(), INTERVAL 10 DAY), 'ALTA', 'Stock crítico en UCI', 2),
(2, DATE_SUB(CURDATE(), INTERVAL 5 DAY), 'NORMAL', 'Compra mensual de reactivos', 1),
(2, CURDATE(), 'ALTA', 'Falta de guantes urgentes', 1),
(2, CURDATE(), 'NORMAL', 'Stock minimo de mascarillas', 1);

-- 8. PROFORMA
INSERT INTO TB_Proforma (idProveedor, fechaEmision, montoTotal, tiempoEntregaDias, idEstado) VALUES
(1, DATE_SUB(CURDATE(), INTERVAL 14 DAY), 12500.00, 5, 3),
(2, DATE_SUB(CURDATE(), INTERVAL 9 DAY), 13950.00, 2, 3),
(3, DATE_SUB(CURDATE(), INTERVAL 4 DAY), 5500.00, 10, 1),
(4, CURDATE(), 2100.00, 3, 1),
(5, CURDATE(), 4200.50, 4, 1);

-- 8.5 DETALLE PROFORMA
INSERT INTO TB_DetalleProforma (idProforma, idInsumo, cantidad, precioUnitario, subtotal) VALUES
(4, 1, 100, 15.00, 1500.00),
(4, 3, 50, 12.00, 600.00),
(5, 4, 200, 21.00, 4200.00),
(5, 5, 1, 0.50, 0.50);

-- 9. ÓRDENES DE COMPRA 
INSERT INTO TB_OrdenCompra (idSolicitud, idProforma, idProveedor, idUsuario, idPresupuesto, fechaEmision, total, idEstado, observaciones) VALUES
(1, 1, 1, 1, 1, DATE_SUB(CURDATE(), INTERVAL 12 DAY), 12500.00, 5, 'OC-2026-0014 (Ref)'),
(2, 2, 2, 2, 1, DATE_SUB(CURDATE(), INTERVAL 8 DAY), 13950.00, 4, 'OC-2026-0015 (Ref)'),
(3, 3, 3, 1, 1, DATE_SUB(CURDATE(), INTERVAL 2 DAY), 5500.00, 4, 'OC-2026-0016 (Ref)'),
(4, 4, 4, 2, 1, CURDATE(), 2100.00, 4, 'OC-2026-0017 (Ref)');

-- 10. DETALLE DE ORDENES DE COMPRA
INSERT INTO TB_DetalleOrdenCompra (idOrdenCompra, idInsumo, cantidad, precioUnitario, subtotal) VALUES
(1, 1, 500, 15.50, 7750.00),
(1, 3, 200, 5.00, 1000.00),
(1, 4, 300, 10.00, 3000.00),
(1, 5, 100, 7.50, 750.00),
(2, 2, 400, 25.00, 10000.00),
(2, 6, 50, 12.00, 600.00),
(2, 7, 200, 16.75, 3350.00),
(3, 8, 20, 150.00, 3000.00),
(3, 9, 100, 25.00, 2500.00),
(4, 10, 60, 35.00, 2100.00);

-- 11. LOTES SANITARIOS (Para el panel de alertas de vencimiento)
INSERT INTO TB_Lote (numeroLote, idInsumo, fechaIngreso, fechaVencimiento, cantidadInicial, cantidadActual, estado) VALUES
('L-998822', 5, '2025-06-01', DATE_ADD(CURDATE(), INTERVAL 25 DAY), 500, 45, 1),
('L-112233', 2, '2025-10-15', DATE_ADD(CURDATE(), INTERVAL 15 DAY), 200, 20, 1),
('L-445566', 1, '2025-01-10', DATE_SUB(CURDATE(), INTERVAL 5 DAY), 1000, 150, 1),
('L-778899', 8, '2026-02-20', DATE_ADD(CURDATE(), INTERVAL 60 DAY), 50, 15, 1),
('L-334455', 9, '2026-03-10', DATE_ADD(CURDATE(), INTERVAL 120 DAY), 300, 120, 1);

-- 12. MOVIMIENTOS DE INVENTARIO
INSERT INTO TB_MovimientoInventario (idInsumo, idLote, idOrdenCompra, idUsuario, fechaMovimiento, tipoMovimiento, cantidad, observaciones) VALUES
(1, NULL, 1, 1, DATE_SUB(NOW(), INTERVAL 6 DAY), 'ENTRADA', 100, 'Recepción de OC parcial'),
(2, NULL, NULL, 2, DATE_SUB(NOW(), INTERVAL 5 DAY), 'SALIDA', 50, 'Destino: Emergencia - Pacientes febriles'),
(3, 1, NULL, 2, DATE_SUB(NOW(), INTERVAL 4 DAY), 'AJUSTE', 5, 'Ajuste de inventario fisico'),
(4, NULL, NULL, 3, DATE_SUB(NOW(), INTERVAL 3 DAY), 'SALIDA', 100, 'Destino: Cirugia'),
(5, NULL, 2, 1, DATE_SUB(NOW(), INTERVAL 2 DAY), 'ENTRADA', 200, 'Recepcion completa'),
(6, NULL, NULL, 2, DATE_SUB(NOW(), INTERVAL 1 DAY), 'SALIDA', 10, 'Destino: Triaje'),
(7, NULL, 3, 1, NOW(), 'ENTRADA', 150, 'Recepcion de mascarillas'),
(8, 4, NULL, 3, NOW(), 'SALIDA', 5, 'Destino: Laboratorio'),
(9, 5, NULL, 2, NOW(), 'SALIDA', 20, 'Destino: Hospitalizacion'),
(10, NULL, 4, 1, NOW(), 'ENTRADA', 60, 'Recepcion de guantes');
