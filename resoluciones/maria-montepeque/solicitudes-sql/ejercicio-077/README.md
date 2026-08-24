# Solicitud SQL - Ejercicio 077: Taller de Motos

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Solicitud del cliente

Un taller de motos recibe servicios, repuestos y mecanicos por orden
de trabajo. El cliente pide que el sistema permita corregir estados
sin borrar informacion importante. Pidio convertir esa operacion en
una base de datos que permita consultar datos, corregir estados,
registrar movimientos y sacar reportes utiles.

## Que entendi de la solicitud

La peticion central es sobre cuando SI y cuando NO usar `DELETE`: los
estados de una orden se corrigen siempre con `UPDATE`, y un repuesto
solo se puede quitar de una orden mientras esta sigue `recibida`
(antes de que sea parte del historial oficial del trabajo). El nivel
pedido (4, reportes y agrupaciones) exige ademas `JOIN`, `GROUP BY`,
`HAVING`, totales y ranking. El detalle completo del analisis esta en
[analisis/requerimiento.md](analisis/requerimiento.md).

## Que tablas cree y por que

- `clientes`: catalogo de duenos de motos.
- `motos`: catalogo de motos, cada una de un cliente.
- `ordenes_servicio`: tabla transaccional, cada trabajo sobre una
  moto. Su `estado` es el dato que mas cambia y siempre se corrige con
  `UPDATE`.
- `repuestos`: catalogo de repuestos disponibles.
- `detalle_repuestos`: detalle de cada orden. Aqui esta el
  `UNIQUE (id_orden, id_repuesto)` que impide registrar el mismo
  repuesto dos veces en la misma orden.

## Como se relacionan

`clientes` 1:N `motos`; `motos` 1:N `ordenes_servicio`;
`ordenes_servicio` 1:N `detalle_repuestos`; `repuestos` 1:N
`detalle_repuestos`. El diagrama esta en
[diagramas/diagrama-er.svg](diagramas/diagrama-er.svg).

## Que datos de prueba use

3 clientes, 3 motos, 5 repuestos, 4 ordenes (2 `finalizada`, 1
`en_reparacion`, 1 `recibida`) y 7 lineas de detalle, incluida una
linea cargada por error en una orden que todavia estaba `recibida`.
Tambien un `INSERT` comentado que reproduce el problema de duplicar
un repuesto en la misma orden y debe fallar. Detalle en
[dml/inserts.sql](dml/inserts.sql).

## Que operaciones de mantenimiento incluyo

En [dml/operaciones.sql](dml/operaciones.sql): un `DELETE` controlado
que corrige el repuesto agregado por error (solo posible porque esa
orden seguia `recibida`) y un `UPDATE` de estado (la orden pasa a
`en_reparacion` una vez que el mecanico empieza a trabajar).

## Que consultas responden al cliente

En [dql/consultas.sql](dql/consultas.sql): que lineas de repuestos
existen (JOIN repuesto-orden-moto), en que estado esta cada orden, que
moto tiene mas ordenes de servicio, las lineas ordenadas por subtotal,
y un reporte con `GROUP BY` + `HAVING` de los repuestos mas usados,
para decidir cuales mantener siempre en stock.

## Evidencias

Resultados de ejecutar todo en orden, incluyendo la verificacion del
caso de duplicado y de las operaciones de mantenimiento, en
[evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-077.db < ddl/schema.sql
sqlite3 ejercicio-077.db < dml/inserts.sql
sqlite3 ejercicio-077.db < dml/operaciones.sql
sqlite3 ejercicio-077.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite`, `.sqlite3` ni `.dump`.
