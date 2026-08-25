# Ejercicio 04: Restaurante Campus

**Camper:** Antonio Canux

## Descripcion del problema

El restaurante necesita reemplazar el registro manual de mesas, platos, pedidos y su detalle por una base de datos relacional que evite duplicidad y permita generar reportes de consumo por mesa y por plato.

## Tablas y relaciones

- `mesas`: catalogo de mesas (numero, capacidad).
- `platos`: catalogo de platos del menu (nombre, categoria, precio).
- `pedidos`: pedido abierto por una mesa (`mesas` 1—N `pedidos`).
- `detalle_pedido`: linea de un plato dentro de un pedido (`pedidos` 1—N `detalle_pedido`, `platos` 1—N `detalle_pedido`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 4 tablas.
- `FOREIGN KEY`: `pedidos.id_mesa`, `detalle_pedido.id_pedido`, `detalle_pedido.id_plato`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `mesas.numero`, `platos.nombre`, `(id_pedido, id_plato)` en `detalle_pedido`.
- `CHECK`: `mesas.capacidad > 0`, `platos.precio > 0`, `pedidos.estado IN (...)`, `detalle_pedido.cantidad > 0`, `detalle_pedido.precio_unitario > 0`.

## Como ejecutar

```bash
sqlite3 ejercicio-04.db < ddl/schema.sql
sqlite3 ejercicio-04.db < dml/inserts.sql
sqlite3 ejercicio-04.db < dml/operaciones.sql
sqlite3 ejercicio-04.db < dql/consultas.sql
```
