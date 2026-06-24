<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Confirmación</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css" />
</head>
<body>
  <header class="topbar">
    <span class="logo">&#127973;</span>
    <div>
      <h1>Sistema de Inventario Hospitalario</h1>
      <p class="sub">Confirmación de operación</p>
    </div>
  </header>

  <main class="contenedor">
    <div class="card">
      <h2>Operación realizada</h2>
      <div class="mensaje mensaje-exito">
        <span class="icono">&#10003;</span>
        <span>${requestScope.message}</span>
      </div>
      <div class="acciones">
        <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primario">Volver al menú</a>
      </div>
    </div>
  </main>

  <footer class="pie">Sistema de Inventario Hospitalario &middot; ADS2</footer>
</body>
</html>
