# Ejercicio 86: ORDER BY Nivel Basico

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Tema central

ORDER BY

## Descripcion del problema

Una biblioteca tecnica necesita mostrar sus libros y prestamos en
distintos ordenes: por cantidad de ejemplares, y agrupados por
categoria con un segundo criterio de desempate, sin tener que
ordenarlos manualmente fuera de la base de datos.

## Tablas y relaciones

- `autores`: catalogo de autores.
- `libros`: catalogo de libros, cada uno de un autor.
- `prestamos`: tabla principal, cada prestamo de un libro. `autores`
  1—N `libros`; `libros` 1—N `prestamos`.

## Uso de ORDER BY

En `dql/consultas.sql`:

1. Orden ascendente (por defecto): `ORDER BY ejemplares_totales`
   ordena los libros de menos a mas ejemplares sin necesitar `ASC`
   explicito.
2. Orden descendente y por varias columnas a la vez: la consulta 5
   usa `ORDER BY categoria ASC, ejemplares_totales DESC`. Primero
   agrupa los libros por categoria (alfabeticamente), y dentro de
   cada categoria los ordena de mas a menos ejemplares. El segundo
   criterio solo desempata dentro de los grupos que forma el primero.

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

`SELECT titulo, categoria FROM libros ORDER BY 5;` falla porque la
consulta solo devuelve 2 columnas, no 5. Se valido con Python
(`sqlite3`): lanza
`1st ORDER BY term out of range - should be between 1 and 2`. Ordenar
por posicion numerica es fragil: si el orden de las columnas del
`SELECT` cambia, el `ORDER BY` termina apuntando a otra columna sin
avisar; por eso es mejor ordenar siempre por nombre.

(Se probo primero ordenar `SELECT DISTINCT categoria ... ORDER BY
titulo`, una columna fuera del resultado, pero en SQLite esa
combinacion es valida a diferencia de otros motores, asi que no sirve
como caso que falla; se reemplazo por el de la posicion fuera de
rango.)

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-86.db < ddl/schema.sql
sqlite3 ejercicio-86.db < dml/inserts.sql
sqlite3 ejercicio-86.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
