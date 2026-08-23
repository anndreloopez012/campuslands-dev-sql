# Ejercicio 36: Normalizacion Hotel Reservas

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-17

## Descripcion del problema

El hotel administraba sus reservas en un archivo plano (`datos/datos-sin-normalizar.csv`) con una sola tabla donde `servicios`, `costos_servicios` y `fechas` guardaban varios valores separados por `|` en una misma celda, y los datos de huesped y habitacion se repetian cada vez. Esto generaba duplicidad, anomalias de insercion/actualizacion/eliminacion y dificultaba los reportes. El detalle completo del analisis (dependencias funcionales, problemas y el proceso de normalizacion 1FN -> 2FN -> 3FN) esta en [`analisis/normalizacion.md`](analisis/normalizacion.md).

## Tablas y relaciones

- `huespedes`: catalogo de huespedes (nombre, documento unico).
- `habitaciones`: catalogo de habitaciones del hotel.
- `servicios`: catalogo de servicios con su costo estandar.
- `reservas`: encabezado de una reserva (que huesped ocupa que habitacion). `huespedes` 1—N `reservas` y `habitaciones` 1—N `reservas`.
- `detalle_servicio`: detalle de cada servicio consumido dentro de una reserva, con su fecha y costo. `reservas` 1—N `detalle_servicio` y `servicios` 1—N `detalle_servicio`.

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 5 tablas.
- `FOREIGN KEY`: `reservas.id_huesped`, `reservas.id_habitacion`, `detalle_servicio.id_reserva`, `detalle_servicio.id_servicio`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `huespedes.documento`, `habitaciones.numero`, `servicios.nombre`, `(id_reserva, id_servicio, fecha)` en `detalle_servicio` (evita repetir el mismo servicio el mismo dia en una reserva).
- `CHECK`: `servicios.costo > 0`, `detalle_servicio.fecha` con formato `YYYY-MM-DD`, `detalle_servicio.costo > 0`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `dql`) con SQLite:

- Datos base: 5 huespedes, 5 habitaciones, 5 servicios, 6 reservas, 12 lineas de `detalle_servicio`.
- Las filas 1 y 3 del CSV original (misma huesped Elena Soto, misma habitacion, distintas fechas de consumo) se mantienen como dos reservas separadas (`id_reserva = 1` y `3`), cada una con sus propios servicios — verificado con la consulta 1 (`JOIN` que reconstruye el archivo original).
- Huesped con mayor gasto total (consulta 8): `Elena Soto` con 345.00.
- Los 2 casos comentados al final de `dml/inserts.sql` fallan al descomentarlos y ejecutarlos: uno por `UNIQUE (huespedes.documento)` y otro por `CHECK (costo > 0)`.

## Como ejecutar

```bash
sqlite3 ejercicio-36.db < ddl/schema.sql
sqlite3 ejercicio-36.db < dml/inserts.sql
sqlite3 ejercicio-36.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
