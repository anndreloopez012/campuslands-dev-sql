# Analisis del requerimiento - Ejercicio 080

## Solicitud entendida

Un cine organiza funciones de peliculas de miedo, en distintas salas,
con venta de boletos por asiento. El cliente quiere detectar tres
tipos de error: registros repetidos, relaciones invalidas y valores
fuera de rango. En un cine, el error clasico de "registro repetido"
es vender el mismo asiento dos veces para la misma funcion. Se
necesita una base de datos que permita consultar datos, corregir
estados, registrar movimientos y sacar reportes utiles.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| peliculas | Catalogo: cada pelicula de terror disponible | titulo (unico), clasificacion, duracion_minutos |
| salas | Catalogo: cada sala del cine | nombre_sala (unico), capacidad |
| funciones | Tabla transaccional: una pelicula proyectada en una sala, en fecha y hora | fecha_funcion, hora_funcion, estado |
| boletos | Detalle de cada funcion: cada asiento vendido | asiento, precio |
| pagos | Resultado: el pago de un boleto, uno por boleto | monto, metodo_pago |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| peliculas -> funciones | 1:N | Una pelicula se proyecta en varias funciones. |
| salas -> funciones | 1:N | Una sala tiene varias funciones a lo largo del tiempo. |
| funciones -> boletos | 1:N | Una funcion tiene un boleto por cada asiento vendido. |
| boletos -> pagos | 1:1 | Cada boleto tiene, como mucho, un pago oficial. |

## Reglas de negocio

Cada regla ataca uno de los tres errores que el cliente quiere
detectar:

- Regla 1 (relaciones invalidas): toda funcion debe apuntar a una
  pelicula y a una sala reales; todo boleto debe apuntar a una funcion
  real; todo pago debe apuntar a un boleto real (`FOREIGN KEY` en
  cadena).
- Regla 2 (registros repetidos): `peliculas.titulo` y
  `salas.nombre_sala` no se repiten (`UNIQUE`); el mismo asiento no se
  puede vender dos veces para la misma funcion
  (`UNIQUE (id_funcion, asiento)`); un boleto no puede tener mas de un
  pago (`UNIQUE (id_boleto)` en `pagos`).
- Regla 3 (valores fuera de rango): `peliculas.duracion_minutos` y
  `salas.capacidad` siempre mayores que 0; `boletos.precio` y
  `pagos.monto` nunca negativos (`CHECK`).
- Regla 4: una funcion nace `'programada'` y avanza a `'en_curso'`,
  `'finalizada'` o `'cancelada'` (`CHECK`); se corrige con `UPDATE`.
- Regla 5: un boleto solo se puede eliminar con `DELETE` mientras
  todavia no tiene pago registrado (reserva sin cobrar). Un boleto ya
  pagado es un resultado oficial y no se borra; si la funcion se
  cancela, se corrige el estado de la funcion, no se elimina el
  boleto pagado.

## Supuestos

- El cliente no detallo si un boleto puede reembolsarse; se asume que
  el alcance de este nivel solo cubre boletos sin pagar (reservas), y
  que un reembolso seria un caso futuro fuera de este modelo.
- No se detallo si una funcion puede repetirse en la misma sala el
  mismo dia; se asume que si, siempre que sea en horarios distintos
  (no se valida solapamiento de horario en este nivel).
- Se asume que el precio del boleto puede variar entre funciones de la
  misma pelicula (por ejemplo, funciones nocturnas mas caras), por eso
  `precio` se guarda en `boletos` y no en `peliculas`.

## Preguntas que responde la base de datos

1. Que boletos existen, con que pelicula, que sala y que funcion.
2. Que funciones estan programadas, en curso, finalizadas o
   canceladas.
3. Que pelicula vendio mas boletos (ranking de actividad).
4. Como se ordenan los boletos por precio.
5. Que pelicula genero mas ingresos, para decidir cual mantener en
   cartelera.
