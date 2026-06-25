<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<div class="container-fluid">
    <!-- Encabezado y Acciones -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-0">Catálogo de Insumos</h3>
            <p class="text-muted mb-0">Gestión maestra de medicamentos y material médico.</p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/categorias.jsp" class="btn btn-outline-secondary me-2 shadow-sm">
                <i class="fas fa-tags me-1"></i> Categorías
            </a>
            <button class="btn btn-primary shadow-sm" data-bs-toggle="modal" data-bs-target="#modalInsumo" onclick="abrirModalNuevo()">
                <i class="fas fa-plus-circle me-1"></i> Nuevo Insumo
            </button>
        </div>
    </div>

    <!-- Tabla Principal -->
    <div class="card shadow-sm border-0">
        <div class="card-body">
            <div class="table-responsive">
                <table id="tablaInsumos" class="table table-hover table-striped w-100 align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th>Código</th>
                            <th>Nombre del Insumo</th>
                            <th>Categoría</th>
                            <th>Presentación</th>
                            <th>Stock Mín.</th>
                            <th>Stock Actual</th>
                            <th>Estado</th>
                            <th class="text-center">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="insumo" items="${insumos}">
                            <tr>
                                <td><span class="badge bg-secondary">${insumo.codigo}</span></td>
                                <td class="fw-bold">${insumo.nombre}</td>
                                <td>
                                    <c:forEach var="cat" items="${categorias}">
                                        <c:if test="${cat.idCategoria == insumo.idCategoria}">
                                            ${cat.nombre}
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td>${insumo.unidadMedida}</td>
                                <td class="text-danger fw-bold">${insumo.stockMinimo}</td>
                                <td><span class="badge ${insumo.stockActual > insumo.stockMinimo ? 'bg-success' : 'bg-danger'} fs-6">${insumo.stockActual}</span></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${insumo.estado == 'ACTIVO'}">
                                            <span class="badge bg-success">Activo</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger">Inactivo</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <button class="btn btn-sm btn-outline-primary" onclick="abrirModalEditar('${insumo.codigo}', '${insumo.nombre}', '${insumo.idCategoria}', '${insumo.unidadMedida}', '${insumo.stockMinimo}', '${insumo.descripcion}')" title="Editar">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn btn-sm btn-outline-danger" onclick="confirmarDesactivacion('${insumo.codigo}')" title="Inactivar">
                                        <i class="fas fa-ban"></i>
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

<!-- Modal para Nuevo/Editar Insumo -->
<div class="modal fade" id="modalInsumo" tabindex="-1" aria-labelledby="modalInsumoLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title fw-bold" id="modalInsumoLabel"><i class="fas fa-box-open me-2"></i>Nuevo Insumo</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <form id="formInsumo" action="${pageContext.request.contextPath}/insumo" method="POST" novalidate>
                <div class="modal-body">
                    <input type="hidden" name="action" id="actionMethod" value="create">
                    
                    <div class="row g-3 mb-3">
                        <div class="col-md-3" id="divCodigoOculto" style="display: none;">
                            <label class="form-label text-muted small fw-bold">Código</label>
                            <input type="text" class="form-control bg-light text-secondary fw-bold" id="codigo" name="codigo" readonly tabindex="-1">
                        </div>

                        <div class="col-md-9" id="divNombre">
                            <label for="nombre" class="form-label">Nombre del Insumo *</label>
                            <input type="text" class="form-control" id="nombre" name="nombre" required placeholder="Ej. Ibuprofeno 400mg">
                            <div class="invalid-feedback">El nombre es obligatorio.</div>
                        </div>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-md-4">
                            <label for="idCategoria" class="form-label">Categoría *</label>
                            <select class="form-select" id="idCategoria" name="idCategoria" required>
                                <option value="" selected disabled>Seleccione...</option>
                                <option value="1">Medicamentos</option>
                                <option value="2">Material Médico</option>
                                <option value="3">Limpieza</option>
                            </select>
                            <div class="invalid-feedback">Debe seleccionar una categoría.</div>
                        </div>

                        <div class="col-md-4">
                            <label for="presentacion" class="form-label">U. Medida / Presentación *</label>
                            <select class="form-select" id="presentacion" name="presentacion" required>
                                <option value="" selected disabled>Seleccione...</option>
                                <option value="Unidad">Unidad</option>
                                <option value="Caja x 100">Caja x 100</option>
                                <option value="Frasco 500ml">Frasco 500ml</option>
                                <option value="Paquete x 50">Paquete x 50</option>
                            </select>
                            <div class="invalid-feedback">Indique cómo se cuenta el stock.</div>
                        </div>

                        <div class="col-md-4">
                            <label for="stockMinimo" class="form-label">Alerta Stock Mínimo *</label>
                            <div class="input-group has-validation">
                                <span class="input-group-text"><i class="fas fa-bell text-warning"></i></span>
                                <input type="number" class="form-control" id="stockMinimo" name="stockMinimo" required min="1" placeholder="Ej. 20">
                                <div class="invalid-feedback">Ingrese un valor numérico mayor a 0.</div>
                            </div>
                        </div>
                    </div>

                    <div class="row g-3">
                        <div class="col-12">
                            <label for="descripcion" class="form-label">Descripción Técnica (Opcional)</label>
                            <textarea class="form-control" id="descripcion" name="descripcion" rows="2" placeholder="Detalles de conservación, componentes, etc."></textarea>
                        </div>
                    </div>

                    <!-- Mensaje IHC Preventivo -->
                    <div class="alert alert-warning mt-4 mb-0 py-2 d-flex align-items-center">
                        <i class="fas fa-info-circle me-2"></i>
                        <small>El stock actual iniciará en 0. Para incrementar el stock, deberá registrar una <b>Entrada de Inventario</b>.</small>
                    </div>

                </div>
                <div class="modal-footer bg-light">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"><i class="fas fa-times me-1"></i> Cancelar</button>
                    <button type="submit" class="btn btn-primary px-4 fw-bold" id="btnGuardar"><i class="fas fa-save me-1"></i> Guardar Insumo</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />

