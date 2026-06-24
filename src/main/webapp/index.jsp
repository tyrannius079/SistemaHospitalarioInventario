<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
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
                            <div class="h5 mb-0 fw-bold text-gray-800">${not empty totalOrdenesPendientes ? totalOrdenesPendientes : '12'}</div>
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
                            <div class="h5 mb-0 fw-bold text-gray-800">${not empty entradasHoy ? entradasHoy : '34'}</div>
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
                            <div class="h5 mb-0 fw-bold text-gray-800">${not empty stockCritico ? stockCritico : '5'}</div>
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
                            <div class="h5 mb-0 fw-bold text-gray-800">${not empty proximosVencer ? proximosVencer : '8'}</div>
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
                        <li class="list-group-item px-4 py-3 d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="mb-0 fw-bold text-dark">Paracetamol 500mg</h6>
                                <small class="text-danger">Stock mínimo superado (12 u.)</small>
                            </div>
                            <span class="badge bg-danger rounded-pill">Crítico</span>
                        </li>
                        <li class="list-group-item px-4 py-3 d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="mb-0 fw-bold text-dark">Amoxicilina 250mg</h6>
                                <small class="text-warning">Vence en 15 días</small>
                            </div>
                            <span class="badge bg-warning rounded-pill text-dark">Vencimiento</span>
                        </li>
                        <li class="list-group-item px-4 py-3 d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="mb-0 fw-bold text-dark">Jeringas 5ml</h6>
                                <small class="text-danger">Agotado (0 u.)</small>
                            </div>
                            <span class="badge bg-danger rounded-pill">Crítico</span>
                        </li>
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
                        data: [45, 60, 30, 80, 50, 20, 10],
                    },
                    {
                        label: "Salidas",
                        backgroundColor: "#dc3545",
                        hoverBackgroundColor: "#bb2d3b",
                        data: [30, 40, 25, 50, 45, 30, 15],
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
