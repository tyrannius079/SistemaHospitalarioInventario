<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/sidebar.jsp" />

<div class="container-fluid">
    <!-- Encabezado -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-0">Gestión de Usuarios</h3>
            <p class="text-muted mb-0">Administración de accesos, roles y credenciales del personal hospitalario.</p>
        </div>
        <div>
            <button class="btn btn-primary shadow-sm" onclick="abrirModalNuevo()">
                <i class="fas fa-user-plus me-1"></i> Registrar Usuario
            </button>
        </div>
    </div>

    <!-- Tabla Principal (CRUD) -->
    <div class="card shadow-sm border-0">
        <div class="card-body">
            <div class="table-responsive">
                <table id="tablaUsuarios" class="table table-hover align-middle w-100">
                    <thead class="table-light">
                        <tr>
                            <th>DNI</th>
                            <th>Nombres y Apellidos</th>
                            <th>Correo Electrónico</th>
                            <th>Rol del Sistema</th>
                            <th class="text-center">Estado</th>
                            <th class="text-center">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Datos Simulados / Fallback UI si la BD no envía info -->
                        <tr>
                            <td class="fw-bold text-secondary">71234567</td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <div class="bg-primary text-white rounded-circle d-flex justify-content-center align-items-center me-3" style="width: 40px; height: 40px;">
                                        JP
                                    </div>
                                    <div>
                                        <div class="fw-bold text-dark">Juan Pérez (Tú)</div>
                                        <small class="text-muted">jperez@hospital.gob.pe</small>
                                    </div>
                                </div>
                            </td>
                            <td>jperez@hospital.gob.pe</td>
                            <td><span class="badge bg-dark">ADMINISTRADOR</span></td>
                            <td class="text-center">
                                <span class="badge bg-success-subtle text-success border border-success-subtle">Activo</span>
                            </td>
                            <td class="text-center">
                                <button class="btn btn-sm btn-outline-primary" title="Editar" onclick="abrirModalEditar('71234567', 'Juan Pérez', 'jperez@hospital.gob.pe', 'ADMINISTRADOR', 'ACTIVO')">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="btn btn-sm btn-outline-danger" title="Desactivar" disabled>
                                    <i class="fas fa-user-slash"></i>
                                </button>
                            </td>
                        </tr>
                        <tr>
                            <td class="fw-bold text-secondary">40556677</td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <div class="bg-secondary text-white rounded-circle d-flex justify-content-center align-items-center me-3" style="width: 40px; height: 40px;">
                                        MR
                                    </div>
                                    <div>
                                        <div class="fw-bold text-dark">María Ramos</div>
                                        <small class="text-muted">mramos@hospital.gob.pe</small>
                                    </div>
                                </div>
                            </td>
                            <td>mramos@hospital.gob.pe</td>
                            <td><span class="badge bg-info text-dark">JEFE DE ALMACÉN</span></td>
                            <td class="text-center">
                                <span class="badge bg-success-subtle text-success border border-success-subtle">Activo</span>
                            </td>
                            <td class="text-center">
                                <button class="btn btn-sm btn-outline-primary" title="Editar">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="btn btn-sm btn-outline-danger" title="Desactivar" onclick="confirmarDesactivacion()">
                                    <i class="fas fa-user-slash"></i>
                                </button>
                            </td>
                        </tr>

                        <!-- Iteración JSTL Original -->
                        <c:forEach var="usu" items="${usuarios}">
                            <tr>
                                <td class="fw-bold text-secondary">${usu.dni}</td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="bg-primary text-white rounded-circle d-flex justify-content-center align-items-center me-3" style="width: 40px; height: 40px; text-transform: uppercase;">
                                            ${usu.nombre.substring(0,2)}
                                        </div>
                                        <div>
                                            <div class="fw-bold text-dark">${usu.nombre}</div>
                                            <small class="text-muted">${usu.correo}</small>
                                        </div>
                                    </div>
                                </td>
                                <td>${usu.correo}</td>
                                <td><span class="badge bg-secondary">${usu.rol}</span></td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${usu.estado == 'ACTIVO'}">
                                            <span class="badge bg-success-subtle text-success border border-success-subtle">Activo</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger-subtle text-danger border border-danger-subtle">Inactivo</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <button class="btn btn-sm btn-outline-primary" title="Editar" onclick="abrirModalEditar('${usu.dni}', '${usu.nombre}', '${usu.correo}', '${usu.rol}', '${usu.estado}')">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <c:if test="${usu.estado == 'ACTIVO'}">
                                        <button class="btn btn-sm btn-outline-danger" title="Desactivar" onclick="confirmarDesactivacion()">
                                            <i class="fas fa-user-slash"></i>
                                        </button>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Modal Formulario de Usuario -->
