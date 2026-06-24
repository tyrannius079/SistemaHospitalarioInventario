<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Iniciar Sesión - Hospital</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css" />
  <style>
    .login-container {
      max-width: 400px;
      margin: 100px auto;
      padding: 2rem;
      background-color: white;
      border-radius: 8px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      text-align: center;
    }
    .login-container h2 {
      margin-bottom: 1.5rem;
      color: #333;
    }
    .form-group {
      margin-bottom: 1rem;
      text-align: left;
    }
    .form-group label {
      display: block;
      margin-bottom: 0.5rem;
      font-weight: bold;
      color: #555;
    }
    .form-group input {
      width: 100%;
      padding: 0.75rem;
      border: 1px solid #ccc;
      border-radius: 4px;
      font-size: 1rem;
    }
    .btn-login {
      width: 100%;
      padding: 0.75rem;
      background-color: #0056b3;
      color: white;
      border: none;
      border-radius: 4px;
      font-size: 1.1rem;
      cursor: pointer;
      margin-top: 1rem;
    }
    .btn-login:hover {
      background-color: #004494;
    }
    .error-msg {
      color: #dc3545;
      margin-bottom: 1rem;
      background-color: #f8d7da;
      padding: 0.5rem;
      border-radius: 4px;
      border: 1px solid #f5c6cb;
    }
  </style>
</head>
<body>
  <div class="login-container">
    <span style="font-size: 3rem;">&#127973;</span>
    <h2>Acceso al Sistema</h2>
    <p>Inventario Hospitalario</p>
    
    <c:if test="${not empty error}">
        <div class="error-msg">${error}</div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/login">
      <div class="form-group">
        <label for="dni">DNI</label>
        <input type="text" id="dni" name="dni" required autofocus autocomplete="off" />
      </div>
      <div class="form-group">
        <label for="password">Contraseña</label>
        <input type="password" id="password" name="password" required />
      </div>
      <button type="submit" class="btn-login">Ingresar</button>
    </form>
  </div>
</body>
</html>
