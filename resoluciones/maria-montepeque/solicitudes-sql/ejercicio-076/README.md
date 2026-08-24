# Solicitud SQL - Ejercicio 076: Cafeteria Campus

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Solicitud del cliente

Una cafeteria cerca del campus quiere controlar productos, ventas
rapidas y pagos de estudiantes. El cliente quiere diferenciar
catalogos, operaciones y resultados para no mezclar informacion
permanente con movimientos. Pidio convertir esa operacion en una base
de datos que permita consultar datos, corregir estados, registrar
movimientos y sacar reportes utiles.

## Que entendi de la solicitud

La peticion central es de diseno: separar claramente lo permanente
(productos, clientes) de lo operativo (ventas y su detalle) y de lo
resultante (pagos), en vez de mezclar todo en una sola tabla. El nivel
pedido (4, reportes y agrupaciones) exige ademas `JOIN`, `GROUP BY`,
`HAVING`, totales y ranking. El detalle completo del analisis esta en
[analisis/requerimiento.md](analisis/requerimiento.md).

## Que tablas cree y por que

- `productos`: catalogo permanente de lo que vende la cafeteria.
- `clientes`: catalogo permanente de estudiantes.
- `ventas`: operacion, el encabezado de cada venta rapida.
- `detalle_ventas`: operacion, cada linea de producto dentro de una
  venta. Aqui esta el `UNIQUE (id_venta, id_producto)` que impide
  registrar el mismo producto dos veces en la misma venta.
- `pagos`: resultado de una venta. El `UNIQUE (id_venta)` garantiza un
  solo pago oficial por venta.

## Como se relacionan

`clientes` 1:N `ventas`; `ventas` 1:N `detalle_ventas`; `productos`
1:N `detalle_ventas`; `ventas` 1:1 `pagos`. El diagrama esta en
[diagramas/diagrama-er.svg](diagramas/diagrama-er.svg).

## Que datos de prueba use

5 productos, 4 clientes, 4 ventas (2 `cerrada` con pago desde el
inicio, 2 `abierta`) y 8 lineas de detalle, incluida una linea
cargada por error en una venta que todavia no tenia pago. Tambien un
`INSERT` comentado que reproduce el problema de duplicar un producto
en la misma venta y debe fallar. Detalle en
[dml/inserts.sql](dml/inserts.sql).

## Que operaciones de mantenimiento incluyo

En [dml/operaciones.sql](dml/operaciones.sql): un `DELETE` controlado
que corrige la linea agregada por error (solo posible porque esa
venta seguia `abierta` y sin pago), un `UPDATE` de estado (la venta se
cobra y se cierra) y el registro de su pago oficial.

## Que consultas responden al cliente

En [dql/consultas.sql](dql/consultas.sql): que lineas de venta existen
(JOIN producto-venta), en que estado esta cada venta, que cliente tiene
mas actividad (mas gastado), las lineas ordenadas por subtotal, y un
reporte con `GROUP BY` + `HAVING` de los productos mas vendidos, para
decidir cuales reabastecer primero.

## Evidencias

Resultados de ejecutar todo en orden, incluyendo la verificacion del
caso de duplicado y de las operaciones de mantenimiento, en
[evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-076.db < ddl/schema.sql
sqlite3 ejercicio-076.db < dml/inserts.sql
sqlite3 ejercicio-076.db < dml/operaciones.sql
sqlite3 ejercicio-076.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite`, `.sqlite3` ni `.dump`.
