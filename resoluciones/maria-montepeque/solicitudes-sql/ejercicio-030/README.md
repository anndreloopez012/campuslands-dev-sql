# Ejercicio 030: Solicitud de cliente - Cine Horror Nights

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Un cine organiza funciones de peliculas de terror, con salas y venta de boletos. El cliente pidio explicitamente poder detectar errores: registros repetidos, relaciones invalidas o valores fuera de rango.

## Tablas y relaciones

- `peliculas`: catalogo de peliculas (titulo unico, duracion).
- `salas`: catalogo de salas del cine (nombre unico, capacidad).
- `funciones`: registro transaccional de cada funcion programada (`peliculas` 1—N `funciones`, `salas` 1—N `funciones`).

No se creo una tabla `boletos` en este nivel: el alcance de este ejercicio pide 2 a 3 tablas con relaciones uno a muchos, y el foco esta en peliculas/salas/funciones (documentado como supuesto en `analisis/requerimiento.md`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las tres tablas.
- `FOREIGN KEY`: `funciones.id_pelicula` -> `peliculas.id_pelicula`, `funciones.id_sala` -> `salas.id_sala` (evita relaciones invalidas).
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `peliculas.titulo`, `salas.nombre_sala`, y `(id_sala, fecha_hora)` en `funciones` (evita registros repetidos: doble reserva de una sala).
- `CHECK`: `duracion_min BETWEEN 60 AND 240` (detecta valores fuera de rango), `capacidad > 0`, `precio_boleto > 0`, `estado IN ('programada', 'en_curso', 'finalizada', 'cancelada')`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 5 peliculas, 4 salas y 9 funciones base (una de ellas, la funcion 9, es una entrada de prueba insertada por error).
- `operaciones.sql` marca una funcion como finalizada, corrige la duracion de una pelicula y elimina la funcion de prueba: quedan 8 funciones.
- Los dos casos comentados fallan al ejecutarlos: doble reserva de sala (`UNIQUE constraint failed: funciones.id_sala, funciones.fecha_hora`) y duracion fuera de rango (`CHECK constraint failed: duracion_min BETWEEN 60 AND 240`).
- Ingreso potencial por sala (sin canceladas): Sala 1 lidera con 130.0.

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-030.db < ddl/schema.sql
sqlite3 ejercicio-030.db < dml/inserts.sql
sqlite3 ejercicio-030.db < dml/operaciones.sql
sqlite3 ejercicio-030.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
