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
            <a href="${pageContext.request.contextPath}/orden-compra?action=listar" class="btn btn-outline-secondary shadow-sm">
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
                                <div class="input-group">
                                    <input type="hidden" id="idProforma" name="idProforma" required>
                                    <input type="text" class="form-control bg-white" id="txtProformaSeleccionada" placeholder="Ninguna proforma seleccionada..." readonly required>
                                    <button class="btn btn-primary" type="button" data-bs-toggle="modal" data-bs-target="#modalBuscadorProformas">
                                        <i class="fas fa-search me-1"></i> Buscar
                                    </button>
                                </div>
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

<!-- Modal Buscador de Proformas -->
<div class="modal fade" id="modalBuscadorProformas" tabindex="-1" aria-labelledby="modalProformasLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="modalProformasLabel"><i class="fas fa-search me-2"></i>Buscador de Proformas</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                <div class="table-responsive">
                    <table id="tablaBuscadorProformas" class="table table-hover table-striped align-middle" style="width:100%">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Proveedor</th>
                                <th>Fecha</th>
                                <th>Monto Total</th>
                                <th>Insumos Cotizados</th>
                                <th class="text-center">Acción</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="prof" items="${proformas}">
                                <tr>
                                    <td><strong>#${prof.idProforma}</strong></td>
                                    <td>${prof.razonSocialProveedor}</td>
                                    <td>${prof.fechaEmision}</td>
                                    <td class="fw-bold text-end">S/ ${prof.montoTotal}</td>
                                    <td><small class="text-muted">${prof.resumenInsumos}</small></td>
                                    <td class="text-center">
                                        <button type="button" class="btn btn-sm btn-success btn-seleccionar-proforma" 
                                                data-bs-dismiss="modal"
                                                data-id="${prof.idProforma}" 
                                                data-proveedor="${prof.idProveedor}"
                                                data-texto="#${prof.idProforma} - ${prof.razonSocialProveedor} (S/ ${prof.montoTotal})">
                                            <i class="fas fa-check"></i> Seleccionar
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- DataTables JS & jQuery -->
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        
        // Auto-llenar fecha de emisión con fecha actual bloqueada
        const fechaActual = new Date().toISOString().split('T')[0];
        document.getElementById('fechaEmision').value = fechaActual;

        // Inicializar DataTable para el buscador de proformas
        const tablaProformas = $('#tablaBuscadorProformas').DataTable({
            language: {
                url: 'https://cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json'
            },
            pageLength: 5,
            lengthMenu: [5, 10, 25]
        });

        const selectProveedor = document.getElementById('idProveedor');
        const idProformaInput = document.getElementById('idProforma');
        const txtProformaSeleccionada = document.getElementById('txtProformaSeleccionada');

        // Si se cambia el proveedor manualmente, podemos filtrar el modal por defecto
        selectProveedor.addEventListener('change', function() {
            const proveedorTexto = this.options[this.selectedIndex].text;
            if(proveedorTexto && proveedorTexto !== 'Seleccione Proveedor...') {
                tablaProformas.search(proveedorTexto).draw();
            } else {
                tablaProformas.search('').draw();
            }
        });

        // Evento al seleccionar una proforma desde el modal
        document.querySelectorAll('.btn-seleccionar-proforma').forEach(btn => {
            btn.addEventListener('click', function() {
                const idProf = this.getAttribute('data-id');
                const idProv = this.getAttribute('data-proveedor');
                const texto = this.getAttribute('data-texto');

                // Llenar datos en el formulario
                idProformaInput.value = idProf;
                txtProformaSeleccionada.value = texto;
                
                // Auto-seleccionar proveedor
                if(selectProveedor.value !== idProv) {
                    selectProveedor.value = idProv;
                }

                cargarDetallesProforma(idProf);
            });
        });

        // --- Cargar detalles de proforma dinámicamente ---
        function cargarDetallesProforma(idProf) {
            if(!idProf) return;
            
            // Limpiar la tabla de detalles actuales
            tbodyDetalles.innerHTML = '';
            totalGeneral = 0;
            lblTotal.innerText = '0.00';
            
            // Bloquear los inputs de agregación manual si se seleccionó proforma
            selectInsumoTMP.disabled = true;
            precioTMP.disabled = true;
            cantidadTMP.disabled = true;
            btnAgregar.disabled = true;
            
            // Llamada AJAX
            fetch('${pageContext.request.contextPath}/proforma?action=detalles_json&idProforma=' + idProf)
                .then(response => response.json())
                .then(data => {
                    if (data && data.length > 0) {
                        data.forEach(det => {
                            const subtotal = det.precioUnitario * det.cantidad;
                            totalGeneral += subtotal;
                            
                            const tr = document.createElement('tr');
                            tr.innerHTML = `
                                <td>
                                    <input type="hidden" name="idInsumo" value="`+det.idInsumo+`">
                                    <span class="badge bg-secondary me-2">`+det.codigoInsumo+`</span>`+det.nombreInsumo+`
                                </td>
                                <td class="text-end">
                                    <input type="hidden" name="precioUnitario" value="`+det.precioUnitario+`">
                                    S/ `+det.precioUnitario.toFixed(2)+`
                                </td>
                                <td class="text-center">
                                    <input type="hidden" name="cantidad" value="`+det.cantidad+`">
                                    `+det.cantidad+`
                                </td>
                                <td class="text-end fw-bold">S/ `+subtotal.toFixed(2)+`</td>
                                <td class="text-center">
                                    <span class="badge bg-success rounded-pill"><i class="fas fa-lock"></i> Desde Proforma</span>
                                </td>
                            `;
                            tbodyDetalles.appendChild(tr);
                        });
                        lblTotal.innerText = totalGeneral.toFixed(2);
                        if(filaVacia) filaVacia.style.display = 'none';
                        
                        Swal.fire({
                            toast: true, position: 'top-end', showConfirmButton: false, timer: 3000,
                            icon: 'success', title: 'Insumos cargados desde la proforma automáticamente.'
                        });
                    } else {
                        // Habilitar manual en caso de que la proforma no tenga detalles (por retrocompatibilidad)
                        selectInsumoTMP.disabled = false;
                        precioTMP.disabled = false;
                        cantidadTMP.disabled = false;
                        btnAgregar.disabled = false;
                        if(filaVacia) filaVacia.style.display = 'table-row';
                    }
                })
                .catch(err => {
                    console.error("Error fetching proforma details", err);
                    Swal.fire('Error', 'No se pudieron cargar los detalles de la proforma.', 'error');
                });
        }

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

<jsp:include page="/includes/footer.jsp" />
