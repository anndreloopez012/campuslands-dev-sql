# Ejercicio 004: Solicitud de cliente - Tienda Sneakers

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Una tienda de ropa urbana vende sneakers en distintas tallas y necesita, al final de cada semana, un reporte rapido que le ayude a tomar decisiones. Tambien pidio poder consultar datos, corregir estados de un pedido y registrar movimientos.

## Tablas y relaciones

- `productos`: catalogo de sneakers (modelo + talla, con su propio precio y stock).
- `pedidos`: registro transaccional de cada venta a un cliente (`productos` 1—N `pedidos`).

No se creo una tabla `clientes` separada: el alcance de este nivel pide 1 a 2 tablas, asi que el nombre del cliente se guarda dentro de `pedidos` (documentado como supuesto en `analisis/requerimiento.md`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en ambas tablas.
- `FOREIGN KEY`: `pedidos.id_producto` -> `productos.id_producto`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `(nombre_modelo, talla)` en `productos` (cada modelo+talla es un producto distinto, sin duplicados).
- `CHECK`: `talla BETWEEN 20 AND 46`, `precio > 0`, `stock >= 0`, `cantidad > 0`, `precio_total > 0`, `estado IN (...)`.
- `DEFAULT`: `stock` en 0, `fecha_pedido` con la fecha/hora actual, `estado` en `'pendiente'`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 6 productos (3 modelos en distintas tallas) y 9 pedidos base en una semana de prueba (2026-08-10 a 2026-08-16), uno de ellos (pedido 8) duplicado por error.
- `operaciones.sql` marca como entregado un pedido que estaba enviado, reabastece el modelo con menos stock y elimina el pedido duplicado: quedan 8 pedidos.
- El caso comentado (`talla = 60`) falla al ejecutarlo: `CHECK constraint failed: talla BETWEEN 20 AND 46`.
- Reporte semanal (ingresos por dia, solo pedidos entregados): el 2026-08-11 fue el dia de mas ingresos (1200.0, con 2 pedidos).
- Cliente con mas actividad: Luis Marroquin, con 3 pedidos en la semana.

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-004.db < ddl/schema.sql
sqlite3 ejercicio-004.db < dml/inserts.sql
sqlite3 ejercicio-004.db < dml/operaciones.sql
sqlite3 ejercicio-004.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
