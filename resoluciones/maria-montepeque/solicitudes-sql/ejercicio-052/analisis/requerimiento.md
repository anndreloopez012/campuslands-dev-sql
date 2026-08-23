# Analisis del requerimiento - Ejercicio 052

## Solicitud entendida

Un taller de motos recibe servicios, repuestos y mecanicos por orden de trabajo. El cliente pide saber quien trajo la moto, que se le hizo, cuando ocurrio y cuanto dinero representa cada orden (mano de obra + repuestos). Es nivel 3: se pide `DELETE` controlado con criterios de negocio.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| clientes | Es el catalogo de clientes del taller. | nombre_cliente (unico), telefono |
| mecanicos | Es el catalogo de mecanicos del taller. | nombre_mecanico (unico), especialidad |
| ordenes_servicio | Es el encabezado de cada orden: que cliente, que mecanico, que moto (placa), cuando, cuanto cuesta la mano de obra y en que estado va. | id_cliente (FK), id_mecanico (FK), placa_moto, fecha_orden, costo_mano_obra, estado |
| repuestos_usados | Es el detalle de repuestos de cada orden: que repuesto, cuantos y a que costo. | id_orden (FK), nombre_repuesto, cantidad, costo_unitario |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| clientes -> ordenes_servicio | 1:N | Un cliente puede tener varias ordenes. |
| mecanicos -> ordenes_servicio | 1:N | Un mecanico puede tener asignadas varias ordenes. |
| ordenes_servicio -> repuestos_usados | 1:N | Una orden puede usar varios repuestos. |

## Reglas de negocio

- Regla 1: Toda orden debe apuntar a un cliente real y a un mecanico real; todo repuesto usado debe apuntar a una orden real (`FOREIGN KEY` en cadena).
- Regla 2: `telefono`, `especialidad`, `placa_moto` y `nombre_repuesto` son `NOT NULL`.
- Regla 3: `costo_mano_obra`, `cantidad` y `costo_unitario` siempre deben ser mayores a cero (`CHECK`).
- Regla 4: `nombre_cliente` y `nombre_mecanico` no se repiten (`UNIQUE`).
- Regla 5: Una orden puede estar `recibida`, `en_reparacion`, `listo`, `entregado` o `cancelada` (`CHECK`); se corrige con `UPDATE` a medida que avanza el trabajo.
- Regla 6: Solo se permite `DELETE` de un repuesto usado cuando la orden a la que pertenece esta `cancelada`. El detalle de una orden activa o entregada nunca se borra.

## Supuestos

- La moto se identifica solo por su `placa_moto` dentro de `ordenes_servicio` (no se creo una tabla `motos` aparte), porque el alcance de este nivel es 3 a 4 tablas y lo que el cliente necesita rastrear con precision es el costo y el estado de cada orden, no una ficha completa del vehiculo.
- El costo total de una orden se calcula como `costo_mano_obra` mas la suma de `cantidad x costo_unitario` de sus repuestos usados.

## Preguntas que responde la base de datos

1. Que ordenes existen, con que cliente, que mecanico y cuanto cuesta cada una en total.
2. Que ordenes no estan entregadas todavia.
3. Que mecanico tiene mas ordenes asignadas.
4. Como se ordenan las ordenes por fecha.
5. Cual es el costo total de cada orden (mano de obra + repuestos), de mayor a menor, para decidir a quien cobrar o entregar primero.
