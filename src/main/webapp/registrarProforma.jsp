<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<div class="container-fluid">
    <!-- Encabezado -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-0">Registrar Proforma</h3>
            <p class="text-muted mb-0">Ingreso de cotizaciones enviadas por los proveedores.</p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline-secondary shadow-sm">
                <i class="fas fa-arrow-left me-1"></i> Volver a Proformas
            </a>
        </div>
    </div>

    <!-- Formulario Maestro-Detalle -->
    <form id="formProforma" action="${pageContext.request.contextPath}/proforma" method="POST" novalidate>
        
        <!-- Bloque Maestro (Cabecera) -->
        <div class="card shadow-sm border-0 mb-4">
            <div class="card-header bg-white py-3">
                <h6 class="m-0 fw-bold text-primary"><i class="fas fa-file-invoice me-2"></i>Datos Generales (Maestro)</h6>
            </div>
            <div class="card-body">
                <div class="row g-3">
                    <div class="col-md-3">
                        <label class="form-label text-muted small fw-bold">N° Proforma (Sistema)</label>
                        <input type="text" class="form-control bg-light text-secondary fw-bold text-center" value="Generado Automáticamente" readonly tabindex="-1">
                    </div>
                    <div class="col-md-5">
                        <label for="idProveedor" class="form-label">Proveedor *</label>
                        <select class="form-select" id="idProveedor" name="idProveedor" required>
                            <option value="" selected disabled>Seleccione un proveedor...</option>
                            <c:forEach var="prov" items="${proveedores}">
                                <option value="${prov.idProveedor}">${prov.codigo} - ${prov.razonSocial}</option>
                            </c:forEach>
                        </select>
                        <div class="invalid-feedback">Seleccione un proveedor.</div>
                    </div>
                    <div class="col-md-2">
                        <label for="moneda" class="form-label">Moneda *</label>
                        <select class="form-select" id="moneda" name="moneda" required>
                            <option value="PEN" selected>Soles (S/)</option>
                            <option value="USD">Dólares ($)</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <label for="fechaValidez" class="form-label">Validez hasta *</label>
                        <input type="date" class="form-control" id="fechaValidez" name="fechaValidez" required>
                        <div class="invalid-feedback">Requerido.</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bloque Detalle (Insumos) -->
        <div class="card shadow-sm border-0 mb-4">
            <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                <h6 class="m-0 fw-bold text-primary"><i class="fas fa-list-ol me-2"></i>Detalle de Cotización</h6>
                <button type="button" class="btn btn-sm btn-success shadow-sm" id="btnAgregarFila">
                    <i class="fas fa-plus me-1"></i> Agregar Insumo
                </button>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0" id="tablaDetalle">
                        <thead class="table-light">
                            <tr>
                                <th style="width: 40%">Insumo</th>
                                <th style="width: 15%">Cantidad</th>
                                <th style="width: 20%">Precio Unitario</th>
                                <th style="width: 15%">Subtotal</th>
                                <th style="width: 10%" class="text-center">Quitar</th>
                            </tr>
                        </thead>
                        <tbody id="detalleBody">
                            <!-- Fila de ejemplo (agregada por JS dinámicamente) -->
                        </tbody>
                        <tfoot class="bg-light">
                            <tr>
                                <td colspan="3" class="text-end fw-bold">Subtotal Neto:</td>
                                <td colspan="2" class="fw-bold text-dark fs-5">S/ <span id="lblSubtotal">0.00</span></td>
                            </tr>
                            <tr>
                                <td colspan="3" class="text-end fw-bold">IGV (18%):</td>
                                <td colspan="2" class="fw-bold text-muted">S/ <span id="lblIgv">0.00</span></td>
                            </tr>
                            <tr>
                                <td colspan="3" class="text-end fw-bold fs-4 text-primary">TOTAL:</td>
                                <td colspan="2" class="fw-bold text-primary fs-4">S/ <span id="lblTotal">0.00</span></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>

        <!-- Panel de Acciones -->
        <div class="d-flex justify-content-end mb-5 gap-2">
            <button type="button" class="btn btn-secondary px-4"><i class="fas fa-times me-1"></i> Cancelar</button>
            <button type="submit" class="btn btn-primary px-5 fw-bold" id="btnGuardar"><i class="fas fa-save me-1"></i> Registrar Proforma</button>
        </div>

    </form>
