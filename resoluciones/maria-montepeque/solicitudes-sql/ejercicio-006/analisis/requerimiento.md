# Analisis del requerimiento - Ejercicio 006

## Solicitud entendida

Una empresa alquila autos deportivos y necesita controlar reservas, clientes y pagos. El cliente pidio explicitamente diferenciar lo permanente (el catalogo de autos) de los movimientos (cada reserva), para no mezclar informacion que no cambia con informacion que se registra dia a dia. Tambien quiere consultar datos, corregir estados y sacar reportes.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| vehiculos | Es el catalogo permanente: los autos que la empresa posee, con su placa, precio por dia y estado actual. No cambia con cada alquiler, solo cuando el auto entra o sale de servicio. | marca, modelo, placa (unica), precio_dia, estado |
| reservas | Es el registro transaccional (el movimiento) de cada alquiler: que auto, que cliente, que fechas, cuanto se cobro y en que estado va la reserva. Es exactamente lo que el cliente pidio separar del catalogo. | id_vehiculo (FK), nombre_cliente, fecha_inicio, fecha_fin, monto_total, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| vehiculos -> reservas | 1:N | Un vehiculo puede tener muchas reservas a lo largo del tiempo, pero cada reserva es de un unico vehiculo. |

## Reglas de negocio

- Regla 1: Toda reserva debe apuntar a un vehiculo real del catalogo (`FOREIGN KEY`).
- Regla 2: `precio_dia` y `monto_total` siempre deben ser mayores a cero (`CHECK`).
- Regla 3: Una reserva puede estar `confirmada`, `en_curso`, `finalizada` o `cancelada` (`CHECK`); la empresa necesita poder corregir ese estado a medida que avanza el alquiler.
- Regla 4: Un vehiculo puede estar `disponible`, `rentado` o `mantenimiento` (`CHECK`); este estado es independiente del estado de cada reserva individual (es el estado actual del auto, no de un alquiler puntual).
- Regla 5: La placa de cada vehiculo no se repite (`UNIQUE`), identifica de forma unica el auto.

## Supuestos

- No se creo una tabla `clientes` separada: el alcance de este nivel pide 1 a 2 tablas, asi que el nombre del cliente se guarda dentro de `reservas`.
- `monto_total` se guarda en la reserva (no solo se calcula desde `vehiculos.precio_dia` por los dias) porque el precio de catalogo puede cambiar con el tiempo y la reserva debe conservar lo que realmente se cobro.
- `vehiculos.estado` y `reservas.estado` son conceptos distintos a proposito: el primero describe la disponibilidad actual del auto, el segundo el avance de un alquiler especifico. Separarlos es justamente la diferenciacion catalogo/movimiento que pidio el cliente.

## Preguntas que responde la base de datos

1. Que reservas existen y en que estado quedo cada una.
2. Que reservas no estan finalizadas todavia.
3. Que cliente reserva mas autos.
4. Como se ordenan las reservas por fecha de inicio.
5. Que reporte de ingresos por vehiculo (sin contar canceladas) puede usar la empresa para decidir que auto conviene mantener en la flota.
