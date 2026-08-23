# Ejercicio 28: Vistas y Reportes

## Información

- **Estudiante:** Carlos Velasco
- **Ejercicio:** 28
- **Tema:** Vistas y reportes
- **Motor:** SQLite
- **Fecha:** 2026-08-20

## Descripción

El ejercicio implementa una base de datos relacional para un sistema de ventas. El modelo permite administrar clientes, vendedores, ventas y pagos, evitando duplicidad y facilitando la generación de reportes mediante vistas SQL.

El objetivo principal es utilizar `CREATE VIEW` para encapsular consultas frecuentes y presentar información consolidada para la toma de decisiones.

## Modelo implementado

```text
clientes
    │
    └──< ventas >── vendedores
             │
             └──< pagos
```

### Tablas

| Tabla | Responsabilidad |
| --- | --- |
| `clientes` | Información de los clientes |
| `vendedores` | Información y comisión de los vendedores |
| `ventas` | Registro de las operaciones comerciales |
| `pagos` | Registro de pagos asociados a las ventas |

## Relaciones

- `ventas.id_cliente` referencia `clientes.id_cliente`.
- `ventas.id_vendedor` referencia `vendedores.id_vendedor`.
- `pagos.id_venta` referencia `ventas.id_venta`.

## Restricciones aplicadas

- `PRIMARY KEY` en todas las tablas.
- `FOREIGN KEY` para las relaciones.
- `NOT NULL` en campos obligatorios.
- `UNIQUE` en correos de clientes.
- `UNIQUE` en correos de vendedores.
- `CHECK` para limitar el porcentaje de comisión.
- `CHECK` para impedir ventas con valores menores o iguales a cero.
- `CHECK` para impedir pagos con valores menores o iguales a cero.
- `CHECK` para controlar estados de ventas.
- `CHECK` para controlar estados de pagos.
- `CHECK` para controlar métodos de pago.
- `PRAGMA foreign_keys = ON`.

## Datos

Los datos iniciales contienen:

- 5 clientes.
- 5 vendedores.
- 10 ventas.
- 10 pagos.

El archivo `dml/operaciones.sql` agrega posteriormente:

- 1 cliente.
- 1 venta.

También ejecuta 2 actualizaciones y 2 eliminaciones controladas.

## Vistas

Se crearon tres vistas:

### `vw_resumen_ventas`

Consolida la información de cada venta con el nombre del cliente y del vendedor.

```sql
SELECT
    id_venta,
    cliente,
    vendedor,
    total,
    fecha_venta,
    estado
FROM vw_resumen_ventas;
```

### `vw_estado_pagos`

Permite identificar cuánto se ha pagado de cada venta y cuál es el saldo pendiente.

```sql
SELECT
    id_venta,
    cliente,
    total_venta,
    total_pagado,
    saldo_pendiente
FROM vw_estado_pagos;
```

### `vw_ventas_vendedores`

Resume el rendimiento comercial de cada vendedor.

```sql
SELECT
    vendedor,
    total_ventas,
    monto_vendido,
    ticket_promedio
FROM vw_ventas_vendedores;
```

## Operaciones

El archivo `dml/operaciones.sql` contiene:

- 2 operaciones `INSERT`.
- 2 operaciones `UPDATE`.
- 2 operaciones `DELETE`.
- 1 operación inválida por `UNIQUE`, comentada.
- 1 operación inválida por `CHECK`, comentada.

Las operaciones inválidas permanecen comentadas para que el script pueda ejecutarse completamente.

## Consultas

El archivo `dql/consultas.sql` contiene las 12 consultas obligatorias:

1. Listado de ventas.
2. Selección de dos columnas.
3. Filtrado por monto.
4. Ordenamiento por fecha.
5. Cinco ventas principales.
6. Conteo total.
7. Promedio, mínimo y máximo.
8. Agrupación por vendedor.
9. Relaciones mediante `JOIN`.
10. Consulta con `WHERE`, `ORDER BY` y `LIMIT`.
11. Reporte con alias legibles.
12. Análisis de rendimiento para apoyar decisiones comerciales.

También se incluyen consultas específicas sobre las tres vistas creadas.

## Ejecución

Desde la carpeta de la solución:

```bash
sqlite3 ejercicio-28.db < ddl/schema.sql
sqlite3 ejercicio-28.db < dml/inserts.sql
sqlite3 ejercicio-28.db < dml/operaciones.sql
sqlite3 ejercicio-28.db < dql/consultas.sql
```

## Validaciones

Comprobar las tablas:

```bash
sqlite3 ejercicio-28.db ".tables"
```

Comprobar las vistas:

```bash
sqlite3 ejercicio-28.db "SELECT name FROM sqlite_master WHERE type = 'view';"
```

Comprobar el esquema:

```bash
sqlite3 ejercicio-28.db ".schema"
```

Comprobar las relaciones:

```bash
sqlite3 ejercicio-28.db "PRAGMA foreign_key_list(ventas);"
sqlite3 ejercicio-28.db "PRAGMA foreign_key_list(pagos);"
```

Comprobar las vistas directamente:

```bash
sqlite3 ejercicio-28.db "SELECT * FROM vw_resumen_ventas;"
sqlite3 ejercicio-28.db "SELECT * FROM vw_estado_pagos;"
sqlite3 ejercicio-28.db "SELECT * FROM vw_ventas_vendedores;"
```

## Evidencias de ejecución

Las consultas permiten verificar:

- Total de ventas.
- Valor promedio de las ventas.
- Ventas de mayor monto.
- Rendimiento de vendedores.
- Clientes asociados a sus ventas.
- Métodos de pago utilizados.
- Total pagado por venta.
- Saldo pendiente de cada venta.
- Vendedores con mayor volumen comercial.
- Ventas pendientes de pago.

Las vistas permiten consultar estos reportes sin repetir la lógica de los `JOIN` y agregaciones en cada consulta.

## Decisiones de diseño

Se utilizaron cuatro tablas para respetar el límite establecido por el ejercicio.

La tabla `ventas` funciona como entidad transaccional central y relaciona clientes y vendedores. La tabla `pagos` permite registrar uno o varios pagos asociados a cada venta.

Las vistas se implementaron como una capa de consulta sobre el modelo físico. Esto permite reutilizar consultas de reportes y mantener separada la información operacional de la lógica de presentación.

Los importes monetarios se almacenan mediante `DECIMAL` y las fechas utilizan el formato ISO `YYYY-MM-DD`.

Los índices se crearon sobre las claves foráneas y campos utilizados frecuentemente en búsquedas y reportes.

No se incluye ningún archivo de base de datos generado (`.db`, `.sqlite` o `.sqlite3`) en la solución.