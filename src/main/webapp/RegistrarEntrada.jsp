<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Registrar Entrada de Insumos</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css" />
</head>
<body>
  <header class="topbar">
    <span class="logo">&#128230;</span>
    <div>
      <h1>Registrar Entrada de Insumos</h1>
      <p class="sub">Sistema de Inventario Hospitalario</p>
    </div>
  </header>

  <main class="contenedor">
    <a class="volver" href="${pageContext.request.contextPath}/index.jsp">&#8592; Volver al inicio</a>

    <div class="card">
      <h2>Datos de la entrada</h2>
      <p class="descripcion">Registre el ingreso de insumos al inventario a partir de una orden de compra.</p>

      <form method="post" action="${pageContext.request.contextPath}/inventario">
        <div class="form-grid">
          <div class="campo ancho-total">
            <label>Orden de Compra</label>
            <select name="idOrdenCompra" required>
              <option value="">-- Seleccione --</option>
              <c:forEach var="ord" items="${ordenes}">
                <option value="${ord.idOrdenCompra}">#${ord.idOrdenCompra} - Total: ${ord.total} - Est: ${ord.estado}</option>
              </c:forEach>
            </select>
          </div>

          <div class="campo">
            <label>Insumo</label>
            <select name="idInsumo" required>
              <option value="">-- Seleccione --</option>
              <c:forEach var="ins" items="${insumos}">
                <option value="${ins.idInsumo}">${ins.nombre} (Stock: ${ins.stockActual})</option>
              </c:forEach>
            </select>
          </div>

          <div class="campo">
            <label>Cantidad a Ingresar</label>
            <input type="number" name="cantidad" required />
          </div>

          <div class="campo">
            <label>Número de Lote</label>
            <input type="text" name="numeroLote" required />
          </div>

          <div class="campo">
            <label>Fecha de Vencimiento</label>
            <input type="date" name="fechaVencimiento" required />
          </div>

          <div class="campo">
            <label>Usuario Responsable</label>
            <select name="idUsuario" required>
              <option value="">-- Seleccione --</option>
              <c:forEach var="user" items="${usuarios}">
                <option value="${user.idUsuario}">${user.nombre} (${user.rol})</option>
              </c:forEach>
            </select>
          </div>

          <div class="campo ancho-total">
            <label>Observaciones</label>
            <input type="text" name="observaciones" />
          </div>
        </div>

        <div class="acciones">
          <button type="submit" class="btn btn-primario">&#10003; Registrar Entrada</button>
          <a href="${pageContext.request.contextPath}/inventario?action=listar" class="btn btn-secundario">Ver entradas registradas</a>
        </div>
      </form>
    </div>
  </main>

  <footer class="pie">Sistema de Inventario Hospitalario &middot; ADS2</footer>
</body>
</html>
