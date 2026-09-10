# Ejercicio 102: Procedimientos almacenados Nivel Intermedio

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-31

## Tema central

Procedimientos almacenados

> **Nota:** SQLite no soporta procedimientos almacenados nativos. Como
> en el ejercicio 101, aqui se documenta el procedimiento teorico para
> MySQL y PostgreSQL (comentado en `ddl/schema.sql`) y se implementa
> la alternativa ejecutable en SQLite con un `TRIGGER`. A diferencia
> del ejercicio 101 (que encadenaba un segundo `UPDATE` automatico),
> aqui el trigger aplica una VALIDACION de negocio antes de insertar y
> cancela la operacion si la regla no se cumple, que es otro uso
> tipico de un procedimiento almacenado.

## Descripcion del problema

Una biblioteca tecnica necesita impedir que se registre un prestamo de
un libro que ya no tiene copias disponibles (todas sus unidades estan
prestadas), sin depender de que la persona que registra el prestamo
revise el stock a mano antes de insertar.

## Tablas y relaciones

- `autores`: catalogo de autores.
- `libros`: catalogo de libros, cada uno con su `stock_total`.
- `prestamos`: tabla principal, cada fila es un prestamo con su
  `estado` (`prestado` o `devuelto`). `autores` 1—N `libros`;
  `libros` 1—N `prestamos`.

## Uso de Procedimientos almacenados

En `ddl/schema.sql`:

1. Se documenta, como comentario, el procedimiento teorico
   `registrar_prestamo` para MySQL (con `SIGNAL SQLSTATE '45000'`
   cuando no hay copias disponibles) y para PostgreSQL (con
   `RAISE EXCEPTION`), que calcula la disponibilidad del libro y, solo
   si es mayor a 0, inserta el prestamo.
2. Como alternativa SI ejecutable en SQLite, el trigger
   `trg_validar_disponibilidad_prestamo` (`BEFORE INSERT ON
   prestamos`) hace la misma validacion: calcula `stock_total` menos
   los prestamos con `estado = 'prestado'` para el libro que se esta
   insertando, y si el resultado es menor o igual a 0, aborta la
   operacion completa con `RAISE(ABORT, 'No hay copias disponibles
   para este libro')`, antes de que la fila llegue a insertarse.
3. La consulta 5 en `dql/consultas.sql` demuestra el caso exitoso: un
   `INSERT` sobre "Refactoring" (que si tenia copias disponibles) pasa
   la validacion del trigger sin problema y queda registrado.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `libros.id_autor`, `prestamos.id_libro`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `autores.nombre_autor`.
- `CHECK`: `libros.stock_total > 0`,
  `prestamos.estado IN ('prestado', 'devuelto')`.
- `DEFAULT` en `prestamos.estado`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dql/consultas.sql`)

Intentar registrar un prestamo de "Clean Architecture" (id_libro = 1),
que ya tiene su unica copia prestada (0 disponibles). Se verifico con
Python (`sqlite3`) que `trg_validar_disponibilidad_prestamo` aborta la
operacion con el error `No hay copias disponibles para este libro`, y
el `INSERT` no llega a insertar ninguna fila. Es la misma validacion
que, en el procedimiento almacenado teorico, se resolveria con un
`SIGNAL SQLSTATE` (MySQL) o un `RAISE EXCEPTION` (PostgreSQL) antes de
ejecutar el `INSERT` interno.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-102.db < ddl/schema.sql
sqlite3 ejercicio-102.db < dml/inserts.sql
sqlite3 ejercicio-102.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
