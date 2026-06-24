<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Panel de Alertas Críticas</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css" />
  <style>
    .alerta-container { margin-bottom: 2rem; border-left: 4px solid #dc3545; padding-left: 1rem; }
    .alerta-container.vencimiento { border-left-color: #ffc107; }
    h3 { margin-bottom: 10px; }
  </style>
</head>
<body>
  <header class="topbar">
    <span class="logo">&#9888;&#65039;</span>
    <div>
      <h1>Panel de Alertas</h1>
      <p class="sub">Vigilancia de Stocks y Vencimientos</p>
    </div>
  </header>

  <main class="contenedor">
    <a class="volver" href="${pageContext.request.contextPath}/index.jsp">&#8592; Volver al inicio</a>

    <div class="card">
      <h2>Centro de Monitoreo Preventivo</h2>
      <p class="descripcion">Aquí se resumen las desviaciones críticas en los niveles de servicio logístico.</p>

      <!-- SECCION 1: STOCK -->
      <div class="alerta-container">
        <h3 style="color: #dc3545;">⚠️ Alertas de Stock Mínimo Crítico</h3>
        <table class="datos">
          <thead>
            <tr>
              <th>ID Insumo</th>
              <th>Código</th>
              <th>Nombre</th>
              <th>Stock Actual</th>
              <th>Stock Mínimo Permitido</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="alerta" items="${alertasStock}">
              <tr style="background-color: #f8d7da; color: #721c24;">
                <td>${alerta.idInsumo}</td>
                <td>${alerta.codigo}</td>
                <td><strong>${alerta.nombre}</strong></td>
                <td>${alerta.stockActual}</td>
                <td>${alerta.stockMinimo}</td>
              </tr>
            </c:forEach>
            <c:if test="${empty alertasStock}">
              <tr><td colspan="5" style="text-align: center; color: green;">Todos los niveles de stock son saludables.</td></tr>
            </c:if>
          </tbody>
        </table>
      </div>

      <!-- SECCION 2: VENCIMIENTO -->
      <div class="alerta-container vencimiento">
        <h3 style="color: #d39e00;">⌛ Alertas de Vencimiento de Lotes (Próximos 30 días)</h3>
        <table class="datos">
          <thead>
            <tr>
              <th>ID Lote</th>
              <th>Núm. Lote</th>
              <th>Insumo Ref.</th>
              <th>Fecha Ingreso</th>
              <th>Fecha Vencimiento</th>
              <th>Cantidad Restante</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="lote" items="${alertasVencimiento}">
              <tr style="background-color: #fff3cd; color: #856404;">
                <td>${lote.idLote}</td>
                <td>${lote.numeroLote}</td>
                <td>${lote.idInsumo}</td>
                <td>${lote.fechaIngreso}</td>
                <td><strong>${lote.fechaVencimiento}</strong></td>
                <td>${lote.cantidadActual} / ${lote.cantidadInicial}</td>
              </tr>
            </c:forEach>
            <c:if test="${empty alertasVencimiento}">
              <tr><td colspan="6" style="text-align: center; color: green;">No hay lotes con riesgo de vencimiento cercano.</td></tr>
            </c:if>
          </tbody>
        </table>
      </div>

    </div>
  </main>

  <footer class="pie">Sistema de Inventario Hospitalario &middot; ADS2</footer>
</body>
</html>
