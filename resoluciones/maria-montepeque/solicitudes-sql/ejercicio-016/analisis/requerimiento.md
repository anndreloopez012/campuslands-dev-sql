# Analisis del requerimiento - Ejercicio 016

## Solicitud entendida

Un hotel tematico para gamers recibe reservas, tiene habitaciones, organiza torneos internos y registra consumos. El cliente pidio explicitamente diferenciar lo permanente (el catalogo de habitaciones) de los movimientos (cada reserva), para no mezclar informacion que no cambia con informacion que se registra dia a dia.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| habitaciones | Es el catalogo permanente: las habitaciones que tiene el hotel, con su tipo, precio por noche y estado fisico actual. No cambia con cada reserva, solo cuando una habitacion entra o sale de servicio. | numero_habitacion (unico), tipo, precio_noche, estado |
| reservas | Es el registro transaccional (el movimiento) de cada estadia: que habitacion, que huesped, que fechas, cuanto se cobro y en que estado va la reserva. Es exactamente lo que el cliente pidio separar del catalogo. | id_habitacion (FK), nombre_huesped, fecha_entrada, fecha_salida, monto_total, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| habitaciones -> reservas | 1:N | Una habitacion puede tener muchas reservas a lo largo del tiempo, pero cada reserva es de una unica habitacion. |

## Reglas de negocio

- Regla 1: Toda reserva debe apuntar a una habitacion real del catalogo (`FOREIGN KEY`).
- Regla 2: `precio_noche` y `monto_total` siempre deben ser mayores a cero (`CHECK`).
- Regla 3: Una reserva puede estar `confirmada`, `en_curso`, `finalizada` o `cancelada` (`CHECK`); el hotel necesita poder corregir este estado a medida que avanza la estadia.
- Regla 4: Una habitacion puede estar `disponible`, `ocupada` o `mantenimiento` (`CHECK`); este estado es independiente del estado de cada reserva individual (es el estado fisico actual de la habitacion, no de una estadia puntual).
- Regla 5: El numero de habitacion no se repite (`UNIQUE`).

## Supuestos

- No se creo una tabla `huespedes` separada: el alcance de este nivel pide 1 a 2 tablas, asi que el nombre del huesped se guarda dentro de `reservas`.
- `monto_total` se guarda en la reserva (no solo se calcula desde `habitaciones.precio_noche` por noches) porque el precio de catalogo puede cambiar con el tiempo y la reserva debe conservar lo que realmente se cobro.
- `habitaciones.estado` y `reservas.estado` son conceptos distintos a proposito: el primero describe la disponibilidad fisica actual de la habitacion, el segundo el avance de una estadia especifica. Separarlos es justamente la diferenciacion catalogo/movimiento que pidio el cliente.

## Preguntas que responde la base de datos

1. Que reservas existen y en que estado quedo cada una.
2. Que reservas no estan finalizadas todavia.
3. Que huesped reserva mas.
4. Como se ordenan las reservas por fecha de entrada.
5. Que reporte de ingresos por habitacion (sin contar canceladas) puede usar el hotel para decidir que habitaciones mantener o remodelar.
