# Evidencias - Ejercicio 104

## Tema

Triggers

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-104.db < ddl/schema.sql
sqlite3 ejercicio-104.db < dml/inserts.sql
sqlite3 ejercicio-104.db < dql/consultas.sql
```

## Resultados

**1. Libros con su stock final (despues de los UPDATE de dml/inserts.sql):**

```text
id_libro   titulo             stock_total
1            Clean Code            6
2            Refactoring           2
3            Design Patterns       2
```

**5. Auditoria generada automaticamente por el trigger:**

```text
id_auditoria   id_libro   stock_anterior   stock_nuevo
1                1            5                4
2                1            4                6
3                2            3                2
```

Verificacion manual: hay exactamente 3 filas en `auditoria_libros`,
una por cada uno de los 3 `UPDATE` de `dml/inserts.sql`, y cada
`stock_anterior`/`stock_nuevo` coincide con esos cambios (Clean Code
5→4→6; Refactoring 3→2). Ningun `INSERT` manual toco
`auditoria_libros` en todo el script.

**Caso comentado verificado (CHECK):**

- `UPDATE libros SET stock_total = -1 WHERE id_libro = 3;` → `CHECK constraint failed: stock_total >= 0`.

**Caso comentado verificado (trigger AFTER INSERT referenciando OLD):**

```text
CREATE TRIGGER trg_auditar_insercion_mal
AFTER INSERT ON libros
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_libros (id_libro, stock_anterior, stock_nuevo)
    VALUES (NEW.id_libro, OLD.stock_total, NEW.stock_total);
END;
```

→ se ejecuta sin ningun error.

```text
INSERT INTO libros (titulo, stock_total) VALUES ('Domain-Driven Design', 4);
```

→ `no such column: OLD.stock_total`. El `INSERT` nunca llega a
completarse porque el trigger que dispara falla al intentar leer
`OLD`, que no existe en un evento de tipo `INSERT`.

## Aprendizaje

Un trigger permite automatizar una accion (aqui, registrar auditoria)
cada vez que ocurre un evento sobre una tabla (`INSERT`, `UPDATE` o
`DELETE`), sin que el codigo que provoca el evento tenga que
implementar esa logica extra por su cuenta. Dentro del cuerpo del
trigger, `NEW` representa la fila despues del cambio y `OLD` la fila
antes del cambio, pero `OLD` solo existe quando el evento es `UPDATE`
o `DELETE` (hay una fila previa que comparar); en un trigger
`AFTER INSERT` no hay ninguna fila "anterior", por lo que referenciar
`OLD` ahi es un error. Igual que con las vistas, SQLite no valida el
cuerpo de un trigger en el momento de crearlo (`CREATE TRIGGER`
siempre tiene exito si la sintaxis es correcta): el error solo aparece
cuando el trigger realmente se dispara y ejecuta esa referencia
invalida.
