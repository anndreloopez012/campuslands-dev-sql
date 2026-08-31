# Ejercicio 95: JOIN Nivel Basico

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-31

## Tema central

JOIN

## Descripcion del problema

Una bodega de dispositivos tecnologicos necesita listar sus productos
junto con el nombre de su categoria, y tambien necesita ver el
catalogo completo de categorias, incluyendo las que todavia no tienen
ningun producto registrado.

## Tablas y relaciones

- `categorias`: catalogo de categorias de producto.
- `productos`: tabla principal, cada producto pertenece a una
  categoria. `categorias` 1—N `productos`.

## Uso de JOIN

En `dql/consultas.sql`:

1. `INNER JOIN` (consulta 1): combina cada producto con su categoria;
   solo aparecen categorias que tienen al menos un producto.
2. `LEFT JOIN` (consulta 5): parte de `categorias` (tabla izquierda) y
   combina con `productos`; como se conserva toda fila de la
   izquierda aunque no tenga pareja, la categoria "Redes" (sin
   productos) tambien aparece en el resultado, con las columnas de
   `productos` en `NULL`. Esto demuestra la diferencia central entre
   `INNER JOIN` (solo coincidencias) y `LEFT JOIN` (todo lo de la
   izquierda, tenga o no coincidencia).

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 2 tablas.
- `FOREIGN KEY`: `productos.id_categoria`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `categorias.nombre_categoria`.
- `CHECK`: `productos.precio_unitario >= 0`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dql/consultas.sql`)

`JOIN` implicito de estilo antiguo (`FROM productos p, categorias c`)
sin ninguna condicion de union (`ON` o `WHERE` equivalente). SQLite no
lanza error, pero se verifico con Python (`sqlite3`) que genera un
producto cartesiano: cada uno de los 5 productos se combina con las 4
categorias, devolviendo 20 filas en vez de las 5 filas correctas de la
consulta 1, mezclando productos con categorias a las que no
pertenecen.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-95.db < ddl/schema.sql
sqlite3 ejercicio-95.db < dml/inserts.sql
sqlite3 ejercicio-95.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
