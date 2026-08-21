# Ejercicio 007: Solicitud de cliente - Academia Kickboxing

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Una academia de kickboxing gestiona alumnos, planes, entrenadores y asistencias, y pidio explicitamente poder corregir estados sin borrar informacion importante: si un alumno deja de pagar o se retira temporalmente, su registro no debe desaparecer.

## Tablas y relaciones

- `planes`: catalogo de planes de entrenamiento (nombre unico, precio mensual, clases por semana).
- `alumnos`: registro central de cada alumno inscrito, con su estado (`planes` 1—N `alumnos`).

No se crearon tablas de `entrenadores` ni `asistencias`: el alcance de este nivel pide 1 a 2 tablas, y el modelo se enfoca en donde vive la peticion central del cliente (documentado como supuesto en `analisis/requerimiento.md`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en ambas tablas.
- `FOREIGN KEY`: `alumnos.id_plan` -> `planes.id_plan`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `planes.nombre_plan`.
- `CHECK`: `precio_mensual > 0`, `clases_por_semana > 0`, `estado IN ('activo', 'suspendido', 'inactivo', 'graduado')`.
- `DEFAULT`: `fecha_inscripcion` con la fecha actual, `estado` en `'activo'`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 5 planes y 9 alumnos base (uno de ellos, el alumno 9, es una entrada de prueba insertada por error).
- `operaciones.sql` corrige el estado de una alumna suspendida a activa, ajusta el precio de un plan y elimina la entrada de prueba (la unica fila que realmente se borra): quedan 8 alumnos.
- El caso comentado (`clases_por_semana = 0`) falla al ejecutarlo: `CHECK constraint failed: clases_por_semana > 0`.
- Reporte de decision de negocio (ingreso mensual estimado por plan, solo alumnos activos): el Plan Elite Personalizado genera el mayor ingreso (700.0) con un solo alumno.
- Plan con mas alumnos activos: Plan Basico, con 2.

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-007.db < ddl/schema.sql
sqlite3 ejercicio-007.db < dml/inserts.sql
sqlite3 ejercicio-007.db < dml/operaciones.sql
sqlite3 ejercicio-007.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
