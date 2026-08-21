# Ejercicio 013: Solicitud de cliente - Clinica de Tatuajes

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Un estudio de tatuajes agenda sesiones con sus artistas, con pagos asociados. El cliente pidio explicitamente evitar registros incompletos porque despues no puede hacer reportes confiables.

## Tablas y relaciones

- `artistas`: catalogo de tatuadores del estudio (nombre unico, estilo principal).
- `sesiones`: registro transaccional de cada cita, con su monto y estado (`artistas` 1—N `sesiones`).

No se creo una tabla `clientes` separada: el alcance de este nivel pide 1 a 2 tablas, asi que el nombre del cliente se guarda dentro de `sesiones` (documentado como supuesto en `analisis/requerimiento.md`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en ambas tablas.
- `FOREIGN KEY`: `sesiones.id_artista` -> `artistas.id_artista`.
- `NOT NULL` en `nombre_cliente`, `fecha_sesion` y `monto_pagado`: exactamente los campos que, si faltaran, romperian el reporte de ingresos que pide el estudio.
- `UNIQUE`: `artistas.nombre_artista`.
- `CHECK`: `monto_pagado > 0`, `estilo_principal IN (...)`, `estado IN ('agendada', 'completada', 'cancelada')`.
- `DEFAULT`: `estado` en `'agendada'`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 5 artistas y 9 sesiones base (una de ellas, la sesion 9, es una entrada de prueba insertada por error).
- `operaciones.sql` marca una sesion como completada, actualiza el estilo de un artista y elimina la entrada de prueba: quedan 8 sesiones.
- El caso comentado (`monto_pagado = 0`) falla al ejecutarlo: `CHECK constraint failed: monto_pagado > 0`.
- Reporte de ingresos por artista (solo completadas): Karla Diaz genera el mayor ingreso (2700.0), aunque empata en numero de sesiones con Julio Perez.

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-013.db < ddl/schema.sql
sqlite3 ejercicio-013.db < dml/inserts.sql
sqlite3 ejercicio-013.db < dml/operaciones.sql
sqlite3 ejercicio-013.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
