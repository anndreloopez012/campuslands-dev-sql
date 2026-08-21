# Ejercicio 66: ALTER TABLE Nivel Intermedio

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-21

## Descripcion del problema

Las tablas `autores`, `libros` y `prestamos` de una biblioteca tecnica
se crearon con la estructura minima. Con el tiempo la biblioteca pidio
clasificar los libros por categoria, saber cuantos ejemplares quedan
disponibles, llevar el estado de cada prestamo, y usar nombres de tabla
y de columna mas claros, todo sin perder los libros y prestamos ya
registrados.

## Tablas y relaciones

- `escritores` (antes `autores`): catalogo de autores.
- `libros`: catalogo de libros tecnicos. `escritores` 1—N `libros`.
- `prestamos`: prestamo de un libro a un lector. `libros` 1—N
  `prestamos`.

## Uso de ALTER TABLE

En `ddl/schema.sql`, despues de crear las 3 tablas e insertar datos con
la estructura original:

1. `ALTER TABLE libros ADD COLUMN categoria ... DEFAULT 'programacion' CHECK (...)`:
   agrega una columna nueva con `DEFAULT`.
2. `ALTER TABLE libros ADD COLUMN ejemplares_disponibles ... DEFAULT 1 CHECK (...)`:
   agrega otra columna nueva.
3. `ALTER TABLE prestamos ADD COLUMN estado ... DEFAULT 'prestado' CHECK (...)`:
   agrega el estado del prestamo en otra tabla distinta.
4. `ALTER TABLE prestamos RENAME COLUMN prestatario TO nombre_prestatario`:
   renombra una columna.
5. `ALTER TABLE autores RENAME TO escritores`: renombra toda la tabla.
   SQLite actualizo automaticamente la `FOREIGN KEY` de
   `libros.id_autor`, que sigue apuntando correctamente a la tabla
   renombrada (ver consulta 5c en `dql/consultas.sql`).

Los 2 libros y los 2 prestamos creados antes de los `ALTER TABLE`
conservaron sus datos originales y quedaron con las columnas nuevas
tomadas del `DEFAULT` (ver consulta 5 en `dql/consultas.sql`).

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `libros.id_autor`, `prestamos.id_libro`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `escritores.nombre`.
- `CHECK`: `categoria IN (...)`, `ejemplares_disponibles >= 0`,
  `estado IN (...)`.
- `DEFAULT` en las columnas agregadas por `ALTER TABLE`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `ddl/schema.sql`)

`ALTER TABLE escritores ADD COLUMN nacionalidad TEXT NOT NULL;` falla
porque la tabla ya tiene filas y no hay `DEFAULT` que asignarles. Se
valido ejecutandolo con Python (`sqlite3`): lanza
`OperationalError: Cannot add a NOT NULL column with default value NULL`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos finales: 3 escritores, 3 libros, 3 prestamos (2 originales que
  sobrevivieron los `ALTER TABLE`, 1 nuevo con estructura completa).

## Como ejecutar

```bash
sqlite3 ejercicio-66.db < ddl/schema.sql
sqlite3 ejercicio-66.db < dml/inserts.sql
sqlite3 ejercicio-66.db < dql/consultas.sql
```
