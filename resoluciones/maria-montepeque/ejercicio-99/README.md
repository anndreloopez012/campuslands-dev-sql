# Ejercicio 99: Vistas Nivel Intermedio

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-31

## Tema central

Vistas

## Descripcion del problema

Una cafeteria necesita varios reportes distintos sobre sus ventas
(por linea de venta, por cliente, por producto), todos basados en la
misma combinacion de clientes, productos y ventas. En vez de repetir
el `JOIN` de las 3 tablas en cada reporte, conviene definirlo una sola
vez como vista.

## Tablas y relaciones

- `clientes`: catalogo de clientes.
- `productos`: catalogo de productos.
- `ventas`: tabla principal, cada fila es una venta de un producto a
  un cliente. `clientes` 1—N `ventas`; `productos` 1—N `ventas`.

## Uso de Vistas

En `ddl/schema.sql` se define `vista_detalle_ventas`, que hace el
`JOIN` de las 3 tablas y calcula `total_linea = cantidad *
precio_unitario`. En `dql/consultas.sql`:

1. La consulta 1 muestra todos los datos principales directamente
   desde la vista, sin escribir el `JOIN`.
2. Las consultas 2, 3 y 4 filtran (`WHERE`), ordenan (`ORDER BY`) y
   agrupan (`GROUP BY`) sobre la vista como si fuera una tabla
   normal.
3. La consulta 5 demuestra el proposito central de las vistas:
   reutiliza `vista_detalle_ventas` para armar un reporte totalmente
   distinto (ingresos totales por producto) sin volver a escribir el
   `JOIN` de `ventas`, `clientes` y `productos`; la vista centraliza
   esa combinacion una sola vez.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `ventas.id_cliente`, `ventas.id_producto`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `clientes.email`, `productos.nombre_producto`.
- `CHECK`: `productos.precio_unitario >= 0`, `ventas.cantidad > 0`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dql/consultas.sql`)

Crear una vista que referencia una columna que no existe
(`total_calculado`, que no esta en `ventas`). SQLite usa evaluacion
perezosa para las vistas: el `CREATE VIEW` se ejecuta sin ningun error
aunque la columna no exista, porque SQLite no valida el `SELECT`
interno en ese momento. El problema aparece recien al consultar la
vista: se verifico con Python (`sqlite3`) que
`SELECT * FROM vista_ventas_mal` falla con el error
`no such column: total_calculado`. La leccion practica es probar
siempre una vista nueva con un `SELECT` justo despues de crearla, en
vez de asumir que un `CREATE VIEW` sin errores significa que esta bien
definida.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-99.db < ddl/schema.sql
sqlite3 ejercicio-99.db < dml/inserts.sql
sqlite3 ejercicio-99.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
