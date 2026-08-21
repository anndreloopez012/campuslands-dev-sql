# Ejercicio 14: Marketplace Campus

## Información

| Campo | Valor |
| --- | --- |
| Nombre | Carlos Velasco |
| Ejercicio | 14 - Marketplace Campus |
| Motor | SQLite |
| Fecha | 2026-08-20 |
| Rama | `alumno/carlos-velasco/ejercicio-14` |

## Descripción

El ejercicio implementa una base de datos relacional para gestionar un marketplace digital enfocado en vendedores, productos, compradores y órdenes de compra.

El modelo permite relacionar cada orden con el vendedor, producto y comprador correspondientes y generar reportes sobre volumen de órdenes y ventas por vendedor.

## Modelo implementado

La solución utiliza cuatro tablas:

| Tabla | Responsabilidad |
| --- | --- |
| `vendedores` | Registrar vendedores y sus datos básicos. |
| `productos` | Gestionar productos publicados por cada vendedor. |
| `compradores` | Registrar compradores del marketplace. |
| `ordenes` | Registrar las operaciones de compra realizadas. |

```text
vendedores 1 ──────── N productos
      │
      └────────────── N ordenes ──────────── 1 compradores
                         │
                         └────────────────── 1 productos
```

## Relaciones

- Un vendedor puede publicar múltiples productos.
- Cada producto pertenece obligatoriamente a un vendedor.
- Un vendedor puede recibir múltiples órdenes.
- Un comprador puede realizar múltiples órdenes.
- Un producto puede aparecer en múltiples órdenes.
- Cada orden pertenece obligatoriamente a un vendedor, producto y comprador.

Las relaciones se implementan mediante claves foráneas y `PRAGMA foreign_keys = ON`.

## Restricciones

El esquema utiliza:

- `PRIMARY KEY` en las cuatro tablas.
- `FOREIGN KEY` para mantener la integridad referencial.
- `NOT NULL` en los campos obligatorios.
- `UNIQUE` para los correos de vendedores y compradores.
- `CHECK` para validar nombres y estados.
- `CHECK` para validar precios positivos.
- `CHECK` para impedir stock negativo.
- `CHECK` para validar cantidades positivas.
- `CHECK` para validar precios unitarios positivos.
- `CHECK` para controlar estados de las órdenes.
- `CHECK` para validar fechas en formato ISO.
- Índices sobre las claves foráneas y fecha de las órdenes.

## Datos

Los datos base incluyen:

- 5 vendedores.
- 10 productos.
- 5 compradores.
- 12 órdenes.

Los registros permiten consultar ventas, productos, compradores, vendedores y órdenes con diferentes estados y valores.

## Operaciones

El archivo `dml/operaciones.sql` contiene:

- 2 `INSERT` adicionales.
- 2 `UPDATE` válidos.
- 2 `DELETE` controlados mediante `WHERE`.
- 1 operación inválida por `UNIQUE`, comentada.
- 1 operación inválida por `FOREIGN KEY`, comentada.

Las operaciones inválidas permanecen comentadas para evitar que interrumpan la ejecución completa del archivo.

## Consultas

El archivo `dql/consultas.sql` contiene consultas para:

1. Listar todas las órdenes.
2. Mostrar dos columnas relevantes de las órdenes.
3. Filtrar órdenes por valor.
4. Ordenar órdenes por fecha.
5. Obtener las cinco órdenes de mayor valor.
6. Contar las órdenes totales.
7. Calcular promedio, mínimo y máximo del valor de las órdenes.
8. Agrupar órdenes por estado.
9. Relacionar vendedores y productos.
10. Aplicar `WHERE`, `ORDER BY` y `LIMIT`.
11. Generar un reporte completo con alias legibles.
12. Clasificar vendedores según su rendimiento de ventas.

## Ejecución

Desde la raíz de la solución:

```bash
sqlite3 ejercicio-14.db < ddl/schema.sql
sqlite3 ejercicio-14.db < dml/inserts.sql
sqlite3 ejercicio-14.db < dml/operaciones.sql
sqlite3 ejercicio-14.db < dql/consultas.sql
```

Para validar las tablas:

```bash
sqlite3 ejercicio-14.db ".tables"
```

Para consultar el esquema:

```bash
sqlite3 ejercicio-14.db ".schema"
```

Para comprobar la integridad referencial:

```bash
sqlite3 ejercicio-14.db "PRAGMA foreign_keys = ON;"
sqlite3 ejercicio-14.db "PRAGMA foreign_key_check;"
```

Para consultar las ventas por vendedor:

```sql
SELECT
    v.nombre_completo AS vendedor,
    COUNT(o.id_orden) AS ordenes,
    ROUND(SUM(o.cantidad * o.precio_unitario), 2) AS ventas_totales
FROM vendedores AS v
INNER JOIN ordenes AS o
    ON o.id_vendedor = v.id_vendedor
GROUP BY
    v.id_vendedor,
    v.nombre_completo
ORDER BY ventas_totales DESC;
```

## Validaciones

La implementación permite comprobar:

- Integridad referencial entre vendedores y productos.
- Integridad referencial entre vendedores y órdenes.
- Integridad referencial entre productos y órdenes.
- Integridad referencial entre compradores y órdenes.
- Prevención de correos duplicados.
- Prevención de precios negativos o iguales a cero.
- Prevención de stock negativo.
- Prevención de cantidades inválidas.
- Prevención de precios unitarios inválidos.
- Validación de estados permitidos.
- Validación de fechas en formato ISO.

## Decisiones de diseño

Se utilizaron cuatro tablas para respetar el límite establecido por el ejercicio.

La tabla `ordenes` funciona como entidad transaccional central y conserva directamente las referencias al vendedor, producto y comprador. Esta estructura permite consultar las ventas por vendedor sin crear tablas adicionales.

La tabla `productos` mantiene la relación con el vendedor responsable de su publicación. El precio unitario de una orden se almacena de manera independiente al precio actual del producto para conservar el valor utilizado en el momento de la compra.

Los correos electrónicos se establecen como únicos para reducir duplicidades en vendedores y compradores.

Las fechas se almacenan en formato ISO para mantener consistencia y permitir ordenamiento cronológico.

Los índices se concentran principalmente en las claves foráneas y la fecha de las órdenes para facilitar las consultas de relaciones y reportes.

## Archivos principales

```text
ddl/schema.sql
dml/inserts.sql
dml/operaciones.sql
dql/consultas.sql
diagramas/README.md
```