# Ejercicio 28: Vistas y Reportes

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-06

## Descripcion del problema

Un sistema de ventas necesita reemplazar el registro manual de clientes, vendedores, ventas y pagos por una base de datos relacional que evite duplicidad de datos y que ademas facilite generar reportes de cobranza y desempeno de vendedores mediante vistas SQL.

## Tablas y relaciones

- `clientes`: catalogo de clientes que realizan compras (nombre, correo).
- `vendedores`: catalogo de vendedores (nombre, correo).
- `ventas`: venta realizada a un cliente por un vendedor (total, fecha). `clientes` 1—N `ventas` y `vendedores` 1—N `ventas`.
- `pagos`: abono realizado a una venta, permitiendo pagos parciales (monto, metodo, fecha). `ventas` 1—N `pagos`.

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 4 tablas.
- `FOREIGN KEY`: `ventas.id_cliente`, `ventas.id_vendedor`, `pagos.id_venta`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `clientes.correo`, `vendedores.correo`.
- `CHECK`: `ventas.total > 0`, `pagos.monto > 0`, `pagos.metodo IN ('efectivo', 'tarjeta', 'transferencia')`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Vistas creadas

- `vista_resumen_ventas`: por cada venta muestra cliente, vendedor, total facturado, total pagado (suma de `pagos`) y saldo pendiente (`total - total_pagado`). Usa `LEFT JOIN` con `pagos` para incluir ventas sin pagos registrados.
- `vista_ranking_vendedores`: agrupa las ventas por vendedor y muestra la cantidad de ventas y el total vendido, util para evaluar desempeno.

Estas vistas se usan directamente en `dql/consultas.sql`, incluyendo la consulta de decision de negocio (punto 12), que consulta `vista_resumen_ventas` para identificar el cliente con mayor saldo pendiente.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3` disponible en el entorno:

- Datos base: 5 clientes, 5 vendedores, 5 ventas, 10 pagos.
- Tras aplicar `operaciones.sql`: 6 clientes, 5 vendedores, 5 ventas y 9 pagos (2 insertados, 2 eliminados).
- Las 2 operaciones comentadas en `dml/operaciones.sql` fallan al descomentarlas y ejecutarlas: una por `UNIQUE (clientes.correo)` y otra por `CHECK (pagos.metodo IN (...))`.
- `vista_resumen_ventas` refleja correctamente los saldos pendientes tras las operaciones (por ejemplo, la venta de Cristina Barrios quedo con 250.00 de saldo pendiente tras actualizar su total a 1250.00).
- Consulta de decision de negocio (cliente con mayor saldo pendiente por pagar): `Cristina Barrios` con 250.00.

## Como ejecutar

```bash
sqlite3 ejercicio-28.db < ddl/schema.sql
sqlite3 ejercicio-28.db < dml/inserts.sql
sqlite3 ejercicio-28.db < dml/operaciones.sql
sqlite3 ejercicio-28.db < dql/consultas.sql
```
