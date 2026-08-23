# Ejercicio 04: Restaurante Campus

## Información

**Nombre:** Carlos Elias Tzoy Velasco  
**Fecha:** 2026-08-20  
**Tecnología:** SQLite  
**Ejercicio:** 04 - Restaurante Campus

## Descripción del problema

Restaurante Campus necesita reemplazar el manejo manual de mesas, platos, pedidos y detalles de consumo mediante una base de datos relacional.

La solución permite registrar las mesas disponibles, el catálogo de platos, los pedidos realizados y el detalle de los productos consumidos en cada pedido.

## Modelo implementado

La base de datos utiliza cuatro tablas:

### `mesas`

Representa las mesas disponibles en el restaurante.

Contiene información como:

- Número de mesa.
- Capacidad.
- Ubicación.
- Estado.

### `platos`

Representa el catálogo de productos ofrecidos por el restaurante.

Contiene:

- Nombre.
- Categoría.
- Precio.
- Disponibilidad.

### `pedidos`

Representa las órdenes realizadas desde las mesas.

Contiene:

- Mesa asociada.
- Fecha y hora.
- Estado del pedido.

### `detalle_pedido`

Representa los platos incluidos en cada pedido.

Contiene:

- Pedido asociado.
- Plato asociado.
- Cantidad.
- Precio unitario.

## Relaciones

Las relaciones implementadas son:

```text
mesas 1 ─────── N pedidos

pedidos 1 ───── N detalle_pedido

platos 1 ────── N detalle_pedido
```

Estas relaciones permiten determinar qué mesa realizó un pedido y qué platos fueron consumidos.

## Restricciones aplicadas

### PRIMARY KEY

Cada tabla posee una clave primaria:

- `mesas.id_mesa`
- `platos.id_plato`
- `pedidos.id_pedido`
- `detalle_pedido.id_detalle`

### FOREIGN KEY

Se implementaron:

```text
pedidos.id_mesa
    → mesas.id_mesa

detalle_pedido.id_pedido
    → pedidos.id_pedido

detalle_pedido.id_plato
    → platos.id_plato
```

La integridad referencial se habilita mediante:

```sql
PRAGMA foreign_keys = ON;
```

### UNIQUE

Se utilizaron restricciones `UNIQUE` para:

- Número de mesa.
- Nombre del plato.
- Combinación de pedido y plato dentro de `detalle_pedido`.

### CHECK

Se implementaron restricciones para:

- Validar la capacidad de las mesas.
- Validar los estados de las mesas.
- Garantizar precios positivos.
- Validar disponibilidad de platos.
- Validar estados de pedidos.
- Garantizar cantidades positivas.
- Garantizar precios unitarios positivos.
- Validar el formato de fecha del pedido.

## Datos registrados

Los datos base contienen:

| Tabla | Registros |
| --- | ---: |
| mesas | 5 |
| platos | 5 |
| pedidos | 10 |
| detalle_pedido | 15 |

Los datos permiten obtener resultados en todas las consultas solicitadas.

## Operaciones DML

`dml/operaciones.sql` contiene:

- 2 operaciones `INSERT` adicionales.
- 2 operaciones `UPDATE`.
- 2 operaciones `DELETE`.
- 3 operaciones inválidas comentadas.

Los registros adicionales son eliminados posteriormente, por lo que el estado final de la base conserva los datos base.

Las operaciones inválidas permanecen comentadas para evitar que el script se detenga durante su ejecución normal.

## Operaciones inválidas documentadas

Se incluyen ejemplos de:

1. Violación de `CHECK` por capacidad de mesa inválida.
2. Violación de `UNIQUE` por número de mesa duplicado.
3. Violación de `FOREIGN KEY` utilizando una mesa inexistente.

## Consultas implementadas

El archivo `dql/consultas.sql` contiene las 12 consultas requeridas:

1. Listado completo de pedidos.
2. Selección de dos columnas.
3. Filtrado por fecha.
4. Ordenamiento por fecha.
5. Top 5 de platos más vendidos.
6. Conteo total de pedidos.
7. Promedio, mínimo y máximo de precios.
8. Agrupación de pedidos por estado.
9. JOIN entre pedidos y mesas.
10. `WHERE + ORDER BY + LIMIT`.
11. Reporte detallado con alias.
12. Reporte de platos más vendidos para apoyar decisiones de inventario y preparación.

## Ejecución

Desde la raíz de `ejercicio-04`:

```bash
sqlite3 ejercicio-04.db < ddl/schema.sql
sqlite3 ejercicio-04.db < dml/inserts.sql
sqlite3 ejercicio-04.db < dml/operaciones.sql
sqlite3 ejercicio-04.db < dql/consultas.sql
```

No se debe subir `ejercicio-04.db` al repositorio.

## Validación de tablas

Comando:

```bash
sqlite3 ejercicio-04.db ".tables"
```

Salida esperada:

```text
detalle_pedido  mesas  pedidos  platos
```

## Validación de cantidades

```bash
sqlite3 ejercicio-04.db <<'SQL'
SELECT 'mesas' AS tabla, COUNT(*) AS registros FROM mesas
UNION ALL
SELECT 'platos', COUNT(*) FROM platos
UNION ALL
SELECT 'pedidos', COUNT(*) FROM pedidos
UNION ALL
SELECT 'detalle_pedido', COUNT(*) FROM detalle_pedido;
SQL
```

Salida esperada:

```text
mesas|5
platos|5
pedidos|10
detalle_pedido|15
```

## Validación de claves foráneas

```bash
sqlite3 ejercicio-04.db "PRAGMA foreign_keys;"
```

Salida esperada:

```text
1
```

## Validación de pedidos

```sql
SELECT
    pe.id_pedido,
    me.numero AS mesa,
    pe.estado,
    ROUND(
        SUM(dp.cantidad * dp.precio_unitario),
        2
    ) AS total_pedido
FROM pedidos AS pe
INNER JOIN mesas AS me
    ON pe.id_mesa = me.id_mesa
INNER JOIN detalle_pedido AS dp
    ON pe.id_pedido = dp.id_pedido
GROUP BY
    pe.id_pedido,
    me.numero,
    pe.estado
ORDER BY pe.id_pedido;
```

Esta consulta permite verificar que los pedidos están correctamente relacionados con sus mesas y detalles.

## Resultado final

La solución implementa un modelo relacional de cuatro tablas para gestionar el consumo de un restaurante.

El diseño permite identificar qué mesa realizó cada pedido, qué platos fueron consumidos, sus cantidades y precios, además de generar indicadores sobre ventas y demanda.

Las restricciones garantizan integridad referencial, evitan duplicidades y controlan valores inválidos. Las consultas permiten obtener información operativa y generar reportes útiles para decisiones de inventario y preparación.