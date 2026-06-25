<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<style>
    /* Tema Premium Oscuro (Dark Slate) para el Sidebar */
    #sidebar {
        background-color: #1e293b !important; /* Azul Pizarra Oscuro */
        color: #f8fafc;
    }
    #sidebar .sidebar-header {
        border-bottom: 1px solid #334155 !important;
        background-color: #0f172a;
    }
    #sidebar .sidebar-header h4 {
        color: #ffffff !important;
        letter-spacing: 1px;
    }
    /* Estilos de Tipografía de cabeceras de sección */
    #sidebar .section-title {
        color: #64748b !important;
        font-size: 0.75rem;
        letter-spacing: 1.2px;
        margin-top: 1.5rem;
    }
    
    #sidebar ul.components {
        padding: 10px 0;
    }
    /* Estilos para los enlaces principales */
    #sidebar ul li a, #sidebar ul li a.dropdown-toggle {
        padding: 12px 20px;
        font-size: 1rem;
        display: block;
        color: #cbd5e1 !important; /* Texto gris claro */
        text-decoration: none;
        transition: all 0.25s ease;
        border-left: 4px solid transparent;
    }
    
    /* Efecto Hover y Estado Abierto (Menú Padre) */
    #sidebar ul li a:hover, #sidebar ul li a[aria-expanded="true"] {
        background: #334155;
        color: #ffffff !important;
        border-left: 4px solid #3b82f6; /* Acento Azul Brillante */
    }
    #sidebar ul li.active > a {
        background: #0f172a;
        color: #60a5fa !important;
        border-left: 4px solid #60a5fa;
    }
    
    /* Iconos de los menús principales */
    #sidebar ul li a i.main-icon {
        color: #94a3b8;
        transition: color 0.25s ease;
        width: 25px; /* Fijar ancho para alinear textos */
        text-align: center;
    }
    #sidebar ul li a:hover i.main-icon, #sidebar ul li a[aria-expanded="true"] i.main-icon {
        color: #60a5fa; /* El icono se ilumina en azul al pasar el mouse */
    }

    /* Animación del Chevron (Flecha Dropdown) */
    #sidebar .dropdown-toggle::after {
        display: inline-block;
        margin-left: auto;
        vertical-align: middle;
        content: "";
        border-top: .3em solid;
        border-right: .3em solid transparent;
        border-bottom: 0;
        border-left: .3em solid transparent;
        transition: transform 0.3s ease;
    }
    #sidebar a[aria-expanded="true"].dropdown-toggle::after {
        transform: rotate(-180deg);
    }
    
    /* Submenús (Collapse y Animación) - Transición Fluida */
    #sidebar ul.collapse,
    #sidebar ul.collapsing {
        background-color: #0f172a; /* Mantiene el fondo oscuro durante la animación de apertura/cierre */
    }
    #sidebar ul.collapse li a,
    #sidebar ul.collapsing li a {
        font-size: 0.92rem;
        padding-top: 10px;
        padding-bottom: 10px;
        padding-left: 55px !important;
        border-left: 4px solid transparent;
        color: #94a3b8 !important;
    }
    #sidebar ul.collapse li a:hover,
    #sidebar ul.collapsing li a:hover {
        border-left: 4px solid #38bdf8;
        background-color: #1e293b;
        color: #ffffff !important;
    }
    #sidebar ul.collapse li a i,
    #sidebar ul.collapsing li a i {
        color: #64748b;
        width: 20px;
        text-align: center;
    }
    #sidebar ul.collapse li a:hover i,
    #sidebar ul.collapsing li a:hover i {
        color: #38bdf8;
    }
</style>

