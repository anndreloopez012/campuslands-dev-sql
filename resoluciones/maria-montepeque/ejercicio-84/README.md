# Ejercicio 84: WHERE Nivel Intermedio

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Tema central

WHERE

## Descripcion del problema

Una biblioteca tecnica necesita filtros mas elaborados que "mostrar
todo": libros que no son de cierta categoria, prestamos activos
distinguidos de los devueltos, y prestamos de libros que pertenecen a
una categoria especifica, todo combinando varias condiciones a la vez.

## Tablas y relaciones

- `autores`: catalogo de autores.
- `libros`: catalogo de libros, cada uno de un autor.
- `prestamos`: tabla principal. `fecha_devolucion` queda en `NULL`
  mientras el prestamo sigue activo. `autores` 1—N `libros`; `libros`
  1—N `prestamos`.

## Uso de WHERE

En `dql/consultas.sql`:

1. Negacion y agrupacion: `WHERE categoria <> 'Arquitectura' AND
   (ejemplares_totales > 1 OR categoria = 'Algoritmos')` usa
   parentesis para controlar el orden en que se evaluan `AND` y `OR`.
2. `IS NULL` / `IS NOT NULL`: distingue prestamos activos de
   devueltos, contando cada grupo con subconsultas independientes.
3. Subconsulta dentro de `WHERE ... IN (...)`: primero filtra los
   libros de categoria "Arquitectura", y despues usa esa lista de ids
   para filtrar los prestamos activos de esos libros especificos. A
   diferencia del nivel basico, aqui la condicion de `WHERE` depende
   del resultado de otra consulta completa.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `libros.id_autor`, `prestamos.id_libro`.
- `NOT NULL` en todas las columnas obligatorias (excepto
  `fecha_devolucion`, `NULL` a proposito mientras el prestamo sigue
  activo).
- `UNIQUE`: `autores.nombre_autor`.
- `CHECK`: `libros.ejemplares_totales > 0`.
- `DEFAULT` en `prestamos.fecha_prestamo`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dql/consultas.sql`)

`SELECT * FROM libros WHERE (categoria = 'Arquitectura' AND
ejemplares_totales > 1;` falla porque el parentesis que abre antes de
`categoria` nunca se cierra. Se valido con Python (`sqlite3`): lanza
`near ";": syntax error`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos finales: 3 autores, 5 libros, 7 prestamos (5 activos, 2
  devueltos). 3 prestamos activos corresponden a libros de
  Arquitectura.

## Como ejecutar

```bash
sqlite3 ejercicio-84.db < ddl/schema.sql
sqlite3 ejercicio-84.db < dml/inserts.sql
sqlite3 ejercicio-84.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
