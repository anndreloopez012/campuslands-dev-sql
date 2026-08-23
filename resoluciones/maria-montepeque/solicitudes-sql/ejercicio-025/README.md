# Ejercicio 025: Solicitud de cliente - Track Day Hiperdeportivos

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Una pista organiza track days con vehiculos hiperdeportivos: un piloto lleva su vehiculo, corre sesiones cronometradas y se registra su tiempo de vuelta. El cliente no piensa en tablas, describe su operacion diaria, y espera que se traduzca a un modelo relacional.

## Tablas y relaciones

- `pilotos`: catalogo de pilotos registrados (nombre unico, licencia unica, categoria).
- `vehiculos`: catalogo de vehiculos, cada uno propiedad de un piloto (`pilotos` 1—N `vehiculos`).
- `sesiones`: registro transaccional de cada vuelta cronometrada (`vehiculos` 1—N `sesiones`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las tres tablas.
- `FOREIGN KEY`: `vehiculos.id_piloto` -> `pilotos.id_piloto`, `sesiones.id_vehiculo` -> `vehiculos.id_vehiculo`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `pilotos.nombre_piloto`, `pilotos.licencia`.
- `CHECK`: `potencia_hp > 0`, `tiempo_vuelta_segundos > 0`, `categoria IN (...)`, `clima IN (...)`, `estado IN ('valida', 'descalificada', 'en_revision')`.
- `DEFAULT`: `estado` en `'valida'`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 5 pilotos, 5 vehiculos y 9 sesiones base (una de ellas, la sesion 9, es una duplicada por error de digitacion).
- `operaciones.sql` confirma una sesion que estaba en revision, asciende de categoria a un piloto y elimina la duplicada: quedan 8 sesiones.
- El caso comentado (`tiempo_vuelta_segundos = 0`) falla al ejecutarlo: `CHECK constraint failed: tiempo_vuelta_segundos > 0`.
- Todas las consultas encadenan `JOIN` a traves de las tres tablas.
- Record de la pista: Andres Lopez, con 91.98 segundos en el Ferrari SF90.

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-025.db < ddl/schema.sql
sqlite3 ejercicio-025.db < dml/inserts.sql
sqlite3 ejercicio-025.db < dml/operaciones.sql
sqlite3 ejercicio-025.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
