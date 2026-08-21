# Ejercicio 37: Normalizacion Biblioteca Multiautor

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-17

## Descripcion del problema

La biblioteca administraba sus prestamos en un archivo plano (`datos/datos-sin-normalizar.csv`) con una sola tabla donde cada libro tenia dos listas independientes en la misma fila: sus autores y sus generos, ambas separadas por `|`. Esto obligaba a repetir la lista completa de autores y generos cada vez que el mismo libro se prestaba de nuevo. El detalle completo del analisis (dependencias funcionales, problemas y el proceso de normalizacion 1FN -> 2FN -> 3FN) esta en [`analisis/normalizacion.md`](analisis/normalizacion.md).

## Tablas y relaciones

- `autores`: catalogo de autores.
- `generos`: catalogo de generos.
- `libros`: catalogo de libros.
- `usuarios`: catalogo de usuarios que piden prestamos.
- `libro_autor`: tabla puente para la relacion N:M entre libros y autores (un libro puede tener varios autores, un autor puede tener varios libros).
- `libro_genero`: tabla puente para la relacion N:M entre libros y generos.
- `prestamos`: detalle de cada prestamo de un libro a un usuario. `libros` 1—N `prestamos` y `usuarios` 1—N `prestamos`.

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en `autores`, `generos`, `libros`, `usuarios` y `prestamos`; llave compuesta en las tablas puente (`(id_libro, id_autor)` y `(id_libro, id_genero)`).
- `FOREIGN KEY`: `libro_autor.id_libro/id_autor`, `libro_genero.id_libro/id_genero`, `prestamos.id_libro`, `prestamos.id_usuario`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `autores.nombre`, `generos.nombre`, `libros.titulo`, `usuarios.nombre`.
- `CHECK`: `libros.titulo` no puede quedar vacio (`length(titulo) > 0`), `prestamos.fecha_devolucion` con formato `YYYY-MM-DD`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `dql`) con SQLite:

- Datos base: 5 autores, 5 generos, 5 libros, 5 usuarios (catalogos), 6 lineas en `libro_autor`, 7 en `libro_genero`, 11 en `prestamos`.
- La consulta 1 (`JOIN` con subconsultas `GROUP_CONCAT`) reconstruye exactamente el CSV original: los prestamos 1 y 3 de "Bases de Datos I" vuelven a mostrar `A. Torres|M. Ruiz` como autores y `SQL|Academico` como generos, sin haber duplicado esa informacion en las tablas puente.
- Libro mas prestado (consulta 8): `Bases de Datos I` con 3 prestamos.
- Los 2 casos comentados al final de `dml/inserts.sql` fallan al descomentarlos y ejecutarlos: uno por `UNIQUE (libros.titulo)` y otro por `CHECK` de formato de fecha.

## Como ejecutar

```bash
sqlite3 ejercicio-37.db < ddl/schema.sql
sqlite3 ejercicio-37.db < dml/inserts.sql
sqlite3 ejercicio-37.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
