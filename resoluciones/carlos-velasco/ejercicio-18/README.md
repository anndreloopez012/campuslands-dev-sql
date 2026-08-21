# Ejercicio 18: Farmacia Inventario

## Información

- **Nombre:** Carlos Velasco
- **Fecha:** 2026-08-20
- **Motor:** SQLite
- **Ejercicio:** 18
- **Tema:** Farmacia, inventario, compras y ventas

## Descripción

El ejercicio modela la información básica de una farmacia que necesita controlar medicamentos, laboratorios, compras y ventas.

La base de datos permite relacionar cada medicamento con su laboratorio y registrar las operaciones de compra y venta asociadas al inventario.

## Modelo implementado

La solución utiliza cuatro tablas:

| Tabla | Responsabilidad |
| --- | --- |
| `laboratorios` | Almacenar los laboratorios que fabrican los medicamentos. |
| `medicamentos` | Mantener el catálogo, precio, stock y vencimiento de los medicamentos. |
| `compras` | Registrar adquisiciones de medicamentos a proveedores. |
| `ventas` | Registrar ventas realizadas a clientes. |

### Relaciones

```text
LABORATORIOS 1 ─────── N MEDICAMENTOS
MEDICAMENTOS 1 ─────── N COMPRAS
MEDICAMENTOS 1 ─────── N VENTAS
```

## Restricciones

Se implementaron:

- Llaves primarias en todas las tablas.
- Llaves foráneas para mantener la integridad referencial.
- Campos obligatorios mediante `NOT NULL`.
- `UNIQUE` para evitar laboratorios duplicados.
- `UNIQUE` compuesto para evitar medicamentos repetidos dentro del mismo laboratorio.
- `CHECK` para impedir precios no positivos.
- `CHECK` para impedir cantidades negativas o iguales a cero.
- `CHECK` para impedir stock negativo.
- `CHECK` para validar fechas.
- `PRAGMA foreign_keys = ON`.

## Datos registrados

Se incluyen:

- 5 laboratorios.
- 10 medicamentos.
- 10 compras.
- 10 ventas.

Los datos fueron construidos para permitir resultados en las consultas de inventario, compras, ventas, agrupaciones y reportes.

## Operaciones DML

El archivo `dml/operaciones.sql` contiene:

- 2 `INSERT` adicionales.
- 2 `UPDATE` válidos.
- 2 `DELETE` controlados mediante `WHERE`.
- 2 operaciones inválidas comentadas para demostrar restricciones.

Las operaciones inválidas corresponden a:

```sql
-- CHECK por cantidad igual a cero.
-- FOREIGN KEY por medicamento inexistente.
```

## Consultas implementadas

El archivo `dql/consultas.sql` contiene consultas para:

1. Listar medicamentos.
2. Mostrar nombre y stock.
3. Filtrar medicamentos por stock.
4. Ordenar medicamentos alfabéticamente.
5. Obtener los cinco medicamentos con mayor stock.
6. Contar medicamentos.
7. Calcular precios promedio, mínimo y máximo.
8. Agrupar medicamentos por laboratorio.
9. Relacionar medicamentos con laboratorios.
10. Aplicar `WHERE`, `ORDER BY` y `LIMIT`.
11. Generar un reporte de ventas con alias.
12. Identificar medicamentos que requieren reabastecimiento.

También se incluye un reporte adicional de ingresos generados por medicamento.

## Ejecución

Desde la raíz de `ejercicio-18`:

```bash
sqlite3 ejercicio-18.db < ddl/schema.sql
sqlite3 ejercicio-18.db < dml/inserts.sql
sqlite3 ejercicio-18.db < dml/operaciones.sql
sqlite3 ejercicio-18.db < dql/consultas.sql
```

El archivo de base de datos generado durante las pruebas no debe formar parte del repositorio.

## Validaciones

La estructura puede verificarse con:

```bash
sqlite3 ejercicio-18.db ".tables"
sqlite3 ejercicio-18.db "PRAGMA foreign_keys;"
sqlite3 ejercicio-18.db "PRAGMA foreign_key_check;"
```

La consulta:

```sql
PRAGMA foreign_keys;
```

debe devolver:

```text
1
```

La consulta:

```sql
PRAGMA foreign_key_check;
```

no debe devolver registros cuando la base de datos se encuentra correctamente relacionada.

## Decisiones de diseño

Se mantuvieron cuatro tablas para respetar el límite establecido por el ejercicio.

Las compras y ventas funcionan como tablas transaccionales relacionadas directamente con `medicamentos`. Esto permite consultar cantidades, fechas, precios y actores de cada operación sin crear tablas adicionales.

El stock se mantiene como atributo del medicamento porque representa la existencia actual disponible en farmacia. Las compras y ventas conservan el historial de movimientos comerciales.

Los índices se agregaron sobre las columnas utilizadas frecuentemente para relaciones y consultas de fechas.

## Archivos principales

```text
README.md
diagramas/README.md
ddl/schema.sql
dml/inserts.sql
dml/operaciones.sql
dql/consultas.sql
```