<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:if test="${empty totalOrdenesPendientes && empty arrayEntradasChart}">
    <c:redirect url="/dashboard" />
</c:if>
<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<!-- Contenido del Dashboard -->
<div class="container-fluid">
    
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-0">Dashboard Principal</h3>
            <p class="text-muted mb-0">Resumen operativo y estado del inventario en tiempo real.</p>
        </div>
        <div>
            <button class="btn btn-outline-primary btn-sm"><i class="fas fa-sync-alt me-1"></i> Actualizar</button>
            <button class="btn btn-primary btn-sm ms-2"><i class="fas fa-download me-1"></i> Reporte</button>
        </div>
    </div>

    <!-- Tarjetas de KPI -->
    <div class="row mb-4">
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-0 border-start border-4 border-primary shadow-sm h-100 py-2">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs fw-bold text-primary text-uppercase mb-1">Órdenes Pendientes</div>
                            <div class="h5 mb-0 fw-bold text-gray-800">${not empty totalOrdenesPendientes ? totalOrdenesPendientes : '0'}</div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-file-invoice-dollar fa-2x text-muted opacity-50"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-0 border-start border-4 border-success shadow-sm h-100 py-2">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs fw-bold text-success text-uppercase mb-1">Entradas (Hoy)</div>
                            <div class="h5 mb-0 fw-bold text-gray-800">${not empty entradasHoy ? entradasHoy : '0'}</div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-boxes-stacked fa-2x text-muted opacity-50"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-0 border-start border-4 border-danger shadow-sm h-100 py-2">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs fw-bold text-danger text-uppercase mb-1">Stock Crítico</div>
                            <div class="h5 mb-0 fw-bold text-gray-800">${not empty stockCritico ? stockCritico : '0'}</div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-exclamation-triangle fa-2x text-muted opacity-50"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-0 border-start border-4 border-warning shadow-sm h-100 py-2">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs fw-bold text-warning text-uppercase mb-1">Próximos a Vencer</div>
                            <div class="h5 mb-0 fw-bold text-gray-800">${not empty proximosVencer ? proximosVencer : '0'}</div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-calendar-times fa-2x text-muted opacity-50"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Gráficos y Tablas -->
    <div class="row">
        <!-- Gráfico de Movimientos -->
        <div class="col-lg-8 mb-4">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-header bg-white py-3 d-flex flex-row align-items-center justify-content-between">
                    <h6 class="m-0 fw-bold text-primary">Movimientos de Inventario (Últimos 7 días)</h6>
                </div>
                <div class="card-body">
                    <div class="chart-area" style="height: 300px;">
                        <canvas id="movimientosChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- Alertas Recientes -->
        <div class="col-lg-4 mb-4">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-header bg-white py-3">
                    <h6 class="m-0 fw-bold text-danger">Alertas Recientes</h6>
                </div>
                <div class="card-body p-0">
                    <ul class="list-group list-group-flush">
                        <c:forEach var="insumo" items="${alertasInsumos}">
                            <li class="list-group-item px-4 py-3 d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="mb-0 fw-bold text-dark">${insumo.nombre}</h6>
                                    <small class="text-danger">Stock actual: ${insumo.stockActual} u. (Mín: ${insumo.stockMinimo})</small>
                                </div>
                                <span class="badge bg-danger rounded-pill">Crítico</span>
                            </li>
                        </c:forEach>
                        <c:forEach var="lote" items="${alertasLotes}">
                            <li class="list-group-item px-4 py-3 d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="mb-0 fw-bold text-dark">Lote: ${lote.numeroLote}</h6>
                                    <small class="text-warning">Vence: ${lote.fechaVencimiento}</small>
                                </div>
                                <span class="badge bg-warning rounded-pill text-dark">Vencimiento</span>
                            </li>
                        </c:forEach>
                        <c:if test="${empty alertasInsumos && empty alertasLotes}">
                            <li class="list-group-item px-4 py-3 text-center text-muted">
                                No hay alertas críticas por el momento.
                            </li>
                        </c:if>
                    </ul>
                </div>
                <div class="card-footer bg-white text-center">
                    <a href="${pageContext.request.contextPath}/alertas" class="text-decoration-none small fw-bold">Ver todas las alertas <i class="fas fa-chevron-right ms-1"></i></a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />

<!-- Script Específico para el Chart del Dashboard -->
<script>
document.addEventListener("DOMContentLoaded", function() {
    // Actualizar Título del Layout
    const titleElement = document.getElementById('pageTitle');
    if (titleElement) {
        titleElement.textContent = 'Dashboard Principal';
    }

    // Gráfico de Barras - Movimientos
    var ctx = document.getElementById("movimientosChart");
    if(ctx) {
        var myBarChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ["Lun", "Mar", "Mié", "Jue", "Vie", "Sáb", "Dom"],
                datasets: [
                    {
                        label: "Entradas",
                        backgroundColor: "#198754",
                        hoverBackgroundColor: "#157347",
                        data: ${not empty arrayEntradasChart ? arrayEntradasChart : '[0,0,0,0,0,0,0]'},
                    },
                    {
                        label: "Salidas",
                        backgroundColor: "#dc3545",
                        hoverBackgroundColor: "#bb2d3b",
                        data: ${not empty arraySalidasChart ? arraySalidasChart : '[0,0,0,0,0,0,0]'},
                    }
                ],
            },
            options: {
                maintainAspectRatio: false,
                responsive: true,
                scales: {
                    x: { grid: { display: false } },
                    y: { 
                        beginAtZero: true,
                        grid: { borderDash: [2] }
                    }
                },
                plugins: {
                    legend: { position: 'top' }
                }
            }
        });
    }
});
</script>
