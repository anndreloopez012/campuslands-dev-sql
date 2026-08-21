# Diagrama ER

## Modelo entidad-relacion

El modelo está compuesto por cuatro entidades: `pacientes`, `medicos`, `consultorios` y `citas`.

La tabla `citas` funciona como entidad central y relaciona pacientes, médicos y consultorios mediante llaves foráneas.

```mermaid
erDiagram
    PACIENTES ||--o{ CITAS : "agenda"
    MEDICOS ||--o{ CITAS : "atiende"
    CONSULTORIOS ||--o{ CITAS : "asigna"

    PACIENTES {
        INTEGER id_paciente PK
        TEXT nombre_completo
        TEXT documento UK
        TEXT fecha_nacimiento
        TEXT telefono
        TEXT correo UK
    }

    MEDICOS {
        INTEGER id_medico PK
        TEXT nombre_completo
        TEXT especialidad
        TEXT registro_profesional UK
        TEXT telefono
        TEXT correo UK
    }

    CONSULTORIOS {
        INTEGER id_consultorio PK
        INTEGER numero UK
        INTEGER piso
        TEXT especialidad
        INTEGER capacidad
    }

    CITAS {
        INTEGER id_cita PK
        INTEGER id_paciente FK
        INTEGER id_medico FK
        INTEGER id_consultorio FK
        TEXT fecha_hora
        TEXT motivo
        TEXT estado
    }
```

## Relaciones

- `pacientes` 1:N `citas`: un paciente puede tener múltiples citas y cada cita pertenece a un paciente.
- `medicos` 1:N `citas`: un médico puede atender múltiples citas y cada cita pertenece a un médico.
- `consultorios` 1:N `citas`: un consultorio puede utilizarse en múltiples citas en diferentes horarios y cada cita se asigna a un consultorio.
- `citas` posee restricciones `UNIQUE` sobre la combinación médico-fecha y consultorio-fecha para evitar conflictos de agenda.