## Modelo original sin normalizar

La estructura de partida contiene:

```text
estudiante
documento
ruta
trainer
modulos
horarios
notas
```

Los campos `modulos`, `horarios` y `notas` pueden contener múltiples valores asociados a una misma matrícula, generando grupos repetidos y violando la Primera Forma Normal.

Además, los datos de estudiantes, rutas y trainers se repiten en diferentes registros.

## Dependencias funcionales

Las principales dependencias identificadas son:

```text
documento -> nombre_completo, correo, estado
correo_estudiante -> documento, nombre_completo, estado

correo_trainer -> nombre_completo, especialidad, estado

nombre_ruta -> jornada, estado

(id_ruta, nombre_modulo) -> orden, horario
(id_ruta, orden) -> nombre_modulo, horario

id_matricula -> id_estudiante, id_ruta, id_trainer, fecha_matricula, estado

(id_matricula, id_modulo) -> nota
```

## Primera Forma Normal

Para cumplir 1FN se eliminan los grupos repetidos de módulos, horarios y notas.

Cada módulo evaluado pasa a representar un registro independiente relacionado con una matrícula.

```text
MATRICULAS
id_matricula
estudiante
documento
ruta
trainer
fecha_matricula
estado

NOTAS
id_matricula
modulo
horario
nota
```

Cada atributo almacena un solo valor y los conjuntos repetitivos dejan de estar contenidos dentro de una celda.

## Segunda Forma Normal

Para cumplir 2FN se eliminan las dependencias parciales producidas por las relaciones con claves compuestas.

La información propia de la matrícula se almacena en `matriculas`.

La información de cada módulo se almacena en `modulos`.

La relación entre matrícula y módulo, junto con la nota obtenida, se almacena en `notas`.

```text
MATRICULAS
id_matricula -> id_estudiante, id_ruta, id_trainer, fecha_matricula, estado

MODULOS
id_modulo -> id_ruta, nombre, orden, horario

NOTAS
(id_matricula, id_modulo) -> nota
```

## Tercera Forma Normal

Para cumplir 3FN se eliminan dependencias transitivas.

Los datos de estudiantes se separan de las matrículas.

Los datos de trainers se separan de las matrículas.

Los datos de las rutas se separan de las matrículas.

Los módulos se relacionan directamente con sus rutas.

```text
ESTUDIANTES
id_estudiante -> documento, nombre_completo, correo, estado

TRAINERS
id_trainer -> nombre_completo, correo, especialidad, estado

RUTAS
id_ruta -> nombre, jornada, estado

MODULOS
id_modulo -> id_ruta, nombre, orden, horario

MATRICULAS
id_matricula -> id_estudiante, id_ruta, id_trainer, fecha_matricula, estado

NOTAS
(id_matricula, id_modulo) -> nota
```

## Tablas finales

### estudiantes

Almacena la información única de cada estudiante.

### trainers

Almacena los datos de los trainers responsables de las rutas o matrículas.

### rutas

Representa las rutas académicas disponibles.

### modulos

Representa los módulos pertenecientes a cada ruta y conserva su orden y horario.

### matriculas

Representa la inscripción de un estudiante en una ruta y registra el trainer asignado, la fecha y el estado.