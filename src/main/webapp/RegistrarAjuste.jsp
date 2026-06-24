<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Registrar Salida o Ajuste</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css" />
</head>
<body>
  <header class="topbar">
    <span class="logo">&#9888;&#65039;</span>
    <div>
      <h1>Salida de Insumos</h1>
      <p class="sub">Declaración de mermas o despachos a áreas</p>
    </div>
  </header>

  <main class="contenedor">
    <a class="volver" href="${pageContext.request.contextPath}/index.jsp">&#8592; Volver al inicio</a>

    <div class="card form-container">
      <h2>Registrar Movimiento de Resta</h2>
      <p class="descripcion">Utilice este formulario para descontar stock por distribución interna, mermas o fechas de vencimiento expiradas.</p>

      <form action="${pageContext.request.contextPath}/ajuste-inventario" method="POST">

        <div class="form-group">
          <label for="idInsumo">Insumo a Descontar:</label>
          <select id="idInsumo" name="idInsumo" required>
            <option value="">-- Seleccione un Insumo --</option>
            <c:forEach var="insumo" items="${insumos}">
              <c:if test="${insumo.stockActual > 0}">
                <option value="${insumo.idInsumo}">${insumo.codigo} - ${insumo.nombre} (Stock Disponible: ${insumo.stockActual})</option>
              </c:if>
            </c:forEach>
          </select>
        </div>

        <div class="form-group">
          <label for="tipoMovimiento">Tipo de Movimiento:</label>
          <select id="tipoMovimiento" name="tipoMovimiento" required>
            <option value="SALIDA">Salida (Despacho a otra área)</option>
            <option value="AJUSTE">Ajuste / Merma (Dañado o Vencido)</option>
          </select>
        </div>

        <div class="form-group">
          <label for="cantidad">Cantidad a Retirar:</label>
          <input type="number" id="cantidad" name="cantidad" min="1" required placeholder="Ej: 5" />
          <small>El sistema validará que la cantidad no exceda el stock actual del insumo.</small>
        </div>

        <div class="form-group">
          <label for="observaciones">Observaciones / Motivo (Obligatorio):</label>
          <textarea id="observaciones" name="observaciones" rows="3" required placeholder="Ej: Solicitado por Cirugía general, o Lote dañado."></textarea>
        </div>

        <button type="submit" class="btn">Procesar Movimiento</button>

      </form>
    </div>
  </main>

  <footer class="pie">Sistema de Inventario Hospitalario &middot; ADS2</footer>
</body>
</html>
