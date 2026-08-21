# Ejercicio 19: Universidad Notas

## Información

- **Nombre:** Carlos Velasco
- **Fecha:** 2026-08-20
- **Motor:** SQLite
- **Ejercicio:** 19
- **Tema:** Registro académico y promedios

## Descripción

La solución modela un sistema académico universitario destinado a gestionar estudiantes, profesores, materias y notas.

El modelo permite relacionar las evaluaciones con el estudiante y la materia correspondiente, además de identificar al profesor responsable de cada asignatura.

## Modelo implementado

La base de datos utiliza cuatro tablas:

| Tabla | Responsabilidad |
| --- | --- |
| `estudiantes` | Almacenar la información académica básica de los estudiantes. |
| `profesores` | Registrar los profesores y su especialidad. |
| `materias` | Mantener el catálogo de asignaturas y su profesor responsable. |
| `notas` | Registrar las evaluaciones obtenidas por los estudiantes. |

### Relaciones

```text
PROFESORES 1 ─────── N MATERIAS
ESTUDIANTES 1 ────── N NOTAS
MATERIAS 1 ───────── N NOTAS
```

## Restricciones

Se implementaron:

- Llaves primarias en todas las tablas.
- Llaves foráneas para garantizar integridad referencial.
- `NOT NULL` en los campos obligatorios.
- `UNIQUE` en los correos de estudiantes y profesores.
- `UNIQUE` en el código de cada materia.
- `UNIQUE` compuesto para evitar evaluaciones duplicadas.
- `CHECK` para validar semestres.
- `CHECK` para validar créditos académicos.
- `CHECK` para mantener las calificaciones entre 0 y 5.
- `CHECK` para controlar los tipos de evaluación.
- `CHECK` para validar fechas.
- `PRAGMA foreign_keys = ON`.

## Datos registrados

Se incluyen:

- 5 estudiantes.
- 5 profesores.
- 5 materias.
- 10 notas.

Los datos están relacionados mediante claves foráneas y permiten ejecutar las consultas académicas solicitadas.

## Operaciones DML

El archivo `dml/operaciones.sql` contiene:

- 2 `INSERT` adicionales.
- 2 `UPDATE` válidos.
- 2 `DELETE` controlados mediante `WHERE`.
- 2 operaciones inválidas comentadas.

Las operaciones inválidas corresponden a:

```sql
-- CHECK por una calificación superior al máximo permitido.
-- FOREIGN KEY por un estudiante inexistente.
```

## Consultas implementadas

El archivo `dql/consultas.sql` contiene consultas para:

1. Listar todas las notas.
2. Mostrar dos columnas relevantes.
3. Filtrar notas por calificación.
4. Ordenar resultados por rendimiento.
5. Obtener las cinco mejores calificaciones.
6. Contar evaluaciones.
7. Calcular promedio, mínimo y máximo.
8. Agrupar resultados por materia.
9. Relacionar estudiantes, notas y materias.
10. Utilizar `WHERE`, `ORDER BY` y `LIMIT`.
11. Generar un reporte académico con alias.
12. Identificar estudiantes que requieren seguimiento académico.

También se incluye un reporte de rendimiento agrupado por profesor y materia.

## Ejecución

Desde la raíz de `ejercicio-19`:

```bash
sqlite3 ejercicio-19.db < ddl/schema.sql
sqlite3 ejercicio-19.db < dml/inserts.sql
sqlite3 ejercicio-19.db < dml/operaciones.sql
sqlite3 ejercicio-19.db < dql/consultas.sql
```

No se debe incluir el archivo de base de datos generado durante las pruebas.

## Validaciones

La estructura puede verificarse mediante:

```bash
sqlite3 ejercicio-19.db ".tables"
sqlite3 ejercicio-19.db "PRAGMA foreign_keys;"
sqlite3 ejercicio-19.db "PRAGMA foreign_key_check;"
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

no debe devolver registros cuando las relaciones son válidas.

## Decisiones de diseño

Se mantuvieron cuatro tablas para respetar el límite establecido por el ejercicio.

La tabla `notas` funciona como entidad transaccional académica y relaciona estudiantes con materias. La tabla `materias` mantiene la relación con el profesor responsable, evitando duplicar información del profesor en cada nota.

La calificación se almacenó como `REAL` para permitir valores decimales dentro del rango académico de 0 a 5.

El tipo de evaluación se controla mediante `CHECK` para impedir valores que no formen parte del catálogo definido.

Los índices se agregaron sobre las claves foráneas y la fecha de evaluación para facilitar las relaciones y consultas frecuentes.

## Archivos principales

```text
README.md
diagramas/README.md
ddl/schema.sql
dml/inserts.sql
dml/operaciones.sql
dql/consultas.sql
```