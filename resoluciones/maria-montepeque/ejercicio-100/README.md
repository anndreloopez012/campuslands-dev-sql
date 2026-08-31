# Ejercicio 100: Vistas Nivel Aplicado

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-31

## Tema central

Vistas

## Descripcion del problema

Una biblioteca tecnica necesita un reporte final que muestre, para
cada libro, cuantas copias quedan disponibles ahora mismo (stock total
menos los prestamos que siguen activos), y que permita identificar de
inmediato los libros agotados.

## Tablas y relaciones

- `autores`: catalogo de autores.
- `libros`: catalogo de libros, cada uno con su `stock_total` y su
  autor.
- `prestamos`: tabla principal, cada fila es el prestamo de un libro,
  con su `estado` (`prestado` o `devuelto`). `autores` 1—N `libros`;
  `libros` 1—N `prestamos`.

## Uso de Vistas

En `ddl/schema.sql` se define `vista_disponibilidad_libros`, que
combina `libros` con `autores` (`JOIN`) y con `prestamos`
(`LEFT JOIN`, para no perder los libros sin ningun prestamo), agrupa
por libro y calcula `prestamos_activos` (con `COUNT(CASE WHEN estado =
'prestado' THEN 1 END)`) y `copias_disponibles` (`stock_total -
prestamos_activos`). En `dql/consultas.sql`:

- La consulta 1 muestra el reporte completo directamente desde la
  vista.
- La consulta 5 es el reporte de negocio final: filtra la vista con
  `WHERE copias_disponibles <= 0` para obtener solo los libros
  agotados ("Clean Code" y "Design Patterns"), sin repetir el `JOIN`
  ni el conteo de prestamos activos.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `libros.id_autor`, `prestamos.id_libro`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `autores.nombre_autor`.
- `CHECK`: `libros.stock_total > 0`,
  `prestamos.estado IN ('prestado', 'devuelto')`.
- `DEFAULT` en `prestamos.estado`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dql/consultas.sql`)

Intentar "actualizar" la definicion de `vista_disponibilidad_libros`
usando `CREATE VIEW IF NOT EXISTS` con una logica distinta (un umbral
de stock en vez del calculo completo). Como la vista ya existe,
SQLite no lanza ningun error, pero tampoco reemplaza su definicion: la
ignora en silencio. Se verifico con Python (`sqlite3`) que, despues de
ejecutar esa sentencia, `vista_disponibilidad_libros` conserva
exactamente sus columnas originales (`prestamos_activos`,
`copias_disponibles`, etc.), no las de la nueva definicion. SQLite no
tiene `CREATE OR REPLACE VIEW`; la forma correcta de cambiar una vista
existente es `DROP VIEW vista_disponibilidad_libros;` seguido de un
`CREATE VIEW` nuevo.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-100.db < ddl/schema.sql
sqlite3 ejercicio-100.db < dml/inserts.sql
sqlite3 ejercicio-100.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
