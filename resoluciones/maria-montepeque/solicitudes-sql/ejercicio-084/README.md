# Solicitud SQL - Ejercicio 084: Estudio Animacion 3D

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Solicitud del cliente

Un estudio maneja proyectos de animacion 3D, artistas, entregas y
estados. El cliente necesita un reporte rapido para tomar decisiones
al final de cada semana. Pidio convertir esa operacion en una base de
datos que permita consultar datos, corregir estados, registrar
movimientos y sacar reportes utiles.

## Que entendi de la solicitud

"Al final de cada semana" se tradujo en un checkpoint semanal por
proyecto (`entregas`), no solo un estado general del proyecto. Es un
nivel 5 (solicitud profesional): ademas del modelo, se pide
interpretar ambiguedad, normalizar datos, documentar decisiones y
crear al menos una vista SQL. El detalle completo del analisis esta en
[analisis/requerimiento.md](analisis/requerimiento.md).

## Que tablas cree y por que

- `clientes`: catalogo de clientes que encargan proyectos.
- `artistas`: catalogo de artistas del estudio.
- `proyectos`: tabla transaccional, cada proyecto de animacion.
- `tareas`: detalle de trabajo especifico de un artista en un
  proyecto.
- `entregas`: checkpoint semanal de avance. `UNIQUE (id_proyecto,
  semana)` garantiza un solo reporte oficial por semana por proyecto.

## Vista SQL

`vista_reporte_semanal` (definida en
[ddl/schema.sql](ddl/schema.sql)) junta entregas, proyecto y cliente
en una sola consulta, respondiendo directamente "que paso esta semana
en cada proyecto".

## Como se relacionan

`clientes` 1:N `proyectos`; `proyectos` 1:N `tareas`; `artistas` 1:N
`tareas`; `proyectos` 1:N `entregas`. El diagrama esta en
[diagramas/diagrama-er.svg](diagramas/diagrama-er.svg).

## Que datos de prueba use

3 clientes, 4 artistas, 3 proyectos, 8 tareas (incluida una cargada
por error para un alcance que el cliente cancelo) y 4 entregas
semanales (1 sin aprobar todavia). Tambien un `INSERT` comentado que
reproduce el problema de duplicar el checkpoint semanal y debe
fallar. Detalle en [dml/inserts.sql](dml/inserts.sql).

## Que operaciones de mantenimiento incluyo

En [dml/operaciones.sql](dml/operaciones.sql): un `DELETE` controlado
que elimina la tarea del alcance cancelado, y un `UPDATE` de estado
(la entrega semanal pendiente se aprueba una vez revisada).

## Que consultas responden al cliente

En [dql/consultas.sql](dql/consultas.sql): el reporte semanal completo
usando la vista, en que estado esta cada proyecto, que artista tiene
mas horas trabajadas, las tareas ordenadas por fecha, y un reporte con
`GROUP BY` + `HAVING` de horas totales por proyecto, para decidir
donde reforzar el equipo.

## Evidencias

Resultados de ejecutar todo en orden, incluyendo la verificacion del
caso de duplicado y de las operaciones de mantenimiento, en
[evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-084.db < ddl/schema.sql
sqlite3 ejercicio-084.db < dml/inserts.sql
sqlite3 ejercicio-084.db < dml/operaciones.sql
sqlite3 ejercicio-084.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite`, `.sqlite3` ni `.dump`.
