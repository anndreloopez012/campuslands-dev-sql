# Ejercicio 009: Solicitud de cliente - Estudio Animacion 3D

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Un estudio de animacion 3D maneja proyectos, artistas, entregas y estados, y necesita guardar historico porque en auditorias le preguntan que paso y cuando paso en cada proyecto.

## Tablas y relaciones

- `proyectos`: catalogo de proyectos del estudio (nombre unico, cliente, artista asignado, estado actual).
- `entregas`: historico/bitacora de auditoria, un evento por fila con su fecha exacta (`proyectos` 1—N `entregas`).

No se crearon tablas de `clientes` ni `artistas` separadas: el alcance de este nivel pide 1 a 2 tablas, asi que ambos se guardan como texto dentro de `proyectos` (documentado como supuesto en `analisis/requerimiento.md`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en ambas tablas.
- `FOREIGN KEY`: `entregas.id_proyecto` -> `proyectos.id_proyecto`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `proyectos.nombre_proyecto`.
- `CHECK`: `proyectos.estado_actual IN (...)`, `entregas.tipo_evento IN (...)`, `entregas.estado IN ('pendiente', 'aprobado', 'rechazado')`.
- `DEFAULT`: `entregas.fecha_evento` con la fecha/hora actual, `entregas.estado` en `'pendiente'`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 5 proyectos y 9 eventos base en el historico (uno de ellos, el evento 9, es una entrada de prueba insertada por error).
- `operaciones.sql` aprueba una correccion que estaba rechazada, reasigna un artista y elimina la entrada de prueba (la unica fila del historico que se borra): quedan 8 eventos.
- El caso comentado (`tipo_evento = 'cancelacion'`) falla al ejecutarlo: `CHECK constraint failed: tipo_evento IN (...)`.
- Reporte de auditoria (ultimo evento por proyecto): responde en un vistazo en que quedo cada proyecto sin revisar todo el historico.
- Proyecto con mas eventos: tres proyectos empatan con 2 eventos cada uno.

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-009.db < ddl/schema.sql
sqlite3 ejercicio-009.db < dml/inserts.sql
sqlite3 ejercicio-009.db < dml/operaciones.sql
sqlite3 ejercicio-009.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
