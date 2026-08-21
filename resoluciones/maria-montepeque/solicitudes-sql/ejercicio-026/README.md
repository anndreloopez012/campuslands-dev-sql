# Ejercicio 026: Solicitud de cliente - Cafeteria Campus

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Una cafeteria cerca del campus quiere controlar productos, ventas rapidas y pagos de estudiantes, diferenciando catalogos de movimientos. A diferencia de una version mas basica de este mismo caso, aqui se pide una relacion real (con `FOREIGN KEY` y `JOIN`) entre productos, clientes y ventas.

## Tablas y relaciones

- `clientes`: catalogo permanente de estudiantes (nombre unico, carne estudiantil unico).
- `productos`: catalogo permanente de lo que vende la cafeteria (nombre unico, categoria, precio).
- `ventas`: registro transaccional de cada venta (`clientes` 1—N `ventas`, `productos` 1—N `ventas`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las tres tablas.
- `FOREIGN KEY`: `ventas.id_producto` -> `productos.id_producto`, `ventas.id_cliente` -> `clientes.id_cliente`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `clientes.nombre_cliente`, `clientes.carne_estudiantil`, `productos.nombre_producto`.
- `CHECK`: `precio > 0`, `cantidad > 0`, `monto_total > 0`, `categoria IN (...)`, `estado IN ('pagada', 'pendiente', 'cancelada')`.
- `DEFAULT`: `fecha_venta` con la fecha/hora actual, `estado` en `'pagada'`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 5 clientes, 6 productos y 9 ventas base (una de ellas, la venta 9, es una duplicada por error de digitacion).
- `operaciones.sql` corrige un pago pendiente, ajusta el precio de un producto y elimina la venta duplicada: quedan 8 ventas.
- El caso comentado (categoria invalida) falla al ejecutarlo: `CHECK constraint failed: categoria IN (...)`.
- Cliente con mas actividad: Ana Gomez, con 3 compras pagadas.
- Producto que mas ingresos genera (sin canceladas): Sandwich de Pollo, con 50.0.

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-026.db < ddl/schema.sql
sqlite3 ejercicio-026.db < dml/inserts.sql
sqlite3 ejercicio-026.db < dml/operaciones.sql
sqlite3 ejercicio-026.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
