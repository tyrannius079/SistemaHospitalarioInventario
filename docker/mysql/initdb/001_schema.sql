SET NAMES 'utf8mb4';

CREATE DATABASE IF NOT EXISTS hospitaldb DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE hospitaldb;

CREATE TABLE IF NOT EXISTS TB_Rol (
  idRol INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL UNIQUE,
  descripcion VARCHAR(150),
  estado TINYINT(1) DEFAULT 1
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS TB_Estado (
  idEstado INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL UNIQUE,
  contexto VARCHAR(50)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS TB_Usuario (
  idUsuario INT AUTO_INCREMENT PRIMARY KEY,
  dni VARCHAR(8) NOT NULL UNIQUE,
  nombres VARCHAR(100) NOT NULL,
  apellidos VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE,
  password VARCHAR(255) NOT NULL,
  idRol INT NOT NULL,
  estado TINYINT(1) DEFAULT 1,
  CONSTRAINT fk_usuario_rol FOREIGN KEY (idRol) REFERENCES TB_Rol(idRol)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS TB_Proveedor (
  idProveedor INT AUTO_INCREMENT PRIMARY KEY,
  razonSocial VARCHAR(150) NOT NULL,
  ruc VARCHAR(11) NOT NULL UNIQUE,
  direccion VARCHAR(200),
  telefono VARCHAR(15),
  email VARCHAR(100),
  estado TINYINT(1) DEFAULT 1
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS TB_Categoria (
  idCategoria INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(80) NOT NULL UNIQUE,
  descripcion VARCHAR(250),
  estado TINYINT(1) DEFAULT 1
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS TB_Insumo (
  idInsumo INT AUTO_INCREMENT PRIMARY KEY,
  codigo VARCHAR(20) NOT NULL UNIQUE,
  nombre VARCHAR(150) NOT NULL,
  descripcion VARCHAR(250),
  unidadMedida VARCHAR(20) NOT NULL,
  stockActual INT DEFAULT 0,
  stockMinimo INT DEFAULT 0,
  precioUnitario DECIMAL(10,2) NOT NULL,
  idCategoria INT NOT NULL,
  estado TINYINT(1) DEFAULT 1,
  CONSTRAINT fk_insumo_categoria FOREIGN KEY (idCategoria) REFERENCES TB_Categoria(idCategoria)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS TB_Lote (
  idLote INT AUTO_INCREMENT PRIMARY KEY,
  numeroLote VARCHAR(30) NOT NULL,
  idInsumo INT NOT NULL,
  fechaIngreso DATE NOT NULL,
  fechaVencimiento DATE NOT NULL,
  cantidadInicial INT NOT NULL,
  cantidadActual INT NOT NULL,
  estado TINYINT(1) DEFAULT 1,
  CONSTRAINT fk_lote_insumo FOREIGN KEY (idInsumo) REFERENCES TB_Insumo(idInsumo)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS TB_SolicitudCompra (
  idSolicitud INT AUTO_INCREMENT PRIMARY KEY,
  idUsuario INT NOT NULL,
  fechaSolicitud DATE NOT NULL,
  urgencia VARCHAR(20) NOT NULL,
  motivo VARCHAR(250),
  idEstado INT NOT NULL,
  CONSTRAINT fk_solicitud_usuario FOREIGN KEY (idUsuario) REFERENCES TB_Usuario(idUsuario),
  CONSTRAINT fk_solicitud_estado FOREIGN KEY (idEstado) REFERENCES TB_Estado(idEstado)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS TB_Proforma (
  idProforma INT AUTO_INCREMENT PRIMARY KEY,
  idProveedor INT NOT NULL,
  fechaEmision DATE NOT NULL,
  montoTotal DECIMAL(12,2) NOT NULL,
  tiempoEntregaDias INT NOT NULL,
  idEstado INT NOT NULL,
  CONSTRAINT fk_proforma_proveedor FOREIGN KEY (idProveedor) REFERENCES TB_Proveedor(idProveedor),
  CONSTRAINT fk_proforma_estado FOREIGN KEY (idEstado) REFERENCES TB_Estado(idEstado)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS TB_DetalleProforma (
  idDetalle INT AUTO_INCREMENT PRIMARY KEY,
  idProforma INT NOT NULL,
  idInsumo INT NOT NULL,
  cantidad INT NOT NULL,
  precioUnitario DECIMAL(12,2) NOT NULL,
  subtotal DECIMAL(12,2) NOT NULL,
  CONSTRAINT fk_detalleproforma_proforma FOREIGN KEY (idProforma) REFERENCES TB_Proforma(idProforma),
  CONSTRAINT fk_detalleproforma_insumo FOREIGN KEY (idInsumo) REFERENCES TB_Insumo(idInsumo)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS TB_Presupuesto (
  idPresupuesto INT AUTO_INCREMENT PRIMARY KEY,
  periodo VARCHAR(10) NOT NULL,
  montoTotal DECIMAL(14,2) NOT NULL,
  montoDisponible DECIMAL(14,2) NOT NULL,
  estado TINYINT(1) DEFAULT 1
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS TB_OrdenCompra (
  idOrdenCompra INT AUTO_INCREMENT PRIMARY KEY,
  idSolicitud INT NOT NULL,
  idProforma INT NOT NULL,
  idProveedor INT NOT NULL,
  idUsuario INT NOT NULL,
  idPresupuesto INT NOT NULL,
  fechaEmision DATE NOT NULL,
  total DECIMAL(12,2) NOT NULL,
  idEstado INT NOT NULL,
  observaciones VARCHAR(250),
  CONSTRAINT fk_orden_solicitud FOREIGN KEY (idSolicitud) REFERENCES TB_SolicitudCompra(idSolicitud),
  CONSTRAINT fk_orden_proforma FOREIGN KEY (idProforma) REFERENCES TB_Proforma(idProforma),
  CONSTRAINT fk_orden_proveedor FOREIGN KEY (idProveedor) REFERENCES TB_Proveedor(idProveedor),
  CONSTRAINT fk_orden_usuario FOREIGN KEY (idUsuario) REFERENCES TB_Usuario(idUsuario),
  CONSTRAINT fk_orden_presupuesto FOREIGN KEY (idPresupuesto) REFERENCES TB_Presupuesto(idPresupuesto),
  CONSTRAINT fk_orden_estado FOREIGN KEY (idEstado) REFERENCES TB_Estado(idEstado)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS TB_DetalleOrdenCompra (
  idDetalle INT AUTO_INCREMENT PRIMARY KEY,
  idOrdenCompra INT NOT NULL,
  idInsumo INT NOT NULL,
  cantidad INT NOT NULL,
  precioUnitario DECIMAL(10,2) NOT NULL,
  subtotal DECIMAL(12,2) NOT NULL,
  CONSTRAINT fk_detalle_orden FOREIGN KEY (idOrdenCompra) REFERENCES TB_OrdenCompra(idOrdenCompra),
  CONSTRAINT fk_detalle_insumo FOREIGN KEY (idInsumo) REFERENCES TB_Insumo(idInsumo)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS TB_MovimientoInventario (
  idMovimiento INT AUTO_INCREMENT PRIMARY KEY,
  idInsumo INT NOT NULL,
  idLote INT NULL,
  idOrdenCompra INT NULL,
  idUsuario INT NOT NULL,
  fechaMovimiento DATETIME NOT NULL,
  tipoMovimiento VARCHAR(20) NOT NULL,
  cantidad INT NOT NULL,
  observaciones VARCHAR(250),
  CONSTRAINT fk_mov_insumo FOREIGN KEY (idInsumo) REFERENCES TB_Insumo(idInsumo),
  CONSTRAINT fk_mov_lote FOREIGN KEY (idLote) REFERENCES TB_Lote(idLote),
  CONSTRAINT fk_mov_orden FOREIGN KEY (idOrdenCompra) REFERENCES TB_OrdenCompra(idOrdenCompra),
  CONSTRAINT fk_mov_usuario FOREIGN KEY (idUsuario) REFERENCES TB_Usuario(idUsuario)
) ENGINE=InnoDB;
