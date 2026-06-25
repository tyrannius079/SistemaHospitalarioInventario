<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<div class="container-fluid">
    <!-- Encabezado -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-0">Generar Orden de Compra</h3>
            <p class="text-muted mb-0">Formalización de la adquisición a proveedores adjudicados.</p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/ConsultarOrdenes.jsp" class="btn btn-outline-secondary shadow-sm">
                <i class="fas fa-list me-1"></i> Ver Órdenes
            </a>
        </div>
    </div>

    <!-- Formulario -->
    <form id="formOrdenCompra" action="${pageContext.request.contextPath}/orden-compra" method="POST" novalidate>
        
        <div class="row">
            <!-- Columna Izquierda: Datos del Documento -->
            <div class="col-lg-8">
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-white py-3">
                        <h6 class="m-0 fw-bold text-primary"><i class="fas fa-file-contract me-2"></i>Cabecera de la Orden</h6>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-4">
                                <label class="form-label text-muted small fw-bold">N° Orden (Auto)</label>
                                <input type="text" class="form-control bg-light text-secondary fw-bold text-center" value="Generado Automáticamente" readonly tabindex="-1">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label text-muted small fw-bold">Fecha de Emisión</label>
                                <!-- Prellenado por JS con la fecha actual -->
                                <input type="date" class="form-control bg-light" id="fechaEmision" name="fechaEmision" readonly tabindex="-1">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label text-muted small fw-bold">Estado Inicial</label>
                                <input type="text" class="form-control bg-light text-success fw-bold" name="estado" value="EMITIDA" readonly tabindex="-1">
                            </div>

                            <div class="col-md-6">
                                <label for="idProveedor" class="form-label">Proveedor Adjudicado *</label>
                                <!-- Preselección vía URL si viene de compararProformas -->
                                <select class="form-select" id="idProveedor" name="idProveedor" required>
                                    <option value="" disabled ${empty param.provId ? 'selected' : ''}>Seleccione...</option>
                                    <c:forEach var="prov" items="${proveedores}">
                                        <option value="${prov.idProveedor}" ${param.provId == prov.idProveedor ? 'selected' : ''}>
                                            ${prov.razonSocial} (${prov.ruc})
                                        </option>
                                    </c:forEach>
                                    <c:if test="${empty proveedores}">
                                        <option value="" disabled>No hay proveedores registrados</option>
                                    </c:if>
                                </select>
                                <div class="invalid-feedback">Obligatorio.</div>
                            </div>

                            <div class="col-md-6">
                                <label for="idProforma" class="form-label">Proforma de Referencia *</label>
                                <select class="form-select" id="idProforma" name="idProforma" required>
                                    <option value="" selected disabled>Seleccione Proforma...</option>
                                    <c:forEach var="prof" items="${proformas}">
                                        <option value="${prof.idProforma}" data-proveedor="${prof.idProveedor}">#${prof.idProforma} - Total: S/ ${prof.montoTotal}</option>
                                    </c:forEach>
                                    <c:if test="${empty proformas}">
                                        <option value="" disabled>No hay proformas vigentes</option>
                                    </c:if>
                                </select>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="idPresupuesto" class="form-label">Partida Presupuestal *</label>
                                <select class="form-select" id="idPresupuesto" name="idPresupuesto" required>
                                    <option value="" selected disabled>Seleccione Presupuesto...</option>
                                    <c:forEach var="pres" items="${presupuestos}">
                                        <option value="${pres.idPresupuesto}">${pres.periodo} - Disp: S/ ${pres.montoDisponible}</option>
                                    </c:forEach>
                                    <c:if test="${empty presupuestos}">
                                        <option value="" disabled>No hay presupuestos activos</option>
                                    </c:if>
                                </select>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="idSolicitud" class="form-label">ID Solicitud / Requerimiento</label>
                                <input type="number" class="form-control" id="idSolicitud" name="idSolicitud" placeholder="Ej. 1002" required>
                            </div>

                            <div class="col-12">
                                <label for="observaciones" class="form-label">Observaciones</label>
                                <textarea class="form-control" id="observaciones" name="observaciones" rows="2" placeholder="Condiciones de entrega, lugar, etc."></textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Columna Completa: Detalle de la Orden -->
            <div class="col-lg-12 mt-2">
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                        <h6 class="m-0 fw-bold text-primary"><i class="fas fa-boxes me-2"></i>Detalle de Insumos</h6>
                    </div>
                    <div class="card-body bg-light border-bottom">
                        <div class="row g-2 align-items-end">
                            <div class="col-md-5">
                                <label class="form-label small fw-bold">Seleccionar Insumo</label>
                                <select class="form-select" id="selectInsumoTMP">
                                    <option value="" selected disabled>Seleccione insumo...</option>
                                    <c:forEach var="ins" items="${insumos}">
                                        <option value="${ins.idInsumo}" data-nombre="${ins.nombre}" data-precio="${ins.precioUnitario}">
                                            ${ins.nombre} (Stock: ${ins.stockActual})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <label class="form-label small fw-bold">Precio Unit. (S/)</label>
                                <input type="number" step="0.01" class="form-control" id="precioTMP" placeholder="0.00">
                            </div>
                            <div class="col-md-2">
                                <label class="form-label small fw-bold">Cantidad</label>
                                <input type="number" class="form-control" id="cantidadTMP" placeholder="0" min="1">
                            </div>
                            <div class="col-md-3">
                                <button type="button" class="btn btn-primary w-100 fw-bold" id="btnAgregarFila">
                                    <i class="fas fa-plus me-1"></i> Agregar a la Lista
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0" id="tablaDetalles">
                                <thead class="table-light">
                                    <tr>
                                        <th>Insumo</th>
                                        <th class="text-end">Precio Unit.</th>
                                        <th class="text-center">Cantidad</th>
                                        <th class="text-end">Subtotal</th>
                                        <th class="text-center">Quitar</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr id="filaVacia">
                                        <td colspan="5" class="text-center text-muted py-4">No hay insumos agregados a esta orden.</td>
                                    </tr>
                                </tbody>
                                <tfoot class="table-light fw-bold">
                                    <tr>
                                        <td colspan="3" class="text-end">Monto Total Estimado:</td>
                                        <td class="text-end text-primary fs-5">S/ <span id="lblTotalCalculado">0.00</span></td>
                                        <td></td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="card shadow-sm border-0 mb-4 bg-light">
                    <div class="card-body">
                        <h6 class="text-uppercase text-muted fw-bold mb-3 border-bottom pb-2">Auditoría del Sistema</h6>
                        
                        <div class="mb-3">
                            <label class="form-label text-muted small fw-bold mb-1">Usuario Generador</label>
                            <div class="d-flex align-items-center">
                                <i class="fas fa-user-circle fa-2x text-primary me-2"></i>
                                <div>
                                    <!-- Aquí no se pone un select libre, sino el de la sesión -->
                                    <div class="fw-bold">${not empty sessionScope.usuarioLogueado ? sessionScope.usuarioLogueado.nombre : 'Admin. Compras'}</div>
                                    <div class="small text-muted">${not empty sessionScope.usuarioLogueado ? sessionScope.usuarioLogueado.nombreRol : 'ADMINISTRADOR'}</div>
                                    <!-- Input oculto para que viaje al backend -->
                                    <input type="hidden" name="idUsuario" value="${not empty sessionScope.usuarioLogueado ? sessionScope.usuarioLogueado.idUsuario : 1}">
                                </div>
                            </div>
                        </div>

                        <div class="alert alert-info py-2 d-flex mt-4">
                            <i class="fas fa-info-circle me-2 mt-1"></i>
                            <small>Al emitir la orden, el monto se bloqueará de la <b>partida presupuestal</b> seleccionada.</small>
                        </div>
                    </div>
                </div>

                <button type="submit" class="btn btn-success btn-lg w-100 fw-bold shadow" id="btnEmitir">
                    <i class="fas fa-paper-plane me-2"></i> Emitir Orden Oficial
                </button>
            </div>
        </div>
    </form>
