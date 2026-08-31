# Ejercicio 069: Solicitud de cliente - Diseno 3D Arquitectura

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-21

## Que entendi de la solicitud

El estudio necesita guardar historico porque en auditorias le preguntan
que paso y cuando paso. Se necesita una base de datos que permita
consultar renders y su historial de revisiones, corregir estados,
registrar movimientos y sacar reportes, como saber que proyecto
requirio mas revisiones o cuales estan listos para entrega. El detalle
completo del analisis esta en
[`analisis/requerimiento.md`](analisis/requerimiento.md).

## Tablas y por que se crearon

- `clientes`: catalogo de quien contrata cada proyecto.
- `proyectos`: proyecto de diseno para un cliente.
- `renders`: tabla transaccional; imagen generada para un proyecto.
- `revisiones`: **historico de auditoria**; cada revision de un render
  se conserva con su fecha y resultado, nunca se borra.
- `entregas`: version formal del proyecto entregada al cliente.

## Como se relacionan

`clientes` 1—N `proyectos`; `proyectos` 1—N `renders`; `renders` 1—N
`revisiones`; `proyectos` 1—N `entregas`.

## Datos de prueba

3 clientes, 4 proyectos, 9 renders (uno de ellos duplicado por error,
sin revisiones todavia), 12 revisiones y 4 entregas.

## Operaciones (`dml/operaciones.sql`)

- `UPDATE`: un render `'en_proceso'` termina y pasa a `'terminado'`.
- `UPDATE`: se corrige un comentario de revision con error de captura
  **sin eliminarlo**, para conservar el historico de auditoria tal
  como pidio el cliente.
- `DELETE` controlado (con `WHERE`): se elimina un render duplicado
  creado por error, que todavia no tenia ninguna revision asociada.
  Este es el unico caso del modelo donde un `DELETE` real es aceptable;
  el resto del historico nunca se borra.
- Caso comentado que debe fallar: eliminar un render que ya tiene
  revisiones asociadas viola la `FOREIGN KEY` de
  `revisiones.id_render`.

## Consultas que responden al cliente

1. Todos los renders con su proyecto y cliente (`JOIN`).
2. Renders filtrados por estado (`en_proceso`, `terminado`,
   `descartado`).
3. Ranking de proyectos por numero de revisiones -- el historico de
   auditoria (`GROUP BY` + `ORDER BY`).
4. Revisiones ordenadas por fecha, de la mas reciente a la mas antigua.
5. Reporte de decision de negocio: proyectos con renders aprobados,
   para saber cuales estan listos para su proxima entrega
   (`GROUP BY` + `HAVING`).

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` ->
`consultas`) con Python (modulo `sqlite3`), ya que no se tenia el
binario `sqlite3` disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos base: 3 clientes, 4 proyectos, 9 renders, 12 revisiones, 4
  entregas.
- Tras `operaciones.sql`: 8 renders (se elimino el duplicado sin
  historico), render 3 terminado, comentario de revision corregido sin
  perder el registro.
- Reporte final: "Casa Vista Verde" es el proyecto con mas renders
  aprobados (2).

## Como validar

```bash
sqlite3 ejercicio-069.db < ddl/schema.sql
sqlite3 ejercicio-069.db < dml/inserts.sql
sqlite3 ejercicio-069.db < dml/operaciones.sql
sqlite3 ejercicio-069.db < dql/consultas.sql
```
