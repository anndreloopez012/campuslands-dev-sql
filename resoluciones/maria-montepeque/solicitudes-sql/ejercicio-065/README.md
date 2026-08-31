# Ejercicio 065: Solicitud de cliente - Laboratorio Quimico

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-21

## Que entendi de la solicitud

El laboratorio no sabe hablar en terminos de tablas: solo describe su
operacion diaria (formulas, muestras, reactivos y tecnicos). Necesita
una base de datos que permita consultar muestras, corregir su estado,
registrar resultados y sacar reportes, como saber que reactivo se usa
mas o en que formula conviene seguir invirtiendo. El detalle completo
del analisis esta en
[`analisis/requerimiento.md`](analisis/requerimiento.md).

## Tablas y por que se crearon

- `tecnicos`: catalogo de personal del laboratorio.
- `formulas`: catalogo de formulas que se prueban.
- `reactivos`: catalogo de sustancias usadas en los analisis.
- `muestras`: tabla transaccional central; relaciona formula, reactivo
  y tecnico, con fecha y estado.
- `resultados`: se separa de `muestras` porque tiene su propio dato
  numerico (valor medido) y una decision de aprobacion; relacion 1:1
  con `muestras` mediante `UNIQUE (id_muestra)`.

## Como se relacionan

`tecnicos` 1—N `muestras`, `formulas` 1—N `muestras`, `reactivos` 1—N
`muestras`, `muestras` 1—1 `resultados`.

## Datos de prueba

3 tecnicos, 4 formulas, 4 reactivos, 10 muestras (con estados variados)
y 6 resultados.

## Operaciones (`dml/operaciones.sql`)

- `UPDATE`: una muestra `'en_analisis'` termina y pasa a
  `'finalizada'`.
- `UPDATE`: se corrige la aprobacion de un resultado tras una segunda
  revision.
- `DELETE` controlado (con `WHERE`): se elimina una muestra
  `'pendiente'` que el cliente cancelo.
- Caso comentado que debe fallar: eliminar un reactivo con muestras
  asociadas viola la `FOREIGN KEY` de `muestras.id_reactivo`.

## Consultas que responden al cliente

1. Todas las muestras con formula, reactivo y tecnico (`JOIN`).
2. Muestras filtradas por estado (`pendiente`, `en_analisis`,
   `finalizada`).
3. Ranking de reactivos por frecuencia de uso (`GROUP BY` +
   `ORDER BY`).
4. Muestras ordenadas por fecha, de la mas reciente a la mas antigua.
5. Reporte de decision de negocio: formula con mas muestras aprobadas,
   filtrando las que superan 1 muestra aprobada (`GROUP BY` +
   `HAVING`).

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` ->
`consultas`) con Python (modulo `sqlite3`), ya que no se tenia el
binario `sqlite3` disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos base: 3 tecnicos, 4 formulas, 4 reactivos, 10 muestras, 6
  resultados.
- Tras `operaciones.sql`: 9 muestras (se elimino la cancelada).
- Reporte final: "Formula A-12" es la de mas muestras aprobadas (4),
  seguida de "Formula B-07" (2).

## Como validar

```bash
sqlite3 ejercicio-065.db < ddl/schema.sql
sqlite3 ejercicio-065.db < dml/inserts.sql
sqlite3 ejercicio-065.db < dml/operaciones.sql
sqlite3 ejercicio-065.db < dql/consultas.sql
```
