# Ejercicio 77: DELETE Nivel Basico

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Tema central

DELETE

## Descripcion del problema

Una bodega de dispositivos tecnologicos necesita corregir errores de
captura en su historial de movimientos, y tambien dar de baja
productos descontinuados sin perder el historial de lo que ya se
vendio o recibio de ellos. Este ejercicio compara ambos casos: cuando
`DELETE` fisico es seguro, y cuando conviene una baja logica en su
lugar.

## Tablas y relaciones

- `categorias`: catalogo de categorias de producto.
- `productos`: catalogo de productos, con una bandera `activo` para
  la baja logica.
- `movimientos`: historial de entradas y salidas de bodega.
  `categorias` 1—N `productos`; `productos` 1—N `movimientos`.

## Uso de DELETE

En `dml/inserts.sql`:

1. `DELETE` real (baja fisica): un movimiento de Mouse Inalambrico se
   cargo dos veces por error de digitacion. Como `movimientos` no
   tiene dependientes, es seguro eliminar de verdad la fila duplicada
   con `WHERE id_movimiento = 6`.
2. Baja logica (sin `DELETE`): Teclado Mecanico se descontinua, pero
   ya tiene un movimiento asociado por `FOREIGN KEY`. En vez de
   intentar borrarlo, se marca `activo = 0` con `UPDATE`, conservando
   el historial.

La consulta 5 en `dql/consultas.sql` confirma que el movimiento
duplicado ya no existe, y que el resto de movimientos del mismo
producto sigue intacto.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `productos.id_categoria`, `movimientos.id_producto`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `categorias.nombre_categoria`, `productos.nombre_producto`.
- `CHECK`: `productos.precio_unitario >= 0`, `productos.activo IN (0, 1)`,
  `movimientos.tipo_movimiento IN (...)`, `movimientos.cantidad > 0`.
- `DEFAULT` en `productos.activo`, `movimientos.tipo_movimiento` y
  `fecha_movimiento`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dml/inserts.sql`)

`DELETE FROM productos WHERE id_producto = 4;` falla porque Teclado
Mecanico todavia tiene un movimiento en `movimientos` que depende de
el por `FOREIGN KEY`. Se valido con Python (`sqlite3`): lanza
`FOREIGN KEY constraint failed`. Esto es exactamente lo que justifica
usar baja logica (`UPDATE activo = 0`) en vez de `DELETE` para
productos que ya tienen historial.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos finales: 5 movimientos (sin el duplicado), 4 productos
  activos y 1 inactivo (Teclado Mecanico, dado de baja logica).

## Como ejecutar

```bash
sqlite3 ejercicio-77.db < ddl/schema.sql
sqlite3 ejercicio-77.db < dml/inserts.sql
sqlite3 ejercicio-77.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
