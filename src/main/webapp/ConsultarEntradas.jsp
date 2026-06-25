<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movimientos de Inventario - Sistema Hospitalario</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- DataTables CSS -->
    <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/buttons/2.4.1/css/buttons.bootstrap5.min.css" rel="stylesheet">
    
    <style>
        body { background-color: #f8f9fa; font-family: 'Inter', sans-serif; }
        .card { border: none; border-radius: 12px; box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075); }
        .card-header { background-color: #ffffff; border-bottom: 1px solid rgba(0,0,0,.125); border-radius: 12px 12px 0 0 !important; }
        .table > :not(caption) > * > * { padding: 1rem 1rem; }
        .badge { font-weight: 500; padding: 0.5em 0.8em; }
        .btn-sm { padding: 0.4rem 0.8rem; }
        .page-header { background: linear-gradient(135deg, #1e40af 0%, #3b82f6 100%); color: white; padding: 2rem 0; margin-bottom: 2rem; border-radius: 0 0 1.5rem 1.5rem; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1); }
    </style>
</head>
<body>

    <div class="d-flex">
        <!-- Sidebar -->
        <jsp:include page="includes/sidebar.jsp" />

        <div class="w-100">
            <!-- Contenido Principal -->
            <div class="container-fluid px-4 py-4">
                
                <!-- Encabezado de Página -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h3 class="mb-1 fw-bold text-dark"><i class="fas fa-exchange-alt text-primary me-2"></i>Movimientos de Inventario</h3>
                        <p class="text-muted mb-0">Historial completo de entradas y salidas de almacén.</p>
                    </div>
                    <div class="d-flex gap-2">
                        <a href="${pageContext.request.contextPath}/inventario" class="btn btn-primary shadow-sm">
                            <i class="fas fa-arrow-down me-1"></i> Registrar Entrada
                        </a>
                        <a href="${pageContext.request.contextPath}/ajuste-inventario" class="btn btn-warning shadow-sm">
                            <i class="fas fa-arrow-up me-1 text-dark"></i> <span class="text-dark">Registrar Salida / Merma</span>
                        </a>
                    </div>
                </div>

                <!-- Tabla de Movimientos -->
                <div class="card shadow-sm border-0">
                    <div class="card-body p-4">
                        <div class="table-responsive">
                            <table id="tablaMovimientos" class="table table-hover align-middle w-100">
                                <thead class="table-light">
                                    <tr>
                                        <th>ID Mov.</th>
                                        <th>Fecha</th>
                                        <th>Tipo</th>
                                        <th>Insumo</th>
                                        <th>Lote</th>
                                        <th>Orden Compra</th>
                                        <th>Cantidad</th>
                                        <th>Observaciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="mov" items="${movimientos}">
                                        <tr>
                                            <td><span class="text-muted fw-bold">#${mov.idMovimiento}</span></td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <i class="far fa-calendar-alt text-secondary me-2"></i>
                                                    ${mov.fechaMovimiento}
                                                </div>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${mov.tipoMovimiento == 'ENTRADA'}">
                                                        <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 rounded-pill"><i class="fas fa-arrow-down me-1"></i> ENTRADA</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25 rounded-pill"><i class="fas fa-arrow-up me-1"></i> ${mov.tipoMovimiento}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <span class="fw-bold">${mov.nombreInsumo != null ? mov.nombreInsumo : 'Insumo #'.concat(mov.idInsumo)}</span>
                                            </td>
                                            <td>
                                                <span class="text-secondary">${mov.numeroLote != null ? mov.numeroLote : (mov.idLote != 0 ? 'ID: '.concat(mov.idLote) : '-')}</span>
                                            </td>
                                            <td>${mov.idOrdenCompra != 0 ? mov.idOrdenCompra : '-'}</td>
                                            <td>
                                                <span class="badge ${mov.tipoMovimiento == 'ENTRADA' ? 'bg-success' : 'bg-danger'} rounded-pill fs-6">
                                                    ${mov.tipoMovimiento == 'ENTRADA' ? '+' : '-'}${mov.cantidad}
                                                </span>
                                            </td>
                                            <td><small class="text-muted">${mov.observaciones != null ? mov.observaciones : '-'}</small></td>
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

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
    
    <script>
        $(document).ready(function() {
            $('#tablaMovimientos').DataTable({
                language: {
                    url: 'https://cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json'
                },
                order: [[0, 'desc']], // Ordenar por ID descendente (más recientes primero)
                pageLength: 15,
                dom: '<"row align-items-center mb-4"<"col-md-6"l><"col-md-6"f>>rt<"row align-items-center mt-4"<"col-md-6"i><"col-md-6"p>>',
                drawCallback: function() {
                    $('.dataTables_paginate > .pagination').addClass('pagination-rounded');
                }
            });
        });
    </script>
</body>
</html>
