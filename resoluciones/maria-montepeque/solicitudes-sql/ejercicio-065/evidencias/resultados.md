# Evidencias - Ejercicio 065

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-065.db < ddl/schema.sql
sqlite3 ejercicio-065.db < dml/inserts.sql
sqlite3 ejercicio-065.db < dml/operaciones.sql
sqlite3 ejercicio-065.db < dql/consultas.sql
```

## Resultados importantes

Conteo de datos base (despues de `inserts.sql`):

```text
tecnicos -> 3
formulas -> 4
reactivos -> 4
muestras -> 10
resultados -> 6
```

Caso que debe fallar - segundo resultado para la misma muestra (`UNIQUE`):

```text
Fallo como se esperaba: UNIQUE constraint failed: resultados.id_muestra
```

Despues de `operaciones.sql`:

```text
muestras -> 9                        (se elimino la muestra 8, pendiente y cancelada)
muestra 4 estado: ('finalizada',)     -- ya no 'en_analisis'
resultado muestra3 aprobado: (1,)     -- corregido tras segunda revision
muestra 8: None                        -- eliminada correctamente
```

Caso que debe fallar - eliminar reactivo con muestras asociadas (`FOREIGN KEY`):

```text
Fallo como se esperaba: FOREIGN KEY constraint failed
```

Consulta 3 (ranking de reactivos por uso):

```text
reactivo              veces_usado
Acido Sulfurico         4
Cloruro de Sodio        2
Hidroxido de Sodio      2
Etanol                  1
```

Consulta 5 (formulas con mas muestras aprobadas, HAVING > 1):

```text
formula          muestras_aprobadas
Formula A-12       4
Formula B-07       2
```

## Explicacion final

El modelo separa catalogos (`tecnicos`, `formulas`, `reactivos`) de la
tabla transaccional (`muestras`) y del dato final de laboratorio
(`resultados`). Esto permite corregir el estado de una muestra y la
aprobacion de un resultado sin duplicar datos de formula o reactivo, y
responder con `JOIN`, `GROUP BY` y `HAVING` justo lo que el laboratorio
necesita, aunque el cliente lo haya descrito solo como su operacion
diaria y no en terminos de tablas: que reactivo se usa mas y en que
formula conviene seguir invirtiendo segun sus muestras aprobadas.
