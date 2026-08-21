### README.md

# Ejercicio 09: Gimnasio Membresias

## Información

- Nombre: Jose Luis Herrera
- Fecha: 2026-08-20
- Motor: SQLite
- Ejercicio: 09
- Rama: `alumno/joseluis-herrera/ejercicio-09`

## Descripción

La organización necesita reemplazar el registro manual de clientes, planes, membresías y pagos por una base de datos relacional que permita controlar las membresías activas, registrar pagos y generar reportes para apoyar la administración del gimnasio.

## Modelo implementado

La solución utiliza cuatro tablas:

- `clientes`: almacena la información de los clientes.
- `planes`: registra los planes disponibles y sus precios.
- `membresias`: registra la contratación de planes por parte de los clientes.
- `pagos`: almacena los pagos asociados a cada membresía.

## Relaciones

```text
CLIENTES    1 ───────── N MEMBRESIAS
PLANES      1 ───────── N MEMBRESIAS
MEMBRESIAS  1 ───────── N PAGOS
```

La tabla `membresias` funciona como entidad central porque relaciona a los clientes con los planes y permite controlar el periodo de vigencia.

La tabla `pagos` registra las transacciones económicas asociadas a cada membresía.

## Restricciones

- Todas las tablas poseen `PRIMARY KEY`.
- `membresias.id_cliente` referencia `clientes.id_cliente`.
- `membresias.id_plan` referencia `planes.id_plan`.
- `pagos.id_membresia` referencia `membresias.id_membresia`.
- El documento del cliente posee `UNIQUE`.
- El correo del cliente posee `UNIQUE`.
- El nombre del plan posee `UNIQUE`.
- La combinación de cliente y fecha de inicio de membresía posee `UNIQUE`.
- Los campos obligatorios utilizan `NOT NULL`.
- Los estados de clientes y membresías utilizan `CHECK`.
- La duración de los planes debe ser mayor que cero.
- El precio de los planes debe ser mayor que cero.
- La fecha final de una membresía no puede ser anterior a su fecha inicial.
- El monto de un pago debe ser mayor que cero.
- Los métodos de pago están limitados mediante `CHECK`.
- Los estados de pago están limitados mediante `CHECK`.
- Las llaves foráneas se activan mediante `PRAGMA foreign_keys = ON`.

## Datos

```text
Clientes: 5 registros base
Planes: 5 registros base
Membresías: 10 registros base
Pagos: 10 registros base
```

Los datos incluyen membresías activas y vencidas, diferentes planes y pagos realizados mediante distintos métodos.

## Operaciones

```text
INSERT adicionales: 2
UPDATE validos: 2
DELETE controlados: 2
Operaciones invalidas comentadas: 2
```

Las operaciones inválidas corresponden a:

```text
UNIQUE: documento de cliente duplicado
CHECK: duración de plan igual a cero
```

## Consultas

El archivo `dql/consultas.sql` contiene las doce consultas requeridas:

```text
1. Listado completo de membresías.
2. Selección de dos columnas relevantes.
3. Filtrado de membresías por fecha.
4. Ordenamiento por fecha de inicio.
5. Top 5 planes según cantidad de membresías.
6. Conteo total de membresías.
7. Promedio, mínimo y máximo de pagos.
8. Agrupación de membresías por estado.
9. JOIN entre membresías, clientes y planes.
10. WHERE + ORDER BY + LIMIT.
11. Reporte completo de membresías con alias.
12. Consulta de decisión sobre desempeño de planes.
```

También se incluye una consulta adicional para identificar membresías vencidas, próximas a vencer o vigentes.

## Ejecución

Desde la raíz de la solución:

```bash
sqlite3 ejercicio-09.db < ddl/schema.sql
sqlite3 ejercicio-09.db < dml/inserts.sql
sqlite3 ejercicio-09.db < dml/operaciones.sql
sqlite3 ejercicio-09.db < dql/consultas.sql
```

No se incluye ningún archivo `.db`, `.sqlite` ni `.sqlite3`.

## Evidencias esperadas

```text
5 clientes registrados.
5 planes registrados.
10 membresías registradas.
10 pagos registrados.
2 nuevos registros mediante INSERT.
2 modificaciones mediante UPDATE.
2 eliminaciones controladas mediante DELETE.
Restricciones UNIQUE y CHECK documentadas mediante operaciones invalidas comentadas.
Consultas con JOIN, GROUP BY, ORDER BY, LIMIT y funciones de agregación.
Reporte de membresías y pagos.
Consulta para identificar planes con mayor demanda.
Consulta para identificar membresías vencidas o próximas a vencer.
```

## Decisiones de diseño

La tabla `membresias` representa la relación entre clientes y planes, además de almacenar el periodo de vigencia y el estado de cada contratación.

La tabla `pagos` se mantiene separada porque una membresía puede generar múltiples pagos.

Las restricciones de fechas, estados, precios y montos ayudan a evitar información inválida y mantener la integridad de los datos.