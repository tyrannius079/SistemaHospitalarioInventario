<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<div class="container-fluid">
    <!-- Encabezado -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-0">Panel de Alertas Críticas</h3>
            <p class="text-muted mb-0">Monitoreo automático de riesgos operativos y logísticos del hospital.</p>
        </div>
        <div>
            <button class="btn btn-outline-secondary shadow-sm" onclick="location.reload()">
                <i class="fas fa-sync-alt me-1"></i> Refrescar Panel
            </button>
            <button class="btn btn-danger shadow-sm ms-2" onclick="notificarDirectorio()">
                <i class="fas fa-envelope me-1"></i> Enviar a Gerencia
            </button>
        </div>
    </div>

    <div class="row">
        <!-- Columna Izquierda: Alertas de Stock -->
        <div class="col-xl-6 mb-4">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-header bg-danger text-white py-3 d-flex justify-content-between align-items-center">
                    <h6 class="m-0 fw-bold"><i class="fas fa-box-open fa-lg me-2"></i>Quiebre de Stock (Mínimos)</h6>
                    <span class="badge bg-white text-danger fs-6 rounded-pill">3 Ítems Críticos</span>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>Insumo Médico</th>
                                    <th class="text-center">Min.</th>
                                    <th class="text-center">Actual</th>
                                    <th class="text-center">Acción</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="alerta" items="${alertasStock}">
                                    <tr>
                                        <td>
                                            <div class="fw-bold text-danger">${alerta.nombre}</div>
                                            <small class="text-muted">${alerta.codigo}</small>
                                        </td>
                                        <td class="text-center fw-bold text-muted">${alerta.stockMinimo}</td>
                                        <td class="text-center fw-bold fs-5 text-danger">${alerta.stockActual}</td>
                                        <td class="text-center">
                                            <a href="${pageContext.request.contextPath}/orden-compra" class="btn btn-sm btn-danger">Comprar</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty alertasStock}">
                                    <div class="alert alert-light text-center text-muted" role="alert">
                                        No hay alertas de stock por el momento.
                                    </div>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Columna Derecha: Alertas Sanitarias (Lotes) -->
        <div class="col-xl-6 mb-4">
            <div class="card shadow-sm border-0 h-100 border-warning border-start border-4">
                <div class="card-header bg-warning text-dark py-3 d-flex justify-content-between align-items-center">
                    <h6 class="m-0 fw-bold"><i class="fas fa-shield-virus fa-lg me-2"></i>Riesgo Sanitario: Próximos a Vencer (30 Días)</h6>
                    <span class="badge bg-dark text-warning fs-6 rounded-pill">2 Lotes Detectados</span>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>Lote / Producto</th>
                                    <th>Fecha Caducidad</th>
                                    <th class="text-center">Quedan</th>
                                    <th class="text-center">Acción</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="lote" items="${alertasVencimiento}">
                                    <tr>
                                        <td>
                                            <div class="fw-bold text-warning-emphasis">${lote.numeroLote}</div>
                                            <small class="text-muted">Ref: ${lote.idInsumo}</small>
                                        </td>
                                        <td>
                                            <span class="text-danger fw-bold"><i class="fas fa-calendar-times me-1"></i>${lote.fechaVencimiento}</span>
                                        </td>
                                        <td class="text-center fw-bold text-dark">${lote.cantidadActual} unds.</td>
                                        <td class="text-center">
                                            <a href="${pageContext.request.contextPath}/ajuste-inventario" class="btn btn-sm btn-outline-warning text-dark border-warning" title="Mermar stock caducado">Dar Baja</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty alertasVencimiento}">
                                    <div class="alert alert-light text-center text-muted" role="alert">
                                        No hay alertas de vencimiento por el momento.
                                    </div>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="card-footer bg-light border-0">
                    <small class="text-muted"><i class="fas fa-info-circle me-1"></i> Se recomienda aplicar política FIFO (First In, First Out) a estos lotes para evitar mermas financieras.</small>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />

<script>
    function notificarDirectorio() {
        Swal.fire({
            title: '¿Enviar reporte de alertas?',
            text: "Se enviará un correo automático a la Gerencia del Hospital y Jefatura de Farmacia con estas advertencias.",
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#0d6efd',
            cancelButtonColor: '#6c757d',
            confirmButtonText: 'Sí, enviar ahora',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                Swal.fire('Enviado', 'Notificaciones despachadas con éxito.', 'success');
            }
        });
    }
</script>
