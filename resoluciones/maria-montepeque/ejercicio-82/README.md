# Ejercicio 82: SELECT Nivel Aplicado

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Tema central

SELECT

## Descripcion del problema

Una biblioteca tecnica presta libros y necesita saber, en cualquier
momento, cuantos ejemplares de cada libro siguen disponibles: un caso
de negocio con reporte final, propio del nivel aplicado, que combina
varias tecnicas de `SELECT` en una sola consulta.

## Tablas y relaciones

- `autores`: catalogo de autores.
- `libros`: catalogo de libros, cada uno de un autor, con su cantidad
  de ejemplares totales.
- `prestamos`: tabla principal, cada prestamo de un libro.
  `fecha_devolucion` queda en `NULL` mientras el prestamo sigue
  activo. `autores` 1—N `libros`; `libros` 1—N `prestamos`.

## Uso de SELECT

En `dql/consultas.sql`, la consulta 5 es el reporte final del caso de
negocio:

1. Subconsulta correlacionada: por cada libro, cuenta cuantos
   prestamos activos tiene (`WHERE p.id_libro = l.id_libro AND
   p.fecha_devolucion IS NULL`). A diferencia de la subconsulta del
   nivel intermedio (que se calculaba una sola vez), esta se vuelve a
   evaluar por cada fila de `libros`.
2. Expresion calculada: `ejemplares_totales` menos esa subconsulta da
   los ejemplares disponibles reales.
3. `CASE WHEN`: traduce el numero de disponibles en un estado legible
   (`'disponible'` o `'agotado'`), sin que el usuario tenga que
   interpretar un numero.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `libros.id_autor`, `prestamos.id_libro`.
- `NOT NULL` en todas las columnas obligatorias (excepto
  `fecha_devolucion`, que es `NULL` a proposito mientras el prestamo
  sigue activo).
- `UNIQUE`: `autores.nombre_autor`.
- `CHECK`: `libros.ejemplares_totales > 0`.
- `DEFAULT` en `prestamos.fecha_prestamo`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dql/consultas.sql`)

`SELECT COUN(*) FROM libros;` falla porque `COUN` no es una funcion
valida (el nombre correcto es `COUNT`). Se valido con Python
(`sqlite3`): lanza `no such function: COUN`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos finales: 3 autores, 5 libros, 7 prestamos (2 devueltos, 5
  activos). Reporte final: Clean Architecture y The Art of Computer
  Programming quedan `agotado`; los otros 3 libros quedan
  `disponible`.

## Como ejecutar

```bash
sqlite3 ejercicio-82.db < ddl/schema.sql
sqlite3 ejercicio-82.db < dml/inserts.sql
sqlite3 ejercicio-82.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
