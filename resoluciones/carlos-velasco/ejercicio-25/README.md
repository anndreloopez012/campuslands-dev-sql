# Ejercicio 25: Reportes Biblioteca

## Información

- **Nombre:** Carlos Velasco
- **Fecha:** 2026-08-20
- **Motor:** SQLite
- **Ejercicio:** 25
- **Tema:** Reportes Biblioteca

## Descripción

El ejercicio implementa una base de datos relacional para gestionar sedes, libros, usuarios y préstamos de una biblioteca. El modelo permite generar reportes mediante `JOIN`, agrupaciones y funciones de agregación para analizar el comportamiento de los préstamos.

## Modelo implementado

La solución utiliza cuatro tablas:

| Tabla | Responsabilidad |
| --- | --- |
| `sedes` | Registra las sedes disponibles y su capacidad. |
| `libros` | Registra los libros, autores, ISBN y ejemplares. |
| `usuarios` | Registra los usuarios asociados a cada sede. |
| `prestamos` | Registra los préstamos realizados por los usuarios. |

### Relaciones

- `sedes` se relaciona con `usuarios` mediante `id_sede`.
- `usuarios` se relaciona con `prestamos` mediante `id_usuario`.
- `libros` se relaciona con `prestamos` mediante `id_libro`.

## Restricciones

Se implementaron:

- `PRIMARY KEY` en las cuatro tablas.
- `FOREIGN KEY` para mantener la integridad referencial.
- `NOT NULL` en campos obligatorios.
- `UNIQUE` en nombres de sede, ISBN y correo.
- `CHECK` para validar capacidades, años, ejemplares, fechas, estados y duración de préstamos.
- `DEFAULT` para estados de usuarios y préstamos.
- Fechas en formato ISO `YYYY-MM-DD`.
- `PRAGMA foreign_keys = ON`.

## Datos registrados

La carga inicial contiene:

- 5 sedes.
- 5 libros.
- 5 usuarios.
- 10 préstamos.

Los datos están relacionados entre sí para permitir la ejecución de todas las consultas solicitadas.

## Operaciones DML

El archivo `dml/operaciones.sql` contiene:

- 2 `INSERT` adicionales.
- 2 `UPDATE`.
- 2 `DELETE` controlados mediante `WHERE`.
- 2 operaciones inválidas comentadas.

Las operaciones inválidas corresponden a:

1. Inserción de un ISBN duplicado para provocar un error `UNIQUE`.
2. Inserción de un préstamo asociado a un usuario inexistente para provocar un error `FOREIGN KEY`.

Las operaciones adicionales se eliminan posteriormente para mantener el conjunto de datos controlado.

## Consultas

El archivo `dql/consultas.sql` contiene:

1. Listado de préstamos.
2. Selección de columnas relevantes.
3. Filtro por fecha.
4. Ordenamiento por fecha.
5. Cinco préstamos con mayor duración.
6. Conteo total de préstamos.
7. Promedio, mínimo y máximo de duración.
8. Agrupación por estado.
9. `JOIN` entre usuarios y préstamos.
10. Consulta con `WHERE`, `ORDER BY` y `LIMIT`.
11. Reporte con alias legibles y múltiples relaciones.
12. Consulta para identificar los libros con mayor demanda y generar una recomendación de disponibilidad.

## Ejecución

Desde la raíz de `ejercicio-25`:

```bash
sqlite3 ejercicio-25.db < ddl/schema.sql
sqlite3 ejercicio-25.db < dml/inserts.sql
sqlite3 ejercicio-25.db < dml/operaciones.sql
sqlite3 ejercicio-25.db < dql/consultas.sql
```

No se debe incluir ningún archivo `.db`, `.sqlite` ni `.sqlite3` en el repositorio.

## Validaciones esperadas

Después de ejecutar `schema.sql` e `inserts.sql`:

```text
sedes: 5 registros
libros: 5 registros
usuarios: 5 registros
prestamos: 10 registros
```

Después de ejecutar `operaciones.sql`, los registros adicionales utilizados para las operaciones de prueba son eliminados de forma controlada.

## Decisiones de diseño

Se mantuvo el límite máximo de cuatro tablas solicitado por el ejercicio.

`prestamos` funciona como entidad transaccional y relaciona usuarios con libros. La información de sedes y usuarios se mantiene separada para evitar duplicidad, mientras que los libros contienen únicamente información propia del catálogo bibliográfico.

La consulta de decisión del negocio utiliza la cantidad de préstamos por libro para identificar títulos con mayor demanda y determinar si se recomienda aumentar, mantener o conservar la disponibilidad existente.