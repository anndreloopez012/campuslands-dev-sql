# Analisis del requerimiento - Ejercicio 083

## Solicitud entendida

Una agencia vende experiencias de viaje, turismo y saltos en
paracaidas. El cliente quiere evitar registros incompletos porque
despues no puede hacer reportes confiables: eso significa que el
modelo debe garantizar que cada reserva tenga, como maximo, un pago
oficial (nunca cero pagos duplicados ni dos pagos contradictorios), y
que las reservas repetidas por error no contaminen los reportes. Se
necesita una base de datos que permita consultar datos, corregir
estados, registrar movimientos y sacar reportes utiles.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| clientes | Catalogo: cada cliente que reserva una experiencia | nombre_cliente, telefono (unico) |
| experiencias | Catalogo: cada experiencia disponible (salto, tour, buceo) | nombre_experiencia (unica), tipo, precio |
| instructores | Catalogo: cada instructor que guia una experiencia | nombre_instructor (unico), certificacion |
| reservas | Tabla transaccional: un cliente reserva una experiencia con un instructor | fecha_reserva, estado |
| pagos | Resultado: el pago de una reserva, uno por reserva | monto, metodo_pago |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| clientes -> reservas | 1:N | Un cliente puede tener varias reservas. |
| experiencias -> reservas | 1:N | Una experiencia se reserva muchas veces. |
| instructores -> reservas | 1:N | Un instructor guia muchas reservas distintas. |
| reservas -> pagos | 1:1 | Cada reserva tiene, como mucho, un pago oficial. |

## Decisiones de modelado y ambiguedad interpretada

- **Registros incompletos/duplicados (el problema central del
  cliente):** se traduce en dos restricciones concretas:
  `UNIQUE (id_cliente, id_experiencia, fecha_reserva)` en `reservas`
  (evita registrar la misma reserva dos veces por error de captura), y
  `UNIQUE (id_reserva)` en `pagos` (evita que una reserva tenga dos
  pagos, que dejaria el reporte de ingresos poco confiable).
- **Vista SQL:** se crea `vista_resumen_reservas`, que junta reserva,
  cliente, experiencia, instructor y pago (si existe) con `LEFT JOIN`.
  Esto ataca directamente el problema de "reportes no confiables":
  una reserva sin pago todavia no desaparece del reporte, aparece con
  `monto_pagado = NULL`, visible y explicito, en vez de quedar oculta
  por un `JOIN` normal.
- **Ambiguedad no resuelta por el cliente:** no se detallo si un
  instructor puede guiar dos experiencias distintas el mismo dia a la
  misma hora (conflicto de horario). Se documenta como una regla
  deseable pero fuera del alcance de este nivel: validar solapamiento
  de horarios entre reservas requeria comparar filas distintas de la
  misma tabla, lo que en SQLite exige un `TRIGGER`, no un `CHECK`
  simple.

## Reglas de negocio

- Regla 1 (relaciones invalidas): toda reserva debe apuntar a un
  cliente, una experiencia y un instructor reales; todo pago debe
  apuntar a una reserva real (`FOREIGN KEY` en cadena).
- Regla 2 (registros repetidos/incompletos): ver arriba.
- Regla 3 (valores fuera de rango): `experiencias.precio` y
  `pagos.monto` nunca negativos (`CHECK`).
- Regla 4: una reserva nace `'programada'` y avanza a `'confirmada'`,
  `'realizada'` o `'cancelada'` (`CHECK`); se corrige con `UPDATE`.
- Regla 5: un pago solo se elimina con `DELETE` cuando la reserva a la
  que pertenece se cancela y ese pago resulto ser un error (por
  ejemplo, se proceso el cobro de una reserva que en realidad no se
  confirmo). Un pago de una reserva `'realizada'` nunca se borra,
  porque ya es un resultado oficial.

## Supuestos

- El cliente no detallo si el precio de una experiencia puede variar
  por reserva (por ejemplo, descuentos); se guarda el monto real
  cobrado en `pagos.monto`, separado del precio de catalogo en
  `experiencias.precio`.
- Se asume que un instructor puede repetirse en varias reservas de la
  misma experiencia sin restriccion adicional.

## Preguntas que responde la base de datos

1. Que reservas existen, con su cliente, experiencia, instructor y
   pago (via la vista `vista_resumen_reservas`).
2. Que reservas estan programadas, confirmadas, realizadas o
   canceladas.
3. Que cliente tiene mas reservas (ranking de actividad).
4. Como se ordenan las reservas por fecha.
5. Que tipo de experiencia genero mas ingresos, para decidir en cual
   invertir mas promocion.
