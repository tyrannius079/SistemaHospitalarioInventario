<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Registrar Orden de Compra</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css" />
</head>
<body>
  <header class="topbar">
    <span class="logo">&#128221;</span>
    <div>
      <h1>Registrar Orden de Compra</h1>
      <p class="sub">Sistema de Inventario Hospitalario</p>
    </div>
  </header>

  <main class="contenedor">
    <a class="volver" href="${pageContext.request.contextPath}/index.jsp">&#8592; Volver al inicio</a>

    <div class="card">
      <h2>Datos de la orden</h2>
      <p class="descripcion">Complete los datos de cabecera y el detalle de insumos a solicitar.</p>

      <form method="post" action="${pageContext.request.contextPath}/orden-compra">
        <div class="form-grid">
          <div class="campo">
            <label>Id Solicitud</label>
            <input type="number" name="idSolicitud" required />
          </div>

          <div class="campo">
            <label>Proforma</label>
            <select name="idProforma" required>
              <option value="">-- Seleccione --</option>
              <c:forEach var="prof" items="${proformas}">
                <option value="${prof.idProforma}">#${prof.idProforma} - Total: ${prof.montoTotal}</option>
              </c:forEach>
            </select>
          </div>

          <div class="campo">
            <label>Proveedor</label>
            <select name="idProveedor" required>
              <option value="">-- Seleccione --</option>
              <c:forEach var="prov" items="${proveedores}">
                <option value="${prov.idProveedor}">${prov.razonSocial} (${prov.ruc})</option>
              </c:forEach>
            </select>
          </div>

          <div class="campo">
            <label>Usuario</label>
            <select name="idUsuario" required>
              <option value="">-- Seleccione --</option>
              <c:forEach var="user" items="${usuarios}">
                <option value="${user.idUsuario}">${user.nombre} (${user.rol})</option>
              </c:forEach>
            </select>
          </div>

          <div class="campo">
            <label>Presupuesto</label>
            <select name="idPresupuesto" required>
              <option value="">-- Seleccione --</option>
              <c:forEach var="pres" items="${presupuestos}">
                <option value="${pres.idPresupuesto}">${pres.periodo} - Disp: ${pres.montoDisponible}</option>
              </c:forEach>
            </select>
          </div>

          <div class="campo">
            <label>Fecha Emisión</label>
            <input type="date" name="fechaEmision" />
          </div>

          <div class="campo">
            <label>Estado</label>
            <input type="text" name="estado" value="EMITIDA" />
          </div>

          <div class="campo ancho-total">
            <label>Observaciones</label>
            <input type="text" name="observaciones" />
          </div>
        </div>

        <h3 class="seccion-titulo">Detalles de la orden</h3>
        <div class="tabla-wrap">
          <table class="datos">
            <thead>
              <tr>
                <th>Insumo</th>
                <th>Cantidad</th>
                <th>Precio Unitario</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach begin="1" end="3">
              <tr>
                <td>
                  <select name="idInsumo">
                    <option value="">-- Seleccione Insumo --</option>
                    <c:forEach var="ins" items="${insumos}">
                      <option value="${ins.idInsumo}">${ins.nombre} (Stock: ${ins.stockActual})</option>
                    </c:forEach>
                  </select>
                </td>
                <td><input type="number" name="cantidad" /></td>
                <td><input type="number" step="0.01" name="precioUnitario" /></td>
              </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>

        <div class="acciones">
          <button type="submit" class="btn btn-primario">&#10003; Registrar Orden</button>
          <a href="${pageContext.request.contextPath}/orden-compra?action=listar" class="btn btn-secundario">Ver órdenes registradas</a>
        </div>
      </form>
    </div>
  </main>

  <footer class="pie">Sistema de Inventario Hospitalario &middot; ADS2</footer>
</body>
</html>
