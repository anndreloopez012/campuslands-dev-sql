# Ejercicio 64: AUTO_INCREMENT Nivel Aplicado

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-21

## Descripcion del problema

Una biblioteca tecnica presta libros de programacion, redes, bases de
datos y sistemas operativos. Cada prestamo se identifica con un numero
de comprobante que no debe repetirse nunca, ni siquiera si un
comprobante se anula por un error de captura. Se necesita, ademas, un
reporte que ayude a decidir que libro conviene comprar en mas
ejemplares.

## Tablas y relaciones

- `autores`: catalogo de autores (nombre).
- `libros`: catalogo de libros tecnicos, con categoria y ejemplares
  disponibles. `autores` 1—N `libros`.
- `prestamos`: prestamo de un libro a un prestatario (fecha, estado).
  `libros` 1—N `prestamos`.

## Uso de AUTO_INCREMENT

En SQLite el equivalente de `AUTO_INCREMENT` es
`INTEGER PRIMARY KEY AUTOINCREMENT`. Se aplico en las 3 tablas, pero es
especialmente importante en `prestamos.id_prestamo`, porque ese numero
funciona como comprobante de prestamo: si se reutilizara despues de
anular un registro, dos prestamos distintos podrian terminar
compartiendo el mismo numero de comprobante.

Para demostrarlo:

1. Se registran 6 prestamos (ids 1 a 6).
2. Se elimina el prestamo con `id_prestamo = 3` (comprobante emitido por
   error dos veces el mismo dia).
3. Se registra un prestamo nuevo: recibe el `id_prestamo = 7`, **no** el
   3 que quedo libre.

## Caso de negocio (nivel aplicado)

Consulta 6 en `dql/consultas.sql`: se calcula que libro tiene mas
prestamos historicos, como apoyo para decidir si conviene comprar mas
ejemplares. En los datos de prueba, "Clean Code" es el libro con mas
prestamos (2).

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `libros.id_autor`, `prestamos.id_libro`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `autores.nombre`.
- `CHECK`: `libros.categoria IN (...)`, `libros.ejemplares_disponibles >= 0`,
  `prestamos.estado IN (...)`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla (comentado en `dml/inserts.sql`)

`INSERT INTO prestamos (id_libro, prestatario) VALUES (999, 'Ingrid Say');`
falla porque el `id_libro = 999` no existe (viola la `FOREIGN KEY`). Se
valido ejecutandolo con Python (`sqlite3`): lanza
`IntegrityError: FOREIGN KEY constraint failed`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con Python
(modulo `sqlite3`), ya que no se tenia el binario `sqlite3` disponible en
el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos finales: 3 autores, 6 libros, 6 prestamos (ids 1, 2, 4, 5, 6, 7
  -- el comprobante 3 nunca se reutilizo).

## Como ejecutar

```bash
sqlite3 ejercicio-64.db < ddl/schema.sql
sqlite3 ejercicio-64.db < dml/inserts.sql
sqlite3 ejercicio-64.db < dql/consultas.sql
```
