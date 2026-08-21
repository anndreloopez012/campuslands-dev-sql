# Ejercicio 13: Banco Cuentas

## Información

| Campo | Valor |
| --- | --- |
| Nombre | Carlos Velasco |
| Ejercicio | 13 - Banco Cuentas |
| Motor | SQLite |
| Fecha | 2026-08-20 |
| Rama | `alumno/carlos-velasco/ejercicio-13` |

## Descripción

El ejercicio implementa una base de datos relacional para gestionar clientes, cuentas bancarias, movimientos financieros y tarjetas dentro de un banco digital.

El modelo permite mantener la relación entre cada cliente y sus cuentas, registrar transacciones y consultar información relacionada con saldos, movimientos y actividad financiera.

## Modelo implementado

La solución utiliza cuatro tablas:

| Tabla | Responsabilidad |
| --- | --- |
| `clientes` | Registrar la información básica de los clientes. |
| `cuentas` | Gestionar cuentas bancarias, saldos y estados. |
| `transacciones` | Registrar movimientos financieros realizados sobre las cuentas. |
| `tarjetas` | Registrar tarjetas asociadas a las cuentas. |

```text
clientes 1 ──────── N cuentas
                       │
                       ├──────── N transacciones
                       │
                       └──────── N tarjetas
```

## Relaciones

- Un cliente puede tener múltiples cuentas.
- Cada cuenta pertenece obligatoriamente a un cliente.
- Una cuenta puede registrar múltiples transacciones.
- Cada transacción pertenece obligatoriamente a una cuenta.
- Una cuenta puede tener múltiples tarjetas.
- Cada tarjeta pertenece obligatoriamente a una cuenta.

Las relaciones se implementan mediante claves foráneas y `PRAGMA foreign_keys = ON`.

## Restricciones

El esquema utiliza:

- `PRIMARY KEY` en las cuatro tablas.
- `FOREIGN KEY` para mantener la integridad referencial.
- `NOT NULL` en los campos obligatorios.
- `UNIQUE` para documentos, correos, números de cuenta y números de tarjeta.
- `CHECK` para validar nombres y fechas de clientes.
- `CHECK` para validar tipos, saldos y estados de cuentas.
- `CHECK` para validar tipos y montos de transacciones.
- `CHECK` para validar tipos, estados y fechas de tarjetas.
- Índices para relaciones y consultas frecuentes.
- `PRAGMA foreign_keys = ON` para activar las claves foráneas de SQLite.

## Datos

Los datos base incluyen:

- 5 clientes.
- 5 cuentas.
- 15 transacciones.
- 5 tarjetas.

Los registros permiten realizar consultas sobre saldos, tipos de movimientos, clientes, cuentas y actividad financiera.

## Operaciones

El archivo `dml/operaciones.sql` contiene:

- 2 `INSERT` adicionales.
- 2 `UPDATE` válidos.
- 2 `DELETE` controlados mediante `WHERE`.
- 1 operación inválida por `UNIQUE`, comentada.
- 1 operación inválida por `FOREIGN KEY`, comentada.

Las operaciones inválidas permanecen comentadas para que el archivo pueda ejecutarse completamente sin interrumpir el proceso.

## Consultas

El archivo `dql/consultas.sql` contiene consultas para:

1. Listar todas las transacciones.
2. Mostrar tipo y monto de las transacciones.
3. Filtrar movimientos por monto.
4. Ordenar movimientos por fecha.
5. Obtener las cinco cuentas con mayor saldo.
6. Contar transacciones.
7. Calcular promedio, mínimo y máximo de los movimientos.
8. Agrupar movimientos por tipo.
9. Relacionar clientes y cuentas.
10. Aplicar `WHERE`, `ORDER BY` y `LIMIT`.
11. Generar un reporte financiero con alias legibles.
12. Clasificar cuentas según actividad y saldo para apoyar decisiones comerciales.

## Ejecución

Desde la raíz de la solución:

```bash
sqlite3 ejercicio-13.db < ddl/schema.sql
sqlite3 ejercicio-13.db < dml/inserts.sql
sqlite3 ejercicio-13.db < dml/operaciones.sql
sqlite3 ejercicio-13.db < dql/consultas.sql
```

Para validar las tablas:

```bash
sqlite3 ejercicio-13.db ".tables"
```

Para consultar el esquema:

```bash
sqlite3 ejercicio-13.db ".schema"
```

Para comprobar las claves foráneas:

```bash
sqlite3 ejercicio-13.db "PRAGMA foreign_keys = ON;"
sqlite3 ejercicio-13.db "PRAGMA foreign_key_check;"
```

Para consultar las cuentas con sus respectivos clientes:

```sql
SELECT
    cl.nombre_completo,
    c.numero_cuenta,
    c.saldo
FROM clientes AS cl
INNER JOIN cuentas AS c
    ON c.id_cliente = cl.id_cliente;
```

## Validaciones

La implementación permite comprobar:

- Integridad referencial entre clientes y cuentas.
- Integridad referencial entre cuentas y transacciones.
- Integridad referencial entre cuentas y tarjetas.
- Prevención de documentos duplicados.
- Prevención de correos duplicados.
- Prevención de números de cuenta duplicados.
- Prevención de números de tarjeta duplicados.
- Prevención de saldos negativos.
- Validación de tipos de cuenta.
- Validación de tipos de transacción.
- Validación de montos positivos.
- Validación de tipos de tarjeta.
- Validación de estados permitidos.
- Validación de fechas en formato ISO.

## Decisiones de diseño

Se utilizaron cuatro tablas para respetar el límite establecido por el ejercicio.

Los clientes y las cuentas se mantienen separados porque un cliente puede tener más de una cuenta. Las transacciones se separan de las cuentas porque una misma cuenta puede registrar múltiples movimientos. Las tarjetas se gestionan de forma independiente porque una cuenta puede tener diferentes tarjetas asociadas.

El saldo se almacena como `REAL` para mantener el ejercicio compatible con SQLite y facilitar las operaciones numéricas requeridas.

Las fechas se almacenan como texto en formato ISO para permitir ordenamiento cronológico y mantener consistencia en los datos.

Las restricciones `UNIQUE` evitan duplicidades en identificadores naturales como documento, correo, número de cuenta y número de tarjeta.

Los índices se concentran en las claves foráneas y en la fecha de las transacciones para facilitar consultas frecuentes.

## Archivos principales

```text
ddl/schema.sql
dml/inserts.sql
dml/operaciones.sql
dql/consultas.sql
diagramas/README.md
```