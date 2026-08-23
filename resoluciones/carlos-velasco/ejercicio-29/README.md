# Ejercicio 29: Transacciones Reservas

## Información

- **Estudiante:** Carlos Velasco
- **Ejercicio:** 29
- **Tema:** Transacciones y consistencia
- **Motor:** SQLite
- **Fecha:** 2026-08-20

## Descripción

El ejercicio implementa una base de datos relacional para administrar un sistema de reservas. El modelo permite registrar usuarios, recursos, reservas y pagos, manteniendo la integridad de los datos mediante claves primarias, claves foráneas y restricciones.

El objetivo principal es demostrar el uso de transacciones para ejecutar operaciones relacionadas de forma consistente mediante `BEGIN TRANSACTION`, `COMMIT` y `ROLLBACK`.

## Modelo implementado

```text
usuarios
    │
    └──< reservas >── recursos
             │
             └──< pagos
```

### Tablas

| Tabla | Responsabilidad |
| --- | --- |
| `usuarios` | Información de los usuarios |
| `recursos` | Catálogo de recursos disponibles |
| `reservas` | Registro central de las reservas |
| `pagos` | Pagos asociados a las reservas |

## Relaciones

- `reservas.id_usuario` referencia `usuarios.id_usuario`.
- `reservas.id_recurso` referencia `recursos.id_recurso`.
- `pagos.id_reserva` referencia `reservas.id_reserva`.

## Restricciones aplicadas

- `PRIMARY KEY` en las cuatro tablas.
- `FOREIGN KEY` para las relaciones.
- `NOT NULL` en los campos obligatorios.
- `UNIQUE` en el correo de los usuarios.
- `CHECK` para validar capacidad de recursos.
- `CHECK` para validar precios por hora.
- `CHECK` para validar que `fecha_fin` sea posterior a `fecha_inicio`.
- `CHECK` para validar estados de reserva.
- `CHECK` para validar montos positivos.
- `CHECK` para validar métodos de pago.
- `CHECK` para validar estados de pago.
- `PRAGMA foreign_keys = ON`.

## Datos

Los datos iniciales contienen:

- 5 usuarios.
- 5 recursos.
- 10 reservas.
- 10 pagos.

Los datos fueron diseñados para que las consultas produzcan resultados útiles sobre reservas, recursos, usuarios y pagos.

## Operaciones

El archivo `dml/operaciones.sql` contiene:

- Una transacción completa de creación de usuario, reserva y pago.
- `COMMIT` para confirmar la transacción.
- 2 operaciones `UPDATE`.
- Una transacción adicional con cambios de reserva y pago.
- `ROLLBACK` para revertir los cambios de la segunda transacción.
- 2 operaciones `DELETE` relacionadas y 1 eliminación del usuario creado.
- 1 operación inválida por `UNIQUE`, comentada.
- 1 operación inválida por `CHECK`, comentada.

## Transacciones

La primera transacción agrupa tres operaciones relacionadas:

```sql
BEGIN TRANSACTION;

INSERT INTO usuarios (...);
INSERT INTO reservas (...);
INSERT INTO pagos (...);

COMMIT;
```

Las tres operaciones se confirman juntas mediante `COMMIT`.

Posteriormente se ejecuta una segunda transacción:

```sql
BEGIN TRANSACTION;

UPDATE reservas
SET estado = 'Cancelada'
WHERE id_reserva = 11;

UPDATE pagos
SET estado = 'Rechazado'
WHERE id_pago = 11;

ROLLBACK;
```

El `ROLLBACK` revierte ambos cambios, demostrando que las operaciones de la transacción pueden descartarse conjuntamente.

## Consultas

El archivo `dql/consultas.sql` contiene las 12 consultas obligatorias:

1. Listado de reservas.
2. Selección de dos columnas.
3. Filtrado por monto.
4. Ordenamiento por fecha.
5. Cinco reservas de mayor valor.
6. Conteo total.
7. Promedio, mínimo y máximo.
8. Agrupación por recurso.
9. Relaciones mediante `JOIN`.
10. Consulta con `WHERE`, `ORDER BY` y `LIMIT`.
11. Reporte con alias legibles.
12. Análisis de demanda para apoyar decisiones del negocio.

También se incluyen reportes relacionados con pagos y saldos pendientes.

## Ejecución

Desde la carpeta de la solución:

```bash
sqlite3 ejercicio-29.db < ddl/schema.sql
sqlite3 ejercicio-29.db < dml/inserts.sql
sqlite3 ejercicio-29.db < dml/operaciones.sql
sqlite3 ejercicio-29.db < dql/consultas.sql
```

## Validaciones

Comprobar las tablas:

```bash
sqlite3 ejercicio-29.db ".tables"
```

Comprobar las relaciones:

```bash
sqlite3 ejercicio-29.db "PRAGMA foreign_key_list(reservas);"
sqlite3 ejercicio-29.db "PRAGMA foreign_key_list(pagos);"
```

Comprobar el esquema:

```bash
sqlite3 ejercicio-29.db ".schema"
```

Comprobar que las reservas y pagos relacionados permanecen consistentes:

```bash
sqlite3 ejercicio-29.db < dql/consultas.sql
```

## Evidencias de ejecución

Las consultas permiten verificar:

- Cantidad total de reservas.
- Valores promedio, mínimo y máximo.
- Recursos con mayor cantidad de reservas.
- Recursos que generan mayores ingresos.
- Usuarios asociados a sus reservas.
- Estado de las reservas.
- Pagos confirmados.
- Saldos pendientes.
- Consistencia entre reservas y pagos.

La transacción con `COMMIT` confirma la creación de los registros relacionados. La transacción con `ROLLBACK` demuestra que los cambios realizados dentro de una misma unidad de trabajo pueden revertirse conjuntamente.

## Decisiones de diseño

Se utilizaron cuatro tablas para respetar el límite establecido por el ejercicio.

La tabla `reservas` funciona como entidad transaccional central y relaciona usuarios con recursos. La tabla `pagos` depende de las reservas y permite registrar los pagos correspondientes.

Las transacciones se utilizaron para agrupar operaciones que deben mantener consistencia. La creación de una reserva junto con su pago se confirma mediante `COMMIT`, mientras que una modificación conjunta de reserva y pago se revierte mediante `ROLLBACK`.

Las fechas utilizan el formato ISO `YYYY-MM-DD HH:MM`.

Los índices se crearon sobre las claves foráneas y las columnas utilizadas frecuentemente para filtros y búsquedas.

No se incluye ningún archivo de base de datos generado (`.db`, `.sqlite` o `.sqlite3`) en la solución.