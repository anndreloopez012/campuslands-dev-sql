# Evidencias - Ejercicio 74

## Tema

UPDATE

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-74.db < ddl/schema.sql
sqlite3 ejercicio-74.db < dml/inserts.sql
sqlite3 ejercicio-74.db < dql/consultas.sql
```

## Resultados

Estado final tras `dml/inserts.sql` (que incluye los 4 `UPDATE` de
validacion sobre las 4 partidas insertadas todas en `'programada'`
con 0-0):

```text
id_partida | equipo_local | equipo_visitante | fecha_partida | puntaje_local | puntaje_visitante | estado
1           | 1              | 2                  | 2026-08-01       | 2                 | 1                     | jugada
2           | 3              | 4                  | 2026-08-01       | 2                 | 2                     | jugada
3           | 2              | 1                  | 2026-08-08       | 0                 | 0                     | cancelada
4           | 4              | 3                  | 2026-08-08       | 0                 | 0                     | cancelada
```

**Caso comentado verificado:**

- `UPDATE partidas SET estado = 'suspendida' WHERE id_partida = 1;` → `CHECK constraint failed: estado IN ('programada', 'jugada', 'cancelada')`.

**4. Resumen: partidas por estado:**

```text
estado         total
cancelada       2
jugada          2
```

**5. Validacion especifica de UPDATE:**

```text
id_partida | puntaje_local | puntaje_visitante | estado
1           | 2                 | 1                     | jugada
3           | 0                 | 0                     | cancelada
4           | 0                 | 0                     | cancelada
```

La partida 1 llego a 3-1 con el primer `UPDATE`, y quedo en 2-1
despues del `UPDATE` por expresion (`puntaje_local = puntaje_local - 1`)
que anulo un gol tras revision en video. Las partidas 3 y 4 quedaron
`'cancelada'` con un solo `UPDATE` multiple (`WHERE id_partida IN (3, 4)`).

## Aprendizaje

`UPDATE` con `WHERE` modifica exactamente las filas que cumplen la
condicion, ni una mas: el `UPDATE` de la partida 1 nunca toco las
partidas 2, 3 ni 4. Un mismo `UPDATE` puede afectar varias filas a la
vez si el `WHERE` las agrupa (`IN (3, 4)`), sin tener que repetir la
sentencia. Ademas, `SET columna = columna - 1` demuestra que `UPDATE`
puede calcular el nuevo valor a partir del valor actual, en vez de
tener que escribir el resultado final a mano; eso es justo lo que
permitio corregir el marcador de la partida 1 sin necesitar saber de
antemano cual iba a quedar el numero exacto.
