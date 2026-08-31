# Ejercicio 063: Solicitud de cliente - Clinica de Tatuajes

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-21

## Que entendi de la solicitud

El estudio de tatuajes quiere evitar registros incompletos porque eso le
impide hacer reportes confiables. Necesita una base de datos que permita
consultar sesiones, corregir su estado, registrar pagos y sacar
reportes, como saber que artista tiene mas actividad o cuanto se
factura por estilo de tatuaje. El detalle completo del analisis esta en
[`analisis/requerimiento.md`](analisis/requerimiento.md).

## Tablas y por que se crearon

- `clientes`: catalogo de clientes (se repite en muchas sesiones).
- `artistas`: catalogo de tatuadores (se repite en muchas sesiones).
- `estilos`: catalogo de estilos de tatuaje (se repite en muchas
  sesiones).
- `sesiones`: tabla transaccional central; relaciona cliente, artista y
  estilo, con duracion, fecha y estado. `cliente`, `artista` y `estilo`
  son `NOT NULL` a proposito, para que ninguna sesion quede incompleta.
- `pagos`: se separa de `sesiones` porque tiene su propio ciclo de vida
  (pendiente, pagado, reembolsado) y metodo de pago; relacion 1:1 con
  `sesiones` mediante `UNIQUE (id_sesion)`.

## Como se relacionan

`clientes` 1—N `sesiones`, `artistas` 1—N `sesiones`, `estilos` 1—N
`sesiones`, `sesiones` 1—1 `pagos`.

## Datos de prueba

5 clientes, 3 artistas, 4 estilos, 10 sesiones (con estados variados) y
6 pagos.

## Operaciones (`dml/operaciones.sql`)

- `UPDATE`: una sesion agendada se realiza y pasa a `'completada'`.
- `UPDATE`: se confirma como `'pagado'` un pago que estaba pendiente.
- `DELETE` controlado (con `WHERE`): se elimina una sesion `'cancelada'`
  que nunca genero pago.
- Caso comentado que debe fallar: eliminar un artista con sesiones
  asociadas viola la `FOREIGN KEY` de `sesiones.id_artista`.

## Consultas que responden al cliente

1. Todas las sesiones con cliente, artista y estilo (`JOIN`).
2. Sesiones filtradas por estado (`agendada`, `completada`,
   `cancelada`).
3. Ranking de artistas por sesiones completadas (`GROUP BY` +
   `ORDER BY`).
4. Sesiones ordenadas por fecha, de la mas reciente a la mas antigua.
5. Reporte de decision de negocio: facturacion por estilo, solo pagos
   ya `'pagado'`, filtrando los que superan Q300 (`GROUP BY` +
   `HAVING`).

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` ->
`consultas`) con Python (modulo `sqlite3`), ya que no se tenia el
binario `sqlite3` disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos base: 5 clientes, 3 artistas, 4 estilos, 10 sesiones, 6 pagos.
- Tras `operaciones.sql`: 9 sesiones (se elimino la cancelada sin pago).
- Reporte final: "Realismo" es el estilo con mayor facturacion
  (Q500.00), seguido de "Tradicional Japones" (Q480.00).

## Como validar

```bash
sqlite3 ejercicio-063.db < ddl/schema.sql
sqlite3 ejercicio-063.db < dml/inserts.sql
sqlite3 ejercicio-063.db < dml/operaciones.sql
sqlite3 ejercicio-063.db < dql/consultas.sql
```
