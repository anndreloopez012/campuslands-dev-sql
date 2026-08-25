# Solicitud SQL - Ejercicio 085: Biblioteca Sci-Fi

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Solicitud del cliente

Una biblioteca especializada presta libros de ciencia ficcion y
controla devoluciones. El cliente no sabe hablar en terminos de
tablas: solo describe su operacion diaria y espera que se traduzca a
SQL. Pidio convertir esa operacion en una base de datos que permita
consultar datos, corregir estados, registrar movimientos y sacar
reportes utiles.

## Que entendi de la solicitud

A diferencia de versiones mas simples de este mismo caso (donde la
devolucion era solo un cambio de estado dentro de `prestamos`), aqui
se decidio separar `devoluciones` en su propia tabla, porque el
cliente quiere "registrar movimientos" y una devolucion es un
movimiento con su propio detalle (el estado fisico del libro). Es un
nivel 5 (solicitud profesional): ademas del modelo, se pide
interpretar ambiguedad, normalizar datos, documentar decisiones y
crear al menos una vista SQL. El detalle completo del analisis esta en
[analisis/requerimiento.md](analisis/requerimiento.md).

## Que tablas cree y por que

- `autores`: catalogo de autores.
- `libros`: catalogo de libros, cada uno de un autor.
- `lectores`: catalogo de lectores registrados.
- `prestamos`: tabla transaccional, cada prestamo de un libro.
- `devoluciones`: resultado de un prestamo. `UNIQUE (id_prestamo)`
  garantiza una sola devolucion oficial por prestamo.

## Vista SQL

`vista_resumen_prestamos` (definida en
[ddl/schema.sql](ddl/schema.sql)) junta prestamo, lector, libro,
autor y devolucion (si existe) con `LEFT JOIN`, mostrando en un solo
reporte tanto los prestamos activos como los ya devueltos.

## Como se relacionan

`autores` 1:N `libros`; `libros` 1:N `prestamos`; `lectores` 1:N
`prestamos`; `prestamos` 1:1 `devoluciones`. El diagrama esta en
[diagramas/diagrama-er.svg](diagramas/diagrama-er.svg).

## Que datos de prueba use

4 autores, 5 libros, 5 lectores, 6 prestamos y 4 devoluciones
(incluida una cargada por error en el prestamo equivocado). Tambien
un `INSERT` comentado que reproduce el problema de registrar dos
devoluciones para el mismo prestamo y debe fallar. Detalle en
[dml/inserts.sql](dml/inserts.sql).

## Que operaciones de mantenimiento incluyo

En [dml/operaciones.sql](dml/operaciones.sql): un `DELETE` controlado
que corrige la devolucion registrada por error (solo cuando es un
error de captura confirmado) y un `UPDATE` de estado (un prestamo que
paso su fecha esperada se marca `atrasado`).

## Que consultas responden al cliente

En [dql/consultas.sql](dql/consultas.sql): el resumen completo de
prestamos usando la vista, en que estado esta cada prestamo, que
lector tiene mas prestamos, los prestamos ordenados por fecha, y un
reporte con `GROUP BY` + `HAVING` (tambien sobre la vista) de que
autor tiene mas prestamos en total, para decidir de cual comprar mas
ejemplares.

## Evidencias

Resultados de ejecutar todo en orden, incluyendo la verificacion del
caso de duplicado y de las operaciones de mantenimiento, en
[evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-085.db < ddl/schema.sql
sqlite3 ejercicio-085.db < dml/inserts.sql
sqlite3 ejercicio-085.db < dml/operaciones.sql
sqlite3 ejercicio-085.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite`, `.sqlite3` ni `.dump`.
