# Ejercicio 012: Solicitud de cliente - Club Futbol Sala

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Un club de futbol sala registra jugadores, partidos, goles, tarjetas y posiciones. El cliente pidio saber quien hizo el movimiento, que tipo de movimiento fue, cuando ocurrio y cuanto dinero representa: en este club los goles generan un bono y las tarjetas generan una multa.

## Tablas y relaciones

- `equipos`: catalogo de equipos del club (nombre unico, categoria).
- `eventos`: registro transaccional de goles y tarjetas, cada uno con su valor monetario (`equipos` 1—N `eventos`).

No se creo una tabla `jugadores` separada: el alcance de este nivel pide 1 a 2 tablas, asi que el nombre del jugador se guarda dentro de `eventos` (documentado como supuesto en `analisis/requerimiento.md`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en ambas tablas.
- `FOREIGN KEY`: `eventos.id_equipo` -> `equipos.id_equipo`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `equipos.nombre_equipo`.
- `CHECK`: `monto >= 0`, `tipo_evento IN ('gol', 'tarjeta_amarilla', 'tarjeta_roja')`, `categoria IN (...)`, `estado IN ('registrado', 'pagado', 'anulado')`.
- `DEFAULT`: `fecha_partido` con la fecha actual, `estado` en `'registrado'`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 4 equipos y 9 eventos base (uno de ellos, el evento 9, es una entrada de prueba insertada por error).
- `operaciones.sql` marca como pagado un bono de gol, asciende un equipo de categoria y elimina la entrada de prueba: quedan 8 eventos.
- El caso comentado (`monto = -50.00`) falla al ejecutarlo: `CHECK constraint failed: monto >= 0`.
- Jugador con mas eventos: Andres Lopez, con 2 goles.
- Reporte de dinero por tipo de evento (sin anulados): el club debe 200.0 en bonos por goles y recauda 120.0 en multas por tarjetas.

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-012.db < ddl/schema.sql
sqlite3 ejercicio-012.db < dml/inserts.sql
sqlite3 ejercicio-012.db < dml/operaciones.sql
sqlite3 ejercicio-012.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
