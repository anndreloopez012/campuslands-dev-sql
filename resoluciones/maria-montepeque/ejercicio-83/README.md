# Ejercicio 83: WHERE Nivel Basico

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Tema central

WHERE

## Descripcion del problema

Una cafeteria necesita filtrar sus ventas de distintas formas: por
nombre de producto, por rango de precio, por fecha y combinando varias
condiciones a la vez, para poder responder preguntas puntuales sin
revisar todos los registros a mano.

## Tablas y relaciones

- `clientes`: catalogo de clientes.
- `productos`: catalogo de productos, con precio y categoria.
- `ventas`: relaciona un cliente con un producto en una fecha.
  `clientes` 1—N `ventas`; `productos` 1—N `ventas`.

## Uso de WHERE

En `dql/consultas.sql`:

1. Filtro por texto: `WHERE nombre_producto LIKE 'Ca%'` encuentra los
   productos cuyo nombre empieza con "Ca" (Cafe Americano,
   Cappuccino), usando el comodin `%`.
2. Filtro por numero: `WHERE precio BETWEEN 12 AND 18` selecciona
   productos de rango de precio medio.
3. Filtro por fecha simulada: `WHERE fecha_venta >= '2026-08-02'`
   compara fechas guardadas como texto en formato ISO, que ordenan
   igual que fechas reales.
4. Operadores logicos combinados: la consulta 5 junta `BETWEEN`,
   comparacion de fecha e `IN` con `AND`, de forma que una fila solo
   aparece si cumple las tres condiciones a la vez.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `ventas.id_cliente`, `ventas.id_producto`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `clientes.telefono`, `productos.nombre_producto`.
- `CHECK`: `productos.precio >= 0`, `productos.categoria IN (...)`,
  `ventas.cantidad > 0`.
- `DEFAULT` en `ventas.fecha_venta`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dql/consultas.sql`)

`SELECT * FROM productos WHERE preci > 15;` falla porque `preci` no
es el nombre real de la columna (falta la "o" de `precio`). Se valido
con Python (`sqlite3`): lanza `no such column: preci`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos finales: 3 clientes, 5 productos, 6 ventas. El filtro
  combinado de la consulta 5 deja una sola venta que cumple las tres
  condiciones a la vez.

## Como ejecutar

```bash
sqlite3 ejercicio-83.db < ddl/schema.sql
sqlite3 ejercicio-83.db < dml/inserts.sql
sqlite3 ejercicio-83.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
