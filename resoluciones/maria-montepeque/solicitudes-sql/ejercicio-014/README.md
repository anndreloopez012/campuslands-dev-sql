# Ejercicio 014: Solicitud de cliente - Mecanica de Autos

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Un taller automotriz controla diagnosticos, reparaciones, repuestos y garantias, y necesita un reporte rapido al final de cada semana para tomar decisiones.

## Tablas y relaciones

- `vehiculos`: catalogo de vehiculos atendidos por el taller (placa unica, marca, modelo, dueno).
- `reparaciones`: registro transaccional de cada trabajo realizado (`vehiculos` 1—N `reparaciones`).

No se creo una tabla `clientes` separada: el alcance de este nivel pide 1 a 2 tablas, asi que el nombre del dueno se guarda dentro de `vehiculos` (documentado como supuesto en `analisis/requerimiento.md`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en ambas tablas.
- `FOREIGN KEY`: `reparaciones.id_vehiculo` -> `vehiculos.id_vehiculo`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `vehiculos.placa`.
- `CHECK`: `costo > 0`, `garantia_dias >= 0`, `estado IN ('en_proceso', 'completada', 'cancelada')`.
- `DEFAULT`: `fecha_reparacion` con la fecha/hora actual, `garantia_dias` en 30, `estado` en `'en_proceso'`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 5 vehiculos y 9 reparaciones base en una semana de prueba (2026-08-10 a 2026-08-16), una de ellas (reparacion 9) es una entrada de prueba insertada por error.
- `operaciones.sql` marca una reparacion como completada, corrige un dato incompleto y elimina la entrada de prueba: quedan 8 reparaciones.
- El caso comentado (`costo = 0`) falla al ejecutarlo: `CHECK constraint failed: costo > 0`.
- Reporte semanal (ingresos por dia, solo completadas): el 2026-08-15 fue el dia de mas ingresos (800.0, un cambio de llantas).
- Vehiculos con mas reparaciones: tres vehiculos empatan con 2 cada uno.

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-014.db < ddl/schema.sql
sqlite3 ejercicio-014.db < dml/inserts.sql
sqlite3 ejercicio-014.db < dml/operaciones.sql
sqlite3 ejercicio-014.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
