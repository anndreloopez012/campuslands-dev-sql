# Analisis del requerimiento - Ejercicio 082

## Solicitud entendida

Una academia de kickboxing gestiona alumnos, planes de membresia,
entrenadores y asistencias a clases. El cliente pide saber quien
compro, que compro, cuando ocurrio y cuanto dinero representa cada
movimiento: en esta academia eso se traduce directo en la tabla de
pagos (quien = alumno, que = plan, cuando = fecha_pago, cuanto =
monto). Es un nivel 5 (solicitud profesional): ademas del modelo, se
pide interpretar ambiguedad, normalizar datos, documentar decisiones
y crear al menos una vista SQL.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| alumnos | Catalogo: cada alumno inscrito | nombre_alumno, telefono (unico) |
| planes | Catalogo: cada plan de membresia disponible | nombre_plan (unico), precio_mensual, clases_por_semana |
| entrenadores | Catalogo: cada entrenador de la academia | nombre_entrenador (unico), especialidad |
| asistencias | Tabla transaccional: cada clase a la que asiste un alumno | fecha_clase |
| pagos | Resultado: quien pago, que plan, cuando y cuanto (respuesta directa a la solicitud del cliente) | monto, fecha_pago, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| alumnos -> asistencias | 1:N | Un alumno asiste a muchas clases. |
| entrenadores -> asistencias | 1:N | Un entrenador da muchas clases. |
| alumnos -> pagos | 1:N | Un alumno puede tener varios pagos (uno por mes, por ejemplo). |
| planes -> pagos | 1:N | Un plan se paga en muchos pagos distintos. |

## Decisiones de modelado y ambiguedad interpretada

- **Mapeo directo de la solicitud:** "quien compro, que compro, cuando
  y cuanto dinero" se resolvio sin ambiguedad porque el negocio de la
  academia ya tiene ese concepto exacto: un alumno paga
  (`pagos.id_alumno`) un plan (`pagos.id_plan`), en una fecha
  (`pagos.fecha_pago`), por un monto (`pagos.monto`). No hizo falta
  forzar una interpretacion distinta, a diferencia de otras
  solicitudes de esta serie donde la misma frase no encajaba
  directamente con el dominio.
- **Normalizacion:** `planes.precio_mensual` vive en el catalogo, pero
  el monto real cobrado se guarda aparte en `pagos.monto`, porque el
  cliente podria pagar con descuento o un monto distinto al de lista
  (el cliente no lo prohibio, asi que se deja abierto).
- **Registros repetidos (ambiguedad no explicita, pero relevante):**
  el cliente no menciono el problema de datos duplicados en este
  ejercicio, pero por buena practica se agrego
  `UNIQUE (id_alumno, id_entrenador, fecha_clase)` en `asistencias`,
  para que la misma asistencia no se pueda registrar dos veces por
  error.
- **Vista SQL:** se crea `vista_pagos_alumnos`, que responde
  literalmente la pregunta del cliente (quien, que, cuando, cuanto) en
  una sola consulta legible, sin repetir el `JOIN` cada vez.

## Reglas de negocio

- Regla 1 (relaciones invalidas): toda asistencia debe apuntar a un
  alumno y a un entrenador reales; todo pago debe apuntar a un alumno
  y a un plan reales (`FOREIGN KEY` en cadena).
- Regla 2 (registros repetidos): `alumnos.telefono`,
  `planes.nombre_plan` y `entrenadores.nombre_entrenador` no se
  repiten (`UNIQUE`); una asistencia no se registra dos veces para el
  mismo alumno, entrenador y fecha (`UNIQUE` compuesto).
- Regla 3 (valores fuera de rango): `planes.precio_mensual`,
  `planes.clases_por_semana` y `pagos.monto` nunca negativos o cero
  segun corresponda (`CHECK`).
- Regla 4: un pago nace `'pendiente'` y avanza a `'pagado'` o
  `'vencido'` (`CHECK`); se corrige con `UPDATE`.
- Regla 5: una asistencia se puede eliminar con `DELETE` solo cuando
  fue un error de captura confirmado (por ejemplo, se marco
  asistencia a un alumno que en realidad no fue). No se borra el
  historico de asistencias reales, ni se usa `DELETE` para "dar de
  baja" a un alumno que deja de venir (eso se maneja simplemente
  dejando de registrar asistencias nuevas, sin tocar las anteriores).

## Supuestos

- El cliente no detallo si un alumno puede tener varios planes al
  mismo tiempo; se asume que si, mientras cada pago referencia el plan
  que corresponde a ese cobro especifico.
- No se detallo un limite de asistencias por semana segun el plan
  (`clases_por_semana`); se asume que ese limite es informativo para
  el negocio y no se valida automaticamente en este nivel.

## Preguntas que responde la base de datos

1. Quien pago, que plan, cuando y cuanto (via la vista
   `vista_pagos_alumnos`).
2. Que pagos estan pendientes, pagados o vencidos.
3. Que alumno tiene mas asistencias (ranking de actividad).
4. Como se ordenan los pagos por fecha.
5. Que plan genero mas ingresos, para decidir en cual invertir mas
   promocion.
