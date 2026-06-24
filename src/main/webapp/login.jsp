<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesión | Sistema de Inventario Hospitalario</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- SweetAlert2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css" rel="stylesheet">

    <style>
        body, html {
            height: 100%;
            background-color: #f4f6f9;
        }
        .login-split {
            height: 100vh;
        }
        .bg-hospital {
            background: linear-gradient(135deg, rgba(13, 110, 253, 0.8), rgba(0, 0, 0, 0.6)), url('https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?q=80&w=2053&auto=format&fit=crop');
            background-size: cover;
            background-position: center;
        }
        .login-form-container {
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-card {
            width: 100%;
            max-width: 400px;
            padding: 2rem;
        }
        .password-toggle {
            cursor: pointer;
            pointer-events: auto;
        }
    </style>
</head>
<body>

    <c:if test="${not empty error}">
        <input type="hidden" id="loginError" value="${error}">
    </c:if>

    <div class="container-fluid p-0">
        <div class="row g-0 login-split">
            
            <div class="col-lg-7 d-none d-lg-flex bg-hospital text-white flex-column justify-content-center p-5">
                <h1 class="display-4 fw-bold mb-3"><i class="fas fa-hospital-user me-3"></i>SigInv</h1>
                <h2 class="fw-light">Sistema Inteligente de Gestión de Inventario</h2>
                <p class="lead mt-4 opacity-75">Optimización de recursos médicos, trazabilidad de insumos y gestión automatizada de compras para la excelencia hospitalaria.</p>
            </div>

            <div class="col-lg-5 col-12 login-form-container bg-white shadow-lg">
                <div class="login-card">
                    
                    <div class="text-center mb-5">
                        <div class="d-inline-flex align-items-center justify-content-center bg-primary text-white rounded-circle mb-3" style="width: 64px; height: 64px; font-size: 28px;">
                            <i class="fas fa-boxes-stacked"></i>
                        </div>
                        <h3 class="fw-bold text-dark">Bienvenido de nuevo</h3>
                        <p class="text-muted">Ingrese sus credenciales para continuar</p>
                    </div>

                    <form action="${pageContext.request.contextPath}/login" method="POST" id="loginForm" novalidate>
                        
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="dni" name="dni" placeholder="DNI" autocomplete="username" autofocus required>
                            <label for="dni"><i class="fas fa-id-card text-muted me-2"></i>DNI corporativo</label>
                            <div class="invalid-feedback">Por favor, ingrese su DNI.</div>
                        </div>

                        <div class="form-floating mb-4 position-relative">
                            <input type="password" class="form-control" id="password" name="password" placeholder="Contraseña" autocomplete="current-password" required>
                            <label for="password"><i class="fas fa-lock text-muted me-2"></i>Contraseña</label>
                            <span class="position-absolute top-50 end-0 translate-middle-y me-3 password-toggle text-muted" id="togglePassword">
                                <i class="fas fa-eye"></i>
                            </span>
                            <div class="invalid-feedback">Por favor, ingrese su contraseña.</div>
                        </div>

                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" value="remember-me" id="rememberMe" name="remember">
                                <label class="form-check-label text-muted" for="rememberMe">
                                    Recordar en este equipo
                                </label>
                            </div>
                        </div>

                        <button class="btn btn-primary btn-lg w-100 fw-bold d-flex justify-content-center align-items-center gap-2" type="submit" id="btnSubmit">
                            <span>Iniciar Sesión</span>
                            <i class="fas fa-arrow-right"></i>
                            <span class="spinner-border spinner-border-sm d-none" role="status" aria-hidden="true" id="btnSpinner"></span>
                        </button>

                    </form>

                    <div class="text-center mt-5">
                        <small class="text-muted">© 2026 Hospital XYZ - Departamento de TI</small>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- SweetAlert2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.all.min.js"></script>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            
            const loginForm = document.getElementById('loginForm');
            const btnSubmit = document.getElementById('btnSubmit');
            const btnSpinner = document.getElementById('btnSpinner');
            const togglePassword = document.getElementById('togglePassword');
            const passwordInput = document.getElementById('password');

            togglePassword.addEventListener('click', function () {
                const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                passwordInput.setAttribute('type', type);
                this.innerHTML = type === 'password' ? '<i class="fas fa-eye"></i>' : '<i class="fas fa-eye-slash"></i>';
            });

            loginForm.addEventListener('submit', function (event) {
                if (!loginForm.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                    loginForm.classList.add('was-validated');
                } else {
                    btnSubmit.setAttribute('disabled', 'true');
                    btnSpinner.classList.remove('d-none');
                    btnSubmit.querySelector('span:not(.spinner-border)').textContent = 'Autenticando...';
                    btnSubmit.querySelector('i.fa-arrow-right').classList.add('d-none');
                }
            }, false);

            const loginError = document.getElementById('loginError');
            if (loginError && loginError.value.trim() !== '') {
                Swal.fire({
                    icon: 'error',
                    title: 'Acceso Denegado',
                    text: loginError.value,
                    confirmButtonColor: '#0d6efd',
                    confirmButtonText: 'Entendido'
                });
            }
        });
    </script>
</body>
</html>
