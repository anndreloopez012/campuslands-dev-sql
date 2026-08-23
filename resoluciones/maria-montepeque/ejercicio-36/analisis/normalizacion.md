# Analisis de Normalizacion - Ejercicio 36

## Tabla original

Archivo `datos/datos-sin-normalizar.csv`:

```text
id_reserva,huesped,documento,habitacion,servicios,costos_servicios,fechas
1,Elena Soto,PAS-1,Habitacion 204,Desayuno|Spa,60|180,2026-07-01|2026-07-02
2,Pedro Mora,PAS-2,Habitacion 105,Parqueo|Lavanderia,45|70,2026-07-03|2026-07-04
3,Elena Soto,PAS-1,Habitacion 204,Desayuno|Parqueo,60|45,2026-07-05|2026-07-06
```

Es una tabla plana donde cada fila mezcla el encabezado de una reserva (huesped, documento, habitacion) con el detalle de los servicios consumidos, y `servicios`, `costos_servicios` y `fechas` guardan varios valores separados por `|` dentro de una sola celda (un grupo repetido por cada servicio).

## Problemas detectados

- **Grupos repetidos**: `servicios`, `costos_servicios` y `fechas` contienen listas de valores (una por servicio) dentro de una misma celda en lugar de una fila por servicio.
- **Datos duplicados**: `huesped`, `documento` y `habitacion` de "Elena Soto" se repiten completos en las filas 1 y 3; el costo del "Desayuno" (60) y el de "Parqueo" (45) tambien se repiten cada vez que se consumen.
- **Dependencias parciales**: si se usara como clave compuesta `(id_reserva, servicio)` para representar cada linea de servicio, datos como `huesped`, `documento` y `habitacion` dependerian solo de `id_reserva` (parte de la clave), no de la clave completa.
- **Dependencias transitivas**: `documento` depende de `huesped` (cada huesped tiene siempre el mismo documento), y `huesped` depende de `id_reserva`; por lo tanto `documento` depende transitivamente de `id_reserva` a traves de `huesped`. Lo mismo ocurre con el costo de cada servicio, que depende del tipo de servicio (`Desayuno` siempre cuesta 60, `Parqueo` siempre 45) y no directamente de la reserva.
- **Anomalias de insercion**: no se puede registrar un servicio nuevo en el catalogo (con su costo estandar) si todavia no se ha consumido en ninguna reserva, ni una habitacion nueva sin inventar una reserva ficticia.
- **Anomalias de actualizacion**: si el documento de "Elena Soto" cambia, hay que actualizarlo en las filas 1 y 3; si el costo estandar del "Desayuno" cambia, habria que corregirlo en todas las filas donde aparece. Si se olvida una, quedan datos inconsistentes.
- **Anomalias de eliminacion**: si se elimina la fila 2 (la unica reserva de Pedro Mora), se pierde tambien la referencia a la habitacion "Habitacion 105", aunque en realidad la habitacion sigue existiendo en el hotel.

## Dependencias funcionales

```text
id_reserva -> huesped, documento, habitacion
huesped -> documento
servicio -> costo
(id_reserva, servicio, fecha) -> costo_aplicado
```

## Primera Forma Normal (1FN)

Se elimino el grupo repetido dividiendo cada reserva en una fila por cada servicio consumido (usando el separador `|` como guia). La clave paso a ser compuesta `(id_reserva, servicio, fecha)`, y cada celda quedo con un unico valor atomico (un servicio, un costo, una fecha por fila).

## Segunda Forma Normal (2FN)

Con la clave compuesta `(id_reserva, servicio, fecha)`, los atributos `huesped`, `documento` y `habitacion` dependian solo de `id_reserva` (dependencia parcial), y el costo estandar dependia solo del `servicio`. Se separaron en tablas independientes:

- `reservas` (huesped y habitacion de la reserva), con clave `id_reserva`.
- `servicios` (nombre del servicio y su costo estandar), con clave `id_servicio`.
- `detalle_servicio` (servicio consumido, fecha y costo aplicado dentro de esa reserva), con clave compuesta `(id_reserva, id_servicio, fecha)`.

## Tercera Forma Normal (3FN)

Dentro de `reservas` seguia existiendo una dependencia transitiva: `documento` dependia de `huesped` (no directamente de `id_reserva`), y `huesped` y `habitacion` eran texto libre repetido en cada fila. Se separaron en catalogos independientes:

- `huespedes` (nombre, documento), referenciado desde `reservas` por `id_huesped`.
- `habitaciones` (numero), referenciada desde `reservas` por `id_habitacion`.

Con esto, `reservas` solo guarda referencias (`id_huesped`, `id_habitacion`) y `detalle_servicio` solo guarda referencias (`id_reserva`, `id_servicio`) mas los datos que dependen unicamente de esa combinacion (`fecha`, `costo`).

## Modelo final

| Tabla | Llave primaria | Llaves foraneas | Proposito |
| --- | --- | --- | --- |
| `huespedes` | `id_huesped` | - | Catalogo de huespedes (nombre, documento unico). |
| `habitaciones` | `id_habitacion` | - | Catalogo de habitaciones del hotel. |
| `servicios` | `id_servicio` | - | Catalogo de servicios y su costo estandar. |
| `reservas` | `id_reserva` | `id_huesped` -> `huespedes`, `id_habitacion` -> `habitaciones` | Encabezado de cada reserva (que huesped ocupa que habitacion). |
| `detalle_servicio` | `id_detalle` | `id_reserva` -> `reservas`, `id_servicio` -> `servicios` | Detalle de cada servicio consumido en una reserva, con su fecha y costo. |

## Justificacion

El modelo final elimina los grupos repetidos (1FN) al dar una fila por cada servicio consumido en `detalle_servicio`. Elimina las dependencias parciales (2FN) al sacar de la reserva todo lo que no depende de la reserva completa: el detalle de cada servicio (fecha, costo) queda en `detalle_servicio`, y el costo estandar pasa a ser un atributo del servicio en `servicios`. Elimina las dependencias transitivas (3FN) al separar `huespedes` y `habitaciones` de `reservas`, de modo que el documento del huesped ya no depende indirectamente de `id_reserva`, sino directamente de `id_huesped`.

Con esto: actualizar el documento de un huesped o el costo estandar de un servicio requiere un solo `UPDATE`; se puede registrar un servicio o una habitacion nueva sin necesidad de una reserva; y eliminar una reserva ya no borra al huesped ni la habitacion asociados, porque existen de forma independiente en sus propias tablas. Las filas 1 y 3 del CSV original (misma huesped, misma habitacion, distintas fechas de consumo) se mantienen como dos reservas separadas, porque representan dos estadias reales.
