<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Consultar Órdenes de Compra</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css" />
</head>
<body>
  <header class="topbar">
    <span class="logo">&#128221;</span>
    <div>
      <h1>Órdenes de Compra</h1>
      <p class="sub">Sistema de Inventario Hospitalario</p>
    </div>
  </header>

  <main class="contenedor">
    <a class="volver" href="${pageContext.request.contextPath}/index.jsp">&#8592; Volver al inicio</a>

    <div class="card">
      <h2>Órdenes registradas</h2>
      <p class="descripcion">Listado de todas las órdenes de compra emitidas a proveedores.</p>

      <div class="acciones" style="margin-top:0;margin-bottom:18px;">
        <a href="${pageContext.request.contextPath}/orden-compra" class="btn btn-primario">+ Registrar nueva orden</a>
      </div>

      <div class="tabla-wrap">
        <table class="datos">
          <thead>
            <tr>
              <th>ID Orden</th>
              <th>ID Proveedor</th>
              <th>Fecha Emisión</th>
              <th>Total</th>
              <th>Estado</th>
              <th>Observaciones</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="orden" items="${ordenes}">
              <tr>
                <td>${orden.idOrdenCompra}</td>
                <td>${orden.idProveedor}</td>
                <td>${orden.fechaEmision}</td>
                <td>${orden.total}</td>
                <td>
                  <form action="${pageContext.request.contextPath}/orden-compra" method="POST" style="display:flex; gap:5px;">
                    <input type="hidden" name="action" value="actualizar" />
                    <input type="hidden" name="idOrdenCompra" value="${orden.idOrdenCompra}" />
                    <select name="estado" style="padding: 2px;">
                      <option value="EMITIDA" ${orden.estado == 'EMITIDA' ? 'selected' : ''}>EMITIDA</option>
                      <option value="APROBADA" ${orden.estado == 'APROBADA' ? 'selected' : ''}>APROBADA</option>
                      <option value="RECEPCIONADA" ${orden.estado == 'RECEPCIONADA' ? 'selected' : ''}>RECEPCIONADA</option>
                      <option value="ANULADA" ${orden.estado == 'ANULADA' ? 'selected' : ''}>ANULADA</option>
                    </select>
                    <button type="submit" class="btn" style="padding: 2px 8px;">✔️</button>
                  </form>
                </td>
                <td>${orden.observaciones}</td>
              </tr>
            </c:forEach>
            <c:if test="${empty ordenes}">
              <tr>
                <td colspan="6" class="vacio">No hay órdenes registradas.</td>
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