</div>

<jsp:include page="/includes/footer.jsp" />

<script>
    const insumosOptions = `<c:forEach var="ins" items="${insumos}"><option value="${ins.idInsumo}">${ins.codigo} - ${ins.nombre}</option></c:forEach>`;

    document.addEventListener("DOMContentLoaded", function() {
        
        // Asignar fecha mínima hoy a "Validez hasta"
        const hoy = new Date().toISOString().split('T')[0];
        document.getElementById('fechaValidez').setAttribute('min', hoy);

        // Añadir primera fila por defecto
        agregarFila();

        // Validar formulario antes del submit
        const form = document.getElementById('formProforma');
        form.addEventListener('submit', function (event) {
            
            const filas = document.querySelectorAll('#detalleBody tr');
            if (filas.length === 0) {
                event.preventDefault();
                Swal.fire('Atención', 'Debe agregar al menos un insumo a la proforma.', 'warning');
                return;
            }

            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
                form.classList.add('was-validated');
                Swal.fire('Formulario incompleto', 'Revise los campos en rojo.', 'error');
            } else {
                // Submit exitoso simulado
                const btnGuardar = document.getElementById('btnGuardar');
                btnGuardar.disabled = true;
                btnGuardar.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Registrando...';
            }
        }, false);

        // Evento Botón agregar fila
        document.getElementById('btnAgregarFila').addEventListener('click', agregarFila);
    });

    let filaContador = 0;

    function agregarFila() {
        filaContador++;
        const tbody = document.getElementById('detalleBody');
        const tr = document.createElement('tr');
        tr.id = 'fila_' + filaContador;

        tr.innerHTML = `
            <td>
                <select class="form-select" name="idInsumo[]" required>
                    <option value="" selected disabled>Buscar insumo...</option>
                    \${insumosOptions}
                </select>
                <div class="invalid-feedback">Seleccione.</div>
            </td>
            <td>
                <input type="number" class="form-control cantidad-input" name="cantidad[]" min="1" step="1" required placeholder="0" onchange="recalcularFila(this)" onkeyup="recalcularFila(this)">
            </td>
            <td>
                <div class="input-group">
                    <span class="input-group-text">$</span>
                    <input type="number" class="form-control precio-input" name="precioUnitario[]" min="0.01" step="0.01" required placeholder="0.00" onchange="recalcularFila(this)" onkeyup="recalcularFila(this)">
                </div>
            </td>
            <td>
                <input type="text" class="form-control bg-light text-end fw-bold subtotal-input" readonly value="0.00" tabindex="-1">
            </td>
            <td class="text-center">
                <button type="button" class="btn btn-sm btn-outline-danger" onclick="eliminarFila('fila_${filaContador}')">
                    <i class="fas fa-trash"></i>
                </button>
            </td>
        `;
        tbody.appendChild(tr);
    }

    function eliminarFila(idFila) {
        document.getElementById(idFila).remove();
        recalcularTotalGlobal();
    }

    function recalcularFila(elemento) {
        const fila = elemento.closest('tr');
        const cantidad = parseFloat(fila.querySelector('.cantidad-input').value) || 0;
        const precio = parseFloat(fila.querySelector('.precio-input').value) || 0;
        
        const subtotal = cantidad * precio;
        fila.querySelector('.subtotal-input').value = subtotal.toFixed(2);
        
        recalcularTotalGlobal();
    }

    function recalcularTotalGlobal() {
        let subtotalNeto = 0;
        const subtotales = document.querySelectorAll('.subtotal-input');
        
        subtotales.forEach(input => {
            subtotalNeto += parseFloat(input.value) || 0;
        });

        const igv = subtotalNeto * 0.18;
        const total = subtotalNeto + igv;

        document.getElementById('lblSubtotal').textContent = subtotalNeto.toFixed(2);
        document.getElementById('lblIgv').textContent = igv.toFixed(2);
        document.getElementById('lblTotal').textContent = total.toFixed(2);
    }
</script>
