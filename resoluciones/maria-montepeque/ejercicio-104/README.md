# Ejercicio 104: Triggers Nivel Basico

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-31

## Tema central

Triggers

## Descripcion del problema

Una biblioteca tecnica necesita un historial de auditoria de cada vez
que cambia el stock de un libro (por prestamos, devoluciones o compra
de copias nuevas), sin que la persona o el sistema que actualiza el
stock tenga que acordarse de registrar ese cambio por separado.

## Tablas y relaciones

- `libros`: tabla principal, con su `stock_total`.
- `auditoria_libros`: guarda un registro por cada cambio de
  `stock_total`, con el valor anterior y el nuevo. `libros` 1—N
  `auditoria_libros`.

## Uso de Triggers

En `ddl/schema.sql` se define `trg_auditar_cambio_stock`
(`AFTER UPDATE OF stock_total ON libros`, con `WHEN OLD.stock_total <>
NEW.stock_total`), que se dispara automaticamente despues de cada
`UPDATE` que cambia el stock de un libro, e inserta una fila en
`auditoria_libros` con `OLD.stock_total` (el valor antes del cambio) y
`NEW.stock_total` (el valor despues). En `dml/inserts.sql`, los 3
`UPDATE` sobre `libros` disparan el trigger 3 veces; en
`dql/consultas.sql`, la consulta 5 confirma que las 3 filas de
`auditoria_libros` existen SOLAS, sin ningun `INSERT` manual sobre esa
tabla en todo el script: ese es el proposito central de un trigger,
automatizar una accion (aqui, la auditoria) ante un evento de la tabla
principal.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 2 tablas.
- `FOREIGN KEY`: `auditoria_libros.id_libro`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `libros.titulo`.
- `CHECK`: `libros.stock_total >= 0`.
- `DEFAULT` en `auditoria_libros.fecha_evento` (`datetime('now')`).
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dql/consultas.sql`)

Crear un trigger `AFTER INSERT` que referencia `OLD`, cuando en un
`INSERT` no existe ninguna fila "anterior" (`OLD` solo tiene sentido
en `UPDATE` y `DELETE`; en `INSERT` solo existe `NEW`). Se verifico
con Python (`sqlite3`) que el `CREATE TRIGGER` en si no falla (SQLite,
igual que con las vistas, no valida el cuerpo del trigger en el
momento de crearlo), pero el primer `INSERT` en `libros` que lo
dispare falla con el error `no such column: OLD.stock_total`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-104.db < ddl/schema.sql
sqlite3 ejercicio-104.db < dml/inserts.sql
sqlite3 ejercicio-104.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
