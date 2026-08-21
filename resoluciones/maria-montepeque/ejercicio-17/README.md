# Ejercicio 17: Red Social Campus

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-06

## Descripcion del problema

Una red social educativa necesita reemplazar el registro manual de usuarios, publicaciones, comentarios y reacciones por una base de datos relacional que evite duplicidad de datos y permita medir la interaccion sobre cada publicacion.

## Tablas y relaciones

- `usuarios`: catalogo de usuarios de la red social (nombre de usuario, correo, fecha de registro).
- `publicaciones`: publicacion creada por un usuario (contenido, fecha). `usuarios` 1—N `publicaciones`.
- `comentarios`: comentario de un usuario sobre una publicacion (contenido, fecha). `publicaciones` 1—N `comentarios` y `usuarios` 1—N `comentarios`.
- `reacciones`: reaccion de un usuario sobre una publicacion (tipo, fecha). `publicaciones` 1—N `reacciones` y `usuarios` 1—N `reacciones`.

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 4 tablas.
- `FOREIGN KEY`: `publicaciones.id_usuario`, `comentarios.id_publicacion`, `comentarios.id_usuario`, `reacciones.id_publicacion`, `reacciones.id_usuario`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `usuarios.nombre_usuario`, `usuarios.correo` y `reacciones (id_publicacion, id_usuario)` para evitar que un usuario reaccione mas de una vez a la misma publicacion.
- `CHECK`: `publicaciones.contenido` no puede quedar vacio (`length(contenido) > 0`), `reacciones.tipo IN ('like', 'love', 'haha', 'wow', 'sad', 'angry')`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3` disponible en el entorno:

- Datos base: 5 usuarios, 5 publicaciones, 5 comentarios, 10 reacciones.
- Tras aplicar `operaciones.sql`: 6 usuarios, 5 publicaciones, 5 comentarios y 9 reacciones (2 insertadas, 2 eliminadas).
- Las 2 operaciones comentadas en `dml/operaciones.sql` fallan al descomentarlas y ejecutarlas: una por `UNIQUE (reacciones.id_publicacion, id_usuario)` y otra por `CHECK (reacciones.tipo IN (...))`.
- Consulta de decision de negocio (publicacion con mas interacciones totales entre reacciones y comentarios): la publicacion "Empezando el semestre con energia nueva y muchas metas." con 4 interacciones (3 reacciones + 1 comentario).

## Como ejecutar

```bash
sqlite3 ejercicio-17.db < ddl/schema.sql
sqlite3 ejercicio-17.db < dml/inserts.sql
sqlite3 ejercicio-17.db < dml/operaciones.sql
sqlite3 ejercicio-17.db < dql/consultas.sql
```
