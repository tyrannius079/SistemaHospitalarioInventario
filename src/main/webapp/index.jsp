<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Menú Principal — Inventario Hospitalario</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css" />
</head>
<body>
  <header class="topbar">
    <span class="logo">&#127973;</span>
    <div>
      <h1>Sistema de Inventario Hospitalario</h1>
      <p class="sub">Gestión de órdenes de compra y entradas de insumos</p>
    </div>
  </header>

  <main class="contenedor">
    <div class="card">
      <h2>Menú Principal</h2>
      <p class="descripcion">Seleccione la operación que desea realizar.</p>

      <div class="menu-grid">
        <a class="menu-item" href="${pageContext.request.contextPath}/orden-compra">
          <span class="icono">&#128221;</span>
          <span class="titulo">Registrar Orden de Compra</span>
          <span class="texto">Crear y consultar órdenes de compra a proveedores.</span>
        </a>
        <a class="menu-item" href="${pageContext.request.contextPath}/inventario">
          <span class="icono">&#128230;</span>
          <span class="titulo">Registrar Entrada de Insumos</span>
          <span class="texto">Registrar y consultar entradas al inventario.</span>
        </a>
      </div>
    </div>
  </main>

  <footer class="pie">Sistema de Inventario Hospitalario &middot; ADS2</footer>
</body>
</html>
