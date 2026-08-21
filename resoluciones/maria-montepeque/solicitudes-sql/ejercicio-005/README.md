# Ejercicio 005: Solicitud de cliente - Cine Horror Nights

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Un cine organiza funciones de peliculas de terror, con salas y venta de boletos. El cliente describe su operacion diaria en lenguaje simple y espera que se traduzca a tablas: vender boletos por asiento, sin repetir un mismo asiento dos veces, y poder corregir estados.

## Tablas y relaciones

- `peliculas`: catalogo de peliculas en cartelera; en este nivel, cada pelicula representa una unica funcion programada (sala, genero, precio de boleto).
- `boletos`: registro transaccional de cada venta, por asiento (`peliculas` 1—N `boletos`).

No se creo una tabla `salas` separada: el alcance de este nivel pide 1 a 2 tablas, asi que la sala se guarda como dato dentro de `peliculas` (documentado como supuesto en `analisis/requerimiento.md`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en ambas tablas.
- `FOREIGN KEY`: `boletos.id_pelicula` -> `peliculas.id_pelicula`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `peliculas.titulo`, y `(id_pelicula, asiento)` en `boletos` (evita vender el mismo asiento dos veces para la misma funcion).
- `CHECK`: `precio_boleto > 0`, `precio_pagado > 0`, `genero IN (...)`, `estado IN ('vendido', 'usado', 'reembolsado')`.
- `DEFAULT`: `fecha_compra` con la fecha/hora actual, `estado` en `'vendido'`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 5 peliculas y 9 boletos base (uno de ellos, el boleto 9, es una entrada de prueba insertada por error).
- `operaciones.sql` marca un boleto como usado, aplica una promocion de precio y elimina la entrada de prueba: quedan 8 boletos.
- El caso comentado (vender el asiento A1 dos veces para la misma pelicula) falla al ejecutarlo: `UNIQUE constraint failed: boletos.id_pelicula, boletos.asiento`.
- Reporte de decision de negocio (ingresos por pelicula, sin reembolsos): `El Grito Final` y `Medianoche Sangrienta` empatan en 90.0 como las de mayor ingreso.
- Pelicula con mas boletos vendidos: `El Grito Final`, con 3.

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-005.db < ddl/schema.sql
sqlite3 ejercicio-005.db < dml/inserts.sql
sqlite3 ejercicio-005.db < dml/operaciones.sql
sqlite3 ejercicio-005.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
