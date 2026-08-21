# Ejercicio 027: Solicitud de cliente - Taller de Motos

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Un taller de motos recibe servicios, repuestos y mecanicos por orden de trabajo. El cliente pidio explicitamente que el sistema permita corregir estados sin borrar informacion importante.

## Tablas y relaciones

- `clientes`: catalogo de duenos de motos (nombre unico, telefono).
- `motos`: catalogo de motos, cada una propiedad de un cliente (`clientes` 1—N `motos`).
- `ordenes_servicio`: registro transaccional de cada trabajo realizado (`motos` 1—N `ordenes_servicio`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las tres tablas.
- `FOREIGN KEY`: `motos.id_cliente` -> `clientes.id_cliente`, `ordenes_servicio.id_moto` -> `motos.id_moto`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `clientes.nombre_cliente`, `motos.placa`.
- `CHECK`: `costo > 0`, `estado IN ('en_proceso', 'completada', 'cancelada')`.
- `DEFAULT`: `fecha_orden` con la fecha/hora actual, `estado` en `'en_proceso'`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 5 clientes, 5 motos y 9 ordenes base (una de ellas, la orden 9, es una duplicada por error de digitacion).
- `operaciones.sql` completa una orden que estaba en proceso, actualiza el telefono de un cliente y elimina la duplicada (la unica fila que realmente se borra): quedan 8 ordenes.
- El caso comentado (`costo = 0`) falla al ejecutarlo: `CHECK constraint failed: costo > 0`.
- Reporte de ingresos por mecanico (sin canceladas): Luis Marin lidera con 750.0 en solo 2 ordenes.

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-027.db < ddl/schema.sql
sqlite3 ejercicio-027.db < dml/inserts.sql
sqlite3 ejercicio-027.db < dml/operaciones.sql
sqlite3 ejercicio-027.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
