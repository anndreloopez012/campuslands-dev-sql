# Analisis del requerimiento - Ejercicio 007

## Solicitud entendida

Una academia de kickboxing gestiona alumnos, planes, entrenadores y asistencias. El cliente pidio explicitamente que el sistema permita corregir estados sin borrar informacion importante: por ejemplo, si un alumno deja de pagar o se retira temporalmente, no se debe eliminar su registro, solo cambiar su estado. Tambien quiere consultar datos y sacar reportes.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| planes | Es el catalogo de planes que ofrece la academia (basico, intermedio, avanzado, etc.), cada uno con su precio y clases por semana. | nombre_plan (unico), precio_mensual, clases_por_semana |
| alumnos | Es el registro central de cada alumno inscrito: a que plan pertenece, cuando se inscribio y en que estado esta. Aqui vive la peticion central del cliente: corregir estados sin borrar. | id_plan (FK), nombre_completo, fecha_inscripcion, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| planes -> alumnos | 1:N | Un plan tiene muchos alumnos inscritos, pero cada alumno pertenece a un unico plan. |

## Reglas de negocio

- Regla 1: Todo alumno debe pertenecer a un plan valido del catalogo (`FOREIGN KEY`).
- Regla 2: `precio_mensual` y `clases_por_semana` siempre deben ser mayores a cero (`CHECK`).
- Regla 3: Un alumno puede estar `activo`, `suspendido`, `inactivo` o `graduado` (`CHECK`); el cliente pidio explicitamente poder corregir este estado en vez de borrar al alumno (por ejemplo, de `suspendido` de vuelta a `activo` cuando se pone al dia con el pago).
- Regla 4: El nombre del plan no se repite (`UNIQUE`), evita cargar el mismo plan dos veces.

## Supuestos

- No se creo una tabla `entrenadores` ni `asistencias` separadas: el alcance de este nivel pide 1 a 2 tablas, asi que el modelo se centra en `planes` y `alumnos`, que es donde vive directamente la peticion del cliente (corregir estados). Si mas adelante se necesita registrar asistencia clase por clase, se separaria en su propia tabla transaccional.
- El estado por defecto de un alumno nuevo es `activo`, porque asi entra normalmente una inscripcion nueva.
- Solo se elimina un registro (`DELETE`) cuando nunca debio existir (por ejemplo, una entrada de prueba); un alumno real que se retira o suspende SIEMPRE se corrige con `UPDATE` de estado, nunca se borra, siguiendo la peticion explicita del cliente.

## Preguntas que responde la base de datos

1. Que alumnos existen y en que estado quedo cada uno.
2. Que alumnos no estan activos (suspendidos, inactivos o graduados).
3. Que plan tiene mas alumnos activos.
4. Como se ordenan los alumnos por fecha de inscripcion.
5. Que reporte de ingreso mensual estimado por plan (solo alumnos activos) puede usar la academia para decidir donde invertir.
