<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<div class="container-fluid">
    <!-- Encabezado -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-0">Recepción en Almacén</h3>
            <p class="text-muted mb-0">Registrar el ingreso físico de mercadería y actualizar el stock (Kardex).</p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/inventario?action=listar" class="btn btn-outline-secondary shadow-sm">
                <i class="fas fa-history me-1"></i> Historial de Entradas
            </a>
        </div>
    </div>

    <!-- Formulario de Recepción -->
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="card shadow-sm border-0 mb-4">
                <div class="card-header bg-primary text-white py-3 d-flex align-items-center">
                    <i class="fas fa-truck-loading fa-lg me-2"></i>
                    <h5 class="m-0 fw-bold">Guía de Ingreso</h5>
                </div>
                
                <div class="card-body p-4">
                    <form id="formEntrada" method="post" action="${pageContext.request.contextPath}/inventario" novalidate>
                        
                        <div class="row g-4">
                            <!-- Sección 1: Documento Origen -->
                            <div class="col-12">
                                <h6 class="text-primary fw-bold border-bottom pb-2 mb-3"><i class="fas fa-link me-2"></i>1. Documento de Origen</h6>
                                <div class="row g-3">
                                    <div class="col-md-8">
                                        <label for="idOrdenCompra" class="form-label">Vincular a Orden de Compra Aprobada *</label>
                                        <select class="form-select border-primary bg-primary-subtle" name="idOrdenCompra" id="idOrdenCompra" required>
                                            <option value="" disabled selected>Seleccione la OC correspondiente...</option>
                                            <c:forEach var="ord" items="${ordenes}">
                                                <option value="${ord.idOrdenCompra}">#OC-${ord.idOrdenCompra} - Total: S/ ${ord.total} - Proveedor: ${ord.idProveedor}</option>
                                            </c:forEach>
                                            <c:if test="${empty ordenes}">
                                                <option value="" disabled>No hay órdenes pendientes</option>
                                            </c:if>
                                        </select>
                                        <div class="invalid-feedback">Debe asociar la entrada a una Orden de Compra.</div>
                                    </div>
                                    
                                    <div class="col-md-4">
                                        <label class="form-label text-muted small fw-bold">Técnico Receptor</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-user"></i></span>
                                            <input type="text" class="form-control bg-light" value="${not empty sessionScope.usuarioLogueado ? sessionScope.usuarioLogueado.nombre : 'Técnico Almacén'}" readonly>
                                        </div>
                                        <input type="hidden" name="idUsuario" value="${not empty sessionScope.usuarioLogueado ? sessionScope.usuarioLogueado.idUsuario : 3}">
                                    </div>
                                </div>
                            </div>

                            <!-- Sección 2: Detalle Físico del Insumo -->
                            <div class="col-12 mt-4">
                                <h6 class="text-primary fw-bold border-bottom pb-2 mb-3"><i class="fas fa-box me-2"></i>2. Detalle del Producto Recibido</h6>
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label for="idInsumo" class="form-label">Insumo Recibido *</label>
                                        <select class="form-select" name="idInsumo" id="idInsumo" required disabled>
                                            <option value="" disabled selected>Primero seleccione una Orden de Compra...</option>
                                        </select>
                                    </div>

                                    <div class="col-md-3">
                                        <label for="cantidad" class="form-label">Cantidad (Unidades) *</label>
                                        <input type="number" class="form-control text-end fw-bold" name="cantidad" id="cantidad" min="1" required placeholder="Ej. 50">
                                    </div>
                                </div>
                            </div>

                            <!-- Sección 3: Datos Clínicos (Lote y Vencimiento) -->
                            <div class="col-12 mt-4">
                                <div class="p-3 bg-warning-subtle border border-warning rounded">
                                    <h6 class="text-warning-emphasis fw-bold mb-3"><i class="fas fa-shield-virus me-2"></i>3. Trazabilidad Sanitaria Obligatoria</h6>
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label for="numeroLote" class="form-label fw-bold">Número de Lote *</label>
                                            <input type="text" class="form-control text-uppercase" name="numeroLote" id="numeroLote" required placeholder="Lote impreso en caja" oninput="this.value = this.value.toUpperCase()">
                                        </div>

                                        <div class="col-md-6">
                                            <label for="fechaVencimiento" class="form-label fw-bold">Fecha de Caducidad *</label>
                                            <input type="date" class="form-control" name="fechaVencimiento" id="fechaVencimiento" required>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Sección 4: Extras -->
                            <div class="col-12 mt-4">
                                <label for="observaciones" class="form-label">Incidencias u Observaciones visuales</label>
                                <textarea class="form-control" name="observaciones" id="observaciones" rows="2" placeholder="Ej. 2 cajas llegaron con abolladuras leves, pero selladas."></textarea>
                            </div>
                        </div>

                        <hr class="my-4">

                        <div class="d-flex justify-content-between align-items-center">
                            <span class="text-muted small"><i class="fas fa-info-circle me-1"></i> Verificar lote y caducidad antes de guardar.</span>
                            <button type="submit" class="btn btn-primary btn-lg fw-bold px-5" id="btnRegistrar">
                                <i class="fas fa-save me-2"></i> Confirmar Ingreso a Kardex
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Validación HTML5 para que Fecha de Vencimiento sea mayor a hoy
        const hoy = new Date();
        hoy.setDate(hoy.getDate() + 1); // Mínimo mañana
        const maanaStr = hoy.toISOString().split('T')[0];
        document.getElementById('fechaVencimiento').setAttribute('min', maanaStr);

        // --- Filtrado dinámico de Insumos por Orden de Compra ---
        const selectOC = document.getElementById('idOrdenCompra');
        const selectInsumo = document.getElementById('idInsumo');
        const inputCantidad = document.getElementById('cantidad');
        
        selectOC.addEventListener('change', function() {
            const idOrden = this.value;
            if(!idOrden) return;
            
            selectInsumo.disabled = true;
            selectInsumo.innerHTML = '<option value="" disabled selected>Cargando insumos...</option>';
            inputCantidad.value = '';
            
            fetch('${pageContext.request.contextPath}/orden-compra?action=detalles_json&idOrdenCompra=' + idOrden)
                .then(response => response.json())
                .then(data => {
                    selectInsumo.innerHTML = '<option value="" disabled selected>Seleccione el insumo recibido...</option>';
                    
                    if (data && data.length > 0) {
                        data.forEach(det => {
                            const opt = document.createElement('option');
                            opt.value = det.idInsumo;
                            opt.text = det.codigoInsumo + ' - ' + det.nombreInsumo + ' (Pendientes: ' + det.cantidad + ' unid)';
                            opt.setAttribute('data-max', det.cantidad);
                            selectInsumo.appendChild(opt);
                        });
                        selectInsumo.disabled = false;
                        
                        Swal.fire({
                            toast: true, position: 'top-end', showConfirmButton: false, timer: 3000,
                            icon: 'success', title: 'Insumos de la OC cargados correctamente.'
                        });
                    } else {
                        selectInsumo.innerHTML = '<option value="" disabled selected>Esta OC no tiene insumos o ya fue procesada</option>';
                        Swal.fire('Atención', 'La Orden de Compra seleccionada no tiene insumos pendientes de recibir.', 'warning');
                    }
                })
                .catch(err => {
                    console.error("Error obteniendo detalles:", err);
                    selectInsumo.innerHTML = '<option value="" disabled selected>Error de conexión</option>';
                    Swal.fire('Error', 'No se pudieron cargar los insumos de la orden.', 'error');
                });
        });

        // Opcional: auto-validar que la cantidad ingresada no supere lo pedido en la OC
        selectInsumo.addEventListener('change', function() {
            const selectedOpt = this.options[this.selectedIndex];
            if(selectedOpt && selectedOpt.hasAttribute('data-max')) {
                inputCantidad.max = selectedOpt.getAttribute('data-max');
            }
        });

        const formEntrada = document.getElementById('formEntrada');
        formEntrada.addEventListener('submit', function (event) {
            if (!formEntrada.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
                formEntrada.classList.add('was-validated');
                Swal.fire('Formulario Incompleto', 'Debe registrar la OC, Insumo, Cantidad, Lote y Caducidad.', 'warning');
            } else {
                event.preventDefault(); // Interceptamos para efecto visual UX
                const errorMsg = document.getElementById('errorMsg');
                if (errorMsg) {
                    Swal.fire('Error', errorMsg.value, 'error');
                }

                const btn = document.getElementById('btnRegistrar');
                btn.disabled = true;
                
                // Alert de carga y submit por AJAX para evitar redirección
                Swal.fire({
                    title: 'Procesando...',
                    text: 'Registrando la entrada en almacén',
                    allowOutsideClick: false,
                    didOpen: () => {
                        Swal.showLoading();
                    }
                });

                const formData = new FormData(formEntrada);
                const params = new URLSearchParams();
                for (const pair of formData) {
                    params.append(pair[0], pair[1]);
                }

                fetch(formEntrada.action || window.location.href, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: params
                })
                .then(response => response.text())
                .then(html => {
                    let mensajeExito = 'El ingreso al Kardex se registró exitosamente.';
                    // Si el backend imprime algún texto confirmando ID, lo extraemos
                    const match = html.match(/(Entrada registrada con ID:\s*\d+|Operación realizada)/i);
                    if (match) mensajeExito = match[1];

                    Swal.fire({
                        icon: 'success',
                        title: '¡Ingreso Completado!',
                        text: mensajeExito,
                        confirmButtonText: 'Aceptar',
                        confirmButtonColor: '#0d6efd'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            window.location.reload();
                        }
                    });
                })
                .catch(error => {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Hubo un problema al registrar la entrada.'
                    });
                    btn.disabled = false;
                });
            }
        }, false);
    });
</script>
