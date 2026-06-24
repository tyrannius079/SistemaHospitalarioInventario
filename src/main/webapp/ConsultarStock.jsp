<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Consultar Stock Actual</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css" />
  <style>
    .stock-critico { background-color: #f8d7da; color: #721c24; font-weight: bold; }
    .stock-ok { color: #155724; }
  </style>
</head>
<body>
  <header class="topbar">
    <span class="logo">&#128230;</span>
    <div>
      <h1>Consultar Stock de Insumos</h1>
      <p class="sub">Control de Inventario Hospitalario</p>
    </div>
  </header>

  <main class="contenedor">
    <a class="volver" href="${pageContext.request.contextPath}/index.jsp">&#8592; Volver al inicio</a>

    <div class="card">
      <h2>Listado Global de Insumos</h2>
      <p class="descripcion">Vista del stock actual de todos los materiales e insumos en el almacén.</p>

      <div class="tabla-wrap">
        <table class="datos">
          <thead>
            <tr>
              <th>ID</th>
              <th>Código</th>
              <th>Insumo</th>
              <th>U. Medida</th>
              <th>Stock Actual</th>
              <th>Stock Mínimo</th>
              <th>Estado</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="insumo" items="${insumos}">
              <tr class="${insumo.stockActual <= insumo.stockMinimo ? 'stock-critico' : ''}">
                <td>${insumo.idInsumo}</td>
                <td>${insumo.codigo}</td>
                <td><strong>${insumo.nombre}</strong><br><small>${insumo.descripcion}</small></td>
                <td>${insumo.unidadMedida}</td>
                <td style="font-size: 1.2rem; text-align: center;">${insumo.stockActual}</td>
                <td style="text-align: center;">${insumo.stockMinimo}</td>
                <td>
                  <c:if test="${insumo.stockActual <= insumo.stockMinimo}">
                    ⚠️ Alerta de Stock
                  </c:if>
                  <c:if test="${insumo.stockActual > insumo.stockMinimo}">
                    <span class="stock-ok">✅ Normal</span>
                  </c:if>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty insumos}">
              <tr>
                <td colspan="7" style="text-align: center;">No hay insumos registrados.</td>
              </tr>
            </c:if>
          </tbody>
        </table>
      </div>

    </div>
  </main>

  <footer class="pie">Sistema de Inventario Hospitalario &middot; ADS2</footer>
</body>
</html>
