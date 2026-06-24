<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<nav id="sidebar">
    <div class="sidebar-header d-flex align-items-center gap-2">
        <i class="fas fa-hospital-user fs-3 text-primary"></i>
        <h4 class="mb-0 fw-bold">SigInv</h4>
    </div>

    <ul class="list-unstyled components">
        <li class="px-3 mb-2 text-uppercase text-muted small fw-bold">Navegación</li>
        <li class="active">
            <a href="${pageContext.request.contextPath}/index.jsp"><i class="fas fa-home me-2"></i> Dashboard</a>
        </li>
        
        <li class="px-3 mt-4 mb-2 text-uppercase text-muted small fw-bold">Compras</li>
        <li>
            <a href="${pageContext.request.contextPath}/proveedores"><i class="fas fa-truck me-2"></i> Proveedores</a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/orden-compra"><i class="fas fa-file-invoice-dollar me-2"></i> Órdenes de Compra</a>
        </li>

        <li class="px-3 mt-4 mb-2 text-uppercase text-muted small fw-bold">Inventario</li>
        <li>
            <a href="${pageContext.request.contextPath}/inventario"><i class="fas fa-boxes-stacked me-2"></i> Stock & Entradas</a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/ajuste-inventario"><i class="fas fa-minus-circle me-2"></i> Salidas / Ajustes</a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/alertas"><i class="fas fa-bell me-2"></i> Alertas</a>
        </li>

        <c:if test="${sessionScope.usuarioLogueado.rol == 'Administrador'}">
            <li class="px-3 mt-4 mb-2 text-uppercase text-muted small fw-bold">Seguridad</li>
            <li>
                <a href="${pageContext.request.contextPath}/usuarios"><i class="fas fa-users-cog me-2"></i> Usuarios</a>
            </li>
        </c:if>
    </ul>
</nav>

<!-- Page Content  -->
<div id="content">
    <nav class="navbar navbar-expand-lg topbar d-flex justify-content-between align-items-center">
        <div class="d-flex align-items-center">
            <button type="button" id="sidebarCollapse" class="btn btn-light shadow-sm border">
                <i class="fas fa-bars"></i>
            </button>
            <h5 class="mb-0 ms-3 fw-bold text-dark d-none d-md-block" id="pageTitle">Panel de Control</h5>
        </div>
        
        <div class="dropdown">
            <a href="#" class="d-flex align-items-center text-dark text-decoration-none dropdown-toggle" id="dropdownUser" data-bs-toggle="dropdown" aria-expanded="false">
                <div class="me-2 text-end d-none d-md-block">
                    <div class="fw-bold">${sessionScope.usuarioLogueado.nombre}</div>
                    <small class="text-muted">${sessionScope.usuarioLogueado.rol}</small>
                </div>
                <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                    <i class="fas fa-user"></i>
                </div>
            </a>
            <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="dropdownUser">
                <li><h6 class="dropdown-header">Opciones</h6></li>
                <li><a class="dropdown-item" href="#"><i class="fas fa-id-badge me-2"></i>Mi Perfil</a></li>
                <li><hr class="dropdown-divider"></li>
                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/login?action=logout"><i class="fas fa-sign-out-alt me-2"></i>Cerrar Sesión</a></li>
            </ul>
        </div>
    </nav>
    <div class="main-content">
