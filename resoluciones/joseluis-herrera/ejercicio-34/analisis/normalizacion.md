# Análisis de normalización

## Tabla original sin normalizar

La estructura inicial del archivo plano contiene los siguientes atributos:

```text
paciente
dpi
medico
especialidad
tratamientos
costos
fecha_consulta
```

## Problemas detectados

La estructura original presenta:

- Repetición de información de pacientes.
- Repetición de información de médicos.
- Repetición de especialidades.
- Múltiples tratamientos dentro de una misma celda.
- Múltiples costos dentro de una misma celda.
- Dificultad para modificar los datos de un paciente sin actualizar múltiples filas.
- Dificultad para modificar los datos de un médico o especialidad.
- Riesgo de eliminar información de un paciente, médico o tratamiento al eliminar una consulta.
- Dificultad para calcular costos y generar reportes.
- Dependencias parciales y transitivas.

## Primera Forma Normal

La tabla original no cumple 1FN porque `tratamientos` y `costos` pueden contener múltiples valores.

La transformación separa cada tratamiento en un registro individual:

```text
CONSULTAS
id_consulta
paciente
dpi
medico
especialidad
fecha_consulta

DETALLE_TRATAMIENTO
id_consulta
tratamiento
costo
cantidad
indicaciones
```

Cada atributo contiene ahora un único valor.

## Segunda Forma Normal

Para cumplir 2FN se separan los atributos que dependen únicamente de una parte de la relación entre consulta y tratamiento.

Los datos de la consulta permanecen en `consultas`.

Los datos propios del tratamiento pasan a `tratamientos`.

La relación entre consulta y tratamiento se representa mediante `detalle_tratamiento`.

```text
CONSULTAS
id_consulta -> id_paciente, id_medico, fecha_consulta, diagnostico, estado

TRATAMIENTOS
id_tratamiento -> nombre, descripcion, costo, estado

DETALLE_TRATAMIENTO
(id_consulta, id_tratamiento) -> cantidad, indicaciones
```

## Tercera Forma Normal

Para cumplir 3FN se eliminan las dependencias transitivas.

Los datos de los pacientes se almacenan en `pacientes`.

Los datos de los médicos se almacenan en `medicos`.

Las especialidades se almacenan en `especialidades`.

Los tratamientos se almacenan en `tratamientos`.

Las consultas relacionan pacientes y médicos.

Los tratamientos aplicados a cada consulta se almacenan en `detalle_tratamiento`.

```text
PACIENTES
id_paciente -> dpi, nombre_completo, fecha_nacimiento, telefono, estado

ESPECIALIDADES
id_especialidad -> nombre, descripcion

MEDICOS
id_medico -> nombre_completo, colegiado, id_especialidad, estado

TRATAMIENTOS
id_tratamiento -> nombre, descripcion, costo, estado

CONSULTAS
id_consulta -> id_paciente, id_medico, fecha_consulta, diagnostico, estado

DETALLE_TRATAMIENTO
(id_consulta, id_tratamiento) -> cantidad, indicaciones
```

## Justificación de las tablas finales

### pacientes

Evita repetir los datos personales del paciente en cada consulta.

### especialidades

Permite almacenar cada especialidad una sola vez y relacionarla con los médicos correspondientes.

### medicos

Centraliza la información de cada médico y establece su especialidad mediante una clave foránea.

### tratamientos

Centraliza el nombre, descripción y costo de cada tratamiento.

### consultas

Representa cada atención médica y relaciona al paciente con el médico.

### detalle_tratamiento

Resuelve la relación de muchos a muchos entre consultas y tratamientos y permite registrar cantidades e indicaciones específicas.
