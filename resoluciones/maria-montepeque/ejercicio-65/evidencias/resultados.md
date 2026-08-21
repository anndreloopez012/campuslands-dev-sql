# Evidencias - Ejercicio 65

## Tema

ALTER TABLE

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-65.db < ddl/schema.sql
sqlite3 ejercicio-65.db < dml/inserts.sql
sqlite3 ejercicio-65.db < dql/consultas.sql
```

## Resultados

Estado de `productos` justo despues de los `ALTER TABLE` (antes de
`inserts.sql`), confirmando que los 3 productos originales sobrevivieron
con `categoria` y `disponible` tomados del `DEFAULT`:

```text
(1, 'Cafe Americano', 15.0, 'bebida', 1)
(2, 'Capuchino', 18.5, 'bebida', 1)
(3, 'Pastel de Chocolate', 22.0, 'bebida', 1)
```

Caso que debe fallar (comentado en `ddl/schema.sql`):

```text
ALTER TABLE productos ADD COLUMN codigo_interno TEXT NOT NULL;
Fallo como se esperaba: OperationalError: Cannot add a NOT NULL column with default value NULL
```

Estado final de `productos` (despues de `inserts.sql`):

```text
(1, 'Cafe Americano', 15.0, 'bebida', 1)
(2, 'Capuchino', 18.5, 'bebida', 1)
(3, 'Pastel de Chocolate', 22.0, 'postre', 1)    -- categoria corregida
(4, 'Te Helado', 12.0, 'bebida', 0)              -- producto nuevo
```

Conteo por categoria (consulta 4):

```text
categoria   total_productos
bebida       3
postre       1
```

## Aprendizaje

`ALTER TABLE` permite modificar una tabla que ya tiene datos sin
recrearla ni perder informacion: agregar columnas nuevas (con `DEFAULT`
para que las filas existentes queden validas), y renombrar columnas
para que el modelo sea mas claro conforme el negocio pide mas datos. La
limitacion importante que se comprobo es que SQLite no permite agregar
una columna `NOT NULL` sin `DEFAULT` si la tabla ya tiene filas, porque
no habria un valor valido que asignarles a esas filas.
