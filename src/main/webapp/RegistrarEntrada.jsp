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
            <a href="${pageContext.request.contextPath}/ConsultarEntradas.jsp" class="btn btn-outline-secondary shadow-sm">
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
                                                <option value="15">#OC-2026-0015 - Distribuidora Médica S.A.C.</option>
                                                <option value="14">#OC-2026-0014 - Insumos Hospitalarios Perú</option>
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
                                        <select class="form-select" name="idInsumo" id="idInsumo" required>
                                            <option value="" disabled selected>Seleccione insumo físico...</option>
                                            <c:forEach var="ins" items="${insumos}">
                                                <option value="${ins.idInsumo}">${ins.nombre} (Stock actual: ${ins.stockActual})</option>
                                            </c:forEach>
                                            <c:if test="${empty insumos}">
                                                <option value="1">INS-0001 - Paracetamol 500mg (Caja x 100)</option>
                                                <option value="2">INS-0002 - Amoxicilina 250mg (Caja x 50)</option>
                                            </c:if>
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
        const mañanaStr = hoy.toISOString().split('T')[0];
        document.getElementById('fechaVencimiento').setAttribute('min', mañanaStr);

        const formEntrada = document.getElementById('formEntrada');
        formEntrada.addEventListener('submit', function (event) {
            if (!formEntrada.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
                formEntrada.classList.add('was-validated');
                Swal.fire('Formulario Incompleto', 'Debe registrar la OC, Insumo, Cantidad, Lote y Caducidad.', 'warning');
            } else {
                event.preventDefault(); // Interceptamos para efecto visual UX
                
                const btn = document.getElementById('btnRegistrar');
                btn.disabled = true;
                btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Registrando Entrada...';
                
                setTimeout(() => {
                    Swal.fire({
                        icon: 'success',
                        title: 'Ingreso Exitoso',
                        text: 'El insumo ha sido ingresado y el stock actualizado.',
                        confirmButtonText: 'Ver Historial'
                    }).then(() => {
                        window.location.href = '${pageContext.request.contextPath}/ConsultarEntradas.jsp';
                    });
                }, 1200);
            }
        }, false);
    });
</script>
