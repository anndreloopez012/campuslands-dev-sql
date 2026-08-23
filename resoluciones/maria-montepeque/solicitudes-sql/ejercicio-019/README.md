# Ejercicio 019: Solicitud de cliente - Diseno 3D Arquitectura

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Un estudio de diseno 3D de arquitectura registra clientes, renders, planos, revisiones y entregas, y necesita guardar historico porque en auditorias le preguntan que paso y cuando paso en cada proyecto.

## Tablas y relaciones

- `proyectos`: catalogo de proyectos del estudio (nombre unico, cliente, arquitecto asignado, estado actual).
- `eventos`: historico/bitacora de auditoria, un evento por fila con su fecha exacta (`proyectos` 1—N `eventos`).

No se crearon tablas de `clientes` ni `arquitectos` separadas: el alcance de este nivel pide 1 a 2 tablas, asi que ambos se guardan como texto dentro de `proyectos` (documentado como supuesto en `analisis/requerimiento.md`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en ambas tablas.
- `FOREIGN KEY`: `eventos.id_proyecto` -> `proyectos.id_proyecto`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `proyectos.nombre_proyecto`.
- `CHECK`: `proyectos.estado_actual IN (...)`, `eventos.tipo_evento IN (...)`, `eventos.estado IN ('pendiente', 'aprobado', 'rechazado')`.
- `DEFAULT`: `eventos.fecha_evento` con la fecha/hora actual, `eventos.estado` en `'pendiente'`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 5 proyectos y 9 eventos base en el historico (uno de ellos, el evento 9, es una entrada de prueba insertada por error).
- `operaciones.sql` aprueba un ajuste que estaba rechazado, reasigna un arquitecto y elimina la entrada de prueba (la unica fila del historico que se borra): quedan 8 eventos.
- El caso comentado (`tipo_evento = 'demolicion'`) falla al ejecutarlo: `CHECK constraint failed: tipo_evento IN (...)`.
- Reporte de auditoria (ultimo evento por proyecto): responde en un vistazo en que quedo cada proyecto sin revisar todo el historico.
- Proyecto con mas eventos: tres proyectos empatan con 2 eventos cada uno.

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-019.db < ddl/schema.sql
sqlite3 ejercicio-019.db < dml/inserts.sql
sqlite3 ejercicio-019.db < dml/operaciones.sql
sqlite3 ejercicio-019.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
