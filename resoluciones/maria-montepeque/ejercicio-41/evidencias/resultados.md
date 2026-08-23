# Evidencias - Ejercicio 41

## Tema

Tipos de datos

## Comandos ejecutados

```bash
sqlite3 ejercicio-41.db < ddl/schema.sql
sqlite3 ejercicio-41.db < dml/inserts.sql
sqlite3 ejercicio-41.db < dql/consultas.sql
```

## Resultados

**1. Todos los productos** (INTEGER en `id_producto`/`stock`, REAL en `precio`, BOOLEAN simulado en `activo`):

```text
id_producto | nombre               | precio  | stock | activo
1           | Laptop 14 pulgadas   | 4599.99 | 12    | 1
2           | Mouse inalambrico    | 89.5    | 40    | 1
3           | Teclado mecanico     | 249.0   | 25    | 1
4           | SSD 500GB            | 349.9   | 30    | 1
5           | Audifonos bluetooth  | 199.0   | 0     | 0
6           | Router WiFi 6        | 459.0   | 15    | 1
7           | Mini PC              | 2100.0  | 5     | 1
```

**4. Resumen** (`SUM(activo)` funciona porque el BOOLEAN simulado sigue siendo INTEGER):

```text
total_productos | productos_activos | precio_promedio
7               | 6                  | 1149.48
```

**5.a Filtro por fecha (DATE simulado, orden alfabetico = orden cronologico):**

```text
id_movimiento | tipo   | cantidad | fecha_movimiento
5             | salida | 2        | 2026-07-10
6             | salida | 5        | 2026-07-11
8             | salida | 3        | 2026-07-12
```

**5.b Conteo directo sobre el BOOLEAN simulado:**

```text
activos | inactivos
6       | 1
```

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- `INSERT INTO productos (... activo) VALUES (..., 2);` → `CHECK constraint failed: activo IN (0, 1)`.
- `INSERT INTO movimientos (... fecha_movimiento) VALUES (..., '10/07/2026');` → `CHECK constraint failed: fecha_movimiento GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'`.

## Aprendizaje

`Tipos de datos` en SQLite no se limita a elegir entre `INTEGER`, `REAL` y `TEXT`: tambien implica reconocer que SQLite **no tiene** `DATE` ni `BOOLEAN` nativos, y decidir como simularlos de forma segura. Usar `TEXT` en formato ISO para fechas conserva el orden cronologico al comparar como texto; usar `INTEGER` restringido con `CHECK (columna IN (0,1))` para booleanos permite operarlo numericamente (`SUM`, comparaciones) sin perder la garantia de que solo existan dos valores posibles. En ambos casos, el `CHECK` es lo que realmente sostiene la simulacion — sin el, cualquier texto o numero pasaria como "fecha" o "booleano" valido.
