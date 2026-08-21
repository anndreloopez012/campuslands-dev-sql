# Ejercicio 006: Solicitud de cliente - Renta Autos de Lujo

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Una empresa alquila autos deportivos y necesita controlar reservas, clientes y pagos. El cliente pidio explicitamente diferenciar catalogos, operaciones y resultados para no mezclar informacion permanente con movimientos, ademas de poder consultar datos, corregir estados y sacar reportes.

## Tablas y relaciones

- `vehiculos`: catalogo permanente de autos (marca, modelo, placa, precio por dia, estado de disponibilidad).
- `reservas`: registro transaccional de cada alquiler (`vehiculos` 1—N `reservas`).

No se creo una tabla `clientes` separada: el alcance de este nivel pide 1 a 2 tablas, asi que el nombre del cliente se guarda dentro de `reservas` (documentado como supuesto en `analisis/requerimiento.md`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en ambas tablas.
- `FOREIGN KEY`: `reservas.id_vehiculo` -> `vehiculos.id_vehiculo`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `vehiculos.placa`.
- `CHECK`: `precio_dia > 0`, `monto_total > 0`, `vehiculos.estado IN (...)`, `reservas.estado IN (...)`.
- `DEFAULT`: `vehiculos.estado` en `'disponible'`, `reservas.estado` en `'confirmada'`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 5 vehiculos y 9 reservas base (una de ellas, la reserva 8, es una entrada de prueba insertada por error).
- `operaciones.sql` marca como finalizada una reserva que estaba en curso, envia un auto a mantenimiento y elimina la reserva de prueba: quedan 8 reservas.
- El caso comentado (`monto_total = 0`) falla al ejecutarlo: `CHECK constraint failed: monto_total > 0`.
- Reporte de decision de negocio (ingresos por vehiculo, sin canceladas): el Porsche 911 Carrera genera el mayor ingreso (3200.0).
- Cliente que mas reserva: Jorge Alvarado, con 3 reservas.

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-006.db < ddl/schema.sql
sqlite3 ejercicio-006.db < dml/inserts.sql
sqlite3 ejercicio-006.db < dml/operaciones.sql
sqlite3 ejercicio-006.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