</div>

<jsp:include page="/includes/footer.jsp" />

<script>
    document.addEventListener("DOMContentLoaded", function() {
        
        // Auto-llenar fecha de emisión con fecha actual bloqueada
        const fechaActual = new Date().toISOString().split('T')[0];
        document.getElementById('fechaEmision').value = fechaActual;

        // --- PUNTO 1: Filtrado Dinámico de Proformas por Proveedor ---
        const selectProveedor = document.getElementById('idProveedor');
        const selectProforma = document.getElementById('idProforma');

        selectProveedor.addEventListener('change', function() {
            const idProv = this.value;
            // Solo buscar options que tengan el atributo data-proveedor
            const opcionesProforma = selectProforma.querySelectorAll('option[data-proveedor]');
            
            // Limpiar la selección actual
            selectProforma.value = "";
            
            let tieneProformas = false;
            opcionesProforma.forEach(opt => {
                if (opt.getAttribute('data-proveedor') === idProv) {
                    opt.style.display = 'block'; // Mostrar
                    tieneProformas = true;
                } else {
                    opt.style.display = 'none';  // Ocultar
                }
            });

            if(idProv !== "" && !tieneProformas && opcionesProforma.length > 0) {
                // Alerta suave (Toast) indicando que este proveedor no nos ha cotizado nada
                Swal.fire({
                    toast: true, position: 'top-end', showConfirmButton: false, timer: 3000,
                    icon: 'warning', title: 'Este proveedor no tiene proformas registradas.'
                });
            }
        });

        // Si la página se recarga y ya había un proveedor seleccionado, disparar el filtro automáticamente
        if(selectProveedor.value) {
            selectProveedor.dispatchEvent(new Event('change'));
        }
        // --- FIN PUNTO 1 ---

        // --- PUNTO 2: Manejo de la Tabla Dinámica de Detalles ---
        const btnAgregar = document.getElementById('btnAgregarFila');
        const selectInsumoTMP = document.getElementById('selectInsumoTMP');
        const precioTMP = document.getElementById('precioTMP');
        const cantidadTMP = document.getElementById('cantidadTMP');
        const tbodyDetalles = document.querySelector('#tablaDetalles tbody');
        const lblTotal = document.getElementById('lblTotalCalculado');
        const filaVacia = document.getElementById('filaVacia');
        
        let totalGeneral = 0;

        // Auto-llenar precio sugerido al seleccionar insumo
        selectInsumoTMP.addEventListener('change', function() {
            const opt = this.options[this.selectedIndex];
            if(opt && opt.value) {
                precioTMP.value = opt.getAttribute('data-precio');
            }
        });

        btnAgregar.addEventListener('click', function() {
            const idInsumo = selectInsumoTMP.value;
            const nombreInsumo = selectInsumoTMP.options[selectInsumoTMP.selectedIndex]?.text;
            const precio = parseFloat(precioTMP.value);
            const cantidad = parseInt(cantidadTMP.value);

            if (!idInsumo || isNaN(precio) || isNaN(cantidad) || precio <= 0 || cantidad <= 0) {
                Swal.fire({ toast: true, position: 'top-end', icon: 'error', title: 'Complete todos los datos del insumo correctamente.', showConfirmButton: false, timer: 3000 });
                return;
            }

            const subtotal = precio * cantidad;
            totalGeneral += subtotal;
            lblTotal.innerText = totalGeneral.toFixed(2);

            if(filaVacia) filaVacia.style.display = 'none';

            const tr = document.createElement('tr');
            tr.innerHTML = `
                <td>
                    <input type="hidden" name="idInsumo" value="`+idInsumo+`">
                    `+nombreInsumo+`
                </td>
                <td class="text-end">
                    <input type="hidden" name="precioUnitario" value="`+precio+`">
                    S/ `+precio.toFixed(2)+`
                </td>
                <td class="text-center">
                    <input type="hidden" name="cantidad" value="`+cantidad+`">
                    `+cantidad+`
                </td>
                <td class="text-end fw-bold">S/ `+subtotal.toFixed(2)+`</td>
                <td class="text-center">
                    <button type="button" class="btn btn-sm btn-outline-danger btn-quitar"><i class="fas fa-trash"></i></button>
                </td>
            `;
            tbodyDetalles.appendChild(tr);

            // Limpiar form temporal
            selectInsumoTMP.value = "";
            precioTMP.value = "";
            cantidadTMP.value = "";

            // Evento para quitar
            tr.querySelector('.btn-quitar').addEventListener('click', function() {
                totalGeneral -= subtotal;
                lblTotal.innerText = totalGeneral.toFixed(2);
                tr.remove();
                if(tbodyDetalles.querySelectorAll('tr').length === 1) { // Solo queda la fila oculta
                    if(filaVacia) filaVacia.style.display = 'table-row';
                }
            });
        });
        // --- FIN PUNTO 2 ---

        // Validación
        const formOC = document.getElementById('formOrdenCompra');
        formOC.addEventListener('submit', function (event) {
            if (!formOC.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
                formOC.classList.add('was-validated');
                Swal.fire({
                    icon: 'error',
                    title: 'Faltan Datos',
                    text: 'Complete todos los campos obligatorios (*)'
                });
            } else {
                // Interceptamos para efecto visual UX y evitar redirección
                event.preventDefault(); 
                const btn = document.getElementById('btnEmitir');
                btn.disabled = true;
                
                // Mostrar spinner de carga
                Swal.fire({
                    title: 'Procesando...',
                    text: 'Emitiendo Orden de Compra',
                    allowOutsideClick: false,
                    didOpen: () => {
                        Swal.showLoading();
                    }
                });

                // Enviar formulario por AJAX (fetch) para evitar redirección de página
                const formData = new FormData(formOC);
                const params = new URLSearchParams();
                for (const pair of formData) {
                    params.append(pair[0], pair[1]);
                }

                fetch(formOC.action || window.location.href, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: params
                })
                .then(response => response.text())
                .then(html => {
                    // Intentamos extraer el ID si el backend devuelve la vista de éxito en texto
                    let mensajeExito = 'La orden ha sido registrada correctamente en el sistema.';
                    const match = html.match(/(Orden registrada con ID:\s*\d+)/i);
                    if (match) {
                        mensajeExito = match[1];
                    }

                    // Mostrar modal de éxito
                    Swal.fire({
                        icon: 'success',
                        title: '¡Operación realizada!',
                        text: mensajeExito,
                        confirmButtonText: 'Aceptar',
                        confirmButtonColor: '#0d6efd'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            // Recargar la página o limpiar el form
                            window.location.reload();
                        }
                    });
                })
                .catch(error => {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error de Conexión',
                        text: 'No se pudo registrar la orden. Verifique su red o el servidor.'
                    });
                    btn.disabled = false;
                });
            }
        }, false);
    });
</script>
