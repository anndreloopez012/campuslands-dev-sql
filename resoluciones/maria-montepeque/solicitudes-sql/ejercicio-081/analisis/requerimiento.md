# Analisis del requerimiento - Ejercicio 081

## Solicitud entendida

Una empresa alquila autos deportivos y de lujo, y necesita controlar
reservas, clientes y pagos. Hoy todo se maneja en hojas de calculo y
varias personas duplican datos sin darse cuenta: el mismo pago
registrado dos veces, o la misma inspeccion de entrega cargada por
error mas de una vez. Es un nivel 5 (solicitud profesional): ademas
del modelo, se pide interpretar ambiguedad, normalizar datos,
documentar decisiones y crear al menos una vista SQL.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| clientes | Catalogo: cada cliente que renta un vehiculo | nombre_cliente, licencia (unica), telefono (unico) |
| vehiculos | Catalogo: cada auto disponible para renta | modelo, placa (unica), categoria, tarifa_diaria |
| reservas | Tabla transaccional: cada renta de un vehiculo por un cliente | fecha_inicio, fecha_fin, estado |
| pagos | Resultado: el pago de una reserva, uno por reserva | monto, metodo_pago |
| inspecciones | Detalle de cada reserva: revision del vehiculo al entregarlo y al devolverlo | tipo_inspeccion, estado_vehiculo |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| clientes -> reservas | 1:N | Un cliente puede tener varias reservas. |
| vehiculos -> reservas | 1:N | Un vehiculo se renta en muchas reservas distintas a lo largo del tiempo. |
| reservas -> pagos | 1:1 | Cada reserva tiene, como mucho, un pago oficial. |
| reservas -> inspecciones | 1:N (maximo 2) | Una reserva tiene una inspeccion de entrega y, cuando corresponde, una de devolucion. |

## Decisiones de modelado y ambiguedad interpretada

- **Duplicados (el problema central del cliente):** se traduce en dos
  restricciones concretas: `pagos.id_reserva` es `UNIQUE` (una reserva
  no puede tener dos pagos, que era justo el tipo de error que
  describio el cliente en la hoja de calculo), e
  `inspecciones` tiene `UNIQUE (id_reserva, tipo_inspeccion)` (no se
  puede cargar dos veces la inspeccion de entrega de la misma
  reserva).
- **Normalizacion:** `vehiculos.tarifa_diaria` vive en `vehiculos`, no
  en `reservas`, porque es un dato del catalogo, no de la transaccion;
  el monto real cobrado (que puede variar por descuentos, por
  ejemplo) se guarda aparte en `pagos.monto`.
- **Ambiguedad no resuelta por el cliente:** no se detallo si se debe
  validar que un vehiculo no tenga dos reservas con fechas
  encimadas (traslape). Se documenta como una regla de negocio
  deseable pero fuera del alcance de este nivel: SQLite no permite un
  `CHECK` que compare filas distintas de la misma tabla sin un
  `TRIGGER`, asi que esa validacion quedaria para el proceso de
  reserva (aplicacion), no para la base de datos en si.
- **Vista SQL:** se crea `vista_resumen_reservas`, que junta reserva,
  cliente, vehiculo y pago (si existe) en una sola consulta legible.
  Resuelve la necesidad del cliente de "consultar datos" sin tener que
  repetir el mismo `JOIN` de cuatro tablas cada vez.

## Reglas de negocio

- Regla 1 (relaciones invalidas): toda reserva debe apuntar a un
  cliente y a un vehiculo reales; todo pago y toda inspeccion deben
  apuntar a una reserva real (`FOREIGN KEY` en cadena).
- Regla 2 (registros repetidos): `clientes.licencia`,
  `clientes.telefono` y `vehiculos.placa` no se repiten (`UNIQUE`);
  ver duplicados arriba.
- Regla 3 (valores fuera de rango): `vehiculos.tarifa_diaria` y
  `pagos.monto` nunca negativos; `reservas.fecha_fin` siempre
  posterior a `reservas.fecha_inicio` (`CHECK`).
- Regla 4: una reserva nace `'reservada'` y avanza a `'en_curso'`,
  `'finalizada'` o `'cancelada'` (`CHECK`); se corrige con `UPDATE`.
- Regla 5: una inspeccion solo tiene sentido si la reserva sigue
  vigente. Si una reserva se cancela y ya tenia una inspeccion de
  entrega cargada por error (por ejemplo, antes de que el cliente
  llegara), esa fila se elimina; nunca se borra una inspeccion de una
  reserva `'en_curso'` o `'finalizada'`, porque ya es parte del
  historico oficial.

## Supuestos

- Se asume que un cliente puede tener varias reservas activas a la
  vez (no se limita a una reserva por cliente).
- No se detallo penalizacion por cancelacion; se asume que una
  reserva `'cancelada'` simplemente no genera pago.

## Preguntas que responde la base de datos

1. Que reservas existen, con que cliente, que vehiculo y su pago (via
   la vista `vista_resumen_reservas`).
2. Que reservas estan reservadas, en curso, finalizadas o canceladas.
3. Que cliente tiene mas reservas (ranking de actividad).
4. Como se ordenan las reservas por fecha de inicio.
5. Que categoria de vehiculo genero mas ingresos, para decidir en cual
   invertir mas flota.
