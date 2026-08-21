# Evidencias - Ejercicio 43

## Tema

Tipos de datos

## Comandos ejecutados

```bash
sqlite3 ejercicio-43.db < ddl/schema.sql
sqlite3 ejercicio-43.db < dml/inserts.sql
sqlite3 ejercicio-43.db < dql/consultas.sql
```

## Resultados

**4. Resumen general:**

```text
total_ventas | unidades_vendidas | ingresos_totales | ventas_con_tarjeta
12           | 17                 | 381.0             | 7
```

**5.a Ingresos por producto** (REAL: `cantidad * precio_unitario` combina INTEGER y REAL):

```text
producto            | unidades | ingresos
Bagel con queso      | 4        | 112.0
Cafe americano       | 7        | 105.0
Capuchino            | 4        | 88.0
Sandwich de pollo    | 2        | 76.0
```

**5.b Reporte diario** (DATE simulado agrupa correctamente por dia):

```text
fecha_venta  | ventas_del_dia | ingresos_del_dia
2026-07-01   | 4              | 105.0
2026-07-02   | 4              | 161.0
2026-07-03   | 4              | 115.0
```

**Reporte final de negocio** (LEFT JOIN + COALESCE conserva las ventas de mostrador con `id_cliente = NULL`):

```text
cliente                | es_frecuente | cantidad_compras | total_gastado
Cliente no registrado  | 0            | 3                 | 111.0
Pedro Suarez           | 1            | 2                 | 59.0
Karla Diaz             | 0            | 1                 | 56.0
Sofia Leon             | 0            | 2                 | 53.0
Ana Ramirez            | 1            | 2                 | 52.0
Luis Gomez             | 0            | 2                 | 50.0
```

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- `INSERT INTO ventas (... hora_venta ...) VALUES (..., '25:99', ...);` → `CHECK constraint failed: hora_venta GLOB '[0-2][0-9]:[0-5][0-9]'`.
- `INSERT INTO ventas (... cantidad ...) VALUES (..., 0, ...);` → `CHECK constraint failed: cantidad > 0`.

## Aprendizaje

Este ejercicio cierra la serie de tipos de datos combinando todo lo visto en el 41 y el 42, y agrega el `TIME` simulado (mismo patron que `DATE`: `TEXT` + formato fijo + `CHECK GLOB`). Lo mas relevante del nivel aplicado fue ver el impacto de estos tipos en un reporte de negocio real: elegir `REAL` para los montos permitio sumar ingresos sin perder precision, elegir `TEXT` ISO para fecha/hora permitio agrupar y ordenar cronologicamente sin funciones de conversion, y permitir `NULL` en una llave foranea (`id_cliente`) reflejo un caso real de negocio (venta de mostrador) que, con `LEFT JOIN` + `COALESCE`, se pudo incluir en el reporte final en vez de perderse silenciosamente.
