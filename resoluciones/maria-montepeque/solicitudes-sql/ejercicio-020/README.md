# Ejercicio 020: Solicitud de cliente - Soldadura Industrial

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Un taller de soldadura industrial controla ordenes de trabajo, materiales, tecnicos, inspecciones y costos. El cliente pidio explicitamente poder detectar errores: registros repetidos, relaciones invalidas o valores fuera de rango.

## Tablas y relaciones

- `tecnicos`: catalogo de soldadores certificados (nombre unico, certificacion, anios de experiencia).
- `ordenes`: registro transaccional de cada trabajo de soldadura (`tecnicos` 1—N `ordenes`).

No se creo una tabla `clientes` separada: el alcance de este nivel pide 1 a 2 tablas, asi que el modelo se enfoca en `tecnicos` y `ordenes` (documentado como supuesto en `analisis/requerimiento.md`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en ambas tablas.
- `FOREIGN KEY`: `ordenes.id_tecnico` -> `tecnicos.id_tecnico` (evita relaciones invalidas).
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `tecnicos.nombre_tecnico`, `ordenes.codigo_orden` (evita registros repetidos).
- `CHECK`: `anios_experiencia BETWEEN 0 AND 50` (detecta valores fuera de rango), `costo > 0`, `certificacion IN (...)`, `estado IN ('en_proceso', 'inspeccionada', 'aprobada', 'rechazada')`.
- `DEFAULT`: `fecha_orden` con la fecha actual, `estado` en `'en_proceso'`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 5 tecnicos y 9 ordenes base (una de ellas, la orden 9, es una entrada de prueba insertada por error).
- `operaciones.sql` aprueba una orden que paso inspeccion, actualiza la certificacion de un tecnico y elimina la orden de prueba: quedan 8 ordenes.
- El caso comentado (`anios_experiencia = 80`) falla al ejecutarlo: `CHECK constraint failed: anios_experiencia BETWEEN 0 AND 50`.
- Reporte de costo total por tecnico (sin rechazadas): Carlos Ruiz genera el mayor costo total (9700.0).
- Tecnicos con mas ordenes: tres tecnicos empatan con 2 cada uno.

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-020.db < ddl/schema.sql
sqlite3 ejercicio-020.db < dml/inserts.sql
sqlite3 ejercicio-020.db < dml/operaciones.sql
sqlite3 ejercicio-020.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
