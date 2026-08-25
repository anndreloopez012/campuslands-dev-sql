# Ejercicio 61: DEFAULT Nivel Aplicado

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-21

## Descripcion del problema

Una cafeteria necesita administrar sus ventas diarias (clientes, productos y
ventas) reduciendo la captura manual de datos repetitivos: tipo de cliente,
categoria de producto, disponibilidad, cantidad, fecha de venta y estado de
la venta. El objetivo es usar `DEFAULT` para que estos valores se completen
automaticamente cuando no se indiquen explicitamente, sin dejar de aplicar
las restricciones normales (`PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`,
`UNIQUE`, `CHECK`).

## Tablas y relaciones

- `clientes`: catalogo de clientes (nombre, correo, tipo de cliente, fecha
  de registro).
- `productos`: catalogo de productos de la cafeteria (nombre, categoria,
  precio, disponibilidad).
- `ventas`: venta de un producto a un cliente (cantidad, fecha, estado).
  `clientes` 1—N `ventas`; `productos` 1—N `ventas`.

## Uso de DEFAULT

- `clientes.tipo_cliente DEFAULT 'regular'`: todo cliente nuevo entra como
  regular si no se especifica otro tipo.
- `clientes.fecha_registro DEFAULT (date('now'))`: se registra la fecha del
  dia automaticamente.
- `productos.categoria DEFAULT 'bebida'`: la mayoria de productos nuevos de
  la cafeteria son bebidas.
- `productos.disponible DEFAULT 1`: un producto nuevo entra disponible
  salvo que se indique lo contrario.
- `ventas.cantidad DEFAULT 1`: la mayoria de ventas de mostrador son de una
  unidad.
- `ventas.fecha_venta DEFAULT (datetime('now'))`: se registra el momento
  exacto de la venta si no se indica otro.
- `ventas.estado DEFAULT 'pendiente'`: toda venta nueva inicia pendiente
  hasta que se cobre.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `ventas.id_cliente`, `ventas.id_producto`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `clientes.correo`, `productos.nombre`.
- `CHECK`: `clientes.tipo_cliente IN (...)`, `productos.categoria IN (...)`,
  `productos.precio > 0`, `productos.disponible IN (0,1)`,
  `ventas.cantidad > 0`, `ventas.estado IN (...)`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla (comentado en `dml/inserts.sql`)

`INSERT INTO ventas (id_cliente, id_producto, cantidad) VALUES (1, 1, 0);`
falla por `CHECK (cantidad > 0)`, incluso dejando que `estado` tome su
valor por defecto `'pendiente'`. Se valido ejecutandolo con Python
(`sqlite3`): lanza `IntegrityError: CHECK constraint failed: cantidad > 0`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con Python
(modulo `sqlite3`), ya que no se tenia el binario `sqlite3` disponible en
el entorno:

- Datos base: 5 clientes, 5 productos, 8 ventas.
- 3 ventas y 3 productos/clientes quedaron con al menos un valor tomado de
  `DEFAULT` (ver consulta 5 en `dql/consultas.sql`).
- Consulta de decision de negocio (ingresos por producto, solo ventas
  pagadas): "Pastel de Chocolate" es el de mayor ingreso con 22.00.

Detalle completo en [`evidencias/resultados.md`](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-61.db < ddl/schema.sql
sqlite3 ejercicio-61.db < dml/inserts.sql
sqlite3 ejercicio-61.db < dql/consultas.sql
```
