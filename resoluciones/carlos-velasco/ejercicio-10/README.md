### README.md

# Ejercicio 10: Hotel Reservas

## Información

| Campo | Valor |
| --- | --- |
| Nombre | Carlos Velasco |
| Ejercicio | 10 - Hotel Reservas |
| Motor | SQLite |
| Fecha | 2026-08-20 |
| Rama | `alumno/carlos-velasco/ejercicio-10` |

## Descripción

El ejercicio implementa una base de datos relacional para gestionar huéspedes, habitaciones, reservas y pagos de un hotel.

El objetivo es sustituir el manejo manual de información por un modelo estructurado que permita controlar la ocupación de habitaciones, registrar reservas, gestionar pagos y generar reportes útiles para la administración del hotel.

## Modelo implementado

La solución utiliza cuatro tablas:

| Tabla | Responsabilidad |
| --- | --- |
| `huespedes` | Almacenar la información de los huéspedes. |
| `habitaciones` | Registrar las habitaciones, sus características, precios y disponibilidad. |
| `reservas` | Gestionar las reservas y relacionar huéspedes con habitaciones. |
| `pagos` | Registrar los pagos asociados a las reservas. |

La tabla `reservas` funciona como entidad central del modelo.

```text
huespedes 1 ──────── N reservas N ──────── 1 habitaciones
                       │
                       N
                       │
                       1
                     pagos
```

## Relaciones

- Un huésped puede realizar múltiples reservas.
- Una habitación puede estar asociada a múltiples reservas en diferentes períodos.
- Cada reserva pertenece obligatoriamente a un huésped y a una habitación.
- Una reserva puede tener múltiples pagos.
- Cada pago pertenece obligatoriamente a una reserva.

## Restricciones

El esquema utiliza:

- `PRIMARY KEY` para identificar cada registro.
- `FOREIGN KEY` para mantener la integridad referencial.
- `NOT NULL` para campos obligatorios.
- `UNIQUE` en documentos y correos de huéspedes.
- `UNIQUE` en el número de habitación.
- `UNIQUE` en habitación y fecha de entrada de la reserva.
- `CHECK` para validar tipos y estados de habitaciones.
- `CHECK` para validar capacidad y precio de las habitaciones.
- `CHECK` para validar fechas y cantidad de huéspedes.
- `CHECK` para validar métodos y estados de pago.
- `DEFAULT` para establecer estados iniciales.
- `PRAGMA foreign_keys = ON` para activar la integridad referencial de SQLite.
- Índices para facilitar consultas frecuentes sobre huéspedes, habitaciones, fechas de reservas y pagos.

## Datos

Los datos base incluyen:

- 5 huéspedes.
- 5 habitaciones.
- 10 reservas.
- 10 pagos.

Los datos permiten consultar reservas completadas, confirmadas y pendientes, además de diferentes tipos de habitación y diferentes métodos de pago.

## Operaciones

El archivo `dml/operaciones.sql` contiene:

- 2 `INSERT` adicionales.
- 2 `UPDATE` válidos.
- 2 `DELETE` controlados mediante `WHERE`.
- 1 operación inválida por `UNIQUE`, comentada.
- 1 operación inválida por `FOREIGN KEY`, comentada.

Las operaciones inválidas permanecen comentadas para que el script pueda ejecutarse completamente.

## Consultas

El archivo `dql/consultas.sql` contiene consultas para:

1. Listar todas las reservas.
2. Mostrar columnas específicas de las reservas.
3. Filtrar reservas por fecha.
4. Ordenar reservas por fecha de entrada.
5. Obtener las cinco reservas más largas.
6. Contar el total de reservas.
7. Calcular promedio, mínimo y máximo de pagos.
8. Agrupar reservas por estado.
9. Relacionar huéspedes con sus reservas.
10. Aplicar `WHERE`, `ORDER BY` y `LIMIT`.
11. Generar un reporte completo con alias y total estimado de la reserva.
12. Identificar las habitaciones con mayor demanda para apoyar decisiones de gestión.

## Ejecución

Desde la raíz de la solución:

```bash
sqlite3 ejercicio-10.db < ddl/schema.sql
sqlite3 ejercicio-10.db < dml/inserts.sql
sqlite3 ejercicio-10.db < dml/operaciones.sql
sqlite3 ejercicio-10.db < dql/consultas.sql
```

Para validar las tablas:

```bash
sqlite3 ejercicio-10.db ".tables"
```

Para consultar el esquema:

```bash
sqlite3 ejercicio-10.db ".schema"
```

Para comprobar la integridad referencial:

```bash
sqlite3 ejercicio-10.db "PRAGMA foreign_keys = ON;"
sqlite3 ejercicio-10.db "PRAGMA foreign_key_check;"
```

El archivo de base de datos utilizado durante las pruebas debe eliminarse antes de realizar la entrega.

## Validaciones

La implementación permite comprobar:

- Integridad de las relaciones entre huéspedes, habitaciones, reservas y pagos.
- Prevención de documentos duplicados.
- Prevención de correos duplicados.
- Prevención de números de habitación duplicados.
- Validación de tipos y estados de habitación.
- Validación de capacidades positivas.
- Validación de precios positivos.
- Validación de fechas en formato ISO.
- Validación de fechas de salida posteriores a las fechas de entrada.
- Validación de cantidades positivas de huéspedes.
- Validación de métodos y estados de pago.
- Prevención de reservas duplicadas para una habitación y fecha de entrada determinada.
- Prevención de pagos asociados a reservas inexistentes.

## Decisiones de diseño

Se utilizaron cuatro tablas para respetar el límite establecido por el ejercicio.

La información de huéspedes y habitaciones se mantiene separada de las reservas para evitar duplicación de datos. La tabla `reservas` registra la relación entre cada huésped y la habitación reservada, además de conservar el período de ocupación y el estado de la reserva.

Los pagos se almacenan en una tabla independiente porque representan operaciones transaccionales asociadas a las reservas.

Las fechas se almacenan en formato ISO `YYYY-MM-DD`, lo que permite ordenarlas y filtrarlas correctamente.

El precio por noche se almacena en la tabla `habitaciones` y el reporte calcula el total estimado utilizando la cantidad de noches multiplicada por el precio correspondiente.

Los índices creados están orientados a las consultas habituales sobre huéspedes, habitaciones, fechas de entrada y pagos.

## Archivos principales

```text
ddl/schema.sql
dml/inserts.sql
dml/operaciones.sql
dql/consultas.sql
diagramas/README.md
```
