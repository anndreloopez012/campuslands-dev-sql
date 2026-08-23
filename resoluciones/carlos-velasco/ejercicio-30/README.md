# Ejercicio 30: Proyecto Integrador SQL

## Información

- **Nombre:** Carlos Velasco
- **Ejercicio:** 30
- **Tema:** Proyecto Integrador SQL
- **Motor:** SQLite
- **Fecha:** 2026-08-20

## Descripción

Se implementó una base de datos relacional para una plataforma académica integral que administra campers, rutas de formación, trainers, módulos, evaluaciones y asistencias.

El modelo permite centralizar la información académica, reducir la duplicidad de datos y generar reportes sobre rendimiento, asistencia, rutas, módulos y trainers.

## Modelo implementado

El proyecto utiliza seis tablas:

| Tabla | Responsabilidad |
| --- | --- |
| `campers` | Información de los estudiantes |
| `trainers` | Información de los responsables académicos |
| `rutas` | Rutas de formación disponibles |
| `modulos` | Módulos pertenecientes a cada ruta |
| `evaluaciones` | Resultados académicos de los campers |
| `asistencias` | Registro de asistencia por camper y módulo |

La estructura se mantiene dentro del límite de seis tablas establecido por el ejercicio.

## Relaciones

```text
TRAINERS
   │
   └──< RUTAS
          │
          └──< MODULOS
                  │
                  ├──< EVALUACIONES >── CAMPERS
                  │
                  └──< ASISTENCIAS >── CAMPERS
```

Las relaciones principales son:

- `rutas.id_trainer` referencia `trainers.id_trainer`.
- `modulos.id_ruta` referencia `rutas.id_ruta`.
- `evaluaciones.id_camper` referencia `campers.id_camper`.
- `evaluaciones.id_modulo` referencia `modulos.id_modulo`.
- `asistencias.id_camper` referencia `campers.id_camper`.
- `asistencias.id_modulo` referencia `modulos.id_modulo`.

## Restricciones

Se implementaron:

- `PRIMARY KEY` en todas las tablas.
- `FOREIGN KEY` para las relaciones.
- `NOT NULL` en los campos obligatorios.
- `UNIQUE` en correos de campers y trainers.
- `UNIQUE` en nombres de rutas.
- `CHECK` para estados.
- `CHECK` para niveles y modalidades.
- `CHECK` para notas entre 0 y 100.
- `CHECK` para horas y orden de módulos.
- `UNIQUE` compuesto para evitar duplicidad de módulos dentro de una ruta.
- `UNIQUE` compuesto para evitar evaluaciones duplicadas.
- `UNIQUE` compuesto para evitar registros de asistencia duplicados.
- `PRAGMA foreign_keys = ON`.

## Datos

El archivo `dml/inserts.sql` contiene:

- 5 trainers.
- 5 rutas.
- 5 campers.
- 10 módulos.
- 10 evaluaciones.
- 10 asistencias.

Las tablas contienen datos relacionados suficientes para generar resultados en las consultas obligatorias.

## Operaciones

El archivo `dml/operaciones.sql` contiene:

- 2 `INSERT` adicionales.
- 2 `UPDATE` válidos.
- 2 `DELETE` controlados mediante `WHERE`.
- 1 operación inválida por restricción `UNIQUE`, comentada.
- 1 operación inválida por restricción `CHECK`, comentada.

Los registros adicionales son eliminados posteriormente para mantener el conjunto de datos base después de validar las operaciones.

## Consultas

El archivo `dql/consultas.sql` incluye las consultas obligatorias:

1. Listado de campers.
2. Selección de dos columnas relevantes.
3. Filtrado de evaluaciones por nota.
4. Ordenamiento de campers por fecha de ingreso.
5. Cinco evaluaciones con mayor nota.
6. Conteo total de campers.
7. Promedio, mínimo y máximo de notas.
8. Agrupación de evaluaciones por módulo.
9. Relaciones mediante `JOIN`.
10. Consulta con `WHERE`, `ORDER BY` y `LIMIT`.
11. Reporte académico con alias.
12. Consulta para identificar campers que requieren seguimiento académico.

También se incluyen reportes adicionales de:

- asistencia;
- rendimiento por ruta;
- rendimiento por módulo;
- trainers asociados a rutas;
- módulos con promedio inferior a 85.

## Ejecución

Desde la raíz de la solución:

```bash
sqlite3 ejercicio-30.db < ddl/schema.sql
sqlite3 ejercicio-30.db < dml/inserts.sql
sqlite3 ejercicio-30.db < dml/operaciones.sql
sqlite3 ejercicio-30.db < dql/consultas.sql
```

## Validación del esquema

```bash
sqlite3 ejercicio-30.db ".tables"
```

```bash
sqlite3 ejercicio-30.db ".schema"
```

```bash
sqlite3 ejercicio-30.db "PRAGMA foreign_keys;"
```

El resultado esperado de `PRAGMA foreign_keys;` es:

```text
1
```

## Validación de relaciones

```bash
sqlite3 ejercicio-30.db "PRAGMA foreign_key_list(rutas);"
sqlite3 ejercicio-30.db "PRAGMA foreign_key_list(modulos);"
sqlite3 ejercicio-30.db "PRAGMA foreign_key_list(evaluaciones);"
sqlite3 ejercicio-30.db "PRAGMA foreign_key_list(asistencias);"
```

## Validación de datos

```sql
SELECT COUNT(*) AS total_campers
FROM campers;

SELECT COUNT(*) AS total_trainers
FROM trainers;

SELECT COUNT(*) AS total_rutas
FROM rutas;

SELECT COUNT(*) AS total_modulos
FROM modulos;

SELECT COUNT(*) AS total_evaluaciones
FROM evaluaciones;

SELECT COUNT(*) AS total_asistencias
FROM asistencias;
```

Los datos base permiten comprobar las relaciones entre campers, rutas, trainers, módulos, evaluaciones y asistencias.

## Evidencias de consultas

La consulta de rendimiento académico permite identificar campers con promedio inferior a los niveles establecidos.

La consulta de asistencia permite obtener el porcentaje de asistencia de cada camper.

La consulta de rendimiento por ruta permite comparar los promedios obtenidos en las diferentes rutas formativas.

La consulta de módulos con rendimiento inferior a 85 permite identificar áreas académicas que requieren seguimiento.

## Decisiones de diseño

Se utilizaron seis tablas para representar las responsabilidades principales del dominio sin superar el máximo establecido.

`campers`, `trainers` y `rutas` representan las entidades principales del sistema académico. `modulos` depende de las rutas y permite organizar el contenido formativo. `evaluaciones` y `asistencias` funcionan como entidades transaccionales relacionadas con campers y módulos.

Las restricciones `CHECK` mantienen valores válidos para estados, niveles, modalidades, notas, horas y orden de módulos.

Las restricciones `UNIQUE` evitan duplicidades en información identificadora y en registros académicos.

Las claves foráneas mantienen la integridad referencial entre las entidades.

Las fechas se almacenan utilizando el formato ISO `YYYY-MM-DD`.

Los índices sobre claves foráneas y columnas de consulta frecuente facilitan las búsquedas relacionadas con campers, módulos, evaluaciones, rutas y asistencias.

No se incluye ningún archivo `.db`, `.sqlite` o `.sqlite3` en la solución.