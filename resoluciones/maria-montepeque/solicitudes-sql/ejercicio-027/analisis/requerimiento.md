# Analisis del requerimiento - Ejercicio 027

## Solicitud entendida

Un taller de motos recibe servicios, repuestos y mecanicos por orden de trabajo. El cliente pidio explicitamente que el sistema permita corregir estados sin borrar informacion importante. A diferencia de una version mas basica de este mismo caso, aqui se pide una relacion real con clientes, motos y ordenes de servicio conectadas por `FOREIGN KEY`.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| clientes | Es el catalogo de duenos de motos registrados en el taller. | nombre_cliente (unico), telefono |
| motos | Es el catalogo de motos, cada una propiedad de un cliente. | id_cliente (FK), placa (unica), marca, modelo |
| ordenes_servicio | Es el registro transaccional de cada trabajo realizado a una moto: descripcion, mecanico, costo y estado. Aqui vive la peticion central del cliente: corregir estados sin borrar. | id_moto (FK), descripcion_servicio, mecanico_asignado, costo, fecha_orden, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| clientes -> motos | 1:N | Un cliente puede tener varias motos registradas. |
| motos -> ordenes_servicio | 1:N | Una moto puede tener muchas ordenes de servicio a lo largo del tiempo. |

## Reglas de negocio

- Regla 1: Toda moto debe pertenecer a un cliente real (`FOREIGN KEY`), y toda orden debe apuntar a una moto real (`FOREIGN KEY`).
- Regla 2: `costo` siempre debe ser mayor a cero (`CHECK`).
- Regla 3: Una orden puede estar `en_proceso`, `completada` o `cancelada` (`CHECK`); el taller necesita poder corregir este estado sin borrar la orden, tal como pidio el cliente explicitamente.
- Regla 4: `nombre_cliente` y `placa` no se repiten (`UNIQUE`).

## Supuestos

- A diferencia de una version mas simple de este mismo caso (donde el dueno se guardaba como texto dentro de la moto), aqui se creo una tabla `clientes` real con `FOREIGN KEY`, siguiendo el alcance de este nivel.
- Solo se elimina una orden (`DELETE`) cuando nunca debio existir (una entrada de prueba); una orden real que se completa o cancela SIEMPRE se corrige con `UPDATE` de estado, nunca se borra.

## Preguntas que responde la base de datos

1. Que ordenes de servicio existen y en que estado quedo cada una.
2. Que ordenes no estan completadas todavia.
3. Que cliente tiene mas actividad (mas motos con ordenes).
4. Como se ordenan las ordenes por fecha.
5. Cuanto genera cada mecanico en costo total (sin ordenes canceladas), para decisiones de carga de trabajo.
