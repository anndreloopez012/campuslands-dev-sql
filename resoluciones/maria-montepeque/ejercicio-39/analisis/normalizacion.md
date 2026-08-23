# Analisis de Normalizacion - Ejercicio 39

## Tabla original

Archivo `datos/datos-sin-normalizar.csv`:

```text
id_contrato,empleado,cargo,departamento,jefe,beneficios,salario,fecha_contrato
1,Marco Luna,Developer Jr,Tecnologia,Ingrid Paz,Seguro|Bono,6500,2026-01-15
2,Claudia Soto,Analista,Datos,Ingrid Paz,Seguro|Parqueo,7200,2026-02-01
3,Marco Luna,Developer Jr,Tecnologia,Ingrid Paz,Capacitacion|Bono,6500,2026-03-01
```

Es una tabla plana donde cada fila es un contrato, pero `beneficios` guarda varios valores separados por `|` en una misma celda, y ademas el `jefe` es en realidad otro empleado de la organizacion representado solo como texto libre (no como una referencia real a otro registro).

## Problemas detectados

- **Grupo repetido**: `beneficios` contiene una lista de beneficios por contrato, en vez de una fila por beneficio.
- **Jefe representado como texto, no como relacion**: "Ingrid Paz" aparece como jefe en las filas 1 y 2 escrita como texto libre; nada impide que se escriba distinto ("I. Paz", "ingrid paz") en otra fila, rompiendo la relacion real entre empleados.
- **Datos duplicados**: `empleado`, `cargo`, `departamento`, `jefe` y `salario` de "Marco Luna" se repiten completos en las filas 1 y 3.
- **Dependencias parciales**: si se usara como clave compuesta `(id_contrato, beneficio)`, el resto de columnas (`empleado`, `cargo`, `departamento`, `jefe`, `salario`, `fecha_contrato`) dependerian solo de `id_contrato`, no de la clave completa.
- **Dependencias transitivas / auto-referencia no reconocida**: el `jefe` es un empleado como cualquier otro (el mismo "Ingrid Paz" podria tener su propio contrato, cargo y salario), pero el diseno original no lo modela como tal, sino como una columna de texto suelta.
- **Anomalias de insercion**: no se puede registrar un beneficio nuevo en el catalogo si todavia no aparece en ningun contrato, ni un cargo o departamento nuevo sin inventar un contrato ficticio.
- **Anomalias de actualizacion**: si el nombre de "Marco Luna" cambiara, habria que corregirlo en las filas 1 y 3; si "Ingrid Paz" cambiara de nombre, habria que corregirlo en cada fila donde aparece como jefe.
- **Anomalias de eliminacion**: si se elimina la fila 2 (el unico contrato de "Claudia Soto"), se pierde tambien la referencia al departamento "Datos", aunque en realidad el departamento sigue existiendo.

## Dependencias funcionales

```text
id_contrato -> empleado, cargo, departamento, jefe, salario, fecha_contrato
(id_contrato, beneficio) -> (pertenencia, sin atributos adicionales)
```

## Primera Forma Normal (1FN)

Se elimino el grupo repetido dividiendo cada contrato en una fila por cada beneficio asignado. La clave paso a ser compuesta `(id_contrato, beneficio)`, y cada celda quedo con un unico valor atomico.

## Segunda Forma Normal (2FN)

Con la clave compuesta `(id_contrato, beneficio)`, los atributos `empleado`, `cargo`, `departamento`, `jefe`, `salario` y `fecha_contrato` dependian solo de `id_contrato` (dependencia parcial). Se separaron en:

- `contratos` (empleado, cargo, departamento, jefe, salario, fecha), con clave `id_contrato`.
- `asignaciones` (beneficio asignado a ese contrato), tabla puente con clave compuesta `(id_contrato, id_beneficio)`.

## Tercera Forma Normal (3FN)

Dentro de `contratos`, `empleado`, `cargo`, `departamento` y `jefe` seguian siendo texto libre repetido. Se separaron en catalogos independientes:

- `empleados` (nombre), referenciado desde `contratos` por `id_empleado`.
- `cargos` (nombre), referenciado desde `contratos` por `id_cargo`.
- `departamentos` (nombre), referenciado desde `contratos` por `id_departamento`.
- `beneficios` (nombre), referenciado desde `asignaciones` por `id_beneficio`.

El `jefe` se reconocio como una auto-referencia a `empleados`: `contratos.id_jefe` apunta a otro registro de la misma tabla `empleados` (puede ser `NULL` para el cargo mas alto, que no reporta a nadie).

## Modelo final

| Tabla | Llave primaria | Llaves foraneas | Proposito |
| --- | --- | --- | --- |
| `empleados` | `id_empleado` | - | Catalogo de personas de la organizacion (empleados y jefes). |
| `cargos` | `id_cargo` | - | Catalogo de cargos. |
| `departamentos` | `id_departamento` | - | Catalogo de departamentos. |
| `beneficios` | `id_beneficio` | - | Catalogo de beneficios. |
| `contratos` | `id_contrato` | `id_empleado`, `id_cargo`, `id_departamento` -> sus catalogos; `id_jefe` -> `empleados` (auto-referencia, opcional) | Contrato de un empleado: cargo, departamento, jefe, salario y fecha. |
| `asignaciones` | `id_asignacion` | `id_contrato` -> `contratos`, `id_beneficio` -> `beneficios` | Tabla puente: beneficios asignados a cada contrato (relacion N:M). |

## Justificacion

El modelo final elimina el grupo repetido (1FN) al dar una fila por cada beneficio asignado en `asignaciones`. Elimina las dependencias parciales (2FN) al sacar del contrato todo lo que no depende del contrato completo: la relacion contrato-beneficio pasa a `asignaciones`. Elimina las dependencias transitivas y el texto repetido (3FN) al convertir `empleado`, `cargo`, `departamento` y `beneficio` en catalogos referenciados por llave, y al reconocer que el `jefe` es una auto-referencia a `empleados` en vez de una columna de texto suelta.

Con esto: actualizar el nombre de un empleado (incluyendo cuando actua como jefe de otros) requiere un solo `UPDATE`; se puede registrar un cargo, departamento o beneficio nuevo sin necesidad de un contrato; y la cadena de mando queda representada de forma consistente (por ejemplo, en los datos de prueba, Karen Xitumul reporta a Luis Bran, que a su vez reporta a Ingrid Paz, que no reporta a nadie). Las filas 1 y 3 del CSV original (mismo empleado, mismo cargo, distinta fecha) se mantienen como dos contratos separados, porque representan una renovacion real.
