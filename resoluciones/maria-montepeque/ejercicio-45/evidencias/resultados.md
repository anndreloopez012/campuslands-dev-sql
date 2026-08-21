# Evidencias - Ejercicio 45

## Tema

PRIMARY KEY

## Comandos ejecutados

```bash
sqlite3 ejercicio-45.db < ddl/schema.sql
sqlite3 ejercicio-45.db < dml/inserts.sql
sqlite3 ejercicio-45.db < dql/consultas.sql
```

## Resultados

**4. Resumen:**

```text
total_ventas | productos_distintos_vendidos | clientes_distintos
11           | 4                             | 5
```

**5.a El codigo_barras (PRIMARY KEY natural en `productos`) se repite libremente como FOREIGN KEY en `ventas`:**

```text
codigo_barras | veces_vendido
750100001     | 4
750100002     | 3
750100004     | 2
750100003     | 2
```

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- `INSERT INTO productos (codigo_barras, ...) VALUES ('750100001', ...);` (ya existe) → `UNIQUE constraint failed: productos.codigo_barras`.
- `INSERT INTO clientes (id_cliente, ...) VALUES (1, ...);` (ya existe) → `UNIQUE constraint failed: clientes.id_cliente`.

## Aprendizaje

La `PRIMARY KEY` no siempre tiene que ser un id autoincremental: cuando un dato del negocio ya es unico y estable (como un codigo de barras), usarlo directamente como llave primaria evita una columna redundante. Lo que si es constante, sin importar si la llave es natural o subrogada, es que la base de datos rechaza cualquier intento de repetirla — y que esa unicidad solo aplica en la tabla donde la columna es realmente `PRIMARY KEY`, no en las tablas que solo la referencian como `FOREIGN KEY`.
