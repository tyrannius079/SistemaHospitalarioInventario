# Sistema Inventario Hospital - Backend (Java EE)

## Requisitos
- Java 25+
- Maven
- Docker Desktop
- Tomcat 11+ (Servlet 6 / JSP 3.1)

## Base de datos (MySQL en Docker)
```sh
docker compose up -d
```
El esquema y los datos semilla se cargan desde `docker/mysql/initdb`.

## Build
```sh
mvn -DskipTests package
```

## Deploy local
1. Copia el `war` generado en `target/` al directorio `webapps/` de Tomcat.
2. Inicia Tomcat y abre la app en el navegador.

## Variables de entorno (opcionales)
- `DB_URL` (default: `jdbc:mysql://localhost:3306/hospitaldb?useSSL=false&serverTimezone=UTC`)
- `DB_USER` (default: `hospital`)
- `DB_PASSWORD` (default: `hospital`)

## Endpoints principales
- `GET /orden-compra` -> Formulario de orden de compra
- `POST /orden-compra` -> Registra orden de compra
- `GET /inventario` -> Formulario de entrada de insumos
- `POST /inventario` -> Registra entrada de insumos
