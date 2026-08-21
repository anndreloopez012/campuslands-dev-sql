# Ejercicio 066: Solicitud de cliente - Hotel Gamers

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-21

## Que entendi de la solicitud

El hotel quiere diferenciar catalogos (informacion permanente) de
operaciones y movimientos, para no mezclar ambos tipos de datos.
Necesita una base de datos que permita consultar reservas, corregir su
estado, registrar consumos y sacar reportes, como saber que huesped
tiene mas actividad o cuanto factura cada uno. El detalle completo del
analisis esta en [`analisis/requerimiento.md`](analisis/requerimiento.md).

## Tablas y por que se crearon

- `huespedes`, `habitaciones`, `eventos`: catalogos de informacion
  permanente (no cambian con cada estadia).
- `reservas`: operacion; relaciona un huesped con una habitacion en un
  rango de fechas, con su propio estado.
- `consumos`: movimiento asociado a una reserva; se separa de
  `reservas` porque una reserva puede generar muchos consumos, y
  algunos son inscripciones a un evento (`id_evento` opcional).

## Como se relacionan

`huespedes` 1—N `reservas`; `habitaciones` 1—N `reservas`; `reservas`
1—N `consumos`; `eventos` 1—N `consumos` (relacion opcional: no todo
consumo es inscripcion a un evento).

## Datos de prueba

5 huespedes, 5 habitaciones, 3 eventos, 7 reservas (con estados
variados) y 10 consumos.

## Operaciones (`dml/operaciones.sql`)

- `UPDATE`: una reserva `'activa'` hace check-out y pasa a
  `'finalizada'`.
- `UPDATE`: se corrige el monto de un consumo registrado de forma
  incompleta.
- `DELETE` controlado (con `WHERE`): se elimina una reserva
  `'cancelada'` que nunca genero consumos.
- Caso comentado que debe fallar: eliminar una habitacion con reservas
  asociadas viola la `FOREIGN KEY` de `reservas.id_habitacion`.

## Consultas que responden al cliente

1. Todas las reservas con huesped y habitacion (`JOIN`).
2. Reservas filtradas por estado (`activa`, `finalizada`,
   `cancelada`).
3. Ranking de huespedes por numero de consumos (`GROUP BY` +
   `ORDER BY`).
4. Consumos ordenados por fecha, del mas reciente al mas antiguo.
5. Reporte de decision de negocio: facturacion por huesped (habitacion
   segun noches + consumos), filtrando los que superan Q1000
   (`GROUP BY` + `HAVING`), calculado con una subconsulta para no
   duplicar el costo de habitacion cuando una reserva tiene varios
   consumos.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` ->
`consultas`) con Python (modulo `sqlite3`), ya que no se tenia el
binario `sqlite3` disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos base: 5 huespedes, 5 habitaciones, 3 eventos, 7 reservas, 10
  consumos.
- Tras `operaciones.sql`: 6 reservas (se elimino la cancelada sin
  consumos).
- Reporte final: Manuel Estrada es el huesped con mayor facturacion
  (Q2725.00), seguido de Alejandra Chinchilla (Q2465.00).

## Como validar

```bash
sqlite3 ejercicio-066.db < ddl/schema.sql
sqlite3 ejercicio-066.db < dml/inserts.sql
sqlite3 ejercicio-066.db < dml/operaciones.sql
sqlite3 ejercicio-066.db < dql/consultas.sql
```
