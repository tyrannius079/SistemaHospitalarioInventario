<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<div class="container-fluid">
    <!-- Encabezado y Acciones -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-0">Gestión de Categorías</h3>
            <p class="text-muted mb-0">Clasificación de insumos médicos y generales.</p>
        </div>
        <div>
            <button class="btn btn-primary shadow-sm" data-bs-toggle="modal" data-bs-target="#modalCategoria" onclick="abrirModalNuevo()">
                <i class="fas fa-plus-circle me-1"></i> Nueva Categoría
            </button>
        </div>
    </div>

    <!-- Tabla Principal -->
    <div class="card shadow-sm border-0">
        <div class="card-body">
            <div class="table-responsive">
                <table id="tablaCategorias" class="table table-hover table-striped w-100 align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th>Código</th>
                            <th>Nombre de Categoría</th>
                            <th>Descripción</th>
                            <th>Estado</th>
                            <th class="text-center">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="cat" items="${categorias}">
                            <tr>
                                <td><span class="badge bg-secondary">${cat.codigo}</span></td>
                                <td class="fw-bold">${cat.nombre}</td>
                                <td>${cat.descripcion}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${cat.estado == 'ACTIVO'}">
                                            <span class="badge bg-success">Activo</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger">Inactivo</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <button class="btn btn-sm btn-outline-primary" onclick="abrirModalEditar('${cat.codigo}', '${cat.nombre}', '${cat.descripcion}')" title="Editar">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn btn-sm btn-outline-danger" onclick="confirmarDesactivacion('${cat.codigo}')" title="Desactivar">
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

<!-- Modal para Nueva/Editar Categoría -->
<div class="modal fade" id="modalCategoria" tabindex="-1" aria-labelledby="modalCategoriaLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title fw-bold" id="modalCategoriaLabel"><i class="fas fa-tags me-2"></i>Nueva Categoría</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <form id="formCategoria" action="${pageContext.request.contextPath}/categoria" method="POST" novalidate>
                <div class="modal-body">
                    
                    <input type="hidden" name="action" id="actionMethod" value="create">
                    
                    <div class="alert alert-info py-2 d-flex align-items-center">
                        <i class="fas fa-info-circle fs-4 me-2"></i>
                        <small>El código de categoría se generará automáticamente al guardar.</small>
                    </div>

                    <div class="mb-3" id="divCodigoOculto" style="display: none;">
                        <label class="form-label text-muted small fw-bold">Código (Autogenerado)</label>
                        <input type="text" class="form-control bg-light text-secondary fw-bold" id="codigo" name="codigo" readonly tabindex="-1">
                    </div>

                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Nombre" required autocomplete="off">
                        <label for="nombre">Nombre de la Categoría *</label>
                        <div class="invalid-feedback">Por favor, ingrese el nombre de la categoría.</div>
                    </div>

                    <div class="form-floating mb-3">
                        <textarea class="form-control" id="descripcion" name="descripcion" placeholder="Descripción" style="height: 100px"></textarea>
                        <label for="descripcion">Descripción (Opcional)</label>
                    </div>

                </div>
                <div class="modal-footer bg-light">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"><i class="fas fa-times me-1"></i> Cancelar</button>
                    <button type="submit" class="btn btn-primary px-4 fw-bold" id="btnGuardar"><i class="fas fa-save me-1"></i> Guardar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Inicializar DataTables
        $('#tablaCategorias').DataTable({
            language: {
                url: 'https://cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json'
            },
            responsive: true,
            columnDefs: [
                { orderable: false, targets: 4 } // Deshabilita ordenamiento en acciones
            ]
        });

        // Validación de Bootstrap en el Formulario
        const formCategoria = document.getElementById('formCategoria');
        formCategoria.addEventListener('submit', function (event) {
            if (!formCategoria.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
                formCategoria.classList.add('was-validated');
            } else {
                // Simulación de submit exitoso - idealmente manejado por el Servlet
                btnGuardar.disabled = true;
                btnGuardar.innerHTML = '<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>Guardando...';
            }
        }, false);
    });

    // Resetear formulario para registro nuevo
    function abrirModalNuevo() {
        document.getElementById('formCategoria').reset();
        document.getElementById('formCategoria').classList.remove('was-validated');
        document.getElementById('actionMethod').value = 'create';
        document.getElementById('modalCategoriaLabel').innerHTML = '<i class="fas fa-tags me-2"></i>Nueva Categoría';
        document.getElementById('divCodigoOculto').style.display = 'none';
        
        // Retrasar el focus para asegurar que el modal ya se renderizó
        setTimeout(() => document.getElementById('nombre').focus(), 500);
    }

    // Llenar formulario para edición
    function abrirModalEditar(codigo, nombre, descripcion) {
        document.getElementById('formCategoria').reset();
        document.getElementById('formCategoria').classList.remove('was-validated');
        
        document.getElementById('actionMethod').value = 'update';
        document.getElementById('modalCategoriaLabel').innerHTML = '<i class="fas fa-edit me-2"></i>Editar Categoría';
        
        document.getElementById('divCodigoOculto').style.display = 'block';
        document.getElementById('codigo').value = codigo;
        document.getElementById('nombre').value = nombre;
        document.getElementById('descripcion').value = descripcion;
        
        const modal = new bootstrap.Modal(document.getElementById('modalCategoria'));
        modal.show();
    }

    // Confirmación IHC para eliminar/desactivar
    function confirmarDesactivacion(codigo) {
        Swal.fire({
            title: '¿Estás seguro?',
            text: "Esta categoría (" + codigo + ") dejará de estar disponible al crear nuevos insumos.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#dc3545',
            cancelButtonColor: '#6c757d',
            confirmButtonText: '<i class="fas fa-ban me-1"></i> Sí, desactivar',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                // Aquí iría el submit o redirección al Servlet para borrar
                Swal.fire('Desactivada', 'La operación está pendiente de implementación en backend.', 'info');
            }
        });
    }
</script>