<div class="modal fade" id="modalUsuario" tabindex="-1" aria-labelledby="modalUsuarioLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title fw-bold" id="modalUsuarioLabel"><i class="fas fa-user-shield me-2"></i>Registrar / Editar Usuario</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="formUsuario" action="${pageContext.request.contextPath}/usuario" method="post" novalidate>
                <div class="modal-body p-4">
                    <input type="hidden" name="action" id="formAction" value="crear">
                    
                    <!-- DNI -->
                    <div class="mb-3">
                        <label for="dni" class="form-label fw-bold">Documento de Identidad (DNI) *</label>
                        <input type="text" class="form-control bg-light" name="dni" id="dni" required pattern="[0-9]{8}" maxlength="8" placeholder="Ej. 71234567">
                        <div class="invalid-feedback">El DNI debe contener exactamente 8 dígitos numéricos.</div>
                    </div>

                    <!-- Nombres -->
                    <div class="mb-3">
                        <label for="nombre" class="form-label fw-bold">Nombres y Apellidos Completos *</label>
                        <input type="text" class="form-control" name="nombre" id="nombre" required placeholder="Ej. Juan Andrés Pérez">
                        <div class="invalid-feedback">Este campo es requerido.</div>
                    </div>

                    <!-- Correo -->
                    <div class="mb-3">
                        <label for="correo" class="form-label fw-bold">Correo Institucional</label>
                        <input type="email" class="form-control" name="correo" id="correo" placeholder="ejemplo@hospital.gob.pe">
                    </div>

                    <!-- Rol -->
                    <div class="mb-3">
                        <label for="rol" class="form-label fw-bold">Rol del Sistema *</label>
                        <select class="form-select" name="rol" id="rol" required>
                            <option value="" disabled selected>Seleccione el nivel de acceso...</option>
                            <option value="ADMINISTRADOR">Administrador de Sistema (Full Access)</option>
                            <option value="JEFE DE COMPRAS">Jefatura de Compras (Gestión Financiera)</option>
                            <option value="ALMACEN">Técnico de Almacén (Operativo)</option>
                        </select>
                        <div class="invalid-feedback">Debe asignar un rol al usuario.</div>
                    </div>
                    
                    <!-- Contraseña (Solo en Creación o Forzar Reset) -->
                    <div class="mb-3 p-3 bg-light rounded border border-light" id="divPassword">
                        <label for="password" class="form-label fw-bold">Contraseña de Acceso <span id="lblPassReq" class="text-danger">*</span></label>
                        <input type="password" class="form-control" name="password" id="password" required>
                        <small class="text-muted" id="txtPassHelp">El usuario utilizará su DNI y esta contraseña para ingresar.</small>
                    </div>

                </div>
                <div class="modal-footer bg-light">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-primary px-4"><i class="fas fa-save me-2"></i> Guardar Usuario</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />

<script>
    document.addEventListener("DOMContentLoaded", function() {
        $('#tablaUsuarios').DataTable({
            language: { url: 'https://cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json' },
            responsive: true,
            columnDefs: [
                { orderable: false, targets: 5 } // Desactiva ordenamiento en la columna de acciones
            ]
        });

        // Validación HTML5 de Bootstrap
        const form = document.getElementById('formUsuario');
        form.addEventListener('submit', function (event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        }, false);
    });

    function abrirModalNuevo() {
        document.getElementById('formUsuario').reset();
        document.getElementById('formUsuario').classList.remove('was-validated');
        document.getElementById('formAction').value = 'crear';
        document.getElementById('dni').readOnly = false;
        
        // La contraseña es obligatoria al crear
        document.getElementById('password').required = true;
        document.getElementById('lblPassReq').style.display = 'inline';
        document.getElementById('txtPassHelp').innerText = 'El usuario utilizará su DNI y esta contraseña para ingresar.';
        
        var myModal = new bootstrap.Modal(document.getElementById('modalUsuario'));
        myModal.show();
    }

    function abrirModalEditar(dni, nombre, correo, rol, estado) {
        document.getElementById('formUsuario').classList.remove('was-validated');
        document.getElementById('formAction').value = 'editar';
        
        document.getElementById('dni').value = dni;
        document.getElementById('dni').readOnly = true; // El DNI no se puede editar, es la PK
        document.getElementById('nombre').value = nombre;
        document.getElementById('correo').value = correo;
        document.getElementById('rol').value = rol;
        
        // Al editar, la contraseña no es obligatoria a menos que se quiera cambiar
        document.getElementById('password').required = false;
        document.getElementById('lblPassReq').style.display = 'none';
        document.getElementById('txtPassHelp').innerText = 'Deje este campo en blanco si NO desea cambiar la contraseña actual.';
        
        var myModal = new bootstrap.Modal(document.getElementById('modalUsuario'));
        myModal.show();
    }

    function confirmarDesactivacion() {
        Swal.fire({
            title: '¿Revocar acceso?',
            text: "El usuario será desactivado y no podrá volver a iniciar sesión en el sistema.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#dc3545',
            cancelButtonColor: '#6c757d',
            confirmButtonText: 'Sí, Desactivar',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                // Aquí iría el submit o llamada AJAX real
                Swal.fire('Desactivado', 'El usuario ha perdido acceso al sistema.', 'success');
            }
        });
    }
</script>
