<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<div class="container-fluid">
    <!-- Encabezado y Acciones -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-0">Kardex Central</h3>
            <p class="text-muted mb-0">Control en tiempo real del stock físico de almacén y alertas de desabastecimiento.</p>
        </div>
        <div class="d-flex gap-2">
            <a href="${pageContext.request.contextPath}/RegistrarEntrada.jsp" class="btn btn-outline-success shadow-sm">
                <i class="fas fa-arrow-down me-1"></i> Nueva Entrada
            </a>
            <a href="${pageContext.request.contextPath}/RegistrarAjuste.jsp" class="btn btn-outline-danger shadow-sm">
                <i class="fas fa-arrow-up me-1"></i> Registrar Salida
            </a>
            <button class="btn btn-secondary shadow-sm" onclick="imprimirReporte()">
                <i class="fas fa-print me-1"></i> Exportar
            </button>
        </div>
    </div>

    <!-- Panel de KPIs Financieros/Logísticos -->
    <div class="row g-3 mb-4">
        <div class="col-md-4">
            <div class="card border-0 shadow-sm bg-primary text-white h-100">
                <div class="card-body d-flex align-items-center">
                    <div class="bg-white text-primary rounded-circle p-3 me-3">
                        <i class="fas fa-boxes fa-2x"></i>
                    </div>
                    <div>
                        <h6 class="mb-0 text-white-50 fw-bold text-uppercase">Total de Insumos Activos</h6>
                        <h2 class="mb-0 fw-bold">${not empty totalInsumos ? totalInsumos : '0'}</h2>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card border-0 shadow-sm bg-danger text-white h-100">
                <div class="card-body d-flex align-items-center">
                    <div class="bg-white text-danger rounded-circle p-3 me-3">
                        <i class="fas fa-exclamation-triangle fa-2x"></i>
                    </div>
                    <div>
                        <h6 class="mb-0 text-white-50 fw-bold text-uppercase">Alertas Stock Mínimo</h6>
                        <h2 class="mb-0 fw-bold">${not empty alertasStock ? alertasStock : '0'}</h2>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card border-0 shadow-sm bg-success text-white h-100">
                <div class="card-body d-flex align-items-center">
                    <div class="bg-white text-success rounded-circle p-3 me-3">
                        <i class="fas fa-check-circle fa-2x"></i>
                    </div>
                    <div>
                        <h6 class="mb-0 text-white-50 fw-bold text-uppercase">Nivel de Abastecimiento</h6>
                        <h2 class="mb-0 fw-bold">${not empty nivelAbastecimiento ? nivelAbastecimiento : '0'}%</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Tabla Principal (Kardex) -->
    <div class="card shadow-sm border-0">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center border-bottom">
            <h6 class="m-0 fw-bold text-dark"><i class="fas fa-list me-2 text-primary"></i>Inventario Valorizado</h6>
            <span class="badge bg-danger-subtle text-danger border border-danger-subtle">Las filas rojas requieren compra inmediata</span>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table id="tablaKardex" class="table table-hover align-middle mb-0 w-100">
                    <thead class="table-dark">
                        <tr>
                            <th>Código</th>
                            <th class="text-start">Insumo</th>
                            <th>U. Medida</th>
                            <th class="text-center">Stock Mínimo</th>
                            <th class="text-center bg-primary text-white">Stock Actual</th>
                            <th class="text-center">Estado</th>
                            <th class="text-center">Movimientos</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${empty insumos}">
                            <tr>
                                <td colspan="8" class="text-center text-muted py-4">No hay registros disponibles en el inventario.</td>
                            </tr>
                        </c:if>
                        <!-- Bloque Dinámico JSTL Original Integrado -->
                        <c:forEach var="insumo" items="${insumos}">
                            <tr class="${insumo.stockActual <= insumo.stockMinimo ? 'table-danger' : ''}">
                                <td class="fw-bold text-secondary">${insumo.codigo}</td>
                                <td class="text-start">
                                    <div class="fw-bold ${insumo.stockActual <= insumo.stockMinimo ? 'text-danger' : ''}">${insumo.nombre}</div>
                                    <small class="${insumo.stockActual <= insumo.stockMinimo ? 'text-danger' : 'text-muted'}">${insumo.descripcion}</small>
                                </td>
                                <td class="${insumo.stockActual <= insumo.stockMinimo ? 'text-danger' : ''}">${insumo.unidadMedida}</td>
                                <td class="text-center fw-bold text-muted">${insumo.stockMinimo}</td>
                                <td class="text-center fw-bold fs-5 ${insumo.stockActual <= insumo.stockMinimo ? 'text-danger' : 'text-success'}">${insumo.stockActual}</td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${insumo.stockActual <= insumo.stockMinimo}">
                                            <span class="badge bg-danger"><i class="fas fa-exclamation-circle me-1"></i> CRÍTICO</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-success-subtle text-success"><i class="fas fa-check-circle me-1"></i> ÓPTIMO</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <button class="btn btn-sm btn-outline-primary" title="Ver Historial (Kardex)" onclick="verHistorial('${insumo.codigo}')">
                                        <i class="fas fa-history"></i> Kardex
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

<jsp:include page="/includes/footer.jsp" />

<script>
    document.addEventListener("DOMContentLoaded", function() {
        $('#tablaKardex').DataTable({
            language: { url: 'https://cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json' },
            responsive: true,
            // IHC: Ordenar por Estado Crítico primero para llamar a la acción, 
            // esto se simularía ordenando por Stock Actual vs Mínimo, pero usaremos el texto del badge
            order: [[5, 'asc']],
            columnDefs: [{ orderable: false, targets: 6 }]
        });
    });

    function imprimirReporte() {
        Swal.fire({
            title: 'Descargando Kardex',
            text: 'Generando reporte global de inventario valorizado...',
            icon: 'info',
            timer: 1500,
            showConfirmButton: false
        });
    }

    function verHistorial(codigo) {
        // En la vida real abre un modal con el historial detallado de entradas y salidas de ese item
        Swal.fire({
            title: 'Kardex de Movimientos',
            html: `Historial de entradas y salidas para el insumo <b>${codigo}</b><br><br><i>Función de reporte detallado en construcción.</i>`,
            icon: 'info'
        });
    }
</script>
