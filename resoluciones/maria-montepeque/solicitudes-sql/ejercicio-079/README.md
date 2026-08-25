# Solicitud SQL - Ejercicio 079: Tienda Sneakers

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Solicitud del cliente

Una tienda de ropa urbana vende sneakers, tallas, clientes y pedidos.
El cliente necesita guardar historico porque en auditorias le
preguntan que paso y cuando paso. Pidio convertir esa operacion en una
base de datos que permita consultar datos, corregir estados, registrar
movimientos y sacar reportes utiles.

## Que entendi de la solicitud

La peticion central es de conservacion de historico: una vez que un
pedido se confirma, sus lineas (que producto, que talla, cuantos) ya
son informacion de auditoria y no se borran. El nivel pedido (4,
reportes y agrupaciones) exige ademas `JOIN`, `GROUP BY`, `HAVING`,
totales y ranking. El detalle completo del analisis esta en
[analisis/requerimiento.md](analisis/requerimiento.md).

## Que tablas cree y por que

- `clientes`: catalogo de compradores.
- `productos`: catalogo de modelos de sneaker.
- `tallas`: catalogo de tallas disponibles.
- `pedidos`: tabla transaccional, cada pedido de un cliente. Su
  `estado` se corrige siempre con `UPDATE`.
- `detalle_pedidos`: historico de auditoria de cada pedido. Aqui esta
  el `UNIQUE (id_pedido, id_producto, id_talla)` que impide duplicar
  la misma linea.

## Como se relacionan

`clientes` 1:N `pedidos`; `pedidos` 1:N `detalle_pedidos`;
`productos` 1:N `detalle_pedidos`; `tallas` 1:N `detalle_pedidos`. El
diagrama esta en [diagramas/diagrama-er.svg](diagramas/diagrama-er.svg).

## Que datos de prueba use

4 clientes, 4 productos, 5 tallas, 4 pedidos (2 `entregado`, 1
`enviado`, 1 `pendiente`) y 7 lineas de detalle, incluida una linea
cargada por error en un pedido que todavia estaba `pendiente`.
Tambien un `INSERT` comentado que reproduce el problema de duplicar
una linea de producto/talla y debe fallar. Detalle en
[dml/inserts.sql](dml/inserts.sql).

## Que operaciones de mantenimiento incluyo

En [dml/operaciones.sql](dml/operaciones.sql): un `DELETE` controlado
que corrige la linea agregada por error (solo posible porque ese
pedido seguia `pendiente`) y un `UPDATE` de estado (el pedido se
confirma una vez corregido).

## Que consultas responden al cliente

En [dql/consultas.sql](dql/consultas.sql): que lineas de pedido
existen (JOIN producto-talla-cliente), en que estado esta cada
pedido, que cliente tiene mas pedidos, las lineas ordenadas por
subtotal, y un reporte con `GROUP BY` + `HAVING` de los productos mas
pedidos, para decidir cuales reabastecer primero.

## Evidencias

Resultados de ejecutar todo en orden, incluyendo la verificacion del
caso de duplicado y de las operaciones de mantenimiento, en
[evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-079.db < ddl/schema.sql
sqlite3 ejercicio-079.db < dml/inserts.sql
sqlite3 ejercicio-079.db < dml/operaciones.sql
sqlite3 ejercicio-079.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite`, `.sqlite3` ni `.dump`.
