<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:if test="${empty sessionScope.usuarioLogueado}">
    <c:redirect url="/login.jsp" />
</c:if>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema Inteligente de Gestión de Inventario</title>
    
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- SweetAlert2 -->
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css" rel="stylesheet">
    <!-- DataTables -->
    <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    
    <style>
        body { background-color: #f4f6f9; overflow-x: hidden; }
        .wrapper { display: flex; width: 100%; align-items: stretch; }
        #sidebar { 
            min-width: 250px; 
            max-width: 250px; 
            background: #212529; 
            color: #fff; 
            transition: all 0.3s;
            min-height: 100vh;
        }
        #sidebar .sidebar-header { padding: 20px; background: #1a1e21; }
        #sidebar ul.components { padding: 20px 0; }
        #sidebar ul li a { 
            padding: 10px 20px; 
            font-size: 1.1em; 
            display: block; 
            color: rgba(255,255,255,0.8);
            text-decoration: none;
        }
        #sidebar ul li a:hover { color: #fff; background: #0d6efd; }
        #sidebar ul li.active > a { color: #fff; background: #0d6efd; border-left: 4px solid #fff; }
        
        #content { width: 100%; padding: 0; min-height: 100vh; display: flex; flex-direction: column; }
        .topbar { background: #fff; padding: 15px 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.08); z-index: 10;}
        .main-content { padding: 20px; flex-grow: 1; }
        .footer { background: #fff; padding: 15px; text-align: center; border-top: 1px solid #dee2e6; }
    </style>
</head>
<body>
<div class="wrapper">
    <!-- Sidebar será incluido aquí -->
