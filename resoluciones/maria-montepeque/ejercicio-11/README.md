# Ejercicio 11: Transporte Rutas

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-04

## Descripcion del problema

La empresa de transporte necesita reemplazar el registro manual de rutas, buses, conductores y viajes por una base de datos relacional que evite duplicidad y permita controlar la capacidad y programacion de cada viaje.

## Tablas y relaciones

- `rutas`: catalogo de rutas (origen, destino, distancia).
- `buses`: catalogo de buses (placa, capacidad).
- `conductores`: catalogo de conductores (nombre, licencia).
- `viajes`: viaje programado de un bus y conductor sobre una ruta (`rutas` 1—N `viajes`, `buses` 1—N `viajes`, `conductores` 1—N `viajes`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 4 tablas.
- `FOREIGN KEY`: `viajes.id_ruta`, `viajes.id_bus`, `viajes.id_conductor`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `(origen, destino)` en `rutas`, `buses.placa`, `conductores.licencia`, `(id_bus, fecha_hora)` en `viajes` (evita que un bus tenga dos viajes a la misma hora).
- `CHECK`: `rutas.distancia_km > 0`, `buses.capacidad > 0`, `viajes.pasajeros >= 0`, `viajes.estado IN (...)`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con SQLite:

- 5 rutas, 5 buses, 6 conductores y 9 viajes tras aplicar `operaciones.sql`.
- Las 2 operaciones comentadas en `dml/operaciones.sql` fallan al ejecutarlas: una por `UNIQUE (id_bus, fecha_hora)` y otra por `CHECK (pasajeros >= 0)`.
- Consulta de decision de negocio (ruta con mas pasajeros transportados): `Ciudad Central -> Montana Este` con 81 pasajeros.

## Como ejecutar

```bash
sqlite3 ejercicio-11.db < ddl/schema.sql
sqlite3 ejercicio-11.db < dml/inserts.sql
sqlite3 ejercicio-11.db < dml/operaciones.sql
sqlite3 ejercicio-11.db < dql/consultas.sql
```
