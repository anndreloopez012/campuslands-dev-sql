# Evidencias - Ejercicio 068

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-068.db < ddl/schema.sql
sqlite3 ejercicio-068.db < dml/inserts.sql
sqlite3 ejercicio-068.db < dml/operaciones.sql
sqlite3 ejercicio-068.db < dql/consultas.sql
```

## Resultados importantes

Conteo de datos base (despues de `inserts.sql`):

```text
profesores -> 2
cursos -> 3
alumnos -> 5
entregas -> 10
evaluaciones -> 7
```

Caso que debe fallar - segunda evaluacion para la misma entrega (`UNIQUE`):

```text
Fallo como se esperaba: UNIQUE constraint failed: evaluaciones.id_entrega
```

Despues de `operaciones.sql`:

```text
entregas -> 9                          (se elimino la entrega 8, retirada)
entrega 4 estado: ('evaluada',)         -- ya no 'pendiente'
nota entrega3 corregida: (82.0,)        -- subio de 78 a 82
entrega 8: None                          -- eliminada correctamente
```

Caso que debe fallar - eliminar alumno con entregas asociadas (`FOREIGN KEY`):

```text
Fallo como se esperaba: FOREIGN KEY constraint failed
```

Consulta 3 (ranking de alumnos por numero de entregas):

```text
alumno                  total_entregas
Manuel Estrada           3
Douglas Pineda           2
Alejandra Chinchilla     2
Cristina Barrios         1
Byron Xicay              1
```

Consulta 5 (promedio de notas por alumno):

```text
alumno                  entregas_evaluadas   promedio_nota
Alejandra Chinchilla     2                    93.5
Manuel Estrada            2                    87.5
Byron Xicay               1                    82.0
Cristina Barrios          1                    80.0
Douglas Pineda            2                    79.0
```

## Explicacion final

El modelo separa catalogos (`profesores`, `cursos`, `alumnos`) de la
tabla transaccional (`entregas`) y del resultado de la evaluacion
(`evaluaciones`). Esto permite corregir el estado de una entrega y la
nota de una evaluacion sin duplicar datos de alumno o curso, eliminar
una entrega retirada sin afectar el historial de otros alumnos, y
responder con `JOIN`, `GROUP BY` y `HAVING` exactamente lo que la
escuela pidio: rankings de actividad y de promedio, para decidir a
quien destacar o becar.
