# Ejercicio 05: Inventario de Bicicletas

## Información

**Nombre:** Carlos Elias Tzoy Velasco  
**Fecha:** 2026-08-20  
**Tecnología:** SQLite  
**Ejercicio:** 05 - Inventario de Bicicletas

## Descripción del problema

La tienda de bicicletas necesita reemplazar el registro manual de productos, marcas, proveedores y movimientos de inventario por una base de datos relacional.

La solución permite registrar las bicicletas disponibles, asociarlas con sus respectivas marcas y controlar las entradas y salidas de inventario realizadas mediante proveedores.

## Modelo implementado

La base de datos utiliza cuatro tablas:

### `marcas`

Almacena las marcas de las bicicletas y su país de origen.

### `proveedores`

Almacena los proveedores que participan en las operaciones de inventario.

### `bicicletas`

Contiene el catálogo de bicicletas y sus características principales:

- Código.
- Modelo.
- Categoría.
- Precio.
- Marca.

### `movimientos_inventario`

Registra las operaciones de entrada y salida:

- Bicicleta.
- Proveedor.
- Tipo de movimiento.
- Cantidad.
- Fecha.
- Observación.

La existencia actual no se almacena directamente en `bicicletas`. Se calcula a partir de los movimientos:

```text
Existencia = Entradas - Salidas
```

Esto evita mantener un valor de stock duplicado y permite reconstruir el inventario a partir del historial de movimientos.

## Relaciones

```text
marcas 1 ─────── N bicicletas

bicicletas 1 ─── N movimientos_inventario

proveedores 1 ── N movimientos_inventario
```

## Restricciones aplicadas

### PRIMARY KEY

Cada tabla tiene una clave primaria:

- `marcas.id_marca`
- `proveedores.id_proveedor`
- `bicicletas.id_bicicleta`
- `movimientos_inventario.id_movimiento`

### FOREIGN KEY

Se implementaron:

```text
bicicletas.id_marca
    → marcas.id_marca

movimientos_inventario.id_bicicleta
    → bicicletas.id_bicicleta

movimientos_inventario.id_proveedor
    → proveedores.id_proveedor
```

Las claves foráneas se habilitan mediante:

```sql
PRAGMA foreign_keys = ON;
```

### NOT NULL

Se utilizan restricciones `NOT NULL` para los atributos necesarios para identificar y operar cada registro.

### UNIQUE

Se aplicaron restricciones `UNIQUE` para:

- Nombre de marca.
- Nombre de proveedor.
- Correo electrónico del proveedor.
- Código de bicicleta.

### CHECK

Se implementaron restricciones para:

- Validar precios positivos.
- Validar cantidades positivas.
- Limitar las categorías de bicicletas.
- Limitar los tipos de movimiento a `ENTRADA` y `SALIDA`.
- Validar nombres de marcas.
- Validar el formato básico del correo electrónico.

## Datos registrados

Los datos base contienen:

| Tabla | Registros |
| --- | ---: |
| marcas | 5 |
| proveedores | 5 |
| bicicletas | 5 |
| movimientos_inventario | 10 |

Los movimientos incluyen tanto entradas como salidas para que las consultas puedan calcular existencias y analizar el comportamiento del inventario.

## Operaciones DML

`dml/operaciones.sql` contiene:

- 2 operaciones `INSERT` adicionales.
- 2 operaciones `UPDATE` válidas.
- 2 operaciones `DELETE` controladas.
- 3 operaciones inválidas comentadas.

Las operaciones adicionales insertan una bicicleta y un proveedor. Después de realizar las actualizaciones, ambos registros son eliminados mediante `DELETE ... WHERE`.

Las operaciones inválidas permanecen comentadas para que el script pueda ejecutarse sin interrupciones.

## Operaciones inválidas documentadas

Se incluyen ejemplos de:

1. Violación de `CHECK` mediante una cantidad igual a cero.
2. Violación de `UNIQUE` mediante un código de bicicleta duplicado.
3. Violación de `FOREIGN KEY` mediante una marca inexistente.

## Consultas implementadas

El archivo `dql/consultas.sql` contiene las 12 consultas solicitadas:

1. Listado de movimientos de inventario.
2. Selección de dos columnas de bicicletas.
3. Filtrado de bicicletas por precio.
4. Ordenamiento alfabético de modelos.
5. Top 5 de bicicletas según unidades movidas.
6. Conteo total de movimientos.
7. Promedio, mínimo y máximo de precios.
8. Agrupación de movimientos por tipo.
9. JOIN entre bicicletas y marcas.
10. `WHERE + ORDER BY + LIMIT` para consultar las últimas salidas.
11. Reporte completo con alias legibles.
12. Consulta de decisión para identificar bicicletas que necesitan reposición.

## Ejecución

Desde la raíz de `ejercicio-05`:

```bash
sqlite3 ejercicio-05.db < ddl/schema.sql
sqlite3 ejercicio-05.db < dml/inserts.sql
sqlite3 ejercicio-05.db < dml/operaciones.sql
sqlite3 ejercicio-05.db < dql/consultas.sql
```

El archivo `ejercicio-05.db` es temporal y no debe subirse al repositorio.

## Validación de tablas

```bash
sqlite3 ejercicio-05.db ".tables"
```

Salida esperada:

```text
bicicletas  marcas  movimientos_inventario  proveedores
```

## Validación de cantidades

```bash
sqlite3 ejercicio-05.db <<'SQL'
SELECT 'marcas' AS tabla, COUNT(*) AS registros FROM marcas
UNION ALL
SELECT 'proveedores', COUNT(*) FROM proveedores
UNION ALL
SELECT 'bicicletas', COUNT(*) FROM bicicletas
UNION ALL
SELECT 'movimientos_inventario', COUNT(*) FROM movimientos_inventario;
SQL
```

Salida esperada:

```text
marcas|5
proveedores|5
bicicletas|5
movimientos_inventario|10
```

## Validación de claves foráneas

```bash
sqlite3 ejercicio-05.db "PRAGMA foreign_keys;"
```

Salida esperada:

```text
1
```

## Validación de existencias

La existencia se calcula mediante:

```sql
SELECT
    b.modelo AS bicicleta,
    COALESCE(
        SUM(
            CASE
                WHEN mi.tipo_movimiento = 'ENTRADA'
                    THEN mi.cantidad
                WHEN mi.tipo_movimiento = 'SALIDA'
                    THEN -mi.cantidad
            END
        ),
        0
    ) AS existencia_actual
FROM bicicletas AS b
LEFT JOIN movimientos_inventario AS mi
    ON b.id_bicicleta = mi.id_bicicleta
GROUP BY
    b.id_bicicleta,
    b.modelo
ORDER BY existencia_actual ASC;
```

Con los datos base, las existencias esperadas son:

| Bicicleta | Existencia |
| --- | ---: |
| Marlin 7 | 6 |
| Rockhopper Comp | 3 |
| Escape 3 | 4 |
| Speedster 40 | 3 |
| Trail 5 | 2 |

## Resultado final

La solución implementa un sistema relacional de cuatro tablas para controlar el inventario de una tienda de bicicletas.

El historial de movimientos permite determinar las existencias actuales mediante la diferencia entre entradas y salidas, identificar productos con bajo inventario y generar reportes sobre movimiento de unidades.

El modelo mantiene integridad referencial, evita duplicidades mediante `UNIQUE`, controla valores inválidos mediante `CHECK` y permite realizar las operaciones CRUD y consultas solicitadas.