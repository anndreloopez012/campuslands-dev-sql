# Análisis de normalización

## Tabla original sin normalizar

La estructura inicial del archivo plano contiene:

```text
huesped
documento
habitacion
servicios
costos_servicios
fechas
```
## Problemas detectados

La estructura original presenta:

- Datos repetidos de huéspedes.
- Documentos almacenados repetidamente.
- Datos repetidos de habitaciones.
- Múltiples servicios en una misma celda.
- Múltiples costos asociados a los servicios.
- Fechas agrupadas en una misma estructura.
- Dificultad para actualizar los datos de un huésped.
- Riesgo de inconsistencias en los costos de servicios.
- Anomalías de inserción al no poder registrar fácilmente un servicio independiente.
- Anomalías de eliminación al eliminar la última reserva de un huésped.
- Dificultad para calcular el costo total de una reserva.


## Primera Forma Normal

La tabla original no cumple completamente 1FN debido a que `servicios`, `costos_servicios` y `fechas` pueden contener grupos repetidos.

Se transforma cada servicio en un registro independiente:

```text
DETALLE_SERVICIO
id_detalle
reserva
servicio
cantidad
fecha_servicio
costo_unitario
```

Cada atributo contiene un único valor.

## Segunda Forma Normal

En 2FN se separan los atributos que dependen exclusivamente de una entidad.

Los datos del huésped se separan de la reserva.

Los datos de la habitación se separan de la reserva.

Los datos del servicio se separan del detalle.

La estructura queda:

```text
HUESPEDES
id_huesped -> datos_del_huesped

HABITACIONES
id_habitacion -> datos_de_la_habitacion

SERVICIOS
id_servicio -> datos_del_servicio

RESERVAS
id_reserva -> huesped, habitacion, fechas, estado

DETALLE_SERVICIO
id_detalle -> reserva, servicio, cantidad, fecha, costo
```

## Tercera Forma Normal

En 3FN se eliminan dependencias transitivas y datos repetidos.

Los datos del huésped se mantienen exclusivamente en `huespedes`.

Los datos de cada habitación se mantienen exclusivamente en `habitaciones`.

Los datos de cada servicio se mantienen exclusivamente en `servicios`.

Las reservas solamente mantienen las relaciones y atributos propios de la reserva.

El detalle relaciona reservas y servicios.

## Justificación de las tablas finales

### huespedes

Almacena los datos personales y de contacto de cada huésped.

### habitaciones

Almacena las características, capacidad, precio y estado de cada habitación.

### servicios

Almacena los servicios ofrecidos por el hotel y su costo base.

### reservas

Representa la estancia de un huésped en una habitación durante un período determinado.

### detalle_servicio

Relaciona los servicios consumidos con cada reserva y permite registrar cantidad, fecha y costo aplicado.

## Resultado de la normalización

El modelo final queda compuesto por:

```text
HUESPEDES
HABITACIONES
SERVICIOS
RESERVAS
DETALLE_SERVICIO
```

La estructura elimina grupos repetidos y permite consultar reservas, habitaciones, huéspedes y servicios mediante relaciones normalizadas.