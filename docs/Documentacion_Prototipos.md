# Documentación Visual de Prototipos UI/UX
**Sistema Hospitalario de Inventario (SigInv Pro)**

Este documento consolida la arquitectura de interfaces y los wireframes conceptuales de todos los módulos del sistema, diseñados bajo el estándar de **Bootstrap 5, DataTables y SweetAlert2**, aplicando principios de Interacción Humano-Computadora (IHC) para software empresarial.

---

## 1. Módulo de Autenticación y Entorno (Layout)

### 1.1 Login de Acceso (`login.jsp`)
Punto de entrada seguro. Diseñado con una estructura bicolumnar asimétrica (Split Screen) típica en SaaS médicos.

```text
================================================================
| [ 🏥 Foto Hospital / Branding ] |  SigInv Pro                |
| [                             ] |                            |
| [ "Innovación en logística"   ] |  DNI: [ 71234567 👤 ]      |
| [                             ] |  Clave: [ ******** 🔒 ]    |
| [                             ] |                            |
| [                             ] |      [ Ingresar al Sistema]|
================================================================
```

### 1.2 Layout Base (Sidebar + Topbar)
El cascarón que envuelve todas las pantallas, implementado mediante `includes/sidebar.jsp` y `includes/header.jsp`. Utiliza un tema "Dark Slate" para evitar fatiga visual.

```text
================================================================
| 🏥 SigInv Pro     | ☰ Área de Trabajo             [👤 JP] ⌄ |
|-------------------|------------------------------------------|
| NAVEGACIÓN        |                                          |
| 🏠 Dashboard      |   ( Área de contenido principal )        |
|                   |                                          |
| CATÁLOGOS         |   - Tarjetas KPI                         |
| 🗄️ Datos Maestros ⌄ |   - Formularios                          |
|   - Categorías    |   - Tablas de Datos (DataTables)         |
|   - Insumos       |                                          |
|   - Proveedores   |                                          |
|                   |                                          |
| COMPRAS           |                                          |
| 🛒 Adquisiciones ⌄ |                                          |
|   - Proformas     |                                          |
|   - Órdenes (OC)  |                                          |
================================================================
```

---

## 2. Módulo de Datos Maestros (Catálogos)

Gestión de entidades base. Comparten un diseño CRUD unificado: Botón superior derecho para registrar, tabla central con filtros, e interacciones mediante modales.

### 2.1 Catálogo de Insumos (`insumos.jsp`)
```text
================================================================
| Gestión de Insumos Médicos                  [ ➕ Nuevo Insumo]|
|--------------------------------------------------------------|
| Buscar: [ paracetamol ]                                      |
|                                                              |
| Cód.    | Insumo y Categoría  | Min. | Medida  | Acciones    |
| INS-001 | Paracetamol 500mg   | 50   | Caja    | [✏️] [🗑️]   |
|         | Medicamentos Grales |      |         |             |
|--------------------------------------------------------------|
| [Modal Registro Insumo]                                      |
| Categoría*: [ 💊 Medicamentos ⌄ ]                            |
| Nombre*: [ Paracetamol 500mg ]   Código*: [ INS-001 ]        |
| Medida*: [ Caja x 100 ⌄ ]        Mínimo*: [ 50 ]             |
|                  [ Cancelar ] [ Guardar Insumo ]             |
================================================================
```

---

## 3. Módulo de Gestión de Compras

El flujo logístico financiero.

### 3.1 Registrar Orden de Compra (`RegistrarOrdenCompra.jsp`)
Pantalla de captura de datos transaccionales, autocompletando datos del empleado (sesión).

```text
================================================================
| Emitir Orden de Compra                        [ 📄 Historial ]|
|--------------------------------------------------------------|
| Proveedor Adjudicado *: [ PROV-111 - Insumos Médicos S.A ⌄ ] |
| Responsable: 👤 [ Juan Pérez (Automático) ]                  |
|--------------------------------------------------------------|
| [ + Agregar Ítem a la OC ]                                   |
| Insumo              | Cantidad | P. Unit (S/) | Subtotal     |
| [ Paracetamol ⌄ ]   | [ 500 ]  | [ 25.50 ]    | S/ 12,750.00 |
| [ Jeringas 10ml ⌄ ] | [ 1000 ] | [ 1.20 ]     | S/ 1,200.00  |
|                                                              |
| 💰 Total General a Pagar: S/ 13,950.00                        |
|                                  [ Emitir Orden Formal ]     |
================================================================
```

### 3.2 Gestión de Presupuestos (`GestionarPresupuestos.jsp`)
Panel mixto: Formulario de asignación y tabla de control (Kardex Financiero) con barras de progreso.

```text
================================================================
| Gestión de Presupuestos                                      |
|--------------------------------------------------------------|
| 💰 Nueva Asignación | 📊 Control de Ejecución Presupuestal   |
| Periodo *:          |                                        |
| [ 2026-2          ] | ID | Periodo | Total   | Ejecución     |
| Monto S/ *:         | 1  | 2026-1  | 500,000 | [██████░░] 70%|
| [ 800000.00       ] | 2  | 2026-2  | 800,000 | [█░░░░░░░] 5% |
|                     |                                        |
| [ Aperturar ]       |                                        |
================================================================
```

---

## 4. Módulo de Operaciones de Almacén (Inventario)

Control físico de mercadería. Uso intensivo de semántica de colores (Rojo = Peligro).

### 4.1 Dashboard de Alertas Críticas (`ConsultarAlertas.jsp`)
Panel bicolumnar pasivo. Solo muestra datos cuando hay quiebres de stock o vencimientos.

```text
================================================================
| Panel de Alertas Críticas                    [ ✉️ Notificar ] |
|--------------------------------------------------------------|
| [ 📦 Quiebre de Stock (Mínimos) ] | [ 🛡️ Riesgo Sanitario (30d) ] |
|                                   |                              |
| Amoxicilina 250 (INS-0002)        | Lote: L-998822 (Suero)       |
| Min: 20 | Actual: 5   [Comprar]   | Vence: 30/06/2026 [Dar Baja] |
================================================================
```

### 4.2 Registro de Entrada (`RegistrarEntrada.jsp`)
Formulario por bloques que exige datos sanitarios críticos (Lote/Vencimiento).

```text
================================================================
| Recepción en Almacén                        [ 🕒 Historial ] |
|--------------------------------------------------------------|
| 1. Documento de Origen                                       |
| Orden de Compra *: [ OC-015 - Dist. Médica ⌄ ]               |
|--------------------------------------------------------------|
| 2. Detalle del Producto Recibido                             |
| Insumo *: [ Paracetamol 500mg ⌄ ]   Cantidad *: [ 50 ]       |
|--------------------------------------------------------------|
| 3. Trazabilidad Sanitaria Obligatoria (Caja Amarilla)        |
| Lote *: [ L-998822 ]   Vencimiento *: [ 12/12/2028 📅 ]      |
|                                                              |
|                     [ Confirmar Ingreso a Kardex ]           |
================================================================
```

### 4.3 Registrar Ajuste / Salida (`RegistrarAjuste.jsp`)
Formulario Reactivo (Polimorfismo de Interfaz). Cambia dependiendo de la naturaleza elegida.

```text
================================================================
| Salida y Ajuste de Inventario                                |
|--------------------------------------------------------------|
| Naturaleza *: [ 📦 Salida (Despacho a Área Médica) ⌄ ]       |
|                                                              |
| Insumo *: [ INS-001 Paracetamol (Disp: 120) ⌄ ]              |
| Cantidad a restar *: [ 50 ] unidades (Máx: 120)              |
|                                                              |
| Área Solicitante * (Aparece dinámicamente)                   |
| [ UCI (Cuidados Intensivos) ⌄ ]                              |
|                                                              |
|                    [ ➖ Procesar Movimiento ]                |
================================================================
```

---

## 5. Módulo de Seguridad

### 5.1 Gestión de Usuarios (`usuarios.jsp`)
Control de Acceso basado en Roles (RBAC) con avatares visuales y validaciones estrictas.

```text
================================================================
| Gestión de Usuarios                       [ ➕ Registrar ]    |
|--------------------------------------------------------------|
| DNI      | Nombres         | Rol           | Estado | Acción |
| 71234567 | (JP) Juan Pérez | ADMINISTRADOR | Activo | [✏️] [🚫]|
| 40556677 | (MR) María R.   | ALMACEN       | Activo | [✏️] [🚫]|
|--------------------------------------------------------------|
| [Modal de Edición]                                           |
| El DNI está bloqueado por integridad referencial.            |
| La clave es opcional al editar.                              |
================================================================
```

> [!TIP]
> **Decisiones de Diseño UX:**
> - **Reducción de Clics:** Todas las tablas permiten acciones rápidas (modales) sin salir de la vista actual.
> - **Prevención de Errores (Poka-Yoke):** Se bloquea la creación de salidas mayores al stock actual mediante atributos `max` inyectados en tiempo real con JavaScript.
> - **Feedback Inmediato:** Uso de SweetAlert2 en el 100% de las transacciones (Alta, Baja, Modificación) para confirmar al usuario que su acción tuvo éxito en el servidor.
