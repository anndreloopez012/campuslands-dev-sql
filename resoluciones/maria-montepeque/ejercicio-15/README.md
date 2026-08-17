# Ejercicio 15: Taller de Motos

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-06

## Descripcion del problema

Un taller mecanico necesita reemplazar el registro manual de clientes, motos, servicios y ordenes de trabajo por una base de datos relacional que evite duplicidad de datos y permita controlar el estado y costo de cada servicio realizado.

## Tablas y relaciones

- `clientes`: catalogo de clientes del taller (nombre, telefono, correo).
- `motos`: moto que pertenece a un cliente (placa, marca, anio). `clientes` 1—N `motos`.
- `servicios`: catalogo de servicios que ofrece el taller (nombre, precio).
- `ordenes_servicio`: orden de trabajo aplicada a una moto para un servicio especifico (fecha, estado, costo). `motos` 1—N `ordenes_servicio` y `servicios` 1—N `ordenes_servicio`.

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 4 tablas.
- `FOREIGN KEY`: `motos.id_cliente`, `ordenes_servicio.id_moto`, `ordenes_servicio.id_servicio`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `clientes.telefono`, `clientes.correo`, `motos.placa`, `servicios.nombre`.
- `CHECK`: `motos.anio >= 1980`, `servicios.precio > 0`, `ordenes_servicio.costo > 0`, `ordenes_servicio.estado IN ('pendiente', 'en_proceso', 'completado', 'cancelado')`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3` disponible en el entorno:

- Datos base: 5 clientes, 5 motos, 5 servicios, 10 ordenes de servicio.
- Tras aplicar `operaciones.sql`: 6 clientes, 5 motos, 5 servicios y 9 ordenes de servicio (2 insertadas, 2 eliminadas).
- Las 2 operaciones comentadas en `dml/operaciones.sql` fallan al descomentarlas y ejecutarlas: una por `UNIQUE (motos.placa)` y otra por `CHECK (ordenes_servicio.costo > 0)`.
- Consulta de decision de negocio (servicio que genera mas ingresos totales): `Revision general` con 600.00.

## Como ejecutar

```bash
sqlite3 ejercicio-15.db < ddl/schema.sql
sqlite3 ejercicio-15.db < dml/inserts.sql
sqlite3 ejercicio-15.db < dml/operaciones.sql
sqlite3 ejercicio-15.db < dql/consultas.sql
```
