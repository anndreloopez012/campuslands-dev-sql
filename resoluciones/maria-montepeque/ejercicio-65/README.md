# Ejercicio 65: ALTER TABLE Nivel Basico

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-21

## Descripcion del problema

La tabla `productos` de una cafeteria se creo originalmente solo con
nombre y precio. Con el tiempo el negocio pidio clasificar los
productos por categoria, saber si siguen a la venta, y usar un nombre
de columna mas claro para el precio, todo sin perder los productos que
ya estaban registrados.

## Tabla principal

- `productos`: version inicial con `id_producto`, `nombre` y `precio`.
  Se modifica en 3 pasos con `ALTER TABLE` hasta llegar a su estructura
  final.

## Uso de ALTER TABLE

En `ddl/schema.sql`, despues de crear la tabla e insertar 3 productos
con la estructura original:

1. `ALTER TABLE productos ADD COLUMN categoria ... DEFAULT 'bebida' CHECK (...)`:
   agrega una columna nueva con `DEFAULT`, para que las filas ya
   existentes queden validas de inmediato.
2. `ALTER TABLE productos ADD COLUMN disponible ... DEFAULT 1 CHECK (...)`:
   agrega otra columna nueva, tambien con `DEFAULT`.
3. `ALTER TABLE productos RENAME COLUMN precio TO precio_unitario`:
   renombra una columna existente sin perder sus datos.

Los 3 productos originales conservaron su precio (ahora en
`precio_unitario`) y recibieron `categoria = 'bebida'` y
`disponible = 1` por los `DEFAULT` de cada `ALTER TABLE` (ver consulta 5
en `dql/consultas.sql`).

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental.
- `NOT NULL` en todas las columnas.
- `UNIQUE`: `productos.nombre`.
- `CHECK`: `precio_unitario > 0`, `categoria IN (...)`,
  `disponible IN (0, 1)`.
- `DEFAULT` en `categoria` y `disponible`, agregados junto con las
  columnas.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `ddl/schema.sql`)

`ALTER TABLE productos ADD COLUMN codigo_interno TEXT NOT NULL;` falla
porque la tabla ya tiene filas y SQLite no sabe que valor poner en esa
columna para las filas existentes (una columna `NOT NULL` agregada por
`ALTER TABLE` necesita un `DEFAULT`). Se valido ejecutandolo con Python
(`sqlite3`): lanza
`OperationalError: Cannot add a NOT NULL column with default value NULL`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos finales: 4 productos (3 originales que sobrevivieron los
  `ALTER TABLE`, 1 nuevo creado ya con la estructura completa).

## Como ejecutar

```bash
sqlite3 ejercicio-65.db < ddl/schema.sql
sqlite3 ejercicio-65.db < dml/inserts.sql
sqlite3 ejercicio-65.db < dql/consultas.sql
```
