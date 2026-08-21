# Ejercicio 22: Pedidos Delivery

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-06

## Descripcion del problema

Un servicio de delivery necesita reemplazar el registro manual de clientes, restaurantes, repartidores y pedidos por una base de datos relacional que evite duplicidad de datos y permita dar seguimiento al estado y monto de cada pedido.

## Tablas y relaciones

- `clientes`: catalogo de clientes que realizan pedidos (nombre, telefono, direccion).
- `restaurantes`: catalogo de restaurantes afiliados (nombre, categoria).
- `repartidores`: catalogo de repartidores disponibles (nombre, telefono, vehiculo).
- `pedidos`: pedido realizado por un cliente a un restaurante y asignado a un repartidor (total, estado, fecha). `clientes` 1—N `pedidos`, `restaurantes` 1—N `pedidos` y `repartidores` 1—N `pedidos`.

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 4 tablas.
- `FOREIGN KEY`: `pedidos.id_cliente`, `pedidos.id_restaurante`, `pedidos.id_repartidor`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `clientes.telefono`, `restaurantes.nombre`, `repartidores.telefono`.
- `CHECK`: `repartidores.vehiculo IN ('moto', 'bicicleta', 'carro')`, `pedidos.total > 0`, `pedidos.estado IN ('pendiente', 'en_camino', 'entregado', 'cancelado')`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3` disponible en el entorno:

- Datos base: 5 clientes, 5 restaurantes, 5 repartidores, 10 pedidos.
- Tras aplicar `operaciones.sql`: 6 clientes, 5 restaurantes, 5 repartidores y 9 pedidos (2 insertados, 2 eliminados).
- Las 2 operaciones comentadas en `dml/operaciones.sql` fallan al descomentarlas y ejecutarlas: una por `UNIQUE (clientes.telefono)` y otra por `CHECK (pedidos.total > 0)`.
- Consulta de decision de negocio (restaurante con mayores ingresos por pedidos entregados): `Sushi Kanji` con 325.00.

## Como ejecutar

```bash
sqlite3 ejercicio-22.db < ddl/schema.sql
sqlite3 ejercicio-22.db < dml/inserts.sql
sqlite3 ejercicio-22.db < dml/operaciones.sql
sqlite3 ejercicio-22.db < dql/consultas.sql
```
