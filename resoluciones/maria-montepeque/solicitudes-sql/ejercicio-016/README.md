# Ejercicio 016: Solicitud de cliente - Hotel Gamers

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Un hotel tematico para gamers recibe reservas, tiene habitaciones, organiza torneos internos y registra consumos. El cliente pidio explicitamente diferenciar catalogos, operaciones y resultados para no mezclar informacion permanente con movimientos.

## Tablas y relaciones

- `habitaciones`: catalogo permanente de habitaciones (numero, tipo, precio por noche, estado fisico).
- `reservas`: registro transaccional de cada estadia (`habitaciones` 1—N `reservas`).

No se creo una tabla `huespedes` separada: el alcance de este nivel pide 1 a 2 tablas, asi que el nombre del huesped se guarda dentro de `reservas` (documentado como supuesto en `analisis/requerimiento.md`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en ambas tablas.
- `FOREIGN KEY`: `reservas.id_habitacion` -> `habitaciones.id_habitacion`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `habitaciones.numero_habitacion`.
- `CHECK`: `precio_noche > 0`, `monto_total > 0`, `habitaciones.estado IN (...)`, `reservas.estado IN (...)`.
- `DEFAULT`: `habitaciones.estado` en `'disponible'`, `reservas.estado` en `'confirmada'`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 5 habitaciones y 9 reservas base (una de ellas, la reserva 9, es una entrada de prueba insertada por error).
- `operaciones.sql` marca una reserva como finalizada, envia una habitacion a mantenimiento y elimina la reserva de prueba: quedan 8 reservas.
- El caso comentado (`monto_total = 0`) falla al ejecutarlo: `CHECK constraint failed: monto_total > 0`.
- Reporte de decision de negocio (ingresos por habitacion, sin canceladas): la suite gamer 201 genera el mayor ingreso (4750.0).
- Huespedes con mas actividad: Luis Marroquin y Ana Gomez empatan con 2 reservas cada uno.

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-016.db < ddl/schema.sql
sqlite3 ejercicio-016.db < dml/inserts.sql
sqlite3 ejercicio-016.db < dml/operaciones.sql
sqlite3 ejercicio-016.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
