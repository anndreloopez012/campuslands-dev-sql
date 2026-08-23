# Ejercicio 26: Normalizacion Tienda

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-06

## Descripcion del problema

Una tienda necesita reemplazar el registro manual de clientes, categorias, productos y compras (con datos repetidos en hojas sueltas) por una base de datos relacional normalizada que evite duplicidad y permita calcular ingresos por categoria de forma confiable.

## Tablas y relaciones

- `clientes`: catalogo de clientes que realizan compras (nombre, correo).
- `categorias`: catalogo de categorias de producto (nombre).
- `productos`: producto asociado a una categoria (nombre, precio). `categorias` 1—N `productos`.
- `compras`: compra de un producto realizada por un cliente (cantidad, fecha). `clientes` 1—N `compras` y `productos` 1—N `compras`.

## Normalizacion aplicada

- **1FN**: todos los atributos son atomicos (sin listas ni valores repetidos en una misma columna).
- **2FN**: cada tabla tiene una llave primaria simple y todos los atributos dependen completamente de ella (no hay dependencias parciales).
- **3FN**: se separo `categorias` de `productos` para eliminar la dependencia transitiva que existiria si el nombre de la categoria se repitiera en cada producto; los datos del cliente tampoco se repiten en cada compra, solo se referencian con `id_cliente`.

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 4 tablas.
- `FOREIGN KEY`: `productos.id_categoria`, `compras.id_cliente`, `compras.id_producto`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `clientes.correo`, `categorias.nombre`.
- `CHECK`: `productos.precio > 0`, `compras.cantidad > 0`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3` disponible en el entorno:

- Datos base: 5 clientes, 5 categorias, 5 productos, 10 compras.
- Tras aplicar `operaciones.sql`: 6 clientes, 5 categorias, 5 productos y 9 compras (2 insertadas, 2 eliminadas).
- Las 2 operaciones comentadas en `dml/operaciones.sql` fallan al descomentarlas y ejecutarlas: una por `UNIQUE (clientes.correo)` y otra por `CHECK (compras.cantidad > 0)`.
- Consulta de decision de negocio (categoria con mayores ingresos totales): `Electronica` con 540.00.

## Como ejecutar

```bash
sqlite3 ejercicio-26.db < ddl/schema.sql
sqlite3 ejercicio-26.db < dml/inserts.sql
sqlite3 ejercicio-26.db < dml/operaciones.sql
sqlite3 ejercicio-26.db < dql/consultas.sql
```
