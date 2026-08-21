# Analisis del requerimiento - Ejercicio 066

## Solicitud entendida

Un hotel tematico para gamers recibe reservas, administra habitaciones,
organiza torneos internos (eventos) y registra consumos de sus
huespedes. El cliente pide diferenciar claramente los catalogos
(informacion permanente: huespedes, habitaciones, eventos) de las
operaciones y movimientos (reservas y consumos), para no mezclar ambos
tipos de datos en una sola tabla. Necesita consultar datos, corregir
estados de una reserva, registrar consumos y sacar reportes, por
ejemplo saber cuanto factura cada huesped o que evento tiene mas
inscripciones.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| huespedes | Catalogo: persona que se hospeda; informacion permanente | nombre, telefono (unico) |
| habitaciones | Catalogo: cuarto disponible para reservar; informacion permanente | numero (unico), tipo, precio_noche |
| eventos | Catalogo: torneo interno del hotel; informacion permanente | nombre (unico), fecha_evento, costo_inscripcion |
| reservas | Operacion: un huesped ocupa una habitacion en un rango de fechas | fecha_entrada, fecha_salida, estado |
| consumos | Movimiento: cargo asociado a una reserva (comida, servicios o inscripcion a un evento) | descripcion, monto, fecha_consumo |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| huespedes -> reservas | 1:N | Un huesped puede tener muchas reservas a lo largo del tiempo. |
| habitaciones -> reservas | 1:N | Una habitacion puede reservarse muchas veces (en fechas distintas). |
| reservas -> consumos | 1:N | Una reserva puede generar muchos consumos durante la estadia. |
| eventos -> consumos | 1:N (opcional) | Un evento puede tener muchas inscripciones registradas como consumo; un consumo que no es inscripcion a un evento no referencia ningun evento (`id_evento` admite `NULL`). |

## Reglas de negocio

- Regla 1: para no mezclar catalogos con movimientos, `huespedes`,
  `habitaciones` y `eventos` solo guardan informacion permanente;
  `reservas` y `consumos` son las unicas tablas que registran
  actividad con fecha.
- Regla 2: una reserva nace `'activa'` y solo puede avanzar a
  `'finalizada'` o `'cancelada'` (`CHECK`).
- Regla 3: la fecha de salida de una reserva debe ser posterior a la
  fecha de entrada (`CHECK (fecha_salida > fecha_entrada)`).
- Regla 4: el monto de un consumo y el precio por noche de una
  habitacion deben ser mayores a cero (`CHECK`).
- Regla 5: el numero de habitacion y el nombre de un evento no se
  pueden repetir (`UNIQUE`).

## Supuestos

- El cliente no especifico si un consumo siempre esta ligado a un
  evento; se asume que solo los consumos que son inscripcion a un
  torneo llevan `id_evento`, y el resto (comida, servicios) lo dejan en
  `NULL`.
- No se detallo el precio de la habitacion por noche por tipo de
  cuarto; se asume un precio fijo por habitacion, capturado al crearla.
- Se asume que una reserva cancelada no genera consumos nuevos despues
  de cancelarse (no se modela como restriccion tecnica, es una regla de
  proceso).

## Preguntas que responde la base de datos

1. Cuales son todas las reservas con su huesped y habitacion.
2. Que reservas estan activas, finalizadas o canceladas.
3. Que huesped tiene mas actividad (ranking por numero de consumos).
4. Cuales son los consumos ordenados por fecha, del mas reciente al mas
   antiguo.
5. Cuanto factura cada huesped (habitacion + consumos) y cuales superan
   un monto minimo (reporte para decision de negocio).
