# Diagrama ER

## Ejercicio 19: Universidad Notas

```mermaid
erDiagram
    PROFESORES ||--o{ MATERIAS : "imparte"
    ESTUDIANTES ||--o{ NOTAS : "obtiene"
    MATERIAS ||--o{ NOTAS : "recibe"

    ESTUDIANTES {
        INTEGER id_estudiante PK
        TEXT nombre_completo
        TEXT correo UK
        TEXT fecha_ingreso
        INTEGER semestre
    }

    PROFESORES {
        INTEGER id_profesor PK
        TEXT nombre_completo
        TEXT correo UK
        TEXT especialidad
    }

    MATERIAS {
        INTEGER id_materia PK
        INTEGER id_profesor FK
        TEXT codigo UK
        TEXT nombre
        INTEGER creditos
    }

    NOTAS {
        INTEGER id_nota PK
        INTEGER id_estudiante FK
        INTEGER id_materia FK
        REAL calificacion
        TEXT fecha_evaluacion
        TEXT tipo_evaluacion
    }
```

## Relaciones

- `profesores` mantiene una relación de uno a muchos con `materias`.
- `estudiantes` mantiene una relación de uno a muchos con `notas`.
- `materias` mantiene una relación de uno a muchos con `notas`.
- Cada materia pertenece obligatoriamente a un profesor.
- Cada nota pertenece obligatoriamente a un estudiante.
- Cada nota corresponde obligatoriamente a una materia.

## Restricciones relevantes

- `PRIMARY KEY` en las cuatro tablas.
- `FOREIGN KEY` entre profesores y materias.
- `FOREIGN KEY` entre estudiantes y notas.
- `FOREIGN KEY` entre materias y notas.
- `UNIQUE` en los correos de estudiantes y profesores.
- `UNIQUE` en el código de materia.
- `UNIQUE` compuesto para evitar duplicar una evaluación del mismo estudiante, materia, fecha y tipo.
- `CHECK` para mantener semestres válidos.
- `CHECK` para mantener créditos entre 1 y 6.
- `CHECK` para mantener calificaciones entre 0 y 5.
- `CHECK` para restringir los tipos de evaluación permitidos.