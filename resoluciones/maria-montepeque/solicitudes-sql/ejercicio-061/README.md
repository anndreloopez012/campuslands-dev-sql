# Ejercicio 061: Solicitud de cliente - Delivery de Comida

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-21

## Que entendi de la solicitud

El cliente maneja su delivery de comida en hojas de calculo, con datos
duplicados entre personas. Necesita una base de datos que le permita
consultar pedidos, corregir estados, registrar pagos y sacar reportes
(por ejemplo, que repartidor entrega mas o cuanto factura cada
restaurante). El detalle completo del analisis esta en
[`analisis/requerimiento.md`](analisis/requerimiento.md).

## Tablas y por que se crearon

- `clientes`: catalogo de clientes (se repite en muchos pedidos).
- `menus`: catalogo de platillos por restaurante (se repite en muchos
  pedidos).
- `repartidores`: catalogo de repartidores (se repite en muchos pedidos).
- `pedidos`: tabla transaccional central; relaciona cliente, platillo y
  repartidor, con cantidad, fecha y estado.
- `pagos`: se separa de `pedidos` porque tiene su propio ciclo de vida
  (pendiente, pagado, reembolsado) y metodo de pago; relacion 1:1 con
  `pedidos` mediante `UNIQUE (id_pedido)`.

## Como se relacionan

`clientes` 1—N `pedidos`, `menus` 1—N `pedidos`, `repartidores` 1—N
`pedidos`, `pedidos` 1—1 `pagos`.

## Datos de prueba

5 clientes, 5 platillos (5 restaurantes distintos), 4 repartidores,
10 pedidos (con estados variados, incluyendo 2 sin repartidor asignado
todavia) y 7 pagos.

## Operaciones (`dml/operaciones.sql`)

- `UPDATE`: se asigna repartidor a un pedido pendiente y pasa a
  `'en_camino'`.
- `UPDATE`: se confirma como `'pagado'` el pago de un pedido ya
  entregado.
- `DELETE` controlado (con `WHERE`): se elimina un pedido `'cancelado'`
  que nunca genero pago.
- Caso comentado que debe fallar: eliminar un cliente con pedidos
  asociados viola la `FOREIGN KEY` de `pedidos.id_cliente`.

## Consultas que responden al cliente

1. Todos los pedidos con cliente, platillo, repartidor y estado (`JOIN` +
   `LEFT JOIN`).
2. Pedidos filtrados por estado (`pendiente`, `en_camino`, `entregado`).
3. Ranking de repartidores por pedidos entregados (`GROUP BY` +
   `ORDER BY`).
4. Pedidos ordenados por fecha, del mas reciente al mas antiguo.
5. Reporte de decision de negocio: facturacion por restaurante, solo
   pagos ya `'pagado'`, filtrando los que superan Q100 (`GROUP BY` +
   `HAVING`).

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` ->
`consultas`) con Python (modulo `sqlite3`), ya que no se tenia el
binario `sqlite3` disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos base: 5 clientes, 5 platillos, 4 repartidores, 10 pedidos,
  7 pagos.
- Tras `operaciones.sql`: 9 pedidos (se elimino el cancelado sin pago),
  7 pagos.
- Reporte final: "Sakura Sushi" es el restaurante con mayor facturacion
  (Q240.00), seguido de "Pizza Nostra" (Q190.00).

## Como validar

```bash
sqlite3 ejercicio-061.db < ddl/schema.sql
sqlite3 ejercicio-061.db < dml/inserts.sql
sqlite3 ejercicio-061.db < dml/operaciones.sql
sqlite3 ejercicio-061.db < dql/consultas.sql
```
