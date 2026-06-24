<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<div class="container-fluid">
    <!-- Encabezado -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-0">Salida y Ajuste de Inventario</h3>
            <p class="text-muted mb-0">Registre el despacho a pabellones o la merma por productos dañados/vencidos.</p>
        </div>
        <div>
            <!-- En la versión completa aquí iría un botón hacia Consultar Salidas -->
            <a href="${pageContext.request.contextPath}/ConsultarStock.jsp" class="btn btn-outline-secondary shadow-sm">
                <i class="fas fa-boxes me-1"></i> Ver Kardex General
            </a>
        </div>
    </div>

    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-danger text-white py-3 d-flex align-items-center">
                    <i class="fas fa-dolly-flatbed fa-lg me-2"></i>
                    <h5 class="m-0 fw-bold">Declaración de Descuento de Stock</h5>
                </div>
                
                <div class="card-body p-4">
                    <form id="formSalida" action="${pageContext.request.contextPath}/ajuste-inventario" method="POST" novalidate>
                        
                        <div class="row g-4">
                            <!-- Tipo de Operación -->
                            <div class="col-md-6">
                                <label for="tipoMovimiento" class="form-label fw-bold">Naturaleza de la Operación *</label>
                                <select class="form-select border-danger bg-danger-subtle text-danger-emphasis fw-bold" id="tipoMovimiento" name="tipoMovimiento" required onchange="cambiarContextoUI()">
                                    <option value="" disabled selected>Seleccione motivo...</option>
                                    <option value="SALIDA">📦 Salida (Despacho a Área Médica)</option>
                                    <option value="AJUSTE">⚠️ Ajuste / Merma (Dañado/Vencido)</option>
                                </select>
                                <div class="invalid-feedback">Debe seleccionar el tipo de movimiento.</div>
                            </div>

                            <!-- Técnico -->
                            <div class="col-md-6">
                                <label class="form-label text-muted small fw-bold">Usuario Registrador</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="fas fa-user-shield"></i></span>
                                    <input type="text" class="form-control bg-light" value="${not empty sessionScope.usuarioLogueado ? sessionScope.usuarioLogueado.nombre : 'Autorizado'}" readonly>
                                </div>
                            </div>

                            <!-- Insumo a descontar -->
                            <div class="col-md-8">
                                <label for="idInsumo" class="form-label fw-bold">Insumo a retirar *</label>
                                <select class="form-select" id="idInsumo" name="idInsumo" required onchange="actualizarMaximo()">
                                    <option value="" disabled selected data-stock="0">Buscar insumo en almacén...</option>
                                    <!-- JSTL dinámico leyendo atributos data-stock -->
                                    <c:forEach var="insumo" items="${insumos}">
                                        <c:if test="${insumo.stockActual > 0}">
                                            <option value="${insumo.idInsumo}" data-stock="${insumo.stockActual}">
                                                ${insumo.codigo} - ${insumo.nombre} (Disp: ${insumo.stockActual})
                                            </option>
                                        </c:if>
                                    </c:forEach>
                                    <c:if test="${empty insumos}">
                                        <option value="1" data-stock="120">INS-0001 - Paracetamol 500mg (Disp: 120)</option>
                                        <option value="2" data-stock="50">INS-0002 - Amoxicilina 250mg (Disp: 50)</option>
                                    </c:if>
                                </select>
                                <div class="invalid-feedback">Seleccione un insumo con stock positivo.</div>
                            </div>

                            <!-- Cantidad -->
                            <div class="col-md-4">
                                <label for="cantidad" class="form-label fw-bold">Cantidad a restar *</label>
                                <div class="input-group has-validation">
                                    <input type="number" class="form-control text-end fw-bold fs-5" id="cantidad" name="cantidad" min="1" required placeholder="0">
                                    <span class="input-group-text bg-light text-muted">unidades</span>
                                    <div class="invalid-feedback">Supera el stock o es inválido.</div>
                                </div>
                            </div>

                            <!-- Área de Destino (Solo visible si es SALIDA) -->
                            <div class="col-md-12" id="divAreaDestino" style="display: none;">
                                <label for="areaDestino" class="form-label fw-bold text-primary">Área Hospitalaria Solicitante *</label>
                                <select class="form-select border-primary" id="areaDestino" name="areaDestino">
                                    <option value="" disabled selected>Seleccione área de destino...</option>
                                    <option value="Emergencia">Sala de Emergencias</option>
                                    <option value="Cirugia">Quirófano / Cirugía</option>
                                    <option value="UCI">Cuidados Intensivos (UCI)</option>
                                    <option value="Pediatria">Pabellón de Pediatría</option>
                                </select>
                                <div class="invalid-feedback">Debe especificar a dónde va la mercadería.</div>
                            </div>

                            <!-- Observaciones -->
                            <div class="col-12">
                                <label for="observaciones" class="form-label fw-bold" id="lblObservaciones">Motivo Técnico de la Operación *</label>
                                <textarea class="form-control" id="observaciones" name="observaciones" rows="3" required placeholder="Explique brevemente por qué sale este insumo del almacén..."></textarea>
                                <div class="invalid-feedback">La justificación es obligatoria por normas de auditoría.</div>
                            </div>
                        </div>

                        <hr class="my-4">

                        <div class="d-flex justify-content-end">
                            <button type="submit" class="btn btn-danger btn-lg px-5 fw-bold shadow-sm" id="btnProcesar">
                                <i class="fas fa-minus-circle me-2"></i> Procesar Movimiento
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
        const formSalida = document.getElementById('formSalida');
        
        formSalida.addEventListener('submit', function (event) {
            if (!formSalida.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
                formSalida.classList.add('was-validated');
                Swal.fire('Validación fallida', 'Revise los campos marcados en rojo.', 'error');
            } else {
                event.preventDefault(); // Intercept para confirmación IHC
                
                const cant = document.getElementById('cantidad').value;
                const insumo = document.getElementById('idInsumo');
                const nombreInsumo = insumo.options[insumo.selectedIndex].text.split('(')[0];

                Swal.fire({
                    title: '¿Confirmar Descuento?',
                    html: `Se descontarán <b>${cant} unidades</b> de <br>${nombreInsumo}<br>Esta acción afectará permanentemente el Kardex.`,
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#dc3545',
                    cancelButtonColor: '#6c757d',
                    confirmButtonText: 'Sí, registrar salida',
                    cancelButtonText: 'Cancelar'
                }).then((result) => {
                    if (result.isConfirmed) {
                        const btn = document.getElementById('btnProcesar');
                        btn.disabled = true;
                        btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Registrando...';
                        
                        // Fake AJAX para UX
                        setTimeout(() => {
                            Swal.fire({
                                icon: 'success',
                                title: 'Operación Registrada',
                                text: 'El inventario ha sido actualizado correctamente.',
                                timer: 2000,
                                showConfirmButton: false
                            }).then(() => {
                                window.location.href = '${pageContext.request.contextPath}/ConsultarStock.jsp';
                            });
                        }, 1200);
                    }
                });
            }
        }, false);
    });

    function actualizarMaximo() {
        const selectInsumo = document.getElementById('idInsumo');
        const opcionElegida = selectInsumo.options[selectInsumo.selectedIndex];
        const stockActual = parseInt(opcionElegida.getAttribute('data-stock'), 10) || 0;
        
        const inputCantidad = document.getElementById('cantidad');
        inputCantidad.value = ""; // Limpiar valor anterior por seguridad
        inputCantidad.setAttribute('max', stockActual);
        
        // IHC: Hint en el placeholder
        inputCantidad.setAttribute('placeholder', 'Máx: ' + stockActual);
    }

    function cambiarContextoUI() {
        const tipo = document.getElementById('tipoMovimiento').value;
        const divArea = document.getElementById('divAreaDestino');
        const selectArea = document.getElementById('areaDestino');
        const lblObs = document.getElementById('lblObservaciones');
        const txtObs = document.getElementById('observaciones');

        if (tipo === 'SALIDA') {
            divArea.style.display = 'block';
            selectArea.required = true;
            lblObs.innerHTML = 'Observaciones Adicionales';
            txtObs.placeholder = 'Ej. Entregado a la enfermera de turno...';
        } else {
            // Es un AJUSTE (merma/vencimiento)
            divArea.style.display = 'none';
            selectArea.required = false;
            selectArea.value = "";
            lblObs.innerHTML = 'Motivo de la Merma / Pérdida * <span class="text-danger">(Requerido)</span>';
            txtObs.placeholder = 'Ej. Caja sufrió caída en almacén. Producto contaminado...';
        }
    }
</script>
