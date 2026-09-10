# Ejercicio 101: Procedimientos almacenados Nivel Basico

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-31

## Tema central

Procedimientos almacenados

> **Nota:** SQLite no soporta procedimientos almacenados nativos (no
> existe `CREATE PROCEDURE`). Como indica el enunciado, este ejercicio
> documenta el procedimiento en SQL teorico para MySQL y PostgreSQL
> (comentado en `ddl/schema.sql`) y usa un `TRIGGER` como alternativa
> ejecutable en SQLite, ya que es el objeto de SQLite que mas se
> parece en proposito: encapsular varios pasos de logica de negocio
> para que se ejecuten juntos automaticamente.

## Descripcion del problema

Una cafeteria necesita que, cada vez que se registra una venta, el
stock del producto vendido se descuente automaticamente, sin que la
persona que registra la venta tenga que acordarse de hacer un segundo
paso manual (`UPDATE productos SET stock = ...`).

## Tablas y relaciones

- `productos`: catalogo de productos, con su `stock` actual.
- `ventas`: tabla principal, cada fila es una venta de un producto a
  un cliente. `productos` 1—N `ventas`.

## Uso de Procedimientos almacenados

En `ddl/schema.sql`:

1. Se documenta, como comentario, el procedimiento teorico
   `registrar_venta` para MySQL (`DELIMITER $$ ... CREATE PROCEDURE
   ...`) y para PostgreSQL (`CREATE OR REPLACE PROCEDURE ... LANGUAGE
   plpgsql`), que recibe producto, cliente, cantidad y fecha, inserta
   la venta y descuenta el stock en un solo paso reutilizable
   (`CALL registrar_venta(...)`).
2. Como alternativa SI ejecutable en SQLite, se crea el trigger
   `trg_actualizar_stock_venta` (`AFTER INSERT ON ventas`), que hace
   exactamente el segundo paso (`UPDATE productos SET stock = stock -
   NEW.cantidad ...`) automaticamente cada vez que se inserta una
   venta. Quien registra la venta solo ejecuta un `INSERT INTO ventas`
   normal (ver `dml/inserts.sql`); el trigger se encarga del resto,
   igual que haria el procedimiento almacenado al ser llamado.
3. La consulta 5 en `dql/consultas.sql` verifica el resultado: el
   `stock` final de cada producto refleja el descuento acumulado de
   sus ventas, sin que en ningun lugar del script haya un `UPDATE`
   manual escrito sobre `productos`.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 2 tablas.
- `FOREIGN KEY`: `ventas.id_producto`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `productos.nombre_producto`.
- `CHECK`: `productos.precio_unitario >= 0`, `productos.stock >= 0`,
  `ventas.cantidad > 0`.
- `DEFAULT` en `productos.stock`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dql/consultas.sql`)

Intentar crear el procedimiento almacenado directamente en SQLite, con
la sintaxis de MySQL/PostgreSQL (`CREATE PROCEDURE ...`). Se verifico
con Python (`sqlite3`) que SQLite rechaza la sentencia con el error
`near "PROCEDURE": syntax error`, porque `CREATE PROCEDURE` no existe
en su gramatica: SQLite no tiene el concepto de procedimiento
almacenado como objeto de base de datos, solo funciones (limitadas),
vistas y triggers.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-101.db < ddl/schema.sql
sqlite3 ejercicio-101.db < dml/inserts.sql
sqlite3 ejercicio-101.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
