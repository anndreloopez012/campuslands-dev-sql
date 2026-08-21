# Ejercicio 068: Solicitud de cliente - Escuela de Dibujo

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-21

## Que entendi de la solicitud

La escuela de dibujo quiere consultar rankings, totales y casos
pendientes directamente desde la base de datos. Se necesita una base de
datos que permita registrar entregas de obras, corregir su estado al
evaluarlas, y sacar reportes, como saber que alumno tiene mas actividad
o cual tiene el mejor promedio. El detalle completo del analisis esta
en [`analisis/requerimiento.md`](analisis/requerimiento.md).

## Tablas y por que se crearon

- `profesores`: catalogo de docentes.
- `cursos`: catalogo de cursos, cada uno de un profesor.
- `alumnos`: catalogo de estudiantes inscritos.
- `entregas`: tabla transaccional central; un alumno entrega una obra
  para un curso.
- `evaluaciones`: se separa de `entregas` porque tiene su propia nota y
  comentario, y no toda entrega esta evaluada todavia; relacion 1:1
  con `entregas` mediante `UNIQUE (id_entrega)`.

## Como se relacionan

`profesores` 1—N `cursos`; `cursos` 1—N `entregas`; `alumnos` 1—N
`entregas`; `entregas` 1—1 `evaluaciones`.

## Datos de prueba

2 profesores, 3 cursos, 5 alumnos, 10 entregas (con estados variados) y
7 evaluaciones.

## Operaciones (`dml/operaciones.sql`)

- `UPDATE`: una entrega `'pendiente'` se evalua y pasa a `'evaluada'`
  (con su evaluacion correspondiente).
- `UPDATE`: se corrige la nota de una evaluacion tras una segunda
  revision.
- `DELETE` controlado (con `WHERE`): se elimina una entrega
  `'pendiente'` que el alumno retiro.
- Caso comentado que debe fallar: eliminar un alumno con entregas
  asociadas viola la `FOREIGN KEY` de `entregas.id_alumno`.

## Consultas que responden al cliente

1. Todas las entregas con alumno y curso (`JOIN`).
2. Entregas filtradas por estado (`pendiente`, `evaluada`,
   `rechazada`).
3. Ranking de alumnos por numero de entregas (`GROUP BY` +
   `ORDER BY`).
4. Entregas ordenadas por fecha, de la mas reciente a la mas antigua.
5. Reporte de decision de negocio: promedio de notas por alumno, para
   decidir a quien destacar o becar (`GROUP BY` + `HAVING`).

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` ->
`consultas`) con Python (modulo `sqlite3`), ya que no se tenia el
binario `sqlite3` disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos base: 2 profesores, 3 cursos, 5 alumnos, 10 entregas, 7
  evaluaciones.
- Tras `operaciones.sql`: 9 entregas (se elimino la retirada), 8
  evaluaciones (se agrego la de la entrega 4, se corrigio la de la
  entrega 3).
- Reporte final: Alejandra Chinchilla es la alumna con mejor promedio
  (93.5), seguida de Manuel Estrada (87.5).

## Como validar

```bash
sqlite3 ejercicio-068.db < ddl/schema.sql
sqlite3 ejercicio-068.db < dml/inserts.sql
sqlite3 ejercicio-068.db < dml/operaciones.sql
sqlite3 ejercicio-068.db < dql/consultas.sql
```
