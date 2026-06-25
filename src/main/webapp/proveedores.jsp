<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<div class="container-fluid">
    <!-- Encabezado y Acciones -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-0">Directorio de Proveedores</h3>
            <p class="text-muted mb-0">Gestión de socios comerciales e información de contacto.</p>
        </div>
        <div>
            <button class="btn btn-outline-secondary me-2 shadow-sm"><i class="fas fa-file-excel me-1"></i> Exportar</button>
            <button class="btn btn-primary shadow-sm" data-bs-toggle="modal" data-bs-target="#modalProveedor" onclick="abrirModalNuevo()">
                <i class="fas fa-user-plus me-1"></i> Nuevo Proveedor
            </button>
        </div>
    </div>

    <!-- Tabla Principal -->
    <div class="card shadow-sm border-0">
        <div class="card-body">
            <div class="table-responsive">
                <table id="tablaProveedores" class="table table-hover table-striped w-100 align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th>Código</th>
                            <th>RUC / NIT</th>
                            <th>Razón Social</th>
                            <th>Teléfono</th>
                            <th>Email</th>
                            <th>Estado</th>
                            <th class="text-center">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="prov" items="${proveedores}">
                            <tr>
                                <td><span class="badge bg-secondary">${prov.codigo}</span></td>
                                <td>${prov.ruc}</td>
                                <td class="fw-bold">${prov.razonSocial}</td>
                                <td>${prov.telefono}</td>
                                <td>${prov.email}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${prov.estado == 'ACTIVO'}">
                                            <span class="badge bg-success">Activo</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger">Inactivo</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <button class="btn btn-sm btn-outline-primary" onclick="abrirModalEditar('${prov.codigo}', '${prov.ruc}', '${prov.razonSocial}', '${prov.direccion}', '', '${prov.telefono}', '${prov.email}')" title="Editar">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn btn-sm btn-outline-danger" onclick="confirmarDesactivacion('${prov.codigo}')" title="Inactivar">
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

<!-- Modal para Nuevo/Editar Proveedor (Tamaño Grande) -->
<div class="modal fade" id="modalProveedor" tabindex="-1" aria-labelledby="modalProveedorLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title fw-bold" id="modalProveedorLabel"><i class="fas fa-building me-2"></i>Nuevo Proveedor</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <form id="formProveedor" action="${pageContext.request.contextPath}/proveedor" method="POST" novalidate>
                <div class="modal-body">
                    
                    <input type="hidden" name="action" id="actionMethod" value="create">
                    
                    <!-- Fila de Identificación -->
                    <h6 class="text-uppercase text-muted fw-bold mb-3 border-bottom pb-2">Información Fiscal</h6>
                    <div class="row g-3 mb-4">
                        <div class="col-md-4" id="divCodigoOculto" style="display: none;">
                            <label class="form-label text-muted small fw-bold">Código (Sistema)</label>
                            <input type="text" class="form-control bg-light text-secondary fw-bold" id="codigo" name="codigo" readonly tabindex="-1">
                        </div>

                        <div class="col-md-4" id="divRuc">
                            <label for="ruc" class="form-label">RUC / ID Fiscal *</label>
                            <div class="input-group has-validation">
                                <span class="input-group-text"><i class="fas fa-id-card"></i></span>
                                <input type="text" class="form-control" id="ruc" name="ruc" required pattern="^[0-9]{11}$" maxlength="11" placeholder="Ej. 20123456789">
                                <div class="invalid-feedback">Ingrese un RUC válido de 11 dígitos.</div>
                            </div>
                        </div>

                        <div class="col-md-8" id="divRazon">
                            <label for="razonSocial" class="form-label">Razón Social *</label>
                            <input type="text" class="form-control" id="razonSocial" name="razonSocial" required placeholder="Nombre legal de la empresa">
                            <div class="invalid-feedback">La razón social es obligatoria.</div>
                        </div>
                        
                        <div class="col-md-12">
                            <label for="direccion" class="form-label">Dirección Fiscal</label>
                            <input type="text" class="form-control" id="direccion" name="direccion" placeholder="Ej. Av. Los Incas 1234, Lima">
                        </div>
                    </div>

                    <!-- Fila de Contacto -->
                    <h6 class="text-uppercase text-muted fw-bold mb-3 border-bottom pb-2">Información de Contacto</h6>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="telefono" class="form-label">Teléfono *</label>
                            <div class="input-group has-validation">
                                <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                <input type="tel" class="form-control" id="telefono" name="telefono" required pattern="^[0-9]{7,15}$" placeholder="Solo números">
                                <div class="invalid-feedback">Ingrese un teléfono válido.</div>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <label for="email" class="form-label">Correo Electrónico *</label>
                            <div class="input-group has-validation">
                                <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                <input type="email" class="form-control" id="email" name="email" required placeholder="ventas@empresa.com">
                                <div class="invalid-feedback">Ingrese un correo electrónico válido.</div>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="modal-footer bg-light">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"><i class="fas fa-times me-1"></i> Cancelar</button>
                    <button type="submit" class="btn btn-primary px-4 fw-bold" id="btnGuardar"><i class="fas fa-save me-1"></i> Registrar Proveedor</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />

