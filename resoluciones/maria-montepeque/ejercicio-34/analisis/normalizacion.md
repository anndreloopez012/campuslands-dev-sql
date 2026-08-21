# Analisis de Normalizacion - Ejercicio 34

## Tabla original

Archivo `datos/datos-sin-normalizar.csv`:

```text
id_consulta,paciente,dpi,medico,especialidad,tratamientos,costos,fecha_consulta
1,Rosa Lima,DPI-200,Dr. Perez,Dental,Limpieza|Radiografia,250|180,2026-06-03
2,Mario Leon,DPI-201,Dra. Gomez,General,Consulta|Laboratorio,200|320,2026-06-03
3,Rosa Lima,DPI-200,Dr. Perez,Dental,Calza|Limpieza,400|250,2026-06-10
```

Es una tabla plana donde cada fila mezcla el encabezado de una consulta (paciente, dpi, medico, especialidad, fecha) con el detalle de los tratamientos aplicados, y `tratamientos` y `costos` guardan varios valores separados por `|` dentro de una sola celda (un grupo repetido por cada tratamiento).

## Problemas detectados

- **Grupos repetidos**: `tratamientos` y `costos` contienen listas de valores (uno por tratamiento) dentro de una misma celda en lugar de una fila por tratamiento.
- **Datos duplicados**: `paciente`, `dpi`, `medico` y `especialidad` de "Rosa Lima" / "Dr. Perez" se repiten completos en las filas 1 y 3 (en este caso si son dos consultas reales, en fechas distintas, pero el archivo plano repite igual toda la informacion del paciente y del medico en cada una).
- **Dependencias parciales**: si se usara como clave compuesta `(id_consulta, tratamiento)` para representar cada linea de tratamiento, datos como `paciente`, `dpi`, `medico`, `especialidad` y `fecha_consulta` dependerian solo de `id_consulta` (parte de la clave), no de la clave completa.
- **Dependencias transitivas**: `especialidad` depende de `medico` (cada medico atiende siempre la misma especialidad: Dr. Perez siempre es "Dental", Dra. Gomez siempre es "General"), y `medico` depende de `id_consulta`; por lo tanto `especialidad` depende transitivamente de `id_consulta` a traves de `medico`. Lo mismo ocurre con `dpi`, que depende de `paciente` y no directamente de `id_consulta`.
- **Anomalias de insercion**: no se puede registrar un medico nuevo (con su especialidad) si todavia no ha atendido ninguna consulta, ni un tratamiento nuevo al catalogo sin inventar una consulta ficticia.
- **Anomalias de actualizacion**: si el `dpi` de "Rosa Lima" cambia, hay que actualizarlo en las filas 1 y 3; si Dr. Perez cambiara de especialidad, habria que corregirlo en todas sus filas. Si se olvida una, quedan datos inconsistentes.
- **Anomalias de eliminacion**: si se elimina la fila 2 (la unica consulta de Mario Leon), se pierde tambien la referencia a la especialidad "General" y a la doctora "Dra. Gomez", aunque en realidad ambas siguen existiendo en la clinica.

## Dependencias funcionales

```text
id_consulta -> paciente, dpi, medico, especialidad, fecha_consulta
paciente -> dpi
medico -> especialidad
(id_consulta, tratamiento) -> costo
```

## Primera Forma Normal (1FN)

Se elimino el grupo repetido dividiendo cada consulta en una fila por cada tratamiento aplicado (usando el separador `|` como guia). La clave paso a ser compuesta `(id_consulta, tratamiento)`, y cada celda quedo con un unico valor atomico (un tratamiento, un costo por fila).

## Segunda Forma Normal (2FN)

Con la clave compuesta `(id_consulta, tratamiento)`, los atributos `paciente`, `dpi`, `medico`, `especialidad` y `fecha_consulta` dependian solo de `id_consulta` (dependencia parcial). Se separaron en una tabla de encabezado:

- `consultas` (paciente, medico y fecha de la consulta), con clave `id_consulta`.
- `tratamientos` (nombre del tratamiento aplicado y su costo dentro de esa consulta), con clave compuesta `(id_consulta, tratamiento)`.

## Tercera Forma Normal (3FN)

Dentro de `consultas` seguia existiendo una dependencia transitiva: `especialidad` dependia de `medico` (no directamente de `id_consulta`), y `dpi` dependia de `paciente` (no directamente de `id_consulta`). Se separaron en catalogos independientes:

- `pacientes` (nombre, dpi), referenciado desde `consultas` por `id_paciente`.
- `especialidades` (nombre), referenciado desde `medicos` por `id_especialidad`.
- `medicos` (nombre, especialidad), referenciado desde `consultas` por `id_medico`.

Con esto, `consultas` solo guarda referencias (`id_paciente`, `id_medico`) y el dato que depende unicamente de `id_consulta` (la fecha), y `medicos` guarda su especialidad por referencia en vez de repetirla como texto.

## Modelo final

| Tabla | Llave primaria | Llaves foraneas | Proposito |
| --- | --- | --- | --- |
| `pacientes` | `id_paciente` | - | Catalogo de pacientes (nombre, dpi unico). |
| `especialidades` | `id_especialidad` | - | Catalogo de especialidades medicas. |
| `medicos` | `id_medico` | `id_especialidad` -> `especialidades` | Catalogo de medicos y su especialidad. |
| `consultas` | `id_consulta` | `id_paciente` -> `pacientes`, `id_medico` -> `medicos` | Encabezado de cada consulta (paciente, medico, fecha). |
| `tratamientos` | `id_tratamiento` | `id_consulta` -> `consultas` | Detalle de cada tratamiento aplicado en una consulta, con su costo. |

## Justificacion

El modelo final elimina los grupos repetidos (1FN) al dar una fila por cada tratamiento aplicado en `tratamientos`. Elimina las dependencias parciales (2FN) al sacar de la consulta todo lo que no depende de la consulta completa: el detalle de cada tratamiento (nombre, costo) queda en `tratamientos`. Elimina las dependencias transitivas (3FN) al separar `pacientes`, `especialidades` y `medicos` de `consultas`, de modo que el dpi del paciente y la especialidad del medico ya no dependen indirectamente de `id_consulta`, sino directamente de sus propias llaves primarias.

Con esto: actualizar el dpi de un paciente o la especialidad de un medico requiere un solo `UPDATE`; se puede registrar un medico o un paciente nuevo sin necesidad de una consulta; y eliminar una consulta ya no borra al paciente ni al medico asociados, porque existen de forma independiente en sus propias tablas. A diferencia de otros ejercicios de esta serie, aqui las filas 1 y 3 del CSV original (misma paciente, mismo medico, distinta fecha) representan dos consultas reales y se mantienen como dos registros separados en `consultas`; la restriccion `UNIQUE (id_paciente, id_medico, fecha_consulta)` solo evita registrar dos veces la misma consulta exacta (mismo paciente, medico y fecha).
