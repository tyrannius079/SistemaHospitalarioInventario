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
                                <input type="text" class="form-control bg-light text-secondary fw-bold" value="OC-2026-0015" readonly tabindex="-1">
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
                                    <!-- Fallback visual si la variable JSTL está vacía -->
                                    <c:if test="${empty proveedores}">
                                        <option value="1" ${param.provId == '1' ? 'selected' : ''}>Distribuidora Médica S.A.C.</option>
                                        <option value="2" ${param.provId == '2' ? 'selected' : ''}>Insumos Hospitalarios Perú</option>
                                    </c:if>
                                </select>
                                <div class="invalid-feedback">Obligatorio.</div>
                            </div>

                            <div class="col-md-6">
                                <label for="idProforma" class="form-label">Proforma de Referencia *</label>
                                <select class="form-select" id="idProforma" name="idProforma" required>
                                    <option value="" selected disabled>Seleccione Proforma...</option>
                                    <c:forEach var="prof" items="${proformas}">
                                        <option value="${prof.idProforma}">#${prof.idProforma} - Total: S/ ${prof.montoTotal}</option>
                                    </c:forEach>
                                    <c:if test="${empty proformas}">
                                        <option value="1">PROF-001 - Total: S/ 58.50</option>
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
                                        <option value="1">2026-Q1 (Fármacos) - Disp: S/ 15,000.00</option>
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

            <!-- Columna Derecha: Auditoría y Confirmación -->
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
                                    <div class="small text-muted">${not empty sessionScope.usuarioLogueado ? sessionScope.usuarioLogueado.rol : 'Administrador'}</div>
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
                event.preventDefault(); // Simulación para UX
                const btn = document.getElementById('btnEmitir');
                btn.disabled = true;
                btn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i> Emitiendo...';
                
                setTimeout(() => {
                    Swal.fire({
                        icon: 'success',
                        title: 'Orden Emitida',
                        text: 'La Orden de Compra OC-2026-0015 ha sido generada correctamente.',
                        confirmButtonText: 'Ver Órdenes'
                    }).then(() => {
                        window.location.href = '${pageContext.request.contextPath}/ConsultarOrdenes.jsp';
                    });
                }, 1500);
            }
        }, false);
    });
</script>
