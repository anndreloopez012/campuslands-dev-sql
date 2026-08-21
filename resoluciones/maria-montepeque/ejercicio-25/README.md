# Ejercicio 25: Reportes Biblioteca

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-06

## Descripcion del problema

Una biblioteca con varias sedes necesita reemplazar el registro manual de sedes, libros, usuarios y prestamos por una base de datos relacional que evite duplicidad de datos y permita generar reportes de prestamos y devoluciones de forma confiable.

## Tablas y relaciones

- `sedes`: catalogo de sedes de la biblioteca (nombre, ciudad).
- `libros`: libro disponible en una sede (titulo, autor, isbn). `sedes` 1—N `libros`.
- `usuarios`: catalogo de usuarios que solicitan prestamos (nombre, correo).
- `prestamos`: prestamo de un libro a un usuario (fecha de prestamo, fecha de devolucion, estado). `libros` 1—N `prestamos` y `usuarios` 1—N `prestamos`.

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 4 tablas.
- `FOREIGN KEY`: `libros.id_sede`, `prestamos.id_libro`, `prestamos.id_usuario`.
- `NOT NULL` en todos los campos obligatorios (`prestamos.fecha_devolucion` permite `NULL` mientras el libro no se devuelve).
- `UNIQUE`: `sedes.nombre`, `libros.isbn`, `usuarios.correo`.
- `CHECK`: `prestamos.estado IN ('prestado', 'devuelto', 'atrasado')` y `prestamos.fecha_devolucion IS NULL OR fecha_devolucion >= fecha_prestamo` (la devolucion no puede ser anterior al prestamo).
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3` disponible en el entorno:

- Datos base: 5 sedes, 5 libros, 5 usuarios, 10 prestamos.
- Tras aplicar `operaciones.sql`: 5 sedes, 5 libros, 6 usuarios y 9 prestamos (2 insertados, 2 eliminados).
- Las 2 operaciones comentadas en `dml/operaciones.sql` fallan al descomentarlas y ejecutarlas: una por `UNIQUE (libros.isbn)` y otra por `CHECK (fecha_devolucion >= fecha_prestamo)`.
- Consulta de decision de negocio (libro con mas prestamos atrasados): `El Principito` con 1 prestamo atrasado.

## Como ejecutar

```bash
sqlite3 ejercicio-25.db < ddl/schema.sql
sqlite3 ejercicio-25.db < dml/inserts.sql
sqlite3 ejercicio-25.db < dml/operaciones.sql
sqlite3 ejercicio-25.db < dql/consultas.sql
```
