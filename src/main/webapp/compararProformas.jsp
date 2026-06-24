<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<div class="container-fluid">
    <!-- Encabezado -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-0">Comparación de Proformas</h3>
            <p class="text-muted mb-0">Análisis de cotizaciones para toma de decisiones de compra.</p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/proformas.jsp" class="btn btn-outline-secondary shadow-sm">
                <i class="fas fa-arrow-left me-1"></i> Volver a Proformas
            </a>
        </div>
    </div>

    <!-- Filtros de Comparación -->
    <div class="card shadow-sm border-0 mb-4">
        <div class="card-body bg-light">
            <div class="row align-items-end g-3">
                <div class="col-md-5">
                    <label class="form-label fw-bold small text-muted">Seleccione los Proveedores a comparar:</label>
                    <!-- En un sistema real esto usaría Select2 multiple -->
                    <select class="form-select" id="proveedoresMulti" multiple size="3">
                        <option value="1" selected>PRV-0001 - Distribuidora Médica S.A.C.</option>
                        <option value="2" selected>PRV-0002 - Insumos Hospitalarios Perú</option>
                        <option value="3">PRV-0003 - Global Pharma S.A.</option>
                    </select>
                </div>
                <div class="col-md-5">
                    <label class="form-label fw-bold small text-muted">Filtrar por Categoría de Insumo:</label>
                    <select class="form-select" id="categoriaFiltro">
                        <option value="TODOS" selected>Todas las categorías</option>
                        <option value="1">Medicamentos</option>
                        <option value="2">Material Médico</option>
                    </select>
                </div>
                <div class="col-md-2 text-end">
                    <button class="btn btn-primary w-100" onclick="simularComparacion()">
                        <i class="fas fa-sync-alt me-1"></i> Comparar
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Matriz Comparativa -->
    <div class="card shadow-sm border-0 mb-4">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
            <h6 class="m-0 fw-bold text-primary"><i class="fas fa-balance-scale me-2"></i>Cuadro Comparativo de Precios Unitarios</h6>
            <span class="badge bg-success-subtle text-success border border-success-subtle"><i class="fas fa-trophy me-1"></i> Mejor Precio Resaltado</span>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle mb-0 text-center" id="tablaComparativa">
                    <thead class="table-dark">
                        <tr>
                            <th class="text-start" style="width: 40%">Insumo Requerido</th>
                            <th style="width: 30%">Distribuidora Médica S.A.C.<br><small class="fw-normal text-warning">Proforma: PROF-001</small></th>
                            <th style="width: 30%">Insumos Hospitalarios Perú<br><small class="fw-normal text-warning">Proforma: PROF-002</small></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="text-start fw-bold">Paracetamol 500mg (Caja x 100)</td>
                            <td>
                                S/ 15.50
                            </td>
                            <td class="bg-success-subtle fw-bold text-success">
                                <i class="fas fa-check-circle me-1"></i> S/ 14.20
                            </td>
                        </tr>
                        <tr>
                            <td class="text-start fw-bold">Amoxicilina 250mg (Caja x 50)</td>
                            <td class="bg-success-subtle fw-bold text-success">
                                <i class="fas fa-check-circle me-1"></i> S/ 25.00
                            </td>
                            <td>
                                S/ 28.50
                            </td>
                        </tr>
                        <tr>
                            <td class="text-start fw-bold">Jeringas 5ml (Paquete x 50)</td>
                            <td class="bg-success-subtle fw-bold text-success">
                                <i class="fas fa-check-circle me-1"></i> S/ 18.00
                            </td>
                            <td>
                                S/ 18.50
                            </td>
                        </tr>
                    </tbody>
                    <tfoot class="bg-light">
                        <tr>
                            <td class="text-end fw-bold">Costo Total Estimado:</td>
                            <td class="fw-bold fs-5 text-dark">S/ 58.50</td>
                            <td class="fw-bold fs-5 text-dark">S/ 61.20</td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>

    <!-- Panel de Toma de Decisión -->
    <div class="card border-primary shadow-sm mb-5">
        <div class="card-body d-flex justify-content-between align-items-center bg-primary-subtle rounded">
            <div>
                <h5 class="fw-bold text-primary mb-1">Adjudicación de Compra</h5>
                <p class="text-muted mb-0 small">Seleccione al proveedor ganador para generar automáticamente la Orden de Compra.</p>
            </div>
            <form action="${pageContext.request.contextPath}/orden-compra" method="GET" class="d-flex align-items-center gap-3">
                <select class="form-select border-primary" name="proveedorGanador" id="proveedorGanador" required style="min-width: 250px;">
                    <option value="" selected disabled>Seleccione Ganador...</option>
                    <option value="1">Distribuidora Médica S.A.C.</option>
                    <option value="2">Insumos Hospitalarios Perú</option>
                </select>
                <button type="button" class="btn btn-primary fw-bold text-nowrap" onclick="generarOrden()">
                    <i class="fas fa-file-signature me-2"></i> Generar Orden
                </button>
            </form>
        </div>
    </div>

</div>

<jsp:include page="/includes/footer.jsp" />

<script>
    function simularComparacion() {
        const btn = event.currentTarget;
        const originalText = btn.innerHTML;
        btn.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i> Comparando...';
        btn.disabled = true;
        
        setTimeout(() => {
            btn.innerHTML = originalText;
            btn.disabled = false;
        }, 800);
    }

    function generarOrden() {
        const select = document.getElementById('proveedorGanador');
        if (!select.value) {
            Swal.fire({
                icon: 'warning',
                title: 'Falta Selección',
                text: 'Debe elegir un proveedor ganador para generar la Orden de Compra.'
            });
            return;
        }

        const proveedorNombre = select.options[select.selectedIndex].text;

        Swal.fire({
            title: '¿Confirmar Adjudicación?',
            html: `Se generará una Orden de Compra a favor de:<br><br><b>${proveedorNombre}</b>`,
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#198754',
            cancelButtonColor: '#6c757d',
            confirmButtonText: '<i class="fas fa-check me-1"></i> Confirmar y Generar',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                // Redirección simulada a la pantalla de Orden de Compra
                window.location.href = '${pageContext.request.contextPath}/RegistrarOrdenCompra.jsp?provId=' + select.value;
            }
        });
    }
</script>
