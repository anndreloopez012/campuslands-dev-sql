# Analisis del requerimiento - Ejercicio 032

## Solicitud entendida

Una academia de kickboxing gestiona alumnos, planes, entrenadores y asistencias. El cliente pidio saber quien pago, que plan cubre ese pago, cuando ocurrio y cuanto dinero representa cada movimiento.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| planes | Es el catalogo de planes de entrenamiento, cada uno con su precio mensual. | nombre_plan (unico), precio_mensual |
| alumnos | Es el catalogo de alumnos, cada uno con su plan y entrenador asignado. | id_plan (FK), nombre_completo (unico), entrenador_asignado |
| pagos | Es el registro transaccional de cada pago: quien pago, cuando y cuanto. Aqui vive directamente la pregunta del cliente. | id_alumno (FK), monto_pagado, fecha_pago, metodo_pago, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| planes -> alumnos | 1:N | Un plan tiene varios alumnos inscritos. |
| alumnos -> pagos | 1:N | Un alumno hace muchos pagos a lo largo del tiempo (uno por mes, por ejemplo). |

## Reglas de negocio

- Regla 1: Todo alumno debe pertenecer a un plan real (`FOREIGN KEY`), y todo pago debe pertenecer a un alumno real (`FOREIGN KEY`).
- Regla 2: `precio_mensual` y `monto_pagado` siempre deben ser mayores a cero (`CHECK`).
- Regla 3: Un pago puede estar `confirmado`, `pendiente` o `rechazado` (`CHECK`); la academia necesita poder corregir este estado (por ejemplo, cuando se verifica una transferencia o una tarjeta rechazada).
- Regla 4: `nombre_plan` y `nombre_completo` no se repiten (`UNIQUE`).
- Regla 5: `metodo_pago` solo puede ser uno de los valores permitidos (`CHECK`).

## Supuestos

- No se creo una tabla `entrenadores` separada: el entrenador se guarda como texto dentro de `alumnos`, ya que el alcance de este nivel pide 2 a 3 tablas con relaciones uno a muchos, y el foco esta en planes/alumnos/pagos.
- El "que" de la pregunta del cliente (que compro) se responde a traves del plan del alumno, sin necesidad de repetirlo en cada pago.

## Preguntas que responde la base de datos

1. Que pagos existen y en que estado quedo cada uno.
2. Que pagos no estan confirmados todavia.
3. Que alumno tiene mas pagos registrados.
4. Como se ordenan los pagos por fecha.
5. Cuanto recaudo la academia por plan (sin pagos rechazados), para decisiones financieras.
