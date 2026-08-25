# Solicitud SQL - Ejercicio 086: Delivery de Comida

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Solicitud del cliente

Un negocio de comida recibe pedidos, repartidores, menus y
calificaciones. El cliente quiere diferenciar catalogos, operaciones y
resultados para no mezclar informacion permanente con movimientos.
Pidio convertir esa operacion en una base de datos que permita
consultar datos, corregir estados, registrar movimientos y sacar
reportes utiles.

## Que entendi de la solicitud

La peticion central es de diseno: separar lo permanente (clientes,
menus, repartidores) de lo operativo (pedidos) y de lo resultante
(pagos), sin mezclar las tres capas en una sola tabla. Es un nivel 5
(solicitud profesional): ademas del modelo, se pide interpretar
ambiguedad, normalizar datos, documentar decisiones y crear al menos
una vista SQL. El detalle completo del analisis esta en
[analisis/requerimiento.md](analisis/requerimiento.md).

## Que tablas cree y por que

- `clientes`, `menus`, `repartidores`: catalogos permanentes.
- `pedidos`: operacion, cada pedido nuevo.
- `pagos`: resultado de un pedido. `UNIQUE (id_pedido)` garantiza un
  solo pago oficial por pedido.

## Vista SQL

`vista_pedidos_completos` (definida en
[ddl/schema.sql](ddl/schema.sql)) junta pedido, cliente, menu,
repartidor y pago con `LEFT JOIN`, manteniendo separadas las tres
capas en un solo reporte legible.

## Como se relacionan

`clientes` 1:N `pedidos`; `menus` 1:N `pedidos`; `repartidores` 1:N
`pedidos`; `pedidos` 1:1 `pagos`. El diagrama esta en
[diagramas/diagrama-er.svg](diagramas/diagrama-er.svg).

## Que datos de prueba use

4 clientes, 5 platillos, 2 repartidores, 5 pedidos (2 `entregado` con
pago, 1 `en_camino` sin pago, 1 marcado `entregado` por error con un
pago que se corrige despues, 1 `recibido`) y 3 pagos. Tambien un
`INSERT` comentado que reproduce el problema de duplicar un pago para
el mismo pedido y debe fallar. Detalle en
[dml/inserts.sql](dml/inserts.sql).

## Que operaciones de mantenimiento incluyo

En [dml/operaciones.sql](dml/operaciones.sql): un `UPDATE` de estado
(el pedido que se marco entregado por error pasa a `cancelado`) y un
`DELETE` controlado que elimina el pago invalido de ese pedido, sin
tocar ningun pago de un pedido ya `entregado`.

## Que consultas responden al cliente

En [dql/consultas.sql](dql/consultas.sql): el resumen completo de
pedidos usando la vista, en que estado esta cada pedido, que cliente
tiene mas pedidos, los pedidos ordenados por fecha y monto, y un
reporte con `GROUP BY` + `HAVING` (tambien sobre la vista) de ingresos
totales por categoria de menu, para decidir en cual enfocar
promociones.

## Evidencias

Resultados de ejecutar todo en orden, incluyendo la verificacion del
caso de duplicado y de las operaciones de mantenimiento, en
[evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-086.db < ddl/schema.sql
sqlite3 ejercicio-086.db < dml/inserts.sql
sqlite3 ejercicio-086.db < dml/operaciones.sql
sqlite3 ejercicio-086.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite`, `.sqlite3` ni `.dump`.
