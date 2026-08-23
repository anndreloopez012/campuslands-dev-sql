# Diagrama ER

El modelo de Academia de Cursos utiliza cuatro tablas:

- `cursos`
- `instructores`
- `estudiantes`
- `matriculas`

La tabla `matriculas` funciona como entidad transaccional y relaciona estudiantes, cursos e instructores.

```mermaid
erDiagram
    CURSOS ||--o{ MATRICULAS : contiene
    INSTRUCTORES ||--o{ MATRICULAS : imparte
    ESTUDIANTES ||--o{ MATRICULAS : realiza

    CURSOS {
        INTEGER id_curso PK
        TEXT nombre UK
        TEXT categoria
        INTEGER duracion_horas
        TEXT nivel
    }

    INSTRUCTORES {
        INTEGER id_instructor PK
        TEXT nombre_completo
        TEXT email UK
        TEXT especialidad
    }

    ESTUDIANTES {
        INTEGER id_estudiante PK
        TEXT nombre_completo
        TEXT email UK
        TEXT fecha_nacimiento
        TEXT ciudad
    }

    MATRICULAS {
        INTEGER id_matricula PK
        INTEGER id_estudiante FK
        INTEGER id_curso FK
        INTEGER id_instructor FK
        TEXT fecha_matricula
        INTEGER progreso
        TEXT estado
    }
```

## Relaciones

- Un curso puede tener múltiples matrículas.
- Un instructor puede estar asociado a múltiples matrículas.
- Un estudiante puede realizar múltiples matrículas.
- Cada matrícula pertenece a un único estudiante.
- Cada matrícula corresponde a un único curso.
- Cada matrícula tiene un instructor responsable.

## Restricciones

- Todas las tablas tienen `PRIMARY KEY`.
- Las relaciones utilizan `FOREIGN KEY`.
- Los nombres de cursos son únicos.
- Los correos de instructores son únicos.
- Los correos de estudiantes son únicos.
- La combinación estudiante-curso es única para evitar matrículas duplicadas.
- La duración de los cursos debe ser positiva.
- El nivel del curso está restringido mediante `CHECK`.
- El progreso debe estar entre 0 y 100.
- El estado de la matrícula está restringido mediante `CHECK`.
- Las fechas utilizan formato ISO.
- Las claves foráneas están habilitadas mediante `PRAGMA foreign_keys = ON`.