# Ejercicio 79: DELETE Nivel Aplicado

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Tema central

DELETE

## Descripcion del problema

Una cafeteria registra sus ventas diarias. En un dia normal, la
cajera duplico por error el cobro de un cliente; en otro dia, la caja
registradora fallo y duplico cada cobro del dia completo. El negocio
necesita corregir ambos casos con `DELETE` y despues confirmar, con un
reporte final, que los totales diarios vuelven a ser correctos: un
caso de negocio con validacion final, propio del nivel aplicado.

## Tablas y relaciones

- `clientes`: catalogo de clientes de la cafeteria.
- `productos`: catalogo de productos, con su precio.
- `ventas`: tabla principal de este ejercicio, cada fila una venta
  individual. `clientes` 1—N `ventas`; `productos` 1—N `ventas`.

## Uso de DELETE

En `dml/inserts.sql`, despues de cargar un dia completo de ventas
(2026-08-01) mas una venta duplicada y un segundo dia invalido
(2026-08-02):

1. `DELETE` de una sola fila: se elimina la venta duplicada del Cafe
   Americano de Manuel Estrada, con `WHERE id_venta = 6`.
2. `DELETE` multiple: se anula de una sola vez todo el dia
   2026-08-02, con `WHERE fecha_venta = '2026-08-02'`, sin borrar cada
   venta de ese dia una por una.

La consulta 5 en `dql/consultas.sql` es el reporte final: recalcula el
total cobrado por dia desde cero (`cantidad * precio`) y confirma que
solo queda el 2026-08-01, con el monto correcto.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `ventas.id_cliente`, `ventas.id_producto`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `clientes.telefono`, `productos.nombre_producto`.
- `CHECK`: `productos.precio >= 0`, `ventas.cantidad > 0`.
- `DEFAULT` en `ventas.fecha_venta`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dml/inserts.sql`)

`DELETE FROM productos WHERE id_producto = 1;` falla porque Cafe
Americano todavia tiene ventas del 2026-08-01 que dependen de el por
`FOREIGN KEY`. Se valido con Python (`sqlite3`): lanza
`FOREIGN KEY constraint failed`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos finales: 5 ventas, todas del 2026-08-01, por un total de
  Q119.00.

## Como ejecutar

```bash
sqlite3 ejercicio-79.db < ddl/schema.sql
sqlite3 ejercicio-79.db < dml/inserts.sql
sqlite3 ejercicio-79.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
