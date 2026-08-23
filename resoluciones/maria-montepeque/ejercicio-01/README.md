# Ejercicio 01: CineMax SQLite

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-04

## Descripcion del problema

CineMax necesita reemplazar el registro manual de peliculas, salas, funciones y boletos por una base de datos relacional que evite duplicidad, controle la disponibilidad de asientos y permita generar reportes de ventas.

## Tablas y relaciones

- `peliculas`: catalogo de peliculas (titulo, genero, duracion, clasificacion).
- `salas`: catalogo de salas (nombre, capacidad).
- `funciones`: una pelicula programada en una sala a una fecha/hora (`peliculas` 1—N `funciones`, `salas` 1—N `funciones`).
- `boletos`: venta de un asiento para una funcion (`funciones` 1—N `boletos`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 4 tablas.
- `FOREIGN KEY`: `funciones.id_pelicula`, `funciones.id_sala`, `boletos.id_funcion`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `salas.nombre`, `(id_sala, fecha_hora)` en `funciones`, `(id_funcion, asiento)` en `boletos`.
- `CHECK`: `duracion_min > 0`, `capacidad > 0`, `precio_base > 0`, `precio_pagado > 0`, `estado IN (...)`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con SQLite:

- 6 peliculas, 5 salas, 6 funciones y 9 boletos tras aplicar `operaciones.sql`.
- Las 2 operaciones comentadas en `dml/operaciones.sql` fallan al ejecutarlas: una por `UNIQUE (id_funcion, asiento)` y otra por `CHECK (precio_pagado > 0)`.
- Consulta de decision de negocio (pelicula con mas boletos pagados): `El viaje del tiempo` con 4 boletos.

## Como ejecutar

```bash
sqlite3 ejercicio-01.db < ddl/schema.sql
sqlite3 ejercicio-01.db < dml/inserts.sql
sqlite3 ejercicio-01.db < dml/operaciones.sql
sqlite3 ejercicio-01.db < dql/consultas.sql
```
