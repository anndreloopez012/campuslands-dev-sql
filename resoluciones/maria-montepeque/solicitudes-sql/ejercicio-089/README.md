# Solicitud SQL - Ejercicio 089: Mecanica de Autos

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Solicitud del cliente

Un taller automotriz controla diagnosticos, reparaciones, repuestos y
garantias. El cliente necesita guardar historico porque en auditorias
le preguntan que paso y cuando paso. Pidio convertir esa operacion en
una base de datos que permita consultar datos, corregir estados,
registrar movimientos y sacar reportes utiles.

## Que entendi de la solicitud

Ningun diagnostico ni reparacion se borra una vez registrado: el
historico solo se corrige con `UPDATE` de estado. Es un nivel 5
(solicitud profesional): ademas del modelo, se pide interpretar
ambiguedad, normalizar datos, documentar decisiones y crear al menos
una vista SQL. El detalle completo del analisis esta en
[analisis/requerimiento.md](analisis/requerimiento.md).

## Que tablas cree y por que

- `clientes`, `vehiculos`, `repuestos`: catalogos.
- `diagnosticos`: historico, cada revision inicial de un vehiculo.
- `reparaciones`: historico, con `UNIQUE (id_diagnostico)` para que un
  diagnostico nunca tenga dos reparaciones oficiales contradictorias.
- `detalle_repuestos`: tabla puente entre reparaciones y repuestos.

## Vista SQL

`vista_historial_vehiculo` (definida en
[ddl/schema.sql](ddl/schema.sql)) junta diagnostico, reparacion,
vehiculo y cliente, respondiendo directamente "que paso y cuando
paso" con cada vehiculo.

## Como se relacionan

`clientes` 1:N `vehiculos`; `vehiculos` 1:N `diagnosticos`;
`diagnosticos` 1:1 `reparaciones`; `reparaciones` 1:N
`detalle_repuestos`; `repuestos` 1:N `detalle_repuestos`. El diagrama
esta en [diagramas/diagrama-er.svg](diagramas/diagrama-er.svg).

## Que datos de prueba use

3 clientes, 3 vehiculos, 4 diagnosticos, 4 reparaciones (2
`completada`, 2 `pendiente`), 4 repuestos y 5 lineas de detalle,
incluida una cargada por error en una reparacion todavia `pendiente`.
Tambien un `INSERT` comentado que reproduce el problema de dos
reparaciones oficiales para el mismo diagnostico y debe fallar.
Detalle en [dml/inserts.sql](dml/inserts.sql).

## Que operaciones de mantenimiento incluyo

En [dml/operaciones.sql](dml/operaciones.sql): un `DELETE` controlado
que corrige la linea de repuesto agregada por error (solo mientras la
reparacion sigue `pendiente` o `en_proceso`) y un `UPDATE` de estado
(la reparacion pasa a `en_proceso`).

## Que consultas responden al cliente

En [dql/consultas.sql](dql/consultas.sql): el historial completo
usando la vista, en que estado esta cada reparacion, que vehiculo
tiene mas diagnosticos, los diagnosticos ordenados por fecha, y un
reporte con `GROUP BY` en dos niveles (por reparacion y despues por
cliente) del gasto total de cada cliente, para decidir a quien ofrecer
un programa de fidelidad.

## Evidencias

Resultados de ejecutar todo en orden, incluyendo la verificacion del
caso de duplicado y de las operaciones de mantenimiento, con los
calculos de costo verificados a mano, en
[evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-089.db < ddl/schema.sql
sqlite3 ejercicio-089.db < dml/inserts.sql
sqlite3 ejercicio-089.db < dml/operaciones.sql
sqlite3 ejercicio-089.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite`, `.sqlite3` ni `.dump`.
