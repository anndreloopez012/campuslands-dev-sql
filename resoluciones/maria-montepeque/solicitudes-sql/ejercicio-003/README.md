# Ejercicio 003: Solicitud de cliente - Torneo Esports

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Una organizacion de esports registra equipos, jugadores, partidas y puntos, pero hoy sufre registros incompletos que le impiden sacar reportes confiables. El cliente pidio una base de datos que obligue a llenar lo minimo necesario, permita corregir estados y genere reportes utiles.

## Tablas y relaciones

- `equipos`: catalogo de equipos participantes (nombre unico, region).
- `jugadores`: registro central de cada jugador, con su equipo, rol, puntos acumulados y estado (`equipos` 1—N `jugadores`).

No se creo una tabla `partidas` separada: el alcance de este nivel pide 1 a 2 tablas, asi que `puntos_totales` se guarda como un acumulado directamente en `jugadores` (documentado como supuesto en `analisis/requerimiento.md`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en ambas tablas.
- `FOREIGN KEY`: `jugadores.id_equipo` -> `equipos.id_equipo`.
- `NOT NULL` en `nickname`, `nombre_real`, `rol` y `puntos_totales`: exactamente los campos que, si faltaran, romperian los reportes (la queja principal del cliente).
- `UNIQUE`: `equipos.nombre_equipo`, `jugadores.nickname`.
- `CHECK`: `puntos_totales >= 0`, `rol IN (...)`, `estado IN ('activo', 'inactivo', 'suspendido')`.
- `DEFAULT`: `puntos_totales` en 0, `estado` en `'activo'`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 4 equipos y 9 jugadores base (uno de ellos, `TestPlayer99`, es una cuenta de prueba insertada por error que nunca compitio).
- `operaciones.sql` suma puntos a un jugador que gano su ultima partida, reactiva a un jugador que estaba `inactivo` y elimina la cuenta de prueba: quedan 8 jugadores.
- El caso comentado (`puntos_totales = -10`) falla al ejecutarlo: `CHECK constraint failed: puntos_totales >= 0`.
- Reporte de decision de negocio (ranking de equipos por puntos totales): Dragones Rojos lidera con 760 puntos acumulados entre sus 3 jugadores.
- Equipo con mas jugadores activos: Dragones Rojos, con 3.

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-003.db < ddl/schema.sql
sqlite3 ejercicio-003.db < dml/inserts.sql
sqlite3 ejercicio-003.db < dml/operaciones.sql
sqlite3 ejercicio-003.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
