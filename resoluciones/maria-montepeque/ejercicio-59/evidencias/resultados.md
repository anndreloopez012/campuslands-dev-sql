# Evidencias - Ejercicio 59

## Tema

DEFAULT

## Comandos ejecutados

```bash
sqlite3 ejercicio-59.db < ddl/schema.sql
sqlite3 ejercicio-59.db < dml/inserts.sql
sqlite3 ejercicio-59.db < dql/consultas.sql
```

## Resultados

**4. Resumen: productos por estado:**

```text
estado      | total
agotado      | 1
disponible   | 4
```

**5. Los productos insertados SIN indicar estado, stock, es_fragil ni fecha_registro (LAP-002, MON-002, PER-001) igual quedaron completos gracias a DEFAULT:**

```text
sku      | estado      | stock | es_fragil | tiene_fecha_registro
LAP-002  | disponible  | 0     | 0         | 1
MON-002  | disponible  | 0     | 0         | 1
PER-001  | disponible  | 0     | 0         | 1
```

(`fecha_registro` quedo con la fecha/hora real del momento en que se ejecuto el `INSERT`, por ejemplo `2026-08-18 00:55:01`; el valor exacto varia en cada ejecucion, pero nunca queda vacio.)

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO productos (..., estado) VALUES (..., 'dispnible');` → `CHECK constraint failed: estado IN ('disponible', 'agotado', 'descontinuado')` (un typo al escribir el estado a mano rompe la validacion; dejar que `DEFAULT` lo complete evita ese error).

## Aprendizaje

`DEFAULT` cubre los cuatro tipos de valor que pide el objetivo del ejercicio, todos en la misma tabla principal: un **estado** (`'disponible'`), una **cantidad** (`stock = 0`), una **bandera** (`es_fragil = 0`) y una **fecha** (`fecha_registro = datetime('now')`). Lo que mas me quedo claro es la diferencia entre `DEFAULT` y `NOT NULL`: `DEFAULT` no obliga a nada, simplemente rellena el valor cuando el `INSERT` no lo trae, mientras que si alguien SI escribe un valor (aunque sea con un error de tipeo como `'dispnible'`), `DEFAULT` ya no interviene y el dato entra tal cual se escribio, quedando sujeto al `CHECK`. Por eso, para columnas con un valor tipico claro (como el estado inicial de un producto nuevo), es mas seguro omitir la columna en el `INSERT` y dejar que `DEFAULT` la complete, que escribirla a mano cada vez.