<script>
    document.addEventListener("DOMContentLoaded", function() {
        $('#tablaProveedores').DataTable({
            language: { url: 'https://cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json' },
            responsive: true,
            columnDefs: [{ orderable: false, targets: 6 }]
        });

        const formProveedor = document.getElementById('formProveedor');
        formProveedor.addEventListener('submit', function (event) {
            if (!formProveedor.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
                formProveedor.classList.add('was-validated');
            } else {
                const btnGuardar = document.getElementById('btnGuardar');
                btnGuardar.disabled = true;
                btnGuardar.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Guardando...';
            }
        }, false);
        
        // Evitar que ingresen letras en el RUC y Teléfono
        document.getElementById('ruc').addEventListener('input', function (e) {
            this.value = this.value.replace(/[^0-9]/g, '');
        });
        document.getElementById('telefono').addEventListener('input', function (e) {
            this.value = this.value.replace(/[^0-9]/g, '');
        });
    });

    function abrirModalNuevo() {
        document.getElementById('formProveedor').reset();
        document.getElementById('formProveedor').classList.remove('was-validated');
        document.getElementById('actionMethod').value = 'create';
        document.getElementById('modalProveedorLabel').innerHTML = '<i class="fas fa-building me-2"></i>Nuevo Proveedor';
        
        const colOculta = document.getElementById('divCodigoOculto');
        colOculta.style.display = 'none';
        
        // Ajustar grid de Bootstrap si se oculta el código
        document.getElementById('divRuc').classList.replace('col-md-4', 'col-md-6');
        document.getElementById('divRazon').classList.replace('col-md-8', 'col-md-6');
        
        setTimeout(() => document.getElementById('ruc').focus(), 500);
    }

    function abrirModalEditar(codigo, ruc, razon, direccion, contacto, telefono, email) {
        document.getElementById('formProveedor').reset();
        document.getElementById('formProveedor').classList.remove('was-validated');
        document.getElementById('actionMethod').value = 'update';
        document.getElementById('modalProveedorLabel').innerHTML = '<i class="fas fa-edit me-2"></i>Editar Proveedor';
        
        const colOculta = document.getElementById('divCodigoOculto');
        colOculta.style.display = 'block';
        
        // Reajustar grid de Bootstrap para mostrar código
        document.getElementById('divRuc').classList.replace('col-md-6', 'col-md-4');
        document.getElementById('divRazon').classList.replace('col-md-6', 'col-md-8');

        document.getElementById('codigo').value = codigo;
        document.getElementById('ruc').value = ruc;
        document.getElementById('razonSocial').value = razon;
        document.getElementById('direccion').value = direccion;
        document.getElementById('telefono').value = telefono;
        document.getElementById('email').value = email;
        
        const modal = new bootstrap.Modal(document.getElementById('modalProveedor'));
        modal.show();
    }

    function confirmarDesactivacion(codigo) {
        Swal.fire({
            title: '¿Suspender Proveedor?',
            text: "El proveedor " + codigo + " no podrá ser seleccionado en futuras Órdenes de Compra.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#dc3545',
            cancelButtonColor: '#6c757d',
            confirmButtonText: 'Sí, suspender',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                Swal.fire('Suspendido', 'Proveedor inactivado temporalmente.', 'success');
            }
        });
    }
</script>
