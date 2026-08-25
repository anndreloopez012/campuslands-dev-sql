# Ejercicio 81: SELECT Nivel Intermedio

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Tema central

SELECT

## Descripcion del problema

Una cafeteria necesita responder preguntas mas elaboradas que "mostrar
todo": que productos estan por encima del precio promedio, o cuantos
clientes distintos compraron en un periodo, sin depender de calculos
manuales fuera de la base de datos.

## Tablas y relaciones

- `clientes`: catalogo de clientes.
- `productos`: catalogo de productos, con su precio.
- `ventas`: relaciona un cliente con un producto en una fecha.
  `clientes` 1—N `ventas`; `productos` 1—N `ventas`.

## Uso de SELECT

En `dql/consultas.sql`:

1. `JOIN` con alias y una expresion calculada (`subtotal`), igual que
   en el nivel basico, pero ahora combinando tres columnas de dos
   tablas distintas.
2. Subconsulta: `WHERE precio > (SELECT AVG(precio) FROM productos)`
   calcula el precio promedio del catalogo una sola vez y lo usa para
   filtrar los productos caros, sin tener que calcular el promedio a
   mano fuera de SQL.
3. `COUNT(DISTINCT id_cliente)`: cuenta cuantos clientes unicos
   compraron algo, sin que un cliente que compro varias veces se
   cuente varias veces.
4. `WHERE`, `ORDER BY` y `GROUP BY` con `SUM`, para filtrar, ordenar y
   resumir.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `ventas.id_cliente`, `ventas.id_producto`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `clientes.telefono`, `productos.nombre_producto`.
- `CHECK`: `productos.precio >= 0`, `ventas.cantidad > 0`.
- `DEFAULT` en `ventas.fecha_venta`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dql/consultas.sql`)

`SELECT id_producto FROM productos, ventas;` falla porque tanto
`productos` como `ventas` tienen una columna `id_producto`, y sin
calificarla con el alias de la tabla (`p.id_producto` o
`v.id_producto`), SQLite no sabe cual de las dos usar. Se valido con
Python (`sqlite3`): lanza `ambiguous column name: id_producto`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos finales: 3 clientes, 4 productos, 5 ventas. Cappuccino y
  Croissant son los unicos productos por encima del precio promedio
  (16.25); 3 clientes distintos compraron algo.

## Como ejecutar

```bash
sqlite3 ejercicio-81.db < ddl/schema.sql
sqlite3 ejercicio-81.db < dml/inserts.sql
sqlite3 ejercicio-81.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
