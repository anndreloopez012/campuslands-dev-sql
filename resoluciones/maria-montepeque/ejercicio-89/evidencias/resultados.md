# Evidencias - Ejercicio 89

## Tema

GROUP BY

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-89.db < ddl/schema.sql
sqlite3 ejercicio-89.db < dml/inserts.sql
sqlite3 ejercicio-89.db < dql/consultas.sql
```

## Resultados

**4. Total de citas por medico:**

```text
id_medico   total_citas
1             3
2             2
3             2
```

**Caso comentado verificado:**

- `SELECT id_medico, COUNT(*) FROM citas WHERE COUNT(*) > 2 GROUP BY id_medico;` → `misuse of aggregate: COUNT()` (una funcion de agregacion no se puede usar dentro de `WHERE`).

**5. Medicos con promedio de duracion mayor a 30 minutos:**

```text
nombre_medico       total_citas   minutos_totales   promedio_minutos
Dr. Carlos Perez       2               105                52.5
Dra. Marta Lopez       2               70                 35.0
```

Verificacion manual: Dra. Sofia Ramirez (medico 1) tiene 3 citas de
30+20+30=80 minutos, promedio 26.67, por debajo del umbral de 30 y
por eso no aparece en el resultado.

## Aprendizaje

`GROUP BY` agrupa las filas que comparten el mismo valor en la
columna indicada, y las funciones de agregacion (`COUNT`, `SUM`,
`AVG`) calculan un resultado por cada grupo, no por cada fila
individual. `HAVING` filtra esos grupos ya formados (por ejemplo,
solo los medicos con promedio mayor a 30 minutos), mientras que
`WHERE` filtra filas individuales antes de que existan los grupos:
por eso `WHERE` no puede usar una funcion de agregacion como `COUNT()`,
y usarla ahi hace fallar la consulta con "misuse of aggregate".
