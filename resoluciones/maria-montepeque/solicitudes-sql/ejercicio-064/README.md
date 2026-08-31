# Ejercicio 064: Solicitud de cliente - Mecanica de Autos

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-21

## Que entendi de la solicitud

El taller controla diagnosticos, reparaciones y repuestos de forma
manual y necesita un reporte rapido cada semana para tomar decisiones.
Se necesita una base de datos que permita corregir el estado de un
diagnostico, registrar reparaciones y repuestos, y generar ese reporte
semanal de facturacion por cliente. El detalle completo del analisis
esta en [`analisis/requerimiento.md`](analisis/requerimiento.md).

## Tablas y por que se crearon

- `clientes`: catalogo de duenos de vehiculo.
- `vehiculos`: pertenece a un cliente; se repite en varios diagnosticos.
- `diagnosticos`: tabla transaccional central; revision inicial de un
  vehiculo.
- `reparaciones`: se separa de `diagnosticos` porque tiene su propio
  costo de mano de obra y no todo diagnostico llega a repararse (los
  `'pendiente'` todavia no).
- `repuestos`: se separa de `reparaciones` porque una reparacion puede
  usar varias piezas distintas, cada una con su propio precio.

## Como se relacionan

`clientes` 1—N `vehiculos`; `vehiculos` 1—N `diagnosticos`;
`diagnosticos` 1—1 `reparaciones` (`UNIQUE (id_diagnostico)`);
`reparaciones` 1—N `repuestos`.

## Datos de prueba

5 clientes, 6 vehiculos (un cliente con 2 vehiculos), 8 diagnosticos,
6 reparaciones y 7 repuestos.

## Operaciones (`dml/operaciones.sql`)

- `UPDATE`: un diagnostico `'en_reparacion'` pasa a `'finalizado'`.
- `UPDATE`: se corrige el costo de mano de obra de esa reparacion (se
  cobro tiempo extra).
- `DELETE` controlado (con `WHERE`): se elimina un diagnostico
  `'pendiente'` que el cliente cancelo antes de generar reparacion.
- Caso comentado que debe fallar: eliminar un vehiculo con diagnosticos
  asociados viola la `FOREIGN KEY` de `diagnosticos.id_vehiculo`.

## Consultas que responden al cliente

1. Todos los diagnosticos con vehiculo y cliente (`JOIN`).
2. Diagnosticos filtrados por estado (`pendiente`, `en_reparacion`,
   `finalizado`).
3. Ranking de vehiculos por numero de diagnosticos (`GROUP BY` +
   `ORDER BY`).
4. Diagnosticos ordenados por fecha, del mas reciente al mas antiguo.
5. Reporte semanal para decision de negocio: facturacion por cliente
   (mano de obra + repuestos), filtrando los que superan Q400
   (`GROUP BY` + `HAVING`).

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` ->
`consultas`) con Python (modulo `sqlite3`), ya que no se tenia el
binario `sqlite3` disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos base: 5 clientes, 6 vehiculos, 8 diagnosticos, 6 reparaciones,
  7 repuestos.
- Tras `operaciones.sql`: 7 diagnosticos (se elimino el cancelado sin
  reparacion), diagnostico 3 finalizado con costo de mano de obra
  corregido.
- Reporte final: Manuel Estrada es el cliente con mayor facturacion de
  la semana (Q1055.00), seguido de Cristina Barrios (Q660.00).

## Como validar

```bash
sqlite3 ejercicio-064.db < ddl/schema.sql
sqlite3 ejercicio-064.db < dml/inserts.sql
sqlite3 ejercicio-064.db < dml/operaciones.sql
sqlite3 ejercicio-064.db < dql/consultas.sql
```
