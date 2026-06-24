<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<div class="container-fluid">
    <!-- Encabezado -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-0">Gestión de Presupuestos</h3>
            <p class="text-muted mb-0">Asignación y control de fondos financieros para compras hospitalarias.</p>
        </div>
    </div>

    <div class="row">
        <!-- Formulario de Asignación -->
        <div class="col-lg-4 mb-4">
            <div class="card shadow-sm border-0 h-100 border-primary border-top border-4">
                <div class="card-header bg-white py-3">
                    <h6 class="m-0 fw-bold text-primary"><i class="fas fa-money-check-alt me-2"></i>Nueva Asignación</h6>
                </div>
                <div class="card-body p-4">
                    <form id="formPresupuesto" action="${pageContext.request.contextPath}/presupuestos" method="POST" novalidate>
                        
                        <div class="mb-4">
                            <label for="periodo" class="form-label fw-bold">Periodo Fiscal / Trimestre *</label>
                            <input type="text" class="form-control text-uppercase" name="periodo" id="periodo" required placeholder="Ej. 2026-2 o Q3 2026">
                            <div class="invalid-feedback">Debe especificar el periodo del presupuesto.</div>
                        </div>

                        <div class="mb-4">
                            <label for="montoAsignado" class="form-label fw-bold">Monto Asignado (S/) *</label>
                            <div class="input-group has-validation">
                                <span class="input-group-text bg-light fw-bold text-success">S/</span>
                                <input type="number" class="form-control text-end fw-bold fs-5 text-success" name="montoAsignado" id="montoAsignado" required min="1" step="0.01" placeholder="0.00">
                                <div class="invalid-feedback">Ingrese un monto válido mayor a 0.</div>
                            </div>
                        </div>

                        <div class="d-grid mt-4">
                            <button type="submit" class="btn btn-primary btn-lg fw-bold">
                                <i class="fas fa-plus-circle me-2"></i> Aperturar Presupuesto
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Tabla de Presupuestos -->
        <div class="col-lg-8 mb-4">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-header bg-dark text-white py-3">
                    <h6 class="m-0 fw-bold"><i class="fas fa-chart-pie me-2"></i>Control de Ejecución Presupuestal</h6>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table id="tablaPresupuestos" class="table table-hover align-middle mb-0 w-100">
                            <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th>Periodo</th>
                                    <th class="text-end">Monto Total</th>
                                    <th class="text-end">Disponible</th>
                                    <th class="text-center">Ejecución</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Fallback Visual para demo -->
                                <c:if test="${empty presupuestos}">
                                    <tr>
                                        <td class="fw-bold text-secondary">1</td>
                                        <td><span class="badge bg-primary">2026-1</span></td>
                                        <td class="text-end fw-bold">S/ 500,000.00</td>
                                        <td class="text-end fw-bold text-success">S/ 150,000.00</td>
                                        <td class="text-center align-middle">
                                            <div class="progress" style="height: 20px;">
                                                <div class="progress-bar bg-danger" role="progressbar" style="width: 70%;" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100">70% consumido</div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="fw-bold text-secondary">2</td>
                                        <td><span class="badge bg-primary">2026-2</span></td>
                                        <td class="text-end fw-bold">S/ 800,000.00</td>
                                        <td class="text-end fw-bold text-success">S/ 780,000.00</td>
                                        <td class="text-center align-middle">
                                            <div class="progress" style="height: 20px;">
                                                <div class="progress-bar bg-success" role="progressbar" style="width: 2.5%;" aria-valuenow="2.5" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>

                                <!-- Iteración Dinámica -->
                                <c:forEach var="pres" items="${presupuestos}">
                                    <tr>
                                        <td class="fw-bold text-secondary">${pres.idPresupuesto}</td>
                                        <td><span class="badge bg-primary">${pres.periodo}</span></td>
                                        <td class="text-end fw-bold">S/ ${String.format("%,.2f", pres.montoTotal)}</td>
                                        
                                        <!-- Color conditional based on availability -->
                                        <c:set var="porcentajeConsumido" value="${((pres.montoTotal - pres.montoDisponible) / pres.montoTotal) * 100}" />
                                        
                                        <td class="text-end fw-bold ${porcentajeConsumido > 80 ? 'text-danger' : 'text-success'}">
                                            S/ ${String.format("%,.2f", pres.montoDisponible)}
                                        </td>
                                        
                                        <td class="text-center align-middle">
                                            <div class="progress" style="height: 20px;">
                                                <div class="progress-bar ${porcentajeConsumido > 80 ? 'bg-danger' : (porcentajeConsumido > 50 ? 'bg-warning' : 'bg-success')}" 
                                                     role="progressbar" 
                                                     style="width: ${porcentajeConsumido}%;" 
                                                     aria-valuenow="${porcentajeConsumido}" 
                                                     aria-valuemin="0" 
                                                     aria-valuemax="100">
                                                     ${String.format("%.1f", porcentajeConsumido)}%
                                                </div>
                                            </div>
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
</div>

<jsp:include page="/includes/footer.jsp" />

<script>
    document.addEventListener("DOMContentLoaded", function() {
        $('#tablaPresupuestos').DataTable({
            language: { url: 'https://cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json' },
            responsive: true,
            order: [[0, 'desc']], // Mostrar los últimos periodos primero
            columnDefs: [{ orderable: false, targets: 4 }]
        });

        // Validación de formulario con Bootstrap
        const form = document.getElementById('formPresupuesto');
        form.addEventListener('submit', function (event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            } else {
                // Interceptar visualmente el envío para mostrar feedback
                event.preventDefault();
                Swal.fire({
                    title: 'Aperturando Presupuesto...',
                    text: 'Se están asignando los fondos.',
                    icon: 'info',
                    timer: 1000,
                    showConfirmButton: false
                }).then(() => {
                    form.submit();
                });
            }
            form.classList.add('was-validated');
        }, false);
    });
</script>
