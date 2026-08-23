# Diagrama ER

## Modelo entidad-relación

```mermaid
erDiagram
    DEPARTAMENTOS ||--o{ EMPLEADOS : "tiene"
    CARGOS ||--o{ EMPLEADOS : "asigna"
    EMPLEADOS ||--o{ CONTRATOS : "posee"

    DEPARTAMENTOS {
        INTEGER id_departamento PK
        TEXT nombre UK
        REAL presupuesto_anual
    }

    CARGOS {
        INTEGER id_cargo PK
        TEXT nombre UK
        REAL salario_base
    }

    EMPLEADOS {
        INTEGER id_empleado PK
        INTEGER id_departamento FK
        INTEGER id_cargo FK
        TEXT nombre_completo
        TEXT correo UK
        TEXT fecha_ingreso
        TEXT estado
    }

    CONTRATOS {
        INTEGER id_contrato PK
        INTEGER id_empleado FK
        TEXT fecha_inicio
        TEXT fecha_fin
        TEXT tipo_contrato
        REAL salario
    }
```

## Relaciones

- Un departamento puede tener cero o muchos empleados.
- Un empleado pertenece obligatoriamente a un departamento.
- Un cargo puede estar asignado a cero o muchos empleados.
- Un empleado tiene obligatoriamente un cargo.
- Un empleado puede tener cero o muchos contratos.
- Cada contrato pertenece obligatoriamente a un empleado.

## Restricciones representadas

- `PK`: llave primaria.
- `FK`: llave foránea.
- `UK`: restricción `UNIQUE`.
- `NOT NULL`: aplicada a los atributos obligatorios.
- `CHECK`: aplicada a presupuestos, salarios, fechas, estados y tipos de contrato.