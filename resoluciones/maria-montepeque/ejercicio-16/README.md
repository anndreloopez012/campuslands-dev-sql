# Ejercicio 16: Aerolinea Vuelos

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-06

## Descripcion del problema

Una aerolinea necesita reemplazar el registro manual de aeropuertos, aviones, vuelos y reservas por una base de datos relacional que evite duplicidad de datos y permita controlar la ocupacion y los ingresos de cada vuelo.

## Tablas y relaciones

- `aeropuertos`: catalogo de aeropuertos (codigo IATA, nombre, ciudad).
- `aviones`: catalogo de aviones de la flota (matricula, modelo, capacidad).
- `vuelos`: vuelo operado por un avion entre dos aeropuertos (fecha de salida, precio base). `aviones` 1—N `vuelos`; `aeropuertos` 1—N `vuelos` (origen y destino).
- `reservas`: reserva de un pasajero en un vuelo (asiento, precio pagado, estado). `vuelos` 1—N `reservas`.

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 4 tablas.
- `FOREIGN KEY`: `vuelos.id_avion`, `vuelos.id_aeropuerto_origen`, `vuelos.id_aeropuerto_destino`, `reservas.id_vuelo`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `aeropuertos.codigo`, `aviones.matricula` y `reservas (id_vuelo, asiento)` para evitar doble reserva del mismo asiento en un vuelo.
- `CHECK`: `aviones.capacidad > 0`, `vuelos.precio_base > 0`, `vuelos.id_aeropuerto_origen <> id_aeropuerto_destino`, `reservas.precio_pagado > 0`, `reservas.estado IN ('confirmada', 'pendiente', 'cancelada')`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3` disponible en el entorno:

- Datos base: 5 aeropuertos, 5 aviones, 5 vuelos, 10 reservas.
- Tras aplicar `operaciones.sql`: 6 aeropuertos, 5 aviones, 5 vuelos y 9 reservas (2 insertadas, 2 eliminadas).
- Las 2 operaciones comentadas en `dml/operaciones.sql` fallan al descomentarlas y ejecutarlas: una por `UNIQUE (reservas.id_vuelo, asiento)` y otra por `CHECK (vuelos.id_aeropuerto_origen <> id_aeropuerto_destino)`.
- Consulta de decision de negocio (vuelo con mayores ingresos por reservas confirmadas): vuelo `GUA -> MIA` con 820.00.

## Como ejecutar

```bash
sqlite3 ejercicio-16.db < ddl/schema.sql
sqlite3 ejercicio-16.db < dml/inserts.sql
sqlite3 ejercicio-16.db < dml/operaciones.sql
sqlite3 ejercicio-16.db < dql/consultas.sql
```
