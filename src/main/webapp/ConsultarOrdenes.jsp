<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<div class="container-fluid">
    <!-- Encabezado y Acciones -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-0">Órdenes de Compra</h3>
            <p class="text-muted mb-0">Consulte el historial y estado de los requerimientos de abastecimiento.</p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/orden-compra" class="btn btn-primary shadow-sm">
                <i class="fas fa-plus-circle me-1"></i> Nueva Orden
            </a>
        </div>
    </div>

    <!-- Tabla Principal (reducida por simplicidad en el ejemplo) -->
    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table id="tablaOrdenes" class="table table-hover align-middle mb-0 text-center">
                    <thead class="table-dark">
                        <tr>
                            <th>N° Orden</th>
                            <th class="text-start">Proveedor</th>
                            <th>Fecha Emisión</th>
                            <th class="text-end">Total (S/)</th>
                            <th>Estado Actual</th>
                            <th class="text-center">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="orden" items="${ordenes}">
                            <tr>
                                <td class="fw-bold text-primary">${orden.codigoFormateado}</td>
                                <td class="text-start">
                                    <div class="fw-bold">${orden.razonSocialProveedor}</div>
                                </td>
                                <td>${orden.fechaEmision}</td>
                                <td class="text-end fw-bold">${orden.total}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${orden.nombreEstado == 'EMITIDA'}">
                                            <span class="badge bg-warning text-dark border border-warning"><i class="fas fa-clock me-1"></i> EMITIDA</span>
                                        </c:when>
                                        <c:when test="${orden.nombreEstado == 'APROBADA'}">
                                            <span class="badge bg-primary"><i class="fas fa-thumbs-up me-1"></i> APROBADA</span>
                                        </c:when>
                                        <c:when test="${orden.nombreEstado == 'RECEPCIONADA'}">
                                            <span class="badge bg-success"><i class="fas fa-check-circle me-1"></i> RECEPCIONADA</span>
                                        </c:when>
                                        <c:when test="${orden.nombreEstado == 'ANULADA'}">
                                            <span class="badge bg-danger"><i class="fas fa-times-circle me-1"></i> ANULADA</span>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <button class="btn btn-sm btn-outline-info" title="Imprimir" onclick="imprimirPDF('${orden.codigoFormateado}')">
                                        <i class="fas fa-file-pdf"></i>
                                    </button>
                                    <c:if test="${orden.nombreEstado != 'ANULADA' && orden.nombreEstado != 'RECEPCIONADA'}">
                                        <button class="btn btn-sm btn-outline-secondary" title="Actualizar Estado" onclick="abrirModalEstado('${orden.codigoFormateado}', '${orden.nombreEstado}')">
                                            <i class="fas fa-sync-alt"></i>
                                        </button>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Modal: Actualizar Estado -->
<div class="modal fade" id="modalEstado" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title fw-bold"><i class="fas fa-exchange-alt me-2"></i>Gestión de Estado</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <form id="formActualizarEstado" action="${pageContext.request.contextPath}/orden-compra" method="POST" novalidate>
                <div class="modal-body">
                    <input type="hidden" name="action" value="actualizar">
                    <input type="hidden" name="idOrdenCompra" id="mod_idOrden">
                    
                    <div class="mb-4 text-center">
                        <p class="mb-1 text-muted">Orden de Compra seleccionada</p>
                        <h4 class="fw-bold text-primary mb-0" id="mod_lblOrden">OC-XXXX</h4>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Estado Actual</label>
                        <input type="text" class="form-control bg-light fw-bold" id="mod_estadoActual" readonly>
                    </div>

                    <div class="mb-3">
                        <label for="mod_nuevoEstado" class="form-label fw-bold">Nuevo Estado *</label>
                        <select class="form-select border-primary" id="mod_nuevoEstado" name="estado" required onchange="validarMotivo()">
                            <option value="" disabled selected>Seleccione transición...</option>
                            <option value="APROBADA">✅ Aprobar Orden</option>
                            <option value="ANULADA">❌ Anular Orden</option>
                        </select>
                        <div class="invalid-feedback">Debe seleccionar un nuevo estado.</div>
                    </div>

                    <div class="mb-2" id="divMotivo" style="display: none;">
                        <label for="mod_observaciones" class="form-label fw-bold text-danger">Motivo de Anulación *</label>
                        <textarea class="form-control" id="mod_observaciones" name="observaciones" rows="3" placeholder="Explique por qué se anula esta orden..."></textarea>
                        <div class="invalid-feedback">El motivo es obligatorio al anular.</div>
                    </div>

                    <div class="alert alert-warning mt-3 mb-0 py-2">
                        <i class="fas fa-exclamation-triangle me-1"></i>
                        <small>El cambio de estado quedará registrado con su usuario de sesión.</small>
                    </div>
                </div>
                <div class="modal-footer bg-light">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-primary fw-bold" id="btnGuardarEstado">Actualizar Estado</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />

<script>
    document.addEventListener("DOMContentLoaded", function() {
        $('#tablaOrdenes').DataTable({
            language: { url: 'https://cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json' },
            responsive: true,
            order: [[0, 'desc']],
            columnDefs: [{ orderable: false, targets: 5 }]
        });

        // Validación JS para enviar el cambio
        const formEstado = document.getElementById('formActualizarEstado');
        formEstado.addEventListener('submit', function (event) {
            if (!formEstado.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
                formEstado.classList.add('was-validated');
            } else {
                event.preventDefault(); // Interceptamos para UX
                
                const btnGuardar = document.getElementById('btnGuardarEstado');
                btnGuardar.disabled = true;
                btnGuardar.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Procesando...';
                
                // Simulación de actualización exitosa AJAX
                setTimeout(() => {
                    const nuevoEstado = document.getElementById('mod_nuevoEstado').value;
                    const idOrden = document.getElementById('mod_idOrden').value;
                    
                    Swal.fire({
                        icon: 'success',
                        title: 'Estado Actualizado',
                        text: 'La orden ' + idOrden + ' ahora está ' + nuevoEstado,
                        timer: 2000,
                        showConfirmButton: false
                    }).then(() => {
                        // En la vida real haríamos location.reload() o actualizar el DOM.
                        location.reload(); 
                    });
                }, 1000);
            }
        }, false);
    });

    function abrirModalEstado(idOrden, estadoActual) {
        document.getElementById('formActualizarEstado').reset();
        document.getElementById('formActualizarEstado').classList.remove('was-validated');
        
        document.getElementById('mod_idOrden').value = idOrden;
        document.getElementById('mod_lblOrden').textContent = idOrden;
        document.getElementById('mod_estadoActual').value = estadoActual;
        
        // Esconder motivo
        document.getElementById('divMotivo').style.display = 'none';
        document.getElementById('mod_observaciones').required = false;

        const modal = new bootstrap.Modal(document.getElementById('modalEstado'));
        modal.show();
    }

    function validarMotivo() {
        const select = document.getElementById('mod_nuevoEstado');
        const divMotivo = document.getElementById('divMotivo');
        const txtMotivo = document.getElementById('mod_observaciones');
        
        // IHC: Si decide ANULAR, forzamos a que explique por qué.
        if (select.value === 'ANULADA') {
            divMotivo.style.display = 'block';
            txtMotivo.required = true;
        } else {
            divMotivo.style.display = 'none';
            txtMotivo.required = false;
        }
    }
    
    function imprimirPDF(idOrden) {
        window.open('${pageContext.request.contextPath}/ReporteServlet?tipo=orden&id=' + idOrden, '_blank');
    }
</script>
