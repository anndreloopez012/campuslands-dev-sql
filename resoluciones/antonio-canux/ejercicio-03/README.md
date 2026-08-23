# Ejercicio 03: Biblioteca Tech

**Camper:** Antonio Canux

## Descripcion del problema

La biblioteca academica necesita reemplazar el registro manual de libros, autores, campers y prestamos por una base de datos relacional que evite duplicidad y permita controlar la disponibilidad y devolucion de libros.

## Tablas y relaciones

- `autores`: catalogo de autores (nombre).
- `libros`: catalogo de libros con stock disponible (`autores` 1—N `libros`).
- `campers`: catalogo de estudiantes que solicitan prestamos (nombre, correo, ficha).
- `prestamos`: transaccion de prestamo de un libro a un camper (`campers` 1—N `prestamos`, `libros` 1—N `prestamos`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 4 tablas.
- `FOREIGN KEY`: `libros.id_autor`, `prestamos.id_camper`, `prestamos.id_libro`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `autores.nombre`, `campers.correo`.
- `CHECK`: `libros.anio_publicacion > 0`, `libros.stock >= 0`, `prestamos.estado IN ('prestado', 'devuelto', 'atrasado')`.


## Como ejecutar

```bash
sqlite3 ejercicio-03.db < ddl/schema.sql
sqlite3 ejercicio-03.db < dml/inserts.sql
sqlite3 ejercicio-03.db < dml/operaciones.sql
sqlite3 ejercicio-03.db < dql/consultas.sql
```
