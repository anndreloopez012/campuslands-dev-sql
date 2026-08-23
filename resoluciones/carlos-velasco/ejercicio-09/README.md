### README.md

# Ejercicio 09: Gimnasio Membresías

## Información

| Campo | Valor |
| --- | --- |
| Nombre | Carlos Velasco |
| Ejercicio | 09 - Gimnasio Membresías |
| Motor | SQLite |
| Fecha | 2026-08-20 |
| Rama | `alumno/carlos-velasco/ejercicio-09` |

## Descripción

El ejercicio implementa una base de datos relacional para gestionar clientes, planes, membresías y pagos de un gimnasio.

El objetivo es sustituir el manejo manual de información por un modelo estructurado que permita controlar las membresías activas, registrar pagos, mantener relaciones entre los datos y generar reportes para apoyar la gestión del gimnasio.

## Modelo implementado

La solución utiliza cuatro tablas:

| Tabla | Responsabilidad |
| --- | --- |
| `clientes` | Almacenar la información de los clientes. |
| `planes` | Registrar los planes y sus condiciones comerciales. |
| `membresias` | Registrar los planes contratados por los clientes y su vigencia. |
| `pagos` | Registrar los pagos asociados a cada membresía. |

La tabla `membresias` funciona como entidad central del modelo.

```text
clientes 1 ──────── N membresias N ──────── 1 planes
                       │
                       N
                       │
                       1
                     pagos
```

## Relaciones

- Un cliente puede tener múltiples membresías.
- Un plan puede estar asociado a múltiples membresías.
- Cada membresía pertenece a un cliente y a un plan.
- Una membresía puede tener múltiples pagos.
- Cada pago pertenece obligatoriamente a una membresía.

## Restricciones

El esquema utiliza:

- `PRIMARY KEY` para identificar cada registro.
- `FOREIGN KEY` para mantener la integridad referencial.
- `NOT NULL` para campos obligatorios.
- `UNIQUE` en documentos y correos de clientes.
- `UNIQUE` en el nombre de los planes.
- `UNIQUE` en cliente y fecha de inicio de membresía.
- `CHECK` para validar fechas, precios, duración, estados y métodos de pago.
- `DEFAULT` para establecer estados iniciales.
- `PRAGMA foreign_keys = ON` para activar la integridad referencial de SQLite.
- Índices para facilitar consultas frecuentes sobre clientes, estados, membresías y pagos.

## Datos

Los datos base incluyen:

- 5 clientes.
- 5 planes.
- 10 membresías.
- 10 pagos.

Los registros fueron diseñados para que existan membresías activas, vencidas y diferentes planes con distintos niveles de demanda.

## Operaciones

El archivo `dml/operaciones.sql` contiene:

- 2 `INSERT` adicionales.
- 2 `UPDATE` válidos.
- 2 `DELETE` controlados mediante `WHERE`.
- 1 operación inválida por `UNIQUE`, comentada.
- 1 operación inválida por `FOREIGN KEY`, comentada.

Las operaciones inválidas se mantienen comentadas para permitir la ejecución completa del script.

## Consultas

El archivo `dql/consultas.sql` contiene consultas para:

1. Listar todas las membresías.
2. Mostrar columnas específicas de las membresías.
3. Filtrar membresías por fecha de vencimiento.
4. Ordenar membresías por fecha.
5. Obtener las cinco membresías activas más próximas a vencer.
6. Contar el total de membresías.
7. Calcular promedio, mínimo y máximo de pagos.
8. Agrupar membresías por estado.
9. Relacionar clientes, membresías y planes.
10. Aplicar `WHERE`, `ORDER BY` y `LIMIT`.
11. Generar un reporte con alias legibles.
12. Identificar los planes con mayor demanda para apoyar decisiones comerciales.

## Ejecución

Desde la raíz de la solución:

```bash
sqlite3 ejercicio-09.db < ddl/schema.sql
sqlite3 ejercicio-09.db < dml/inserts.sql
sqlite3 ejercicio-09.db < dml/operaciones.sql
sqlite3 ejercicio-09.db < dql/consultas.sql
```

Para validar las tablas:

```bash
sqlite3 ejercicio-09.db ".tables"
```

Para consultar el esquema:

```bash
sqlite3 ejercicio-09.db ".schema"
```

Para comprobar la integridad referencial:

```bash
sqlite3 ejercicio-09.db "PRAGMA foreign_keys = ON;"
sqlite3 ejercicio-09.db "PRAGMA foreign_key_check;"
```

El archivo de base de datos utilizado durante las pruebas debe eliminarse antes de realizar la entrega.

## Validaciones

La implementación permite comprobar:

- Integridad de las relaciones entre clientes, planes, membresías y pagos.
- Prevención de documentos duplicados.
- Prevención de correos duplicados.
- Prevención de nombres de planes duplicados.
- Validación de precios positivos.
- Validación de duración de los planes.
- Validación de fechas en formato ISO.
- Validación de estados de membresías.
- Validación de métodos y estados de pago.
- Prevención de membresías duplicadas para un mismo cliente y fecha de inicio.
- Prevención de pagos asociados a membresías inexistentes.

## Decisiones de diseño

Se utilizaron cuatro tablas para respetar el límite establecido por el ejercicio.

Los clientes y planes se mantienen separados de las membresías para evitar duplicación de información. La tabla `membresias` registra la relación entre cada cliente y el plan contratado, además de conservar las fechas de vigencia y el estado.

Los pagos se almacenan en una tabla independiente porque representan operaciones transaccionales asociadas a las membresías.

Las fechas se almacenan en formato ISO `YYYY-MM-DD`, permitiendo ordenar y filtrar correctamente los períodos de vigencia y las transacciones.

Los valores monetarios se almacenan mediante `REAL`, utilizando valores positivos y coherentes con los planes definidos para SQLite.

## Archivos principales

```text
ddl/schema.sql
dml/inserts.sql
dml/operaciones.sql
dql/consultas.sql
diagramas/README.md
```

