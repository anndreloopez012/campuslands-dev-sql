# Diagrama ER

## Modelo relacional

La plataforma académica integral se modela mediante seis entidades relacionadas. `campers` representa a los estudiantes, `trainers` a los responsables académicos, `rutas` los recorridos formativos, `modulos` los componentes de cada ruta, `evaluaciones` los resultados académicos y `asistencias` el control de participación.

```mermaid
erDiagram
    TRAINERS {
        INTEGER id_trainer PK
        TEXT nombre_completo
        TEXT correo UK
        TEXT especialidad
        TEXT fecha_ingreso
        TEXT estado
    }

    RUTAS {
        INTEGER id_ruta PK
        TEXT nombre UK
        TEXT nivel
        TEXT modalidad
        INTEGER id_trainer FK
        TEXT fecha_inicio
        TEXT estado
    }

    CAMPERS {
        INTEGER id_camper PK
        TEXT nombre_completo
        TEXT correo UK
        TEXT telefono
        TEXT fecha_ingreso
        TEXT estado
    }

    MODULOS {
        INTEGER id_modulo PK
        INTEGER id_ruta FK
        TEXT nombre
        INTEGER orden
        INTEGER horas
        TEXT estado
    }

    EVALUACIONES {
        INTEGER id_evaluacion PK
        INTEGER id_camper FK
        INTEGER id_modulo FK
        TEXT fecha_evaluacion
        REAL nota
        TEXT tipo
        TEXT estado
    }

    ASISTENCIAS {
        INTEGER id_asistencia PK
        INTEGER id_camper FK
        INTEGER id_modulo FK
        TEXT fecha
        TEXT estado
        TEXT observacion
    }

    TRAINERS ||--o{ RUTAS : dirige
    RUTAS ||--|{ MODULOS : contiene
    CAMPERS ||--o{ EVALUACIONES : recibe
    MODULOS ||--o{ EVALUACIONES : genera
    CAMPERS ||--o{ ASISTENCIAS : registra
    MODULOS ||--o{ ASISTENCIAS : corresponde
```

## Relaciones

- Un trainer puede dirigir una o varias rutas.
- Cada ruta pertenece obligatoriamente a un trainer.
- Una ruta contiene uno o varios módulos.
- Cada módulo pertenece obligatoriamente a una ruta.
- Un camper puede tener múltiples evaluaciones.
- Cada evaluación pertenece a un camper y a un módulo.
- Un camper puede tener múltiples registros de asistencia.
- Cada asistencia pertenece a un camper y a un módulo.

## Restricciones relevantes

- Las claves primarias identifican cada registro.
- Los correos de campers y trainers son únicos.
- Los nombres de las rutas son únicos.
- La nota de una evaluación debe estar entre 0 y 100.
- El orden de los módulos debe ser mayor que cero.
- Las horas de los módulos deben ser mayores que cero.
- Los valores de nivel, modalidad y estados están restringidos mediante `CHECK`.
- Las combinaciones de ruta y orden de módulo son únicas.
- Las combinaciones de ruta y nombre de módulo son únicas.
- Las combinaciones de camper, módulo y fecha de evaluación son únicas.
- Las combinaciones de camper, módulo y fecha de asistencia son únicas.
- Todas las relaciones se implementan mediante claves foráneas.