# Ejercicio 50: UNIQUE Nivel Basico

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-17

## Tema central

UNIQUE

## Descripcion del problema

Sistema de prestamos de libros tecnicos de una biblioteca: `autores`, `libros` (tabla principal) y `prestamos`. El ejercicio se enfoca en `UNIQUE` como restriccion para evitar duplicados en un campo candidato (el ISBN de un libro) que no es la llave primaria.

## Que aprendi sobre UNIQUE

- **UNIQUE evita duplicados en una columna que no es la PRIMARY KEY**: `libros.isbn` es `UNIQUE`, mientras que `id_libro` (autoincremental) sigue siendo la `PRIMARY KEY`. Son restricciones distintas que pueden coexistir: una identifica la fila (`PRIMARY KEY`), la otra evita que un valor de negocio se repita (`UNIQUE`).
- **UNIQUE permite varios `NULL`, a diferencia de `NOT NULL` o de una `PRIMARY KEY`**: inserte dos libros sin ISBN ("Manual interno de Java" y "Guia rapida de Git"), ambos con `isbn = NULL`, y los dos se guardaron sin problema. SQLite trata cada `NULL` como "desconocido", y dos valores desconocidos nunca se consideran iguales entre si para efectos de `UNIQUE`. Esto es util cuando el dato candidato a `UNIQUE` no siempre esta disponible.
- **Confirme la unicidad con una consulta, no solo con el intento fallido**: comparando `COUNT(isbn)` (4, los libros que si tienen ISBN) contra `COUNT(DISTINCT isbn)` (tambien 4), verifique que no hay ningun ISBN repetido entre los libros catalogados — si `UNIQUE` no estuviera funcionando, estos dos numeros podrian diferir.
- Los dos casos comentados muestran `UNIQUE` en dos columnas distintas: repetir un ISBN existente en `libros`, y repetir el nombre de un autor ya registrado en `autores`. Ambos fallan con `UNIQUE constraint failed` sobre la columna correspondiente.

## Como ejecutar

```bash
sqlite3 ejercicio-50.db < ddl/schema.sql
sqlite3 ejercicio-50.db < dml/inserts.sql
sqlite3 ejercicio-50.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
