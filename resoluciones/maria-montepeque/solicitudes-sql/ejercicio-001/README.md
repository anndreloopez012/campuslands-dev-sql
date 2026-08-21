# Ejercicio 001: Solicitud de cliente - Cafeteria Campus

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Una cafeteria cerca del campus maneja productos, ventas rapidas y pagos de estudiantes en hojas de calculo, y varias personas terminan duplicando datos sin darse cuenta. El cliente pidio una base de datos que permita consultar informacion real, corregir estados de una venta, registrar movimientos y sacar reportes utiles.

## Tablas y relaciones

- `productos`: catalogo de lo que vende la cafeteria (nombre unico, precio, categoria, stock).
- `ventas`: registro transaccional de cada venta rapida a un estudiante (`productos` 1—N `ventas`).

No se creo una tabla `clientes` separada: el alcance tecnico de este nivel pide 1 a 2 tablas, y el nombre del estudiante se guarda como dato dentro de `ventas` (documentado como supuesto en `analisis/requerimiento.md`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en ambas tablas.
- `FOREIGN KEY`: `ventas.id_producto` -> `productos.id_producto`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `productos.nombre_producto` (evita el problema de duplicados que menciona el cliente).
- `CHECK`: `precio > 0`, `stock >= 0`, `categoria IN (...)`, `cantidad > 0`, `precio_pagado > 0`, `estado IN (...)`.
- `DEFAULT`: `stock` en 0, `fecha_venta` con la fecha/hora actual, `estado` en `'pagada'`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 6 productos y 8 ventas base (una de ellas, la venta 8, es una duplicada intencional de la venta 2 para reproducir el problema del cliente).
- `operaciones.sql` corrige el pago pendiente de Karen Solis, reabastece el stock de Cafe americano y elimina la venta duplicada: quedan 7 ventas.
- El caso comentado (`categoria = 'liquido'`) falla al ejecutarlo: `CHECK constraint failed: categoria IN ('bebida', 'comida', 'snack')`.
- Reporte de decision de negocio (ingresos por producto, solo ventas pagadas): Galletas artesanales genera el mayor ingreso en este corte (27.0), aunque Cafe americano es el producto con mas ventas pagadas (2).
- Cliente con mas actividad: Ana Gomez, con 3 compras pagadas.

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-001.db < ddl/schema.sql
sqlite3 ejercicio-001.db < dml/inserts.sql
sqlite3 ejercicio-001.db < dml/operaciones.sql
sqlite3 ejercicio-001.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
