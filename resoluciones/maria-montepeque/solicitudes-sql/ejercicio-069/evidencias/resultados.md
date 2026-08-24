# Evidencias - Ejercicio 069

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-069.db < ddl/schema.sql
sqlite3 ejercicio-069.db < dml/inserts.sql
sqlite3 ejercicio-069.db < dml/operaciones.sql
sqlite3 ejercicio-069.db < dql/consultas.sql
```

## Resultados importantes

Conteo de datos base (despues de `inserts.sql`):

```text
clientes -> 3
proyectos -> 4
renders -> 9
revisiones -> 12
entregas -> 4
```

Caso que debe fallar - eliminar render con revisiones asociadas (`FOREIGN KEY`):

```text
Fallo como se esperaba: FOREIGN KEY constraint failed
```

Despues de `operaciones.sql`:

```text
render 3 estado: ('terminado',)         -- ya no 'en_proceso'
comentario corregido, sin perder el registro de la revision original
render 9: None                           -- eliminado (unico DELETE valido: sin historico)
renders -> 8
```

Caso que debe fallar (repetido tras `operaciones.sql`) - eliminar render con revisiones:

```text
Fallo como se esperaba: FOREIGN KEY constraint failed
```

Consulta 3 (ranking de proyectos por revisiones, el historico de auditoria):

```text
proyecto                     total_revisiones
Torre Corporativa Central     4
Casa Vista Verde               4
Remodelacion Oficina           2
Escuela Nueva Esperanza         2
```

Consulta 5 (proyectos con renders aprobados):

```text
proyecto                     renders_aprobados
Casa Vista Verde               2
Remodelacion Oficina           1
Torre Corporativa Central      1
```

## Explicacion final

El modelo trata `revisiones` como un historico de auditoria autentico:
nunca se borra, solo se corrige con `UPDATE` cuando hubo un error de
captura, conservando siempre el rastro de que paso y cuando paso, tal
como exigio el cliente. El unico `DELETE` real permitido es sobre un
render que todavia no genero ninguna revision (un error de creacion
duplicada), y la propia `FOREIGN KEY` de `revisiones.id_render` impide
por diseno que se elimine cualquier render que ya tenga historico. Con
`JOIN`, `GROUP BY` y `HAVING` se responde exactamente lo que el estudio
necesita: que proyectos requirieron mas revisiones y cuales ya tienen
renders aprobados listos para entrega.
