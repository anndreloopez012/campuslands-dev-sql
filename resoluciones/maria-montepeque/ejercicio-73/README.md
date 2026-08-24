# Ejercicio 73: INSERT Nivel Aplicado

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Tema central

INSERT

## Descripcion del problema

Una bodega de dispositivos tecnologicos necesita llevar el inventario
de sus productos sin depender de un numero de stock que alguien tenga
que actualizar a mano. En vez de eso, cada entrada y cada salida de
bodega se registra como un movimiento, y el stock real de cualquier
producto se calcula sumando sus entradas y restando sus salidas: un
caso de negocio completo, con reporte final, propio del nivel
aplicado.

## Tablas y relaciones

- `categorias`: catalogo de categorias de producto.
- `productos`: catalogo de productos, cada uno de una categoria.
- `movimientos`: historial de entradas y salidas de bodega.
  `categorias` 1—N `productos`; `productos` 1—N `movimientos`.

## Uso de INSERT

En `dml/inserts.sql`:

1. `INSERT` de una sola fila: se registra la primera categoria.
2. `INSERT` multiple (`VALUES (...), (...)`): el resto de categorias,
   los 5 productos, las 5 entradas iniciales de bodega y las 5
   salidas por ventas o uso interno.
3. `INSERT` omitiendo `tipo_movimiento`: el reabastecimiento de
   Laptop Pro 14 se inserta sin indicar el tipo, y queda en su
   `DEFAULT` (`'entrada'`).

La consulta 5 en `dql/consultas.sql` es el reporte final del caso de
negocio: reconstruye el stock de cada producto solo a partir de los
`INSERT` de `movimientos`, sin que exista ninguna columna de stock
guardada aparte. Esto confirma que todos los `INSERT` cumplieron su
proposito.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `productos.id_categoria`, `movimientos.id_producto`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `categorias.nombre_categoria`, `productos.nombre_producto`.
- `CHECK`: `productos.precio_unitario >= 0`,
  `movimientos.tipo_movimiento IN (...)`, `movimientos.cantidad > 0`.
- `DEFAULT` en `movimientos.tipo_movimiento` y `fecha_movimiento`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Casos que fallan / no recomendables (comentados en `dml/inserts.sql`)

Uno por cada restriccion, validado con Python (`sqlite3`):

- Repetir `nombre_producto` -> `UNIQUE constraint failed`.
- Apuntar a un `id_producto` que no existe -> `FOREIGN KEY constraint failed`.
- Registrar una `cantidad` negativa -> `CHECK constraint failed`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos finales: 3 categorias, 5 productos, 11 movimientos (6
  entradas, 5 salidas). Stock final verificado: Laptop Pro 14 = 12,
  Laptop Air 13 = 6, Mouse Inalambrico = 38, Teclado Mecanico = 23,
  Disco SSD 1TB = 16.

## Como ejecutar

```bash
sqlite3 ejercicio-73.db < ddl/schema.sql
sqlite3 ejercicio-73.db < dml/inserts.sql
sqlite3 ejercicio-73.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
