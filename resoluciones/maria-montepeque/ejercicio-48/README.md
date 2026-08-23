# Ejercicio 48: FOREIGN KEY Nivel Intermedio

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-17

## Tema central

FOREIGN KEY

## Descripcion del problema

Sistema de prestamos de libros tecnicos de una biblioteca: `autores`, `libros` y `prestamos`. Nivel intermedio: profundiza el tema del ejercicio 47 mostrando que la misma restriccion `FOREIGN KEY` puede comportarse de forma distinta segun la accion `ON DELETE` que se declare.

## Tablas y relaciones

- `autores`: catalogo de autores.
- `libros`: catalogo de libros. `libros.id_autor -> autores.id_autor` con `ON DELETE RESTRICT`. `autores` 1—N `libros`.
- `prestamos`: cada prestamo. `prestamos.id_libro -> libros.id_libro` con `ON DELETE CASCADE`. `libros` 1—N `prestamos`.

## Que aprendi sobre FOREIGN KEY

- **La misma idea de FOREIGN KEY, dos comportamientos distintos**: `libros.id_autor` usa `ON DELETE RESTRICT` (proteger el catalogo: no se puede borrar un autor mientras tenga libros), mientras que `prestamos.id_libro` usa `ON DELETE CASCADE` (si un libro se da de baja del catalogo, tiene sentido de negocio borrar tambien su historial de prestamos). La eleccion no es tecnica, es una decision de negocio que se declara con la sintaxis `ON DELETE ...`.
- **`ON DELETE CASCADE` en accion**: al eliminar "Design Patterns" (`id_libro = 5`) del catalogo, sus 2 prestamos desaparecieron automaticamente, sin necesidad de borrarlos a mano primero. Lo confirme comparando el total de prestamos antes (10) y despues (8) de ese `DELETE`, y verificando que `SELECT * FROM prestamos WHERE id_libro = 5` ya no devuelve ninguna fila.
- **`ON DELETE RESTRICT` sigue protegiendo donde corresponde**: intentar borrar a "Robert Martin" (`id_autor = 1`), que todavia tiene 2 libros en el catalogo, falla con `FOREIGN KEY constraint failed`. Aqui SI se protege el dato, a diferencia de la cascada anterior.
- **FOREIGN KEY encadenadas**: el reporte final (`prestamos -> libros -> autores`) demuestra que la integridad se mantiene a lo largo de toda la cadena de relaciones, no solo en la relacion inmediata.

## Como ejecutar

```bash
sqlite3 ejercicio-48.db < ddl/schema.sql
sqlite3 ejercicio-48.db < dml/inserts.sql
sqlite3 ejercicio-48.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
