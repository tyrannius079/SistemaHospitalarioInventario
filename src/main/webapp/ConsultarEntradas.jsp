<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Consultar Entradas de Inventario</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css" />
</head>
<body>
  <header class="topbar">
    <span class="logo">&#128230;</span>
    <div>
      <h1>Movimientos de Inventario</h1>
      <p class="sub">Sistema de Inventario Hospitalario</p>
    </div>
  </header>

  <main class="contenedor">
    <a class="volver" href="${pageContext.request.contextPath}/index.jsp">&#8592; Volver al inicio</a>

    <div class="card">
      <h2>Entradas registradas</h2>
      <p class="descripcion">Listado de los movimientos de entrada de insumos al inventario.</p>

      <div class="acciones" style="margin-top:0;margin-bottom:18px;">
        <a href="${pageContext.request.contextPath}/inventario" class="btn btn-primario">+ Registrar nueva entrada</a>
      </div>

      <div class="tabla-wrap">
        <table class="datos">
          <thead>
            <tr>
              <th>ID Movimiento</th>
              <th>ID Insumo</th>
              <th>ID Lote</th>
              <th>ID Orden Compra</th>
              <th>Cantidad</th>
              <th>Fecha Movimiento</th>
              <th>Tipo</th>
              <th>Observaciones</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="mov" items="${movimientos}">
              <tr>
                <td>${mov.idMovimiento}</td>
                <td>${mov.idInsumo}</td>
                <td>${mov.idLote}</td>
                <td>${mov.idOrdenCompra}</td>
                <td>${mov.cantidad}</td>
                <td>${mov.fechaMovimiento}</td>
                <td><span class="badge badge-info">${mov.tipoMovimiento}</span></td>
                <td>${mov.observaciones}</td>
              </tr>
            </c:forEach>
            <c:if test="${empty movimientos}">
              <tr>
                <td colspan="8" class="vacio">No hay movimientos registrados.</td>
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
