# Evidencias - Ejercicio 96

## Tema

JOIN

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-96.db < ddl/schema.sql
sqlite3 ejercicio-96.db < dml/inserts.sql
sqlite3 ejercicio-96.db < dql/consultas.sql
```

## Resultados

**1. INNER JOIN de las 3 tablas (5 filas, una por inscripcion):**

```text
id_inscripcion   nombre_camper    nombre_ruta     fecha_inscripcion   estado
1                  Ana Lopez        Ruta Backend     2026-08-01          activo
2                  Byron Ramirez    Ruta Frontend    2026-08-02          activo
3                  Carla Gomez      Ruta Backend     2026-08-03          retirado
4                  Diego Torres     Ruta DevOps      2026-08-04          activo
5                  Fernando Diaz    Ruta Frontend    2026-08-05          retirado
```

**5. Campers sin ninguna inscripcion (LEFT JOIN + WHERE ... IS NULL):**

```text
nombre_camper
Elena Ruiz
```

Verificacion manual: de los 6 campers registrados, solo "Elena Ruiz"
no aparece en `inscripciones`; los otros 5 tienen al menos una fila.

**Caso comentado verificado (CHECK):**

- `INSERT INTO inscripciones (..., estado) VALUES (1, 1, '2026-08-06', 'suspendido');` → `CHECK constraint failed: estado IN ('activo', 'retirado', 'completado')`.

**Caso comentado verificado (LEFT JOIN + WHERE sobre tabla derecha):**

```text
SELECT c.nombre_camper, i.estado
FROM campers c
LEFT JOIN inscripciones i ON i.id_camper = c.id_camper
WHERE i.estado = 'activo';
```

```text
nombre_camper   estado
Ana Lopez         activo
Byron Ramirez     activo
Diego Torres      activo
```

Solo 3 filas, en vez de los 6 campers esperados. "Elena Ruiz" (sin
inscripciones), "Carla Gomez" y "Fernando Diaz" (solo con
inscripciones `retirado`) desaparecen porque `WHERE i.estado =
'activo'` descarta cualquier fila con `estado` en `NULL` o distinto de
`'activo'`, incluyendo las que el `LEFT JOIN` genero justamente para
conservar a los campers sin coincidencia.

## Aprendizaje

`INNER JOIN` combina filas de varias tablas que cumplen la condicion
`ON`; con 3 tablas, basta encadenar dos `INNER JOIN` para traducir ids
a nombres legibles. `LEFT JOIN` conserva todas las filas de la tabla
izquierda aunque no tengan coincidencia, rellenando con `NULL` las
columnas de la derecha; por eso filtrar por `columna_derecha IS NULL`
despues de un `LEFT JOIN` es la forma correcta de encontrar registros
sin relacion (aqui, campers sin inscripciones). Pero si en cambio se
filtra con `WHERE columna_derecha = 'algun_valor'`, esa condicion
descarta tambien las filas con `NULL` que el `LEFT JOIN` genero, y el
resultado termina siendo identico al de un `INNER JOIN`: cualquier
condicion sobre la tabla derecha que no sea "verificar NULL" debe ir
en el `ON`, no en el `WHERE`, si se quiere conservar el comportamiento
de `LEFT JOIN`.