<nav id="sidebar" class="shadow-lg" style="min-height: 100vh; width: 280px; transition: all 0.3s; z-index: 1000;">
    <div class="sidebar-header d-flex align-items-center gap-3 p-4">
        <div class="bg-primary text-white rounded d-flex align-items-center justify-content-center shadow-sm" style="width: 40px; height: 40px;">
            <i class="fas fa-hospital-symbol fs-4"></i>
        </div>
        <h4 class="mb-0 fw-bold">SigInv <span class="text-primary fs-6">Pro</span></h4>
    </div>

    <ul class="list-unstyled components">
        <li class="px-4 mb-2 text-uppercase fw-bold section-title">Navegación</li>
        <li class="active">
            <a href="${pageContext.request.contextPath}/index.jsp"><i class="fas fa-chart-pie main-icon me-2"></i> Dashboard Global</a>
        </li>
        
        <!-- Sección Catálogos Maestros -->
        <li class="px-4 mt-4 mb-2 text-uppercase fw-bold section-title">Catálogos</li>
        <li>
            <a href="#submenuCatalogos" data-bs-toggle="collapse" aria-expanded="false" class="dropdown-toggle d-flex align-items-center">
                <span><i class="fas fa-database main-icon me-2"></i> Datos Maestros</span>
            </a>
            <ul class="collapse list-unstyled" id="submenuCatalogos">
                <li><a href="${pageContext.request.contextPath}/categorias.jsp"><i class="fas fa-tags me-2"></i> Categorías</a></li>
                <li><a href="${pageContext.request.contextPath}/insumos.jsp"><i class="fas fa-pills me-2"></i> Catálogo Insumos</a></li>
                <li><a href="${pageContext.request.contextPath}/proveedores.jsp"><i class="fas fa-building me-2"></i> Proveedores</a></li>
            </ul>
        </li>

        <!-- Sección Compras y Adquisiciones -->
        <li class="px-4 mt-4 mb-2 text-uppercase fw-bold section-title">Compras</li>
        <li>
            <a href="#submenuCompras" data-bs-toggle="collapse" aria-expanded="false" class="dropdown-toggle d-flex align-items-center">
                <span><i class="fas fa-shopping-cart main-icon me-2"></i> Adquisiciones</span>
            </a>
            <ul class="collapse list-unstyled" id="submenuCompras">
                <li><a href="${pageContext.request.contextPath}/registrarProforma.jsp"><i class="fas fa-file-signature me-2"></i> Solicitar Proforma</a></li>
                <li><a href="${pageContext.request.contextPath}/compararProformas.jsp"><i class="fas fa-balance-scale me-2"></i> Cuadro Comparativo</a></li>
                <li><a href="${pageContext.request.contextPath}/RegistrarOrdenCompra.jsp"><i class="fas fa-file-invoice-dollar me-2"></i> Emitir Orden (OC)</a></li>
                <li><a href="${pageContext.request.contextPath}/ConsultarOrdenes.jsp"><i class="fas fa-search-dollar me-2"></i> Seguimiento OCs</a></li>
                <li><a href="${pageContext.request.contextPath}/GestionarPresupuestos.jsp"><i class="fas fa-chart-line me-2"></i> Presupuestos</a></li>
            </ul>
        </li>

        <!-- Sección Inventario Físico -->
        <li class="px-4 mt-4 mb-2 text-uppercase fw-bold section-title">Almacén</li>
        <li>
            <a href="#submenuInventario" data-bs-toggle="collapse" aria-expanded="false" class="dropdown-toggle d-flex align-items-center">
                <span><i class="fas fa-boxes main-icon me-2"></i> Operaciones</span>
            </a>
            <ul class="collapse list-unstyled" id="submenuInventario">
                <li><a href="${pageContext.request.contextPath}/ConsultarStock.jsp"><i class="fas fa-list me-2"></i> Stock Valorizado</a></li>
                <li><a href="${pageContext.request.contextPath}/RegistrarEntrada.jsp"><i class="fas fa-arrow-down me-2"></i> Recepción Física</a></li>
                <li><a href="${pageContext.request.contextPath}/RegistrarAjuste.jsp"><i class="fas fa-arrow-up me-2"></i> Despachos / Mermas</a></li>
                <li><a href="${pageContext.request.contextPath}/ConsultarAlertas.jsp"><i class="fas fa-exclamation-triangle me-2"></i> Alertas Sanitarias</a></li>
            </ul>
        </li>

        <!-- Sección Seguridad -->
        <c:if test="${sessionScope.usuarioLogueado.rol == 'Administrador' || empty sessionScope.usuarioLogueado}">
            <li class="px-4 mt-4 mb-2 text-uppercase fw-bold section-title">Sistema</li>
            <li>
                <a href="#submenuSeguridad" data-bs-toggle="collapse" aria-expanded="false" class="dropdown-toggle d-flex align-items-center">
                    <span><i class="fas fa-shield-alt main-icon me-2"></i> Seguridad</span>
                </a>
                <ul class="collapse list-unstyled" id="submenuSeguridad">
                    <li><a href="${pageContext.request.contextPath}/usuarios.jsp"><i class="fas fa-users-cog me-2"></i> Gestionar Usuarios</a></li>
                </ul>
            </li>
        </c:if>
    </ul>
</nav>

