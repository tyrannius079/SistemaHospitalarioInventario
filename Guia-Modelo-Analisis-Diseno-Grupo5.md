# Guía de Modelado — Análisis y Diseño
## Proyecto: Sistema Inteligente de Inventario Hospitalario

**Equipo 5 — Hospital del Niño**
**Curso:** Análisis y Diseño de Sistemas II
**Avance 2 — Modelo de Análisis y Diseño**

---

## 📋 Índice

1. [Información general](#1-información-general)
2. [Arquitectura del Sistema](#2-arquitectura-del-sistema)
3. [Modelo de Análisis](#3-modelo-de-análisis)
4. [Modelo de Datos](#4-modelo-de-datos)
5. [Modelo de Diseño](#5-modelo-de-diseño)
6. [Programación de las Clases](#6-programación-de-las-clases)
7. [Diagrama de Componentes](#7-diagrama-de-componentes)
8. [Diagrama de Despliegue](#8-diagrama-de-despliegue)
9. [Checklist final de StarUML](#9-checklist-final-de-staruml)

---

## 1. Información general

### 1.1 Alcance del Avance 2

Este avance cubre solo **dos casos de uso del sistema**:

| Código | Nombre | Módulo | Actor principal | Responsable |
|---|---|---|---|---|
| CUS01 | Registrar Orden de Compra | Gestión de Compras | AS_JefeCompra | Rony |
| CUS02 | Registrar Entrada de Insumos | Gestión de Inventario | AS_TecnicoAlmacen | Cristhian |

> ⚠️ **El caso de uso de Distribución Interna se RETIRA del alcance.** Eliminar del `.mdj` el paquete `Gestion de distribucion interna` del subsistema `Modelo de Análisis y Diseño`.

### 1.2 Convenciones de nomenclatura

| Prefijo | Significado | Ejemplo |
|---|---|---|
| `AS_` | Actor del Sistema | `AS_JefeCompra`, `AS_TecnicoAlmacen` |
| `ES_` | Entidad del Sistema (clase de Análisis) | `ES_OrdenCompra`, `ES_Insumo` |
| `frm` | Formulario / clase Vista (Análisis) | `frmRegistrarOrdenCompra` |
| `C_` | Clase Controlador (Análisis) | `C_OrdenCompra`, `C_Inventario` |
| `RCUS_` | Realización de Caso de Uso del Sistema | `RCUS_RegistrarOrdenCompra` |
| `I` | Interfaz (Diseño) | `IOrdenCompraServices` |
| `Bean` | Sufijo para Beans del Diseño | `OrdenCompraBean` |
| `DAO` | Sufijo para DAO del Diseño | `OrdenCompraDAO` |
| `Services` | Sufijo para Servicios del Diseño | `OrdenCompraServices` |
| `Servlet` | Sufijo para controlador del Diseño | `OrdenCompraServlet` |
| `TB_` | Tabla del Modelo Físico | `TB_OrdenCompra`, `TB_Insumo` |

### 1.3 Distribución de trabajo

| Integrante | Responsabilidad principal |
|---|---|
| **Wiliam (líder)** | Modelo de Datos completo, Arquitectura del Software, Diagrama de Componentes y Despliegue, redacción del Word, `ConexionBD.java`, integración final |
| **Rony** | Módulo Compras end-to-end: Análisis + Diseño + Realizaciones + Código (Compras) |
| **Cristhian** | Módulo Inventario end-to-end: Análisis + Diseño + Realizaciones + Código (Inventario) |
| **Astrid** | Entidades transversales: Categoria, Lote, Proveedor, Usuario. Código de estos Bean/DAO. Apoya a Wiliam con Modelo Conceptual/Lógico y diccionario de datos. |

---

## 2. Arquitectura del Sistema

### 2.1 Diagrama de Paquetes (vista del Análisis)

Crear un `UMLPackageDiagram` que muestre los siguientes paquetes y sus dependencias:

```
[P01 - Gestión de Compras]  ───→  [P03 - Seguridad]
        │                                  ↑
        ↓                                  │
[P02 - Gestión de Inventario] ─────────────┘
```

- **P01 — Gestión de Compras**: registro de órdenes de compra, gestión de proveedores y proformas
- **P02 — Gestión de Inventario**: registro de entradas, control de stock, gestión de lotes
- **P03 — Seguridad** (transversal): login, validación de credenciales, gestión de sesión

### 2.2 Estructura en StarUML

Dentro del subsistema **Modelo de Análisis y Diseño**, la estructura debe quedar así:

```
Modelo de Análisis y Diseño 📦
├── Modelo de Análisis [UMLModel]
│   ├── Gestion de Compras 📂
│   │   ├── Modelo 📂              ← Entidades ES_*
│   │   ├── Vista 📂               ← Formularios frm*
│   │   ├── Controlador 📂         ← Controladores C_*
│   │   └── Realización del CU 📂  ← RCUS_RegistrarOrdenCompra
│   ├── Gestion de Inventario 📂
│   │   ├── Modelo 📂
│   │   ├── Vista 📂
│   │   ├── Controlador 📂
│   │   └── Realización del CU 📂  ← RCUS_RegistrarEntradaInsumos
│   └── Arquitectura del Software 📂
│
├── Modelo de Datos [UMLModel]
│   ├── Modelo Conceptual 📂
│   ├── Modelo Lógico 📂
│   └── Modelo Físico 📂           ← ERDDataModel + ERDDiagram
│
└── Modelo de Diseño [UMLModel]
    ├── Gestion de Compras 📂
    │   ├── Modelo 📂
    │   │   ├── Servicios 📂 (Clases + Interfaces)
    │   │   ├── DAO 📂
    │   │   ├── Beans 📂
    │   │   └── Util 📂
    │   ├── Vista 📂
    │   ├── Controlador 📂
    │   ├── Diagrama de Clases del Diseño 📊
    │   └── Diagrama de Secuencia del Diseño 📊
    ├── Gestion de Inventario 📂
    │   └── (misma estructura)
    └── Componentes y Despliegues 📦
        ├── Componentes 📂
        └── Despliegue 📂
```

---

## 3. Modelo de Análisis

### 3.1 Módulo Gestión de Compras

**📁 Ruta en StarUML:** `Modelo de Análisis y Diseño / Modelo de Análisis / Gestion de Compras`

#### 3.1.1 Paquete `Modelo` — Entidades del Sistema (ES)

> Crear estas clases dentro del paquete `Modelo` con estereotipo `«entity»`. Cada clase debe tener atributos y operaciones (no dejarlas vacías).

##### ES_OrdenCompra

| Atributo | Tipo | Visibilidad |
|---|---|---|
| idOrdenCompra | Integer | private |
| fechaEmision | Date | private |
| total | Double | private |
| estado | String | private |
| observaciones | String | private |

| Operación | Retorno |
|---|---|
| `+ crearOrden(datos)` | boolean |
| `+ validarTotal()` | boolean |
| `+ obtenerOrden(id)` | ES_OrdenCompra |
| `+ actualizarEstado(estado)` | boolean |

##### ES_Proveedor

| Atributo | Tipo | Visibilidad |
|---|---|---|
| idProveedor | Integer | private |
| razonSocial | String | private |
| ruc | String | private |
| direccion | String | private |
| telefono | String | private |
| email | String | private |
| estado | String | private |

| Operación | Retorno |
|---|---|
| `+ buscarProveedor(ruc)` | ES_Proveedor |
| `+ validarProveedor()` | boolean |
| `+ listarProveedores()` | List |

##### ES_SolicitudCompra

| Atributo | Tipo | Visibilidad |
|---|---|---|
| idSolicitud | Integer | private |
| fechaSolicitud | Date | private |
| urgencia | String | private |
| estado | String | private |
| motivo | String | private |

| Operación | Retorno |
|---|---|
| `+ registrarSolicitud(datos)` | boolean |
| `+ aprobarSolicitud(id)` | boolean |
| `+ consultarSolicitud(id)` | ES_SolicitudCompra |

##### ES_Proforma

| Atributo | Tipo | Visibilidad |
|---|---|---|
| idProforma | Integer | private |
| fechaEmision | Date | private |
| montoTotal | Double | private |
| tiempoEntrega | Integer | private |
| estado | String | private |

| Operación | Retorno |
|---|---|
| `+ registrarProforma(datos)` | boolean |
| `+ compararProformas(lista)` | ES_Proforma |
| `+ validarVigencia()` | boolean |

##### ES_Presupuesto

| Atributo | Tipo | Visibilidad |
|---|---|---|
| idPresupuesto | Integer | private |
| periodo | String | private |
| montoTotal | Double | private |
| montoDisponible | Double | private |
| estado | String | private |

| Operación | Retorno |
|---|---|
| `+ validarPresupuesto(monto)` | boolean |
| `+ actualizarDisponible(monto)` | boolean |
| `+ consultarPresupuesto()` | ES_Presupuesto |

##### ES_DetalleOrdenCompra

| Atributo | Tipo | Visibilidad |
|---|---|---|
| idDetalle | Integer | private |
| cantidad | Integer | private |
| precioUnitario | Double | private |
| subtotal | Double | private |

| Operación | Retorno |
|---|---|
| `+ agregarDetalle(insumo, cant, precio)` | boolean |
| `+ calcularSubtotal()` | Double |
| `+ listarDetalles(idOrden)` | List |

#### 3.1.2 Asociaciones del paquete Modelo (Compras)

Dibujar en el `ClassDiagram1` del paquete `Modelo`:

| Origen | Tipo | Destino | Multiplicidad |
|---|---|---|---|
| ES_OrdenCompra | «association» | ES_Proveedor | 1 → 1 |
| ES_OrdenCompra | «association» | ES_SolicitudCompra | 1 → 1 |
| ES_OrdenCompra | «composition» | ES_DetalleOrdenCompra | 1 → 1..* |
| ES_OrdenCompra | «association» | ES_Proforma | 1 → 1 |
| ES_Proveedor | «association» | ES_Proforma | 1 → 0..* |
| ES_OrdenCompra | «dependency» | ES_Presupuesto | (valida) |

#### 3.1.3 Paquete `Vista` — Formularios

Renombrar las clases existentes y agregar atributos/operaciones:

##### frmRegistrarOrdenCompra

| Atributo | Tipo | Visibilidad |
|---|---|---|
| txtIdProveedor | String | private |
| txtIdProforma | String | private |
| txtFecha | Date | private |
| txtObservaciones | String | private |
| dgvDetalles | DataGridView | private |

| Operación | Retorno |
|---|---|
| `+ cargarDatos()` | void |
| `+ validarFormulario()` | boolean |
| `+ btnRegistrar_Click()` | void |
| `+ btnCancelar_Click()` | void |
| `+ mostrarMensaje(msg)` | void |

##### frmConsultarProformas

| Atributo | Tipo | Visibilidad |
|---|---|---|
| dgvProformas | DataGridView | private |
| txtFiltro | String | private |

| Operación | Retorno |
|---|---|
| `+ cargarProformas()` | void |
| `+ filtrarProformas()` | void |
| `+ seleccionarProforma()` | ES_Proforma |

##### frmModificarOrdenCompra

| Atributo | Tipo | Visibilidad |
|---|---|---|
| txtIdOrden | String | private |
| txtNuevoEstado | String | private |

| Operación | Retorno |
|---|---|
| `+ cargarOrden(id)` | void |
| `+ btnActualizar_Click()` | void |

#### 3.1.4 Paquete `Controlador`

##### C_OrdenCompra

| Atributo | Tipo | Visibilidad |
|---|---|---|
| ordenCompra | ES_OrdenCompra | private |

| Operación | Retorno |
|---|---|
| `+ registrarOrden(datos)` | boolean |
| `+ consultarOrden(id)` | ES_OrdenCompra |
| `+ actualizarOrden(orden)` | boolean |
| `+ anularOrden(id)` | boolean |

##### C_Proveedor

| Operación | Retorno |
|---|---|
| `+ buscarProveedor(ruc)` | ES_Proveedor |
| `+ listarProveedores()` | List |
| `+ registrarProveedor(datos)` | boolean |

##### C_Presupuesto

| Operación | Retorno |
|---|---|
| `+ validarPresupuesto(monto)` | boolean |
| `+ actualizarPresupuesto(monto)` | boolean |
| `+ consultarPresupuesto()` | ES_Presupuesto |

##### C_Proforma

| Operación | Retorno |
|---|---|
| `+ registrarProforma(datos)` | boolean |
| `+ compararProformas(idsolicitud)` | List |
| `+ seleccionarProforma(id)` | ES_Proforma |

##### C_SolicitudCompra

| Operación | Retorno |
|---|---|
| `+ registrarSolicitud(datos)` | boolean |
| `+ aprobarSolicitud(id)` | boolean |

#### 3.1.5 Realización del CU — RCUS_RegistrarOrdenCompra

**📁 Ruta en StarUML:** `Modelo de Análisis / Gestion de Compras / Realización del CU`

> ⚠️ Eliminar la `Collaboration1` actual con Lifelines `Role1...Role6` y mensajes `Message1...Message3`. Crear una nueva colaboración bien estructurada.

**Pasos en StarUML:**

1. Renombrar el paquete `Realización de Casos de Uso del Sistema` (sin contenido) → mantenerlo
2. Eliminar `Collaboration1` y crear nueva `UMLCollaboration` llamada `RCUS_RegistrarOrdenCompra`
3. Dentro, crear una `UMLInteraction` llamada `Interaction_RegistrarOrdenCompra`
4. Crear **8 lifelines** (UMLLifeline), una por cada actor/clase participante:

##### Lifelines (participantes)

| Nombre del Lifeline | Representa (clase) | Tipo |
|---|---|---|
| `:AS_JefeCompra` | AS_JefeCompra | UMLActor |
| `:frmRegistrarOrdenCompra` | frmRegistrarOrdenCompra | UMLClass (Vista) |
| `:C_OrdenCompra` | C_OrdenCompra | UMLClass (Control) |
| `:C_Proveedor` | C_Proveedor | UMLClass (Control) |
| `:C_Presupuesto` | C_Presupuesto | UMLClass (Control) |
| `:ES_OrdenCompra` | ES_OrdenCompra | UMLClass (Entidad) |
| `:ES_Proveedor` | ES_Proveedor | UMLClass (Entidad) |
| `:ES_Presupuesto` | ES_Presupuesto | UMLClass (Entidad) |
| `:ES_DetalleOrdenCompra` | ES_DetalleOrdenCompra | UMLClass (Entidad) |

##### Mensajes del Diagrama de Comunicación / Secuencia

Crear estos mensajes en orden secuencial numerado:

| # | Origen | Destino | Mensaje (firma) |
|---|---|---|---|
| 1 | `:AS_JefeCompra` | `:frmRegistrarOrdenCompra` | `ingresarDatosOrden()` |
| 2 | `:frmRegistrarOrdenCompra` | `:C_OrdenCompra` | `registrarOrden(datos)` |
| 2.1 | `:C_OrdenCompra` | `:C_Proveedor` | `buscarProveedor(idProveedor)` |
| 2.2 | `:C_Proveedor` | `:ES_Proveedor` | `validarProveedor()` |
| 2.3 | `:ES_Proveedor` | `:C_Proveedor` | `proveedorValido: boolean` |
| 2.4 | `:C_OrdenCompra` | `:C_Presupuesto` | `validarPresupuesto(monto)` |
| 2.5 | `:C_Presupuesto` | `:ES_Presupuesto` | `consultarDisponible()` |
| 2.6 | `:ES_Presupuesto` | `:C_Presupuesto` | `montoDisponible: Double` |
| 3 | `:C_OrdenCompra` | `:ES_OrdenCompra` | `crearOrden(datos)` |
| 3.1 | `:ES_OrdenCompra` | `:ES_DetalleOrdenCompra` | `agregarDetalles(items)` |
| 4 | `:C_OrdenCompra` | `:C_Presupuesto` | `actualizarPresupuesto(monto)` |
| 4.1 | `:C_Presupuesto` | `:ES_Presupuesto` | `descontarMonto(total)` |
| 5 | `:C_OrdenCompra` | `:frmRegistrarOrdenCompra` | `mostrarConfirmacion(numOrden)` |
| 6 | `:frmRegistrarOrdenCompra` | `:AS_JefeCompra` | `confirmacionOrden` |

##### Crear ambos diagramas dentro de la Interaction

- **Diagrama de Comunicación** (`UMLCommunicationDiagram`): vista con conectores entre lifelines y mensajes con números secuenciales (1, 2, 2.1, 2.2, ...)
- **Diagrama de Secuencia** (`UMLSequenceDiagram`): vista temporal de los mismos mensajes con activaciones (focus of control) y barras de vida

---

### 3.2 Módulo Gestión de Inventario

**📁 Ruta en StarUML:** `Modelo de Análisis y Diseño / Modelo de Análisis / Gestion de Inventario`

#### 3.2.1 Paquete `Modelo` — Entidades del Sistema

##### ES_Insumo

| Atributo | Tipo | Visibilidad |
|---|---|---|
| idInsumo | Integer | private |
| codigo | String | private |
| nombre | String | private |
| descripcion | String | private |
| unidadMedida | String | private |
| stockActual | Integer | private |
| stockMinimo | Integer | private |
| precioUnitario | Double | private |
| estado | String | private |

| Operación | Retorno |
|---|---|
| `+ registrarInsumo(datos)` | boolean |
| `+ actualizarStock(cant, tipo)` | boolean |
| `+ consultarStock(id)` | Integer |
| `+ verificarStockMinimo()` | boolean |
| `+ obtenerInsumo(id)` | ES_Insumo |

##### ES_MovimientoInventario

| Atributo | Tipo | Visibilidad |
|---|---|---|
| idMovimiento | Integer | private |
| fechaMovimiento | Date | private |
| tipoMovimiento | String | private |
| cantidad | Integer | private |
| observaciones | String | private |

| Operación | Retorno |
|---|---|
| `+ registrarMovimiento(datos)` | boolean |
| `+ consultarMovimientos(idInsumo)` | List |
| `+ obtenerHistorial(fechaIni, fechaFin)` | List |

##### ES_Lote

| Atributo | Tipo | Visibilidad |
|---|---|---|
| idLote | Integer | private |
| numeroLote | String | private |
| fechaIngreso | Date | private |
| fechaVencimiento | Date | private |
| cantidadInicial | Integer | private |
| cantidadActual | Integer | private |
| estado | String | private |

| Operación | Retorno |
|---|---|
| `+ registrarLote(datos)` | boolean |
| `+ verificarVencimiento()` | boolean |
| `+ actualizarCantidad(cant)` | boolean |
| `+ obtenerLotesProximosVencer()` | List |

##### ES_Categoria

| Atributo | Tipo | Visibilidad |
|---|---|---|
| idCategoria | Integer | private |
| nombre | String | private |
| descripcion | String | private |
| estado | String | private |

| Operación | Retorno |
|---|---|
| `+ registrarCategoria(datos)` | boolean |
| `+ listarCategorias()` | List |

##### ES_Inventario

| Atributo | Tipo | Visibilidad |
|---|---|---|
| idInventario | Integer | private |
| fechaActualizacion | Date | private |
| totalInsumos | Integer | private |

| Operación | Retorno |
|---|---|
| `+ actualizarInventario()` | boolean |
| `+ generarReporte()` | List |
| `+ emitirAlertas()` | List |

#### 3.2.2 Asociaciones del paquete Modelo (Inventario)

| Origen | Tipo | Destino | Multiplicidad |
|---|---|---|---|
| ES_Insumo | «association» | ES_Categoria | * → 1 |
| ES_Insumo | «association» | ES_Lote | 1 → 0..* |
| ES_MovimientoInventario | «association» | ES_Insumo | * → 1 |
| ES_MovimientoInventario | «association» | ES_Lote | * → 1 |
| ES_Inventario | «aggregation» | ES_Insumo | 1 → * |

#### 3.2.3 Paquete `Vista` — Formularios

##### frmRegistrarEntradaInsumos

| Atributo | Tipo |
|---|---|
| txtIdOrdenCompra | String |
| txtIdInsumo | String |
| txtCantidad | Integer |
| txtNumeroLote | String |
| txtFechaVencimiento | Date |
| dgvInsumos | DataGridView |

| Operación | Retorno |
|---|---|
| `+ cargarOrdenCompra(id)` | void |
| `+ validarFormulario()` | boolean |
| `+ btnRegistrar_Click()` | void |
| `+ mostrarConfirmacion()` | void |

##### frmConsultarStock

| Atributo | Tipo |
|---|---|
| txtFiltroInsumo | String |
| dgvStock | DataGridView |
| chkSoloStockMinimo | Boolean |

| Operación | Retorno |
|---|---|
| `+ cargarStock()` | void |
| `+ filtrarPorCategoria()` | void |
| `+ exportarReporte()` | void |

##### frmActualizarStock

| Atributo | Tipo |
|---|---|
| txtIdInsumo | String |
| txtCantidadAjuste | Integer |
| txtMotivo | String |

| Operación | Retorno |
|---|---|
| `+ btnActualizar_Click()` | void |

#### 3.2.4 Paquete `Controlador`

##### C_Inventario

| Operación | Retorno |
|---|---|
| `+ registrarEntrada(datosEntrada)` | boolean |
| `+ registrarSalida(datosSalida)` | boolean |
| `+ consultarStock(idInsumo)` | Integer |
| `+ emitirAlertasStock()` | List |
| `+ generarReporteInventario()` | List |

##### C_MovimientoInventario

| Operación | Retorno |
|---|---|
| `+ crearMovimiento(datos)` | boolean |
| `+ consultarMovimientos(filtros)` | List |
| `+ obtenerHistorial(idInsumo)` | List |

##### C_Insumo

| Operación | Retorno |
|---|---|
| `+ registrarInsumo(datos)` | boolean |
| `+ consultarInsumo(id)` | ES_Insumo |
| `+ actualizarStock(id, cant)` | boolean |
| `+ listarInsumos()` | List |

##### C_Lote

| Operación | Retorno |
|---|---|
| `+ registrarLote(datos)` | boolean |
| `+ verificarVencimientos()` | List |
| `+ obtenerLotePorInsumo(idInsumo)` | List |

##### C_Categoria

| Operación | Retorno |
|---|---|
| `+ listarCategorias()` | List |
| `+ registrarCategoria(datos)` | boolean |

#### 3.2.5 Realización del CU — RCUS_RegistrarEntradaInsumos

**📁 Ruta en StarUML:** `Modelo de Análisis / Gestion de Inventario / Realización del CU`

> ⚠️ Eliminar la `Collaboration1` actual y crear una nueva.

##### Lifelines

| Nombre del Lifeline | Representa | Tipo |
|---|---|---|
| `:AS_TecnicoAlmacen` | AS_TecnicoAlmacen | UMLActor |
| `:frmRegistrarEntradaInsumos` | frmRegistrarEntradaInsumos | UMLClass (Vista) |
| `:C_Inventario` | C_Inventario | UMLClass (Control) |
| `:C_MovimientoInventario` | C_MovimientoInventario | UMLClass (Control) |
| `:C_Lote` | C_Lote | UMLClass (Control) |
| `:ES_OrdenCompra` | ES_OrdenCompra | UMLClass (Entidad, externa) |
| `:ES_Insumo` | ES_Insumo | UMLClass (Entidad) |
| `:ES_Lote` | ES_Lote | UMLClass (Entidad) |
| `:ES_MovimientoInventario` | ES_MovimientoInventario | UMLClass (Entidad) |

##### Mensajes (Comunicación / Secuencia)

| # | Origen | Destino | Mensaje |
|---|---|---|---|
| 1 | `:AS_TecnicoAlmacen` | `:frmRegistrarEntradaInsumos` | `ingresarDatosEntrada()` |
| 2 | `:frmRegistrarEntradaInsumos` | `:C_Inventario` | `registrarEntrada(idOC, datos)` |
| 2.1 | `:C_Inventario` | `:ES_OrdenCompra` | `validarOrdenCompra(idOC)` |
| 2.2 | `:ES_OrdenCompra` | `:C_Inventario` | `ordenValida: boolean` |
| 3 | `:C_Inventario` | `:C_Lote` | `registrarLote(datosLote)` |
| 3.1 | `:C_Lote` | `:ES_Lote` | `crearLote(numLote, fechaVenc, cant)` |
| 3.2 | `:ES_Lote` | `:C_Lote` | `loteCreado: ES_Lote` |
| 4 | `:C_Inventario` | `:C_MovimientoInventario` | `crearMovimiento(tipo: ENTRADA)` |
| 4.1 | `:C_MovimientoInventario` | `:ES_MovimientoInventario` | `registrarMovimiento(datos)` |
| 4.2 | `:ES_MovimientoInventario` | `:C_MovimientoInventario` | `movimientoRegistrado` |
| 5 | `:C_Inventario` | `:ES_Insumo` | `actualizarStock(idInsumo, cant)` |
| 5.1 | `:ES_Insumo` | `:ES_Insumo` | `stockActual += cant` |
| 5.2 | `:ES_Insumo` | `:C_Inventario` | `stockActualizado: boolean` |
| 6 | `:C_Inventario` | `:frmRegistrarEntradaInsumos` | `mostrarConfirmacion(numMov)` |
| 7 | `:frmRegistrarEntradaInsumos` | `:AS_TecnicoAlmacen` | `confirmacionRegistro` |

##### Crear ambos diagramas

- **Diagrama de Comunicación** con la numeración 1, 2, 2.1, 2.2, ...
- **Diagrama de Secuencia** con los mismos mensajes en formato temporal

---

## 4. Modelo de Datos

**📁 Ruta en StarUML:** `Modelo de Análisis y Diseño / Modelo de Datos`

> 🔨 **Responsable:** Wiliam. Crear como nuevo `UMLModel` dentro del subsistema MAyD.

### 4.1 Modelo Conceptual

Crear un `ClassDiagram` dentro del paquete `Modelo Conceptual` con las siguientes entidades del dominio (**sin tipos de datos**, solo nombres y relaciones):

| Entidad | Atributos clave |
|---|---|
| Usuario | nombre, dni, rol |
| Proveedor | razonSocial, ruc, telefono |
| Categoria | nombre, descripcion |
| Insumo | codigo, nombre, stockActual |
| Lote | numeroLote, fechaVencimiento |
| SolicitudCompra | fechaSolicitud, urgencia |
| Proforma | fechaEmision, montoTotal |
| OrdenCompra | fechaEmision, total |
| DetalleOrdenCompra | cantidad, precioUnitario |
| Presupuesto | periodo, montoTotal |
| MovimientoInventario | fechaMovimiento, tipo, cantidad |

**Relaciones (asociaciones simples):**

- Usuario — registra — SolicitudCompra (1 → 0..*)
- SolicitudCompra — origina — OrdenCompra (1 → 1)
- Proveedor — emite — Proforma (1 → 0..*)
- Proforma — sustenta — OrdenCompra (1 → 1)
- OrdenCompra — contiene — DetalleOrdenCompra (1 → 1..*)
- DetalleOrdenCompra — referencia — Insumo (* → 1)
- OrdenCompra — afecta — Presupuesto (* → 1)
- Insumo — pertenece — Categoria (* → 1)
- Insumo — tiene — Lote (1 → 0..*)
- MovimientoInventario — registra — Insumo (* → 1)
- MovimientoInventario — referencia — Lote (* → 0..1)
- MovimientoInventario — origina — OrdenCompra (* → 0..1)
- Usuario — ejecuta — MovimientoInventario (1 → 0..*)

### 4.2 Modelo Lógico

Crear un `ClassDiagram` dentro del paquete `Modelo Lógico` que refine el conceptual con:

- Tipos de datos (Integer, String, Date, Double, Boolean)
- Multiplicidades explícitas en cada extremo de asociación
- Atributos de enlace en relaciones muchos-a-muchos (no aplica aquí, ya están normalizadas)
- Identificadores marcados con `«PK»` y claves foráneas con `«FK»`

> No incluir métodos en este modelo. Solo atributos con sus tipos.

### 4.3 Modelo Físico

Crear un `ERDDataModel` dentro del paquete `Modelo Físico`. Adentro, crear un `ERDDiagram` con las siguientes `ERDEntity`:

#### TB_Usuario

| Campo | Tipo | Longitud | Descripción | Restricción |
|---|---|---|---|---|
| idUsuario | INT | - | Identificador único | PK, AUTO_INCREMENT |
| dni | VARCHAR | 8 | DNI del usuario | UNIQUE NOT NULL |
| nombres | VARCHAR | 100 | Nombres del usuario | NOT NULL |
| apellidos | VARCHAR | 100 | Apellidos del usuario | NOT NULL |
| email | VARCHAR | 100 | Correo electrónico | UNIQUE |
| password | VARCHAR | 255 | Contraseña hash | NOT NULL |
| rol | VARCHAR | 30 | Rol del usuario | NOT NULL |
| estado | CHAR | 1 | A=Activo, I=Inactivo | DEFAULT 'A' |

#### TB_Proveedor

| Campo | Tipo | Longitud | Restricción |
|---|---|---|---|
| idProveedor | INT | - | PK, AUTO_INCREMENT |
| razonSocial | VARCHAR | 150 | NOT NULL |
| ruc | VARCHAR | 11 | UNIQUE NOT NULL |
| direccion | VARCHAR | 200 | - |
| telefono | VARCHAR | 15 | - |
| email | VARCHAR | 100 | - |
| estado | CHAR | 1 | DEFAULT 'A' |

#### TB_Categoria

| Campo | Tipo | Longitud | Restricción |
|---|---|---|---|
| idCategoria | INT | - | PK, AUTO_INCREMENT |
| nombre | VARCHAR | 80 | UNIQUE NOT NULL |
| descripcion | VARCHAR | 250 | - |
| estado | CHAR | 1 | DEFAULT 'A' |

#### TB_Insumo

| Campo | Tipo | Longitud | Restricción |
|---|---|---|---|
| idInsumo | INT | - | PK, AUTO_INCREMENT |
| codigo | VARCHAR | 20 | UNIQUE NOT NULL |
| nombre | VARCHAR | 150 | NOT NULL |
| descripcion | VARCHAR | 250 | - |
| unidadMedida | VARCHAR | 20 | NOT NULL |
| stockActual | INT | - | DEFAULT 0 |
| stockMinimo | INT | - | DEFAULT 0 |
| precioUnitario | DECIMAL | 10,2 | NOT NULL |
| idCategoria | INT | - | FK → TB_Categoria |
| estado | CHAR | 1 | DEFAULT 'A' |

#### TB_Lote

| Campo | Tipo | Longitud | Restricción |
|---|---|---|---|
| idLote | INT | - | PK, AUTO_INCREMENT |
| numeroLote | VARCHAR | 30 | NOT NULL |
| idInsumo | INT | - | FK → TB_Insumo |
| fechaIngreso | DATE | - | NOT NULL |
| fechaVencimiento | DATE | - | NOT NULL |
| cantidadInicial | INT | - | NOT NULL |
| cantidadActual | INT | - | NOT NULL |
| estado | CHAR | 1 | DEFAULT 'A' |

#### TB_SolicitudCompra

| Campo | Tipo | Longitud | Restricción |
|---|---|---|---|
| idSolicitud | INT | - | PK, AUTO_INCREMENT |
| idUsuario | INT | - | FK → TB_Usuario |
| fechaSolicitud | DATE | - | NOT NULL |
| urgencia | VARCHAR | 20 | NOT NULL |
| motivo | VARCHAR | 250 | - |
| estado | VARCHAR | 20 | DEFAULT 'PENDIENTE' |

#### TB_Proforma

| Campo | Tipo | Longitud | Restricción |
|---|---|---|---|
| idProforma | INT | - | PK, AUTO_INCREMENT |
| idProveedor | INT | - | FK → TB_Proveedor |
| fechaEmision | DATE | - | NOT NULL |
| montoTotal | DECIMAL | 12,2 | NOT NULL |
| tiempoEntregaDias | INT | - | NOT NULL |
| estado | VARCHAR | 20 | DEFAULT 'VIGENTE' |

#### TB_Presupuesto

| Campo | Tipo | Longitud | Restricción |
|---|---|---|---|
| idPresupuesto | INT | - | PK, AUTO_INCREMENT |
| periodo | VARCHAR | 10 | NOT NULL |
| montoTotal | DECIMAL | 14,2 | NOT NULL |
| montoDisponible | DECIMAL | 14,2 | NOT NULL |
| estado | CHAR | 1 | DEFAULT 'A' |

#### TB_OrdenCompra

| Campo | Tipo | Longitud | Restricción |
|---|---|---|---|
| idOrdenCompra | INT | - | PK, AUTO_INCREMENT |
| idSolicitud | INT | - | FK → TB_SolicitudCompra |
| idProforma | INT | - | FK → TB_Proforma |
| idProveedor | INT | - | FK → TB_Proveedor |
| idUsuario | INT | - | FK → TB_Usuario |
| idPresupuesto | INT | - | FK → TB_Presupuesto |
| fechaEmision | DATE | - | NOT NULL |
| total | DECIMAL | 12,2 | NOT NULL |
| estado | VARCHAR | 20 | DEFAULT 'EMITIDA' |
| observaciones | VARCHAR | 250 | - |

#### TB_DetalleOrdenCompra

| Campo | Tipo | Longitud | Restricción |
|---|---|---|---|
| idDetalle | INT | - | PK, AUTO_INCREMENT |
| idOrdenCompra | INT | - | FK → TB_OrdenCompra |
| idInsumo | INT | - | FK → TB_Insumo |
| cantidad | INT | - | NOT NULL |
| precioUnitario | DECIMAL | 10,2 | NOT NULL |
| subtotal | DECIMAL | 12,2 | NOT NULL |

#### TB_MovimientoInventario

| Campo | Tipo | Longitud | Restricción |
|---|---|---|---|
| idMovimiento | INT | - | PK, AUTO_INCREMENT |
| idInsumo | INT | - | FK → TB_Insumo |
| idLote | INT | - | FK → TB_Lote (nullable) |
| idOrdenCompra | INT | - | FK → TB_OrdenCompra (nullable) |
| idUsuario | INT | - | FK → TB_Usuario |
| fechaMovimiento | DATETIME | - | NOT NULL |
| tipoMovimiento | VARCHAR | 20 | NOT NULL (ENTRADA / SALIDA / AJUSTE) |
| cantidad | INT | - | NOT NULL |
| observaciones | VARCHAR | 250 | - |

#### Relaciones del modelo físico (PK-FK)

| Tabla origen | Campo FK | Tabla referenciada |
|---|---|---|
| TB_Insumo | idCategoria | TB_Categoria |
| TB_Lote | idInsumo | TB_Insumo |
| TB_SolicitudCompra | idUsuario | TB_Usuario |
| TB_Proforma | idProveedor | TB_Proveedor |
| TB_OrdenCompra | idSolicitud | TB_SolicitudCompra |
| TB_OrdenCompra | idProforma | TB_Proforma |
| TB_OrdenCompra | idProveedor | TB_Proveedor |
| TB_OrdenCompra | idUsuario | TB_Usuario |
| TB_OrdenCompra | idPresupuesto | TB_Presupuesto |
| TB_DetalleOrdenCompra | idOrdenCompra | TB_OrdenCompra |
| TB_DetalleOrdenCompra | idInsumo | TB_Insumo |
| TB_MovimientoInventario | idInsumo | TB_Insumo |
| TB_MovimientoInventario | idLote | TB_Lote |
| TB_MovimientoInventario | idOrdenCompra | TB_OrdenCompra |
| TB_MovimientoInventario | idUsuario | TB_Usuario |

---

## 5. Modelo de Diseño

**📁 Ruta en StarUML:** `Modelo de Análisis y Diseño / Modelo de Diseño`

### 5.1 Arquitectura en Capas (Vista de Capas y Subsistemas)

Diagrama de paquetes mostrando 3 capas con dependencias unidireccionales:

```
┌─────────────────────────────────────────┐
│         Capa de Presentación            │
│  (JSPs, HTML, CSS, JavaScript)          │
└───────────────┬─────────────────────────┘
                │ depends on
┌───────────────▼─────────────────────────┐
│         Capa de Negocio                 │
│  (Servlets, Services, Interfaces)       │
└───────────────┬─────────────────────────┘
                │ depends on
┌───────────────▼─────────────────────────┐
│         Capa de Datos                   │
│  (DAOs, Beans, ConexionBD, BD SQL)      │
└─────────────────────────────────────────┘
```

### 5.2 Módulo Gestión de Compras

**📁 Ruta:** `Modelo de Diseño / Gestion de Compras`

#### 5.2.1 📂 Modelo / Beans

Crear estas clases con sus atributos y getters/setters:

| Bean | Atributos |
|---|---|
| `OrdenCompraBean` | idOrdenCompra, idSolicitud, idProforma, idProveedor, idUsuario, idPresupuesto, fechaEmision, total, estado, observaciones |
| `ProveedorBean` | idProveedor, razonSocial, ruc, direccion, telefono, email, estado |
| `ProformaBean` | idProforma, idProveedor, fechaEmision, montoTotal, tiempoEntregaDias, estado |
| `DetalleOrdenCompraBean` | idDetalle, idOrdenCompra, idInsumo, cantidad, precioUnitario, subtotal |
| `SolicitudCompraBean` | idSolicitud, idUsuario, fechaSolicitud, urgencia, motivo, estado |
| `PresupuestoBean` | idPresupuesto, periodo, montoTotal, montoDisponible, estado |

#### 5.2.2 📂 Modelo / Servicios / Interfaces

| Interface | Operaciones |
|---|---|
| `IOrdenCompraServices` | `+ getOrdenes(): List`, `+ registrarOrden(OrdenCompraBean): boolean`, `+ modificarOrden(OrdenCompraBean): boolean`, `+ consultarOrden(int): OrdenCompraBean` |
| `IProveedorServices` | `+ getProveedores(): List`, `+ registrarProveedor(ProveedorBean): boolean`, `+ consultarProveedor(int): ProveedorBean` |
| `IProformaServices` | `+ getProformas(): List`, `+ registrarProforma(ProformaBean): boolean`, `+ compararProformas(int): List` |

#### 5.2.3 📂 Modelo / Servicios / Clases

Cada clase `Services` implementa su interfaz:

- `OrdenCompraServices` `«realizes»` `IOrdenCompraServices`, usa `OrdenCompraDAO`
- `ProveedorServices` `«realizes»` `IProveedorServices`, usa `ProveedorDAO`
- `ProformaServices` `«realizes»` `IProformaServices`, usa `ProformaDAO`

#### 5.2.4 📂 Modelo / DAO

| DAO | Operaciones principales |
|---|---|
| `OrdenCompraDAO` | constructor, `getOrdenes()`, `registrarOrden(OrdenCompraBean)`, `modificarOrden(OrdenCompraBean)`, `consultarOrden(int)` |
| `ProveedorDAO` | constructor, `getProveedores()`, `registrarProveedor(ProveedorBean)`, `consultarProveedor(int)` |
| `ProformaDAO` | constructor, `getProformas()`, `registrarProforma(ProformaBean)`, `compararProformas(int)` |

Cada DAO se asocia con `ConexionBD`, `ArrayList`, y su `Bean` correspondiente.

#### 5.2.5 📂 Modelo / Util

- `ConexionBD` — `+ getConnection(): Connection`
- `ArrayList` — utilidad de colección

#### 5.2.6 📂 Vista

JSPs (cada una asociada a un `frm`):

- `RegistrarOrdenCompra.jsp` ↔ `frmRegistrarOrdenCompra`
- `ConsultarProformas.jsp` ↔ `frmConsultarProformas`
- `ModificarOrdenCompra.jsp` ↔ `frmModificarOrdenCompra`
- `MenuPrincipal.jsp` ↔ `frmMenuPrincipal` (compartido)

#### 5.2.7 📂 Controlador (Servlets)

| Servlet | Operaciones |
|---|---|
| `OrdenCompraServlet` | constructor, `doGet(req, res)`, `doPost(req, res)`, usa `OrdenCompraServices` |
| `ProveedorServlet` | constructor, `doGet`, `doPost`, usa `ProveedorServices` |

#### 5.2.8 📊 Diagrama de Clases del Diseño — Compras

Integrar en un solo `ClassDiagram` todas las clases anteriores y dibujar:

- `«realization»` entre cada `Services` y su `Interface`
- `«association»` entre `Servlet` ↔ `Services`, `Services` ↔ `DAO`, `DAO` ↔ `Bean`, `DAO` ↔ `ConexionBD`, `DAO` ↔ `ArrayList`
- `«dependency»` entre `JSP` ↔ `Servlet`

#### 5.2.9 📊 Diagrama de Secuencia del Diseño — Compras

Crear una nueva `UMLCollaboration` `DSOrdenCompra` con un `UMLSequenceDiagram`:

##### Lifelines

| Lifeline | Tipo |
|---|---|
| `:RegistrarOrdenCompra.jsp` | JSP |
| `:OrdenCompraServlet` | Servlet |
| `:OrdenCompraServices` | Services |
| `:OrdenCompraDAO` | DAO |
| `:ConexionBD` | Util |
| `:OrdenCompraBean` | Bean |
| `:ArrayList` | Util |

##### Mensajes

| # | Origen | Destino | Mensaje |
|---|---|---|---|
| 1 | Usuario | `:RegistrarOrdenCompra.jsp` | `submitOrden(datos)` |
| 2 | `:RegistrarOrdenCompra.jsp` | `:OrdenCompraServlet` | `doPost(request, response)` |
| 3 | `:OrdenCompraServlet` | `:OrdenCompraServices` | `registrarOrden(bean)` |
| 4 | `:OrdenCompraServices` | `:OrdenCompraDAO` | `registrarOrden(bean)` |
| 5 | `:OrdenCompraDAO` | `:ConexionBD` | `getConnection()` |
| 6 | `:ConexionBD` | `:OrdenCompraDAO` | `connection` |
| 7 | `:OrdenCompraDAO` | `:OrdenCompraBean` | `new OrdenCompraBean(datos)` |
| 8 | `:OrdenCompraDAO` | `:ConexionBD` | `executeUpdate(INSERT...)` |
| 9 | `:OrdenCompraDAO` | `:ArrayList` | `add(bean)` |
| 10 | `:OrdenCompraDAO` | `:ConexionBD` | `close()` |
| 11 | `:OrdenCompraDAO` | `:OrdenCompraServices` | `resultado: boolean` |
| 12 | `:OrdenCompraServices` | `:OrdenCompraServlet` | `resultado: boolean` |
| 13 | `:OrdenCompraServlet` | `:RegistrarOrdenCompra.jsp` | `forward("confirmacion.jsp")` |

---

### 5.3 Módulo Gestión de Inventario

**📁 Ruta:** `Modelo de Diseño / Gestion de Inventario`

#### 5.3.1 📂 Modelo / Beans

| Bean | Atributos |
|---|---|
| `InsumoBean` | idInsumo, codigo, nombre, descripcion, unidadMedida, stockActual, stockMinimo, precioUnitario, idCategoria, estado |
| `MovimientoInventarioBean` | idMovimiento, idInsumo, idLote, idOrdenCompra, idUsuario, fechaMovimiento, tipoMovimiento, cantidad, observaciones |
| `LoteBean` | idLote, numeroLote, idInsumo, fechaIngreso, fechaVencimiento, cantidadInicial, cantidadActual, estado |
| `CategoriaBean` | idCategoria, nombre, descripcion, estado |
| `InventarioBean` | idInventario, fechaActualizacion, totalInsumos |

#### 5.3.2 📂 Modelo / Servicios / Interfaces

| Interface | Operaciones |
|---|---|
| `IInsumoServices` | `+ getInsumos()`, `+ registrarInsumo(InsumoBean)`, `+ actualizarStock(int, int)`, `+ consultarInsumo(int)` |
| `IMovimientoInventarioServices` | `+ getMovimientos()`, `+ registrarMovimiento(MovimientoInventarioBean)`, `+ consultarMovimientos(int)` |
| `ILoteServices` | `+ getLotes()`, `+ registrarLote(LoteBean)`, `+ verificarVencimientos()` |

#### 5.3.3 📂 Modelo / Servicios / Clases

- `InsumoServices` `«realizes»` `IInsumoServices`
- `MovimientoInventarioServices` `«realizes»` `IMovimientoInventarioServices`
- `LoteServices` `«realizes»` `ILoteServices`

#### 5.3.4 📂 Modelo / DAO

| DAO | Operaciones |
|---|---|
| `InsumoDAO` | constructor, `getInsumos()`, `registrarInsumo(InsumoBean)`, `actualizarStock(int, int)`, `consultarInsumo(int)` |
| `MovimientoInventarioDAO` | constructor, `getMovimientos()`, `registrarMovimiento(MovimientoInventarioBean)`, `consultarMovimientos(int)` |
| `LoteDAO` | constructor, `getLotes()`, `registrarLote(LoteBean)`, `verificarVencimientos()` |

#### 5.3.5 📂 Vista

- `RegistrarEntrada.jsp` ↔ `frmRegistrarEntradaInsumos`
- `ConsultarStock.jsp` ↔ `frmConsultarStock`
- `ActualizarStock.jsp` ↔ `frmActualizarStock`

#### 5.3.6 📂 Controlador (Servlets)

| Servlet | Operaciones |
|---|---|
| `InventarioServlet` | constructor, `doGet`, `doPost`, usa `InsumoServices`, `MovimientoInventarioServices`, `LoteServices` |

#### 5.3.7 📊 Diagrama de Clases del Diseño — Inventario

Integrar todas las clases anteriores con las mismas relaciones (`realization`, `association`, `dependency`) que el módulo Compras.

#### 5.3.8 📊 Diagrama de Secuencia del Diseño — Inventario

Nueva `UMLCollaboration` `DSEntradaInsumos` con un `UMLSequenceDiagram`:

##### Lifelines

| Lifeline | Tipo |
|---|---|
| `:RegistrarEntrada.jsp` | JSP |
| `:InventarioServlet` | Servlet |
| `:MovimientoInventarioServices` | Services |
| `:LoteServices` | Services |
| `:InsumoServices` | Services |
| `:MovimientoInventarioDAO` | DAO |
| `:LoteDAO` | DAO |
| `:InsumoDAO` | DAO |
| `:ConexionBD` | Util |
| `:MovimientoInventarioBean` | Bean |
| `:LoteBean` | Bean |

##### Mensajes

| # | Origen | Destino | Mensaje |
|---|---|---|---|
| 1 | Usuario | `:RegistrarEntrada.jsp` | `submitEntrada(datos)` |
| 2 | `:RegistrarEntrada.jsp` | `:InventarioServlet` | `doPost(request, response)` |
| 3 | `:InventarioServlet` | `:LoteServices` | `registrarLote(loteBean)` |
| 4 | `:LoteServices` | `:LoteDAO` | `registrarLote(loteBean)` |
| 5 | `:LoteDAO` | `:ConexionBD` | `getConnection()` |
| 6 | `:LoteDAO` | `:LoteBean` | `new LoteBean(datos)` |
| 7 | `:LoteDAO` | `:ConexionBD` | `executeUpdate(INSERT)` |
| 8 | `:LoteDAO` | `:LoteServices` | `idLote: int` |
| 9 | `:InventarioServlet` | `:MovimientoInventarioServices` | `registrarMovimiento(movBean)` |
| 10 | `:MovimientoInventarioServices` | `:MovimientoInventarioDAO` | `registrarMovimiento(movBean)` |
| 11 | `:MovimientoInventarioDAO` | `:ConexionBD` | `getConnection()` |
| 12 | `:MovimientoInventarioDAO` | `:MovimientoInventarioBean` | `new MovimientoInventarioBean(datos)` |
| 13 | `:MovimientoInventarioDAO` | `:ConexionBD` | `executeUpdate(INSERT)` |
| 14 | `:InventarioServlet` | `:InsumoServices` | `actualizarStock(idInsumo, cant)` |
| 15 | `:InsumoServices` | `:InsumoDAO` | `actualizarStock(idInsumo, cant)` |
| 16 | `:InsumoDAO` | `:ConexionBD` | `executeUpdate(UPDATE stockActual)` |
| 17 | `:InsumoDAO` | `:InsumoServices` | `resultado: boolean` |
| 18 | `:InventarioServlet` | `:RegistrarEntrada.jsp` | `forward("confirmacion.jsp")` |

---

## 6. Programación de las Clases

> 🔨 **Responsable de cada clase:** el integrante asignado al módulo. Wiliam genera `ConexionBD.java`.
> Lenguaje: **Java**. Cada archivo se pega en la sección 4.3.3 del Word con captura del IDE compilando sin errores.

### 6.1 Plantilla genérica — `ConexionBD.java` (Wiliam)

```java
package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {
    private static final String URL = "jdbc:mysql://localhost:3306/hospitaldb";
    private static final String USER = "root";
    private static final String PASSWORD = "admin";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver JDBC no encontrado", e);
        }
    }

    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
```

### 6.2 Plantilla — Bean

Estructura para cada Bean. Reemplazar `[Entidad]` y los atributos según corresponda:

```java
package beans;

public class [Entidad]Bean {
    // Atributos privados
    private int id[Entidad];
    private String campo1;
    private double campo2;
    // ... más atributos

    // Constructor vacío
    public [Entidad]Bean() { }

    // Constructor con parámetros
    public [Entidad]Bean(int id[Entidad], String campo1, double campo2) {
        this.id[Entidad] = id[Entidad];
        this.campo1 = campo1;
        this.campo2 = campo2;
    }

    // Getters y Setters
    public int getId[Entidad]() { return id[Entidad]; }
    public void setId[Entidad](int id[Entidad]) { this.id[Entidad] = id[Entidad]; }
    public String getCampo1() { return campo1; }
    public void setCampo1(String campo1) { this.campo1 = campo1; }
    public double getCampo2() { return campo2; }
    public void setCampo2(double campo2) { this.campo2 = campo2; }
}
```

### 6.3 Plantilla — DAO

```java
package dao;

import beans.[Entidad]Bean;
import util.ConexionBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class [Entidad]DAO {

    public [Entidad]DAO() { }

    public boolean registrar[Entidad]([Entidad]Bean bean) {
        String sql = "INSERT INTO TB_[Entidad] (campo1, campo2) VALUES (?, ?)";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, bean.getCampo1());
            ps.setDouble(2, bean.getCampo2());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public [Entidad]Bean consultar[Entidad](int id) {
        String sql = "SELECT * FROM TB_[Entidad] WHERE id[Entidad] = ?";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new [Entidad]Bean(
                    rs.getInt("id[Entidad]"),
                    rs.getString("campo1"),
                    rs.getDouble("campo2")
                );
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public List<[Entidad]Bean> get[Entidad]s() {
        List<[Entidad]Bean> lista = new ArrayList<>();
        String sql = "SELECT * FROM TB_[Entidad]";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(new [Entidad]Bean(
                    rs.getInt("id[Entidad]"),
                    rs.getString("campo1"),
                    rs.getDouble("campo2")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return lista;
    }

    public boolean modificar[Entidad]([Entidad]Bean bean) {
        String sql = "UPDATE TB_[Entidad] SET campo1=?, campo2=? WHERE id[Entidad]=?";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, bean.getCampo1());
            ps.setDouble(2, bean.getCampo2());
            ps.setInt(3, bean.getId[Entidad]());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }
}
```

### 6.4 Archivos Java mínimos a entregar

| Archivo | Responsable | Módulo |
|---|---|---|
| `ConexionBD.java` | Wiliam | Util |
| `OrdenCompraBean.java` | Rony | Compras |
| `OrdenCompraDAO.java` | Rony | Compras |
| `ProveedorBean.java` | Astrid | Compartido |
| `ProveedorDAO.java` | Astrid | Compartido |
| `ProformaBean.java` | Rony | Compras |
| `ProformaDAO.java` | Rony | Compras |
| `InsumoBean.java` | Cristhian | Inventario |
| `InsumoDAO.java` | Cristhian | Inventario |
| `MovimientoInventarioBean.java` | Cristhian | Inventario |
| `MovimientoInventarioDAO.java` | Cristhian | Inventario |
| `LoteBean.java` | Astrid | Compartido |
| `LoteDAO.java` | Astrid | Compartido |
| `CategoriaBean.java` (opcional) | Astrid | Compartido |
| `CategoriaDAO.java` (opcional) | Astrid | Compartido |

**Total mínimo: 13 archivos Java** (1 ConexionBD + 6 Beans + 6 DAOs).

---

## 7. Diagrama de Componentes

**📁 Ruta:** `Modelo de Diseño / Componentes y Despliegues / Componentes`

> El diagrama actual ya existe parcialmente. Solo hay que ajustarlo:

### 7.1 Correcciones

1. Renombrar `Component4` a `EmailService` o eliminarlo
2. Agregar operaciones a la interfaz `IServices`:
   - `+ registrar(bean): boolean`
   - `+ consultar(id): bean`
   - `+ modificar(bean): boolean`
   - `+ listar(): List`

### 7.2 Componentes finales

| Componente | Estereotipo | Interfaces |
|---|---|---|
| Vistas | `«component»` | (depende de) IServlet, IJavaScript, ICSS |
| JavaScript | `«component»` | (provee) IJavaScript |
| CSS | `«component»` | (provee) ICSS |
| Controlador (Servlets) | `«component»` | (depende de) IServices |
| Services | `«component»` | (provee) IServices; (depende de) IDAO |
| DAO | `«component»` | (provee) IDAO; (depende de) IBeans, IUtil, IORM |
| Beans | `«component»` | (provee) IBeans |
| Util | `«component»` | (provee) IUtil |
| EntityFramework | `«component»` | (provee) IORM |
| SQLServer | `«component»` | (provee) IDB |

### 7.3 Dependencias (ya están en el modelo, solo verificar)

```
usuarios → Vistas
Controlador → Vistas
Vistas → JavaScript
Vistas → CSS
JavaScript → CSS
Services → DAO
DAO → Beans
DAO → Util
DAO → EntityFramework
DAO → SQLServer
```

---

## 8. Diagrama de Despliegue

**📁 Ruta:** `Modelo de Diseño / Componentes y Despliegues / Despliegue`

> El `DeploymentDiagram1` está vacío. Crear los siguientes nodos y conexiones:

### 8.1 Nodos

| Nodo | Estereotipo | Descripción |
|---|---|---|
| PC Cliente Farmacia | `«device»` | Estación de trabajo del Jefe de Farmacia |
| PC Cliente Almacén | `«device»` | Estación del Técnico de Almacén |
| PC Cliente Compras | `«device»` | Estación del Jefe de Compra |
| Impresora | `«device»` | Para órdenes y reportes |
| Navegador Web | `«componentInstance»` | Cliente de la aplicación (Chrome/Edge) |
| Switch | `«node»` | Red local del hospital |
| Router | `«node»` | Enrutador de red |
| Firewall | `«node»` | Seguridad de red |
| Servidor Web | `«node»` | Aloja la aplicación web (Apache Tomcat) |
| Servidor de Base de Datos | `«node»` | Hospeda MySQL/SQL Server |
| Servidor de Aplicaciones | `«component»` | Dentro del Servidor Web (Spring/JEE) |

### 8.2 Conexiones (CommunicationPath)

| Origen | Destino | Protocolo |
|---|---|---|
| PC Cliente Farmacia | Switch | Inalámbrico/Ethernet |
| PC Cliente Almacén | Switch | Inalámbrico/Ethernet |
| PC Cliente Compras | Switch | Inalámbrico/Ethernet |
| Impresora | Switch | Inalámbrico |
| Switch | Router | Ethernet |
| Router | Firewall | Ethernet |
| Firewall | Servidor Web | HTTPS |
| Servidor Web | Servidor de Base de Datos | JDBC |

### 8.3 Componentes desplegados

- En **Navegador Web**: HTML, CSS, JavaScript
- En **Servidor Web**: Servlets, Services, DAO, Beans, JSPs
- En **Servidor de Base de Datos**: TB_Usuario, TB_Insumo, TB_OrdenCompra, etc.

---

## 9. Checklist final de StarUML

### 9.1 Correcciones obligatorias (todos)

- [ ] Eliminar el paquete `Gestion de distribucion interna` en los 3 modelos (Análisis, Diseño)
- [ ] Renombrar todas las clases `EN_*` → `ES_*` en el Modelo de Análisis
- [ ] Eliminar `Entity5` del módulo Inventario
- [ ] Eliminar o renombrar `Component4` en el Diagrama de Componentes
- [ ] Renombrar las 2 `Collaboration1` → `RCUS_RegistrarOrdenCompra` y `RCUS_RegistrarEntradaInsumos`
- [ ] Renombrar todas las clases `Vista` genéricas (Consultar/Registrar/Modificar) con sus nombres `frm*` específicos

### 9.2 Modelo de Análisis (Rony + Cristhian)

- [ ] Todas las clases del Modelo tienen atributos con tipos (no vacías)
- [ ] Todas las clases del Modelo tienen al menos 3 operaciones
- [ ] Los Class Diagrams del Modelo tienen las asociaciones dibujadas
- [ ] Las 2 Realizaciones tienen lifelines con nombres reales (no `Role1...Role6`)
- [ ] Las 2 Realizaciones tienen al menos 10 mensajes con firmas reales (no `Message1`)
- [ ] Cada Realización tiene **DOS** diagramas: Comunicación + Secuencia (no solo uno)

### 9.3 Modelo de Datos (Wiliam)

- [ ] Existe el paquete `Modelo de Datos` con 3 sub-paquetes
- [ ] Modelo Conceptual con 11+ entidades del dominio y sus relaciones
- [ ] Modelo Lógico con tipos de datos, multiplicidades y FK marcadas
- [ ] Modelo Físico con `ERDDataModel` que contiene 11+ tablas `TB_*` con todos los campos
- [ ] Todas las relaciones PK-FK dibujadas en el ERD

### 9.4 Modelo de Diseño (Rony + Cristhian)

- [ ] Cada módulo tiene sub-paquetes Modelo (Servicios/DAO/Beans/Util), Vista, Controlador
- [ ] Cada módulo tiene su Diagrama de Clases del Diseño integrado
- [ ] Cada módulo tiene su Diagrama de Secuencia del Diseño con lifelines `:JSP → :Servlet → :Services → :DAO → :ConexionBD → :Bean`
- [ ] Interfaces `I[Entidad]Services` con sus operaciones definidas
- [ ] Relaciones `«realization»` entre Services e Interfaces dibujadas
- [ ] Diagrama de Componentes corregido (sin Component4, IServices con operaciones)
- [ ] Diagrama de Despliegue completo con al menos 8 nodos y sus conexiones

### 9.5 Programación

- [ ] `ConexionBD.java` listo y compila
- [ ] 6 Beans listos (3 por módulo + compartidos)
- [ ] 6 DAOs listos (3 por módulo + compartidos)
- [ ] Cada archivo está copiado en el Word con captura del IDE compilando

### 9.6 Informe Word

- [ ] Carátula con todos los datos del Equipo 5
- [ ] Sección 1: Introducción completa
- [ ] Sección 2: Resumen de Casos de Uso (CUS01 + CUS02)
- [ ] Sección 3.1: Captura del Diagrama de Paquetes
- [ ] Sección 3.2: Capturas de Realizaciones + descripción textual de los escenarios
- [ ] Sección 3.3: Captura del Modelo Conceptual
- [ ] Sección 3.4: Metas y Restricciones (de los RNF del Avance 1)
- [ ] Sección 4.1: Captura del Modelo Lógico
- [ ] Sección 4.2: Captura del Modelo Físico + diccionario de datos
- [ ] Sección 4.3.1: Captura del Diagrama de Capas
- [ ] Sección 4.3.2: Capturas de los Diagramas de Clases y Secuencia del Diseño
- [ ] Sección 4.3.3: Código fuente de las clases + capturas del IDE

### 9.7 Entrega en Canvas (Wiliam)

- [ ] Informe convertido a PDF
- [ ] Archivo `.mdj` comprimido en `.zip` o `.7z`
- [ ] Ambos archivos subidos por separado en Canvas
- [ ] Confirmación al equipo por chat con captura

---

## 📅 Cronograma resumido

| Día | Wiliam | Rony | Cristhian | Astrid |
|---|---|---|---|---|
| **Mié 20** mañana | Modelo Conceptual + Lógico | Limpieza + Atributos/Ops Modelo Compras | Limpieza + Atributos/Ops Modelo Inventario | Limpieza entidades compartidas (Lote, Categoria) |
| **Mié 20** tarde | Modelo Físico (ERD) | Realización Compras (Com + Sec) | Realización Inventario (Com + Sec) | Apoya con asociaciones en class diagrams |
| **Mié 20** noche | Diagrama de Despliegue + Word sec.1-3 | Vista + Controlador con detalle | Vista + Controlador con detalle | Modelo Conceptual revisión con Wiliam |
| **Jue 21** mañana | Word sec.4 + Componentes corregido | Modelo Diseño Compras completo | Modelo Diseño Inventario completo | Beans/DAOs compartidos (Lote, Categoria, Proveedor) |
| **Jue 21** tarde | ConexionBD.java + integración | Código Compras (OC, Proforma) | Código Inventario (Insumo, Movimiento) | Termina código compartido |
| **Jue 21** noche | PDF + zip + Canvas | Envía a Wiliam | Envía a Wiliam | Envía a Wiliam |

---

**Fin del documento — Guía v1.0**
**Última actualización:** 2026-05-19
