# Ejercicio 002: Solicitud de cliente - Taller de Motos

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Un taller de motos recibe servicios por orden de trabajo y necesita saber, para cada movimiento: quien trajo la moto, que se le hizo, cuando ocurrio y cuanto dinero representa. Tambien pidio poder consultar datos, corregir estados y sacar reportes utiles.

## Tablas y relaciones

- `motos`: catalogo de motos atendidas por el taller (placa unica, marca, modelo, dueno).
- `ordenes_trabajo`: registro transaccional de cada servicio (`motos` 1—N `ordenes_trabajo`).

No se crearon tablas separadas de `clientes`, `repuestos` ni `mecanicos`: el alcance de este nivel pide 1 a 2 tablas, asi que el dueno se guarda en `motos` y el mecanico como dato dentro de la orden (documentado como supuesto en `analisis/requerimiento.md`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en ambas tablas.
- `FOREIGN KEY`: `ordenes_trabajo.id_moto` -> `motos.id_moto`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `motos.placa` (identifica de forma unica cada vehiculo).
- `CHECK`: `costo > 0`, `estado IN ('en_proceso', 'completada', 'cancelada')`.
- `DEFAULT`: `fecha_orden` con la fecha/hora actual, `estado` en `'en_proceso'`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 5 motos y 9 ordenes base (una de ellas, la orden 8, es una duplicada intencional de la orden 2 para practicar una eliminacion segura).
- `operaciones.sql` completa una orden que estaba en proceso, corrige el nombre incompleto de un dueno y elimina la orden duplicada: quedan 8 ordenes.
- El caso comentado (`costo = 0`) falla al ejecutarlo: `CHECK constraint failed: costo > 0`.
- Reporte de decision de negocio (ingresos por mecanico, solo ordenes completadas): Luis Marin genera el mayor ingreso total (750.0) con solo 2 ordenes, por el valor de sus servicios.
- Moto con mas actividad: la de Rosa Mendez (P002BBB), con 3 ordenes de trabajo.

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-002.db < ddl/schema.sql
sqlite3 ejercicio-002.db < dml/inserts.sql
sqlite3 ejercicio-002.db < dml/operaciones.sql
sqlite3 ejercicio-002.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
