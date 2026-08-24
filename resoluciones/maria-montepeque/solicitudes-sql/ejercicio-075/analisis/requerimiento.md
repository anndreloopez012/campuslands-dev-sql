# Analisis del requerimiento - Ejercicio 075

## Solicitud entendida

Una pista organiza sesiones de track day con vehiculos
hiperdeportivos, pilotos y tiempos por vuelta. El cliente no habla en
terminos de tablas, solo describe su operacion diaria: pilotos que se
inscriben, corren varias vueltas en una sesion, y pagan por
participar. Se necesita una base de datos que permita consultar
datos, corregir estados, registrar movimientos y sacar reportes
utiles, como que pilotos tienen el mejor tiempo promedio para
invitarlos al siguiente evento.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| pilotos | Catalogo: cada piloto inscrito en la pista | nombre_piloto (unico), licencia (unica) |
| vehiculos | Catalogo: cada vehiculo hiperdeportivo disponible | modelo (unico), categoria |
| sesiones | Tabla transaccional: cada dia de track day, en una fecha y una pista | fecha_sesion, pista, estado |
| tiempos | Detalle de cada sesion: el tiempo de cada vuelta de cada piloto con su vehiculo | vuelta, tiempo_segundos |
| pagos | Registro de lo que cada piloto pago por participar en una sesion | monto, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| sesiones -> tiempos | 1:N | Una sesion tiene muchas vueltas registradas. |
| pilotos -> tiempos | 1:N | Un piloto corre muchas vueltas a lo largo de varias sesiones. |
| vehiculos -> tiempos | 1:N | Un vehiculo se usa en muchas vueltas distintas. |
| pilotos -> pagos | 1:N | Un piloto puede tener varios pagos (uno por sesion). |
| sesiones -> pagos | 1:N | Una sesion tiene un pago por cada piloto inscrito. |

## Reglas de negocio

- Regla 1 (relaciones invalidas): todo tiempo debe apuntar a una
  sesion, un piloto y un vehiculo reales; todo pago debe apuntar a un
  piloto y a una sesion reales (`FOREIGN KEY` en cadena).
- Regla 2 (registros repetidos): `pilotos.nombre_piloto`,
  `pilotos.licencia` y `vehiculos.modelo` no se repiten (`UNIQUE`); un
  piloto no puede tener dos tiempos para la misma vuelta de la misma
  sesion (`UNIQUE (id_sesion, id_piloto, vuelta)`).
- Regla 3 (valores fuera de rango): `tiempos.tiempo_segundos` y
  `pagos.monto` nunca pueden ser negativos o cero (`CHECK`);
  `tiempos.vuelta` siempre debe ser 1 o mayor (`CHECK`).
- Regla 4: una sesion nace `'programada'` y avanza a `'en_curso'`,
  `'finalizada'` o `'cancelada'` (`CHECK`); un pago nace
  `'pendiente'` y avanza a `'pagado'` o `'reembolsado'` (`CHECK`);
  ambos se corrigen con `UPDATE`.
- Regla 5: los tiempos solo tienen sentido para una sesion que
  realmente se corrio. Si una sesion se cancela y ya tenia tiempos
  cargados por error, esas filas se eliminan; nunca se borra un
  tiempo de una sesion `'finalizada'`, porque ya es un resultado
  oficial.

## Supuestos

- El cliente no detallo cuantas vueltas corre cada piloto por sesion;
  se asume un numero variable, registrado vuelta por vuelta en
  `tiempos`.
- No se detallo si un piloto puede usar vehiculos distintos en
  sesiones distintas; se asume que si, porque asi funciona la mayoria
  de dias de pista con flota compartida.
- Se asume que el pago es por sesion completa (no por vuelta), ya que
  el cliente hablo de "cuanto dinero representa cada movimiento" en
  terminos de su operacion diaria, no de cada vuelta individual.

## Preguntas que responde la base de datos

1. Que tiempos existen, con que piloto, que vehiculo y que sesion.
2. Que sesiones estan programadas, en curso, finalizadas o
   canceladas.
3. Que piloto tiene mas vueltas registradas (ranking de actividad).
4. Como se ordenan los tiempos, de la vuelta mas rapida a la mas
   lenta.
5. Que pilotos tienen el mejor tiempo promedio, para decidir a
   quienes invitar al siguiente evento.
