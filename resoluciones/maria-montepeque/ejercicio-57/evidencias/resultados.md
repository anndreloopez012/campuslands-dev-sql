# Evidencias - Ejercicio 57

## Tema

CHECK

## Comandos ejecutados

```bash
sqlite3 ejercicio-57.db < ddl/schema.sql
sqlite3 ejercicio-57.db < dml/inserts.sql
sqlite3 ejercicio-57.db < dql/consultas.sql
```

## Resultados

**4. Resumen: movimientos por tipo:**

```text
tipo_movimiento | total
entrada          | 4
salida           | 3
```

**5.a Rango numerico en movimientos: ninguna cantidad registrada es cero o negativa:**

```text
cantidad_minima_registrada
5
```

**5.b Rango numerico en productos: ningun precio_unitario es cero o negativo:**

```text
precio_minimo_registrado
24.75
```

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- `INSERT INTO categorias (nombre_categoria, tipo_categoria) VALUES ('Cables', 'consumible');` → `CHECK constraint failed: tipo_categoria IN ('hardware', 'software', 'accesorio')`.
- `INSERT INTO productos (..., precio_unitario) VALUES (..., 0);` → `CHECK constraint failed: precio_unitario > 0`.
- `INSERT INTO movimientos (..., cantidad, ...) VALUES (..., -5, ...);` → `CHECK constraint failed: cantidad > 0`.

## Aprendizaje

En un modelo con varias tablas relacionadas, la misma idea de `CHECK` (valores permitidos y rango numerico) se repite en tablas distintas porque cada una tiene su propia regla de dominio: `categorias.tipo_categoria` limita el dominio a una lista cerrada (`hardware`, `software`, `accesorio`), mientras que `productos.precio_unitario` y `movimientos.cantidad` usan comparaciones numericas (`> 0`) porque un precio o una cantidad de cero o negativa no representa nada real en el negocio, aunque el tipo `REAL`/`INTEGER` los permitiria sin problema. Confirmar esto con `MIN()` sobre datos reales (consultas 5.a y 5.b) es mas convincente que solo mirar el `CREATE TABLE`: si algun `CHECK` hubiera fallado en aplicarse, el minimo mostraria un valor invalido en vez de 5 o 24.75.