<script>
    document.addEventListener("DOMContentLoaded", function() {
        $('#tablaInsumos').DataTable({
            language: { url: 'https://cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json' },
            responsive: true,
            columnDefs: [{ orderable: false, targets: 7 }]
        });

        const formInsumo = document.getElementById('formInsumo');
        formInsumo.addEventListener('submit', function (event) {
            if (!formInsumo.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
                formInsumo.classList.add('was-validated');
            } else {
                const btnGuardar = document.getElementById('btnGuardar');
                btnGuardar.disabled = true;
                btnGuardar.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Guardando...';
            }
        }, false);
    });

    function abrirModalNuevo() {
        document.getElementById('formInsumo').reset();
        document.getElementById('formInsumo').classList.remove('was-validated');
        document.getElementById('actionMethod').value = 'create';
        document.getElementById('modalInsumoLabel').innerHTML = '<i class="fas fa-box-open me-2"></i>Nuevo Insumo';
        
        document.getElementById('divCodigoOculto').style.display = 'none';
        document.getElementById('divNombre').classList.replace('col-md-9', 'col-12');
        
        setTimeout(() => document.getElementById('nombre').focus(), 500);
    }

    function abrirModalEditar(codigo, nombre, idCategoria, presentacion, stockMinimo, descripcion) {
        document.getElementById('formInsumo').reset();
        document.getElementById('formInsumo').classList.remove('was-validated');
        document.getElementById('actionMethod').value = 'update';
        document.getElementById('modalInsumoLabel').innerHTML = '<i class="fas fa-edit me-2"></i>Editar Insumo';
        
        document.getElementById('divCodigoOculto').style.display = 'block';
        document.getElementById('divNombre').classList.replace('col-12', 'col-md-9');

        document.getElementById('codigo').value = codigo;
        document.getElementById('nombre').value = nombre;
        document.getElementById('idCategoria').value = idCategoria;
        document.getElementById('presentacion').value = presentacion;
        document.getElementById('stockMinimo').value = stockMinimo;
        document.getElementById('descripcion').value = descripcion;
        
        const modal = new bootstrap.Modal(document.getElementById('modalInsumo'));
        modal.show();
    }

    function confirmarDesactivacion(codigo) {
        Swal.fire({
            title: '¿Suspender Insumo?',
            text: "El insumo " + codigo + " no podrá ser comprado ni ingresado mientras esté suspendido.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#dc3545',
            cancelButtonColor: '#6c757d',
            confirmButtonText: 'Sí, suspender',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                Swal.fire('Suspendido', 'El insumo ha sido inactivado.', 'success');
            }
        });
    }
</script>