<!-- Page Content  -->
<div id="content" class="w-100">
    <!-- Navbar (Topbar) -->
    <nav class="navbar navbar-expand-lg topbar bg-white border-bottom shadow-sm d-flex justify-content-between align-items-center px-4 py-3 sticky-top">
        <div class="d-flex align-items-center">
            <button type="button" id="sidebarCollapse" class="btn btn-outline-primary border-0 shadow-sm" style="background-color: #f8f9fa;">
                <i class="fas fa-bars"></i>
            </button>
            <h5 class="mb-0 ms-3 fw-bold text-dark d-none d-md-block" id="pageTitle">Área de Trabajo</h5>
        </div>
        
        <div class="dropdown">
            <a href="#" class="d-flex align-items-center text-dark text-decoration-none dropdown-toggle border rounded-pill p-1 pe-3 shadow-sm bg-white" id="dropdownUser" data-bs-toggle="dropdown" aria-expanded="false" style="transition: all 0.2s;">
                <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-2 shadow-sm" style="width: 36px; height: 36px;">
                    <i class="fas fa-user"></i>
                </div>
                <div class="text-end d-none d-md-block mt-1">
                    <div class="fw-bold lh-1" style="font-size: 0.9rem;">${not empty sessionScope.usuarioLogueado ? sessionScope.usuarioLogueado.nombre : 'Usuario Activo'}</div>
                    <small class="text-primary fw-bold" style="font-size: 0.7rem; text-transform: uppercase;">${not empty sessionScope.usuarioLogueado ? sessionScope.usuarioLogueado.rol : 'ADMINISTRADOR'}</small>
                </div>
            </a>
            <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0 mt-3" aria-labelledby="dropdownUser">
                <li class="px-3 py-2 bg-light border-bottom mb-2">
                    <span class="d-block text-muted small fw-bold">CONECTADO COMO</span>
                    <span class="d-block fw-bold">${not empty sessionScope.usuarioLogueado ? sessionScope.usuarioLogueado.nombre : 'Usuario Activo'}</span>
                </li>
                <li><a class="dropdown-item py-2" href="#"><i class="fas fa-id-badge me-2 text-primary"></i>Mi Perfil</a></li>
                <li><a class="dropdown-item py-2" href="#"><i class="fas fa-cog me-2 text-secondary"></i>Configuración</a></li>
                <li><hr class="dropdown-divider"></li>
                <li><a class="dropdown-item text-danger py-2 fw-bold" href="${pageContext.request.contextPath}/login?action=logout"><i class="fas fa-sign-out-alt me-2"></i>Cerrar Sesión</a></li>
            </ul>
        </div>
    </nav>
    <!-- Inicio del Main Content de cada vista -->
    <div class="main-content p-4" style="background-color: #f1f5f9; min-height: calc(100vh - 76px);">

    <!-- Script para mantener el estado activo del menú del Sidebar según la URL -->
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // 1. Obtener la ruta del archivo actual
            const currentPath = window.location.pathname;
            const currentFile = currentPath.substring(currentPath.lastIndexOf('/') + 1);
            
            // 2. Si estamos en el index, no hacemos nada (Dashboard ya activo)
            if (currentFile === '' || currentFile === 'index.jsp') return;
            
            // Remover el 'active' por defecto del Dashboard
            const dashboardItem = document.querySelector('#sidebar .components > li.active');
            if(dashboardItem) dashboardItem.classList.remove('active');

            // 3. Buscar todos los enlaces de los submenús
            const sidebarLinks = document.querySelectorAll('#sidebar ul.collapse li a');
            
            sidebarLinks.forEach(function(link) {
                const linkHref = link.getAttribute('href');
                
                // Si el href del enlace contiene el nombre del archivo actual
                if (linkHref && linkHref.includes(currentFile)) {
                    
                    // a) Aplicar estilos de "Activo" al enlace hijo
                    link.style.color = '#ffffff';
                    link.style.borderLeft = '4px solid #38bdf8';
                    link.style.backgroundColor = '#1e293b';
                    
                    // b) Encontrar el submenú (ul.collapse) padre y forzar su apertura
                    const parentCollapse = link.closest('ul.collapse');
                    if (parentCollapse) {
                        parentCollapse.classList.add('show');
                        
                        // c) Encontrar el botón (a.dropdown-toggle) que abrió esto y cambiar su estado visual
                        const collapseId = parentCollapse.getAttribute('id');
                        const toggleBtn = document.querySelector('a[href="#' + collapseId + '"]');
                        if (toggleBtn) {
                            toggleBtn.setAttribute('aria-expanded', 'true');
                            toggleBtn.parentElement.classList.add('active'); // Estilo activo al padre
                        }
                    }
                }
            });
        });
    </script>
