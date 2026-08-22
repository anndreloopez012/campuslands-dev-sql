# Análisis de Normalización

## 1. Tabla original sin normalizar

La estructura original puede representarse como:

| empleado | cargo | departamento | jefe | beneficios | salario | fecha_contrato |
|---|---|---|---|---|---:|---|
| Ana López | Gerente de Operaciones | Operaciones | Carlos Méndez | Seguro médico, Bono alimentación | 8500 | 2024-01-15 |
| Carlos Méndez | Director General | Dirección | | Seguro médico, Seguro de vida | 15000 | 2022-03-10 |
| María García | Analista de Recursos Humanos | Recursos Humanos | Carlos Méndez | Seguro médico, Bono alimentación | 5200 | 2024-02-01 |
| José Ramírez | Desarrollador Backend | Tecnología | Ana López | Seguro médico, Bono transporte | 6800 | 2023-08-21 |
| Laura Pérez | Diseñadora UX/UI | Tecnología | Ana López | Seguro médico, Bono transporte | 6200 | 2024-04-12 |

```

## 2. Primera Forma Normal

La tabla original no cumple completamente 1FN debido principalmente a:

```text
beneficios
```

porque puede contener valores como:

```text
Seguro médico, Bono alimentación
```

Para cumplir 1FN se separan los beneficios en registros individuales.

La relación resultante puede representarse como:

```text
EMPLEADO_BENEFICIO(
    empleado,
    beneficio
)
```

Cada celda contiene un único valor.

## 3. Segunda Forma Normal

La relación de beneficios puede tener una clave compuesta:

```text
(empleado, beneficio)
```

Los datos asociados únicamente al empleado no deben depender de toda la clave compuesta.

Por esta razón se separan:

```text
EMPLEADOS
BENEFICIOS
ASIGNACIONES_BENEFICIOS
```

La tabla puente `asignaciones_beneficios` conserva únicamente los datos que dependen de la relación entre empleado y beneficio.

También se separa la información laboral relacionada con contratos:

```text
EMPLEADOS
CONTRATOS
```

## 4. Tercera Forma Normal

Para cumplir 3FN se eliminan dependencias transitivas.

La información del cargo se mantiene en:

```text
CARGOS
```

La información del departamento se mantiene en:

```text
DEPARTAMENTOS
```

La información de los beneficios se mantiene en:

```text
BENEFICIOS
```

Los empleados solamente almacenan las claves foráneas correspondientes.

El jefe se representa mediante una relación recursiva de `empleados`:

```text
empleados.id_jefe → empleados.id_empleado
```

## 5. Modelo final

El modelo final contiene:

```text
DEPARTAMENTOS
CARGOS
EMPLEADOS
CONTRATOS
BENEFICIOS
ASIGNACIONES_BENEFICIOS
```

### Departamentos

Almacena la información independiente de cada departamento.

### Cargos

Almacena los cargos disponibles y su salario base.

### Empleados

Almacena la información propia del empleado y referencia su cargo, departamento y jefe.

### Contratos

Almacena la información contractual del empleado, incluyendo salario y fecha de contratación.

### Beneficios

Almacena el catálogo de beneficios disponibles.

### Asignaciones de beneficios

Resuelve la relación muchos a muchos entre empleados y beneficios.

## 6. Justificación del modelo

El modelo evita repetir nombres de departamentos, cargos y beneficios en cada registro de empleado.

La información de contratos puede crecer independientemente del registro principal del empleado.

La relación entre empleados y beneficios se normaliza mediante una tabla puente.

La relación jerárquica entre empleados permite representar a un empleado como jefe de otros empleados sin almacenar nuevamente sus datos.

El resultado cumple con 1FN, 2FN y 3FN y reduce las anomalías de inserción, actualización y eliminación.