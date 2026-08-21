### README.md

# Ejercicio 08: Clínica de Citas

## Información

| Campo | Valor |
| --- | --- |
| Nombre | Carlos Velasco |
| Ejercicio | 08 - Clínica de Citas |
| Motor | SQLite |
| Fecha | 2026-08-20 |
| Rama | `alumno/carlos-velasco/ejercicio-08` |

## Descripción

El ejercicio implementa una base de datos relacional para gestionar pacientes, médicos, consultorios y citas médicas.

El objetivo es reemplazar el manejo manual de información por un modelo estructurado que permita registrar datos, controlar relaciones, evitar duplicidades y consultar la agenda de la clínica.

## Modelo implementado

La solución utiliza cuatro tablas:

| Tabla | Responsabilidad |
| --- | --- |
| `pacientes` | Almacenar la información de los pacientes. |
| `medicos` | Almacenar la información profesional de los médicos. |
| `consultorios` | Registrar los consultorios disponibles. |
| `citas` | Gestionar la agenda y relacionar pacientes, médicos y consultorios. |

La tabla `citas` funciona como entidad central del modelo.

```text
pacientes 1 ──────── N citas N ──────── 1 medicos
                       │
                       N
                       │
                       1
                 consultorios
```

## Relaciones

- Un paciente puede tener múltiples citas.
- Un médico puede atender múltiples citas.
- Un consultorio puede ser utilizado en múltiples citas en diferentes horarios.
- Cada cita pertenece obligatoriamente a un paciente, un médico y un consultorio.

## Restricciones

El esquema utiliza:

- `PRIMARY KEY` para identificar cada registro.
- `FOREIGN KEY` para mantener la integridad referencial.
- `NOT NULL` para campos obligatorios.
- `UNIQUE` en documentos, correos, registros profesionales y números de consultorio.
- `CHECK` para validar fechas, capacidades, valores positivos y estados permitidos.
- `DEFAULT` para establecer el estado inicial de las citas.
- `UNIQUE (id_medico, fecha_hora)` para impedir que un médico tenga dos citas en el mismo horario.
- `UNIQUE (id_consultorio, fecha_hora)` para impedir que un consultorio sea asignado a dos citas simultáneas.
- `PRAGMA foreign_keys = ON` para activar la integridad referencial en SQLite.

## Datos

Los datos base incluyen:

- 5 pacientes.
- 5 médicos.
- 5 consultorios.
- 10 citas.

El archivo `dml/operaciones.sql` agrega operaciones adicionales de inserción, actualización y eliminación.

## Operaciones

Se implementaron:

- 2 `INSERT` adicionales.
- 2 `UPDATE` válidos.
- 2 `DELETE` controlados mediante `WHERE`.
- 1 operación inválida por `UNIQUE`, comentada.
- 1 operación inválida por `FOREIGN KEY`, comentada.

Las operaciones inválidas permanecen comentadas para evitar que interrumpan la ejecución normal del script.

## Consultas

El archivo `dql/consultas.sql` contiene consultas para:

1. Listar las citas registradas.
2. Mostrar columnas específicas de las citas.
3. Filtrar citas por fecha.
4. Ordenar citas cronológicamente.
5. Obtener las cinco próximas citas relevantes.
6. Contar el total de citas.
7. Obtener el mínimo y máximo de citas asignadas por médico.
8. Agrupar citas por estado.
9. Relacionar pacientes con sus citas.
10. Aplicar `WHERE`, `ORDER BY` y `LIMIT`.
11. Generar un reporte con alias legibles.
12. Identificar médicos según su carga de citas para apoyar decisiones de distribución de agenda.

## Ejecución

Desde la raíz de la solución:

```bash
sqlite3 ejercicio-08.db < ddl/schema.sql
sqlite3 ejercicio-08.db < dml/inserts.sql
sqlite3 ejercicio-08.db < dml/operaciones.sql
sqlite3 ejercicio-08.db < dql/consultas.sql
```

Para validar la estructura:

```bash
sqlite3 ejercicio-08.db ".tables"
sqlite3 ejercicio-08.db ".schema"
```

Para comprobar las llaves foráneas:

```bash
sqlite3 ejercicio-08.db "PRAGMA foreign_keys = ON;"
sqlite3 ejercicio-08.db "PRAGMA foreign_key_check;"
```

El archivo de base de datos utilizado para las pruebas debe eliminarse antes de realizar la entrega.

## Validaciones

La implementación permite comprobar:

- Integridad de las relaciones entre pacientes, médicos, consultorios y citas.
- Prevención de documentos duplicados.
- Prevención de registros profesionales duplicados.
- Prevención de consultorios duplicados.
- Validación de estados permitidos.
- Validación de fechas con formato ISO.
- Control de capacidad de los consultorios.
- Prevención de doble asignación de un médico en el mismo horario.
- Prevención de doble asignación de un consultorio en el mismo horario.

## Decisiones de diseño

Se mantuvieron cuatro tablas para respetar el límite establecido por el ejercicio.

La información de pacientes, médicos y consultorios se mantiene separada de las citas para evitar duplicación de datos y facilitar las consultas mediante relaciones `FOREIGN KEY`.

La fecha y hora de cada cita se almacena en formato ISO `YYYY-MM-DD HH:MM`, permitiendo ordenar cronológicamente los registros.

Los campos de estado utilizan una restricción `CHECK` para limitar los valores válidos a `Programada`, `Confirmada`, `Atendida` y `Cancelada`.

Los índices sobre fecha, paciente y médico permiten facilitar las consultas habituales relacionadas con la agenda.

## Archivos principales

```text
ddl/schema.sql
dml/inserts.sql
dml/operaciones.sql
dql/consultas.sql
diagramas/README.md
```

