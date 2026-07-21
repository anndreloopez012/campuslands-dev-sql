# Docker Packages

Este repositorio publica una imagen Docker en GitHub Container Registry para que estudiantes y maestros puedan consultar el contenido localmente sin configurar un servidor manual.

## Imagen publicada

```bash
docker pull ghcr.io/anndreloopez012/campuslands-dev-sql:dev
docker run --rm -p 8080:80 ghcr.io/anndreloopez012/campuslands-dev-sql:dev
```

Luego abre:

```text
http://localhost:8080
```

## Construir localmente desde el repositorio

```bash
docker compose up -d --build
```

Para detenerlo:

```bash
docker compose down
```

## Si el puerto 8080 esta ocupado

Edita `docker-compose.yml` y cambia el lado izquierdo del puerto. Ejemplo:

```yaml
ports:
  - "8090:80"
```

Despues abre `http://localhost:8090`.

## Publicacion automatica

El workflow `.github/workflows/publish-docker-package.yml` publica la imagen cuando hay cambios en `dev` o `main`.

- `dev` publica la etiqueta `ghcr.io/anndreloopez012/campuslands-dev-sql:dev`.
- `main` publica la etiqueta `ghcr.io/anndreloopez012/campuslands-dev-sql:latest`.
- Cada ejecucion tambien publica una etiqueta por SHA del commit.

## Uso recomendado

- Los estudiantes siguen entregando ejercicios por PR hacia `dev`.
- Los maestros revisan y mezclan a `dev`.
- GitHub Actions actualiza la imagen Docker de consulta.
- Para produccion, se conserva `main` como rama estable.
