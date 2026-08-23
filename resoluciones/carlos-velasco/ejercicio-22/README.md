# Ejercicio 22: Pedidos Delivery

## Información

- **Nombre:** Carlos Velasco
- **Fecha:** 2026-08-20
- **Motor:** SQLite
- **Ejercicio:** 22
- **Tema:** Pedidos, estados y asignaciones de delivery

## Descripción

Un servicio de delivery necesita organizar la información relacionada con clientes, restaurantes, repartidores y pedidos. El objetivo es reemplazar registros dispersos por una base de datos relacional que permita controlar los pedidos, sus estados, valores y asignaciones de reparto.

## Modelo implementado

La solución utiliza cuatro tablas:

| Tabla | Responsabilidad |
| --- | --- |
| `clientes` | Almacenar los datos de los clientes |
| `restaurantes` | Registrar los establecimientos disponibles |
| `repartidores` | Gestionar los repartidores y su disponibilidad |
| `pedidos` | Registrar las operaciones de compra y entrega |

La entidad central es `pedidos`, porque conecta al cliente, restaurante y repartidor.

## Relaciones

```text
CLIENTES      1 ─────── N PEDIDOS
RESTAURANTES  1 ─────── N PEDIDOS
REPARTIDORES  1 ─────── N PEDIDOS
```

## Restricciones

Se implementaron:

- `PRIMARY KEY` en las cuatro tablas.
- `FOREIGN KEY` para las relaciones de `pedidos`.
- `NOT NULL` para los campos obligatorios.
- `UNIQUE` en correos de clientes.
- `UNIQUE` en teléfonos de restaurantes y repartidores.
- `CHECK` para calificaciones de restaurantes.
- `CHECK` para vehículos válidos.
- `CHECK` para disponibilidad de repartidores.
- `CHECK` para estados de pedidos.
- `CHECK` para totales positivos.
- `CHECK` para tiempos estimados positivos.
- `PRAGMA foreign_keys = ON`.

## Datos cargados

Se registraron:

- 5 clientes.
- 5 restaurantes.
- 5 repartidores.
- 10 pedidos.

Los registros contienen diferentes estados, valores, restaurantes y repartidores para permitir consultas de filtrado, agrupación, agregación y análisis.

## Operaciones DML

El archivo `dml/operaciones.sql` contiene:

- 2 `INSERT` adicionales.
- 2 `UPDATE` válidos.
- 2 `DELETE` controlados mediante `WHERE`.
- 2 operaciones inválidas comentadas.

Las operaciones inválidas corresponden a:

```text
1. Violación de CHECK mediante una calificación fuera del rango permitido.
2. Violación de FOREIGN KEY mediante un restaurante inexistente.
```

Las operaciones inválidas permanecen comentadas para que el script pueda ejecutarse completo.

## Consultas implementadas

El archivo `dql/consultas.sql` contiene las 12 consultas requeridas:

1. Listado de pedidos.
2. Selección de dos columnas relevantes.
3. Filtrado por valor del pedido.
4. Ordenamiento por fecha.
5. Cinco pedidos de mayor valor.
6. Conteo total de pedidos.
7. Promedio, mínimo y máximo del total.
8. Agrupación por estado.
9. Relación mediante `JOIN`.
10. Uso combinado de `WHERE`, `ORDER BY` y `LIMIT`.
11. Reporte con alias legibles.
12. Análisis de restaurantes con mayor demanda.

## Ejecución

Desde la raíz de la solución:

```bash
sqlite3 ejercicio-22.db < ddl/schema.sql
sqlite3 ejercicio-22.db < dml/inserts.sql
sqlite3 ejercicio-22.db < dml/operaciones.sql
sqlite3 ejercicio-22.db < dql/consultas.sql
```

## Validaciones

Para comprobar que las claves foráneas están activas:

```sql
PRAGMA foreign_keys;
```

Resultado esperado:

```text
1
```

Para verificar las tablas:

```sql
.tables
```

Resultado esperado:

```text
clientes  pedidos  repartidores  restaurantes
```

Para revisar las relaciones:

```sql
PRAGMA foreign_key_list(pedidos);
```

## Decisiones de diseño

Se mantuvieron cuatro tablas para respetar el límite establecido por el ejercicio. `pedidos` funciona como entidad transaccional y mantiene las referencias hacia las entidades participantes.

Los estados del pedido están restringidos mediante `CHECK` para evitar valores inconsistentes. Las fechas se almacenan en formato ISO `YYYY-MM-DD HH:MM`, lo que permite ordenarlas correctamente en SQLite.

La disponibilidad del repartidor se representa mediante `0` y `1`, manteniendo un modelo simple y compatible con SQLite.

Se agregaron índices sobre las claves foráneas y el estado de los pedidos para facilitar consultas frecuentes relacionadas con clientes, restaurantes, repartidores y seguimiento de estados.

## Archivos

```text
ddl/schema.sql
dml/inserts.sql
dml/operaciones.sql
dql/consultas.sql
diagramas/README.md
```

## Evidencia

La solución queda preparada para ejecutarse mediante los scripts SQL indicados y permite demostrar la creación del esquema, carga de datos, modificaciones, eliminaciones, validación de restricciones y consultas de información operativa.