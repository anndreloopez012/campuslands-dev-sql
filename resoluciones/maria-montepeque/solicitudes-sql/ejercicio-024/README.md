# Ejercicio 024: Solicitud de cliente - Liga Videojuego Futbol

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Una liga de videojuegos de futbol registra usuarios, clubes, jornadas y goles, y necesita un reporte rapido al final de cada semana para tomar decisiones.

## Tablas y relaciones

- `usuarios`: catalogo de managers registrados (nombre unico, email unico).
- `clubes`: catalogo de clubes, cada uno administrado por un usuario (`usuarios` 1—N `clubes`).
- `partidos`: registro transaccional de cada partido entre dos clubes (`clubes` 1—N `partidos` dos veces: como local y como visitante).

No se creo una tabla `jornadas` separada: `jornada` se guarda como un numero dentro de `partidos` (documentado como supuesto en `analisis/requerimiento.md`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las tres tablas.
- `FOREIGN KEY`: `clubes.id_usuario` -> `usuarios.id_usuario`, `partidos.id_club_local` -> `clubes.id_club`, `partidos.id_club_visitante` -> `clubes.id_club`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `usuarios.nombre_usuario`, `usuarios.email`, `clubes.nombre_club`.
- `CHECK`: `jornada > 0`, `goles_local >= 0`, `goles_visitante >= 0`, `division IN (...)`, `estado IN ('jugado', 'pendiente', 'suspendido')`, y `id_club_local <> id_club_visitante` (un club no puede jugar contra si mismo).

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 5 usuarios, 5 clubes y 9 partidos base en una semana de prueba (2026-08-10 a 2026-08-14), uno de ellos (partido 9) es una duplicada por error de digitacion.
- `operaciones.sql` corrige el marcador real de un partido que estaba pendiente, asciende un club de division y elimina el partido duplicado: quedan 8 partidos.
- El caso comentado (un club jugando contra si mismo) falla al ejecutarlo: `CHECK constraint failed: id_club_local <> id_club_visitante`.
- Reporte semanal (goles por dia, solo jugados): el 2026-08-10 fue el dia con mas goles (8, en 2 partidos).
- Club con mas partidos: Real Estelar, con 4.

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-024.db < ddl/schema.sql
sqlite3 ejercicio-024.db < dml/inserts.sql
sqlite3 ejercicio-024.db < dml/operaciones.sql
sqlite3 ejercicio-024.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
