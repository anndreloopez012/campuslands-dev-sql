# Analisis del requerimiento - Ejercicio 045

## Solicitud entendida

Un taller de soldadura industrial controla ordenes, materiales, tecnicos, inspecciones y costos. El cliente no habla en terminos de tablas: solo describe su operacion diaria (recibir una orden, asignar tecnico, usar materiales, inspeccionar, entregar) y espera que se traduzca a SQL. Es nivel 3: se pide `DELETE` controlado con criterios de negocio.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| clientes | Es el catalogo de clientes del taller. | nombre_cliente (unico), telefono |
| tecnicos | Es el catalogo de tecnicos soldadores. | nombre_tecnico (unico), certificacion |
| ordenes | Es el registro transaccional de cada trabajo: que cliente, que tecnico, cuando, cuanto cuesta la mano de obra y en que estado va (incluye la inspeccion como un estado mas). | id_cliente (FK), id_tecnico (FK), descripcion, fecha_orden, costo_total, estado |
| materiales | Es el detalle de materiales usados en cada orden. | id_orden (FK), nombre_material, cantidad, costo_unitario |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| clientes -> ordenes | 1:N | Un cliente puede tener varias ordenes. |
| tecnicos -> ordenes | 1:N | Un tecnico puede tener asignadas varias ordenes. |
| ordenes -> materiales | 1:N | Una orden puede usar varios materiales. |

## Reglas de negocio

- Regla 1: Toda orden debe apuntar a un cliente real y a un tecnico real; todo material debe apuntar a una orden real (`FOREIGN KEY` en cadena).
- Regla 2: `telefono`, `certificacion`, `descripcion` y `nombre_material` son `NOT NULL`.
- Regla 3: `costo_total`, `cantidad` y `costo_unitario` siempre deben ser mayores a cero (`CHECK`).
- Regla 4: Una orden puede estar `recibida`, `en_proceso`, `inspeccion`, `entregada` o `rechazada` (`CHECK`); el taller corrige este estado con `UPDATE` a medida que avanza el trabajo.
- Regla 5: `nombre_cliente` y `nombre_tecnico` no se repiten (`UNIQUE`).
- Regla 6: Solo se permite `DELETE` de un material si la orden a la que pertenece todavia esta `recibida` (el trabajo no ha empezado). Si la orden ya esta `en_proceso` o mas adelante, el material ya pudo haberse usado y no se borra.

## Supuestos

- "Inspecciones" se resolvio como un estado mas dentro de `ordenes` (`inspeccion`), no como tabla aparte, porque el alcance de este nivel es 3 a 4 tablas y una inspeccion, para este taller, es una etapa del mismo trabajo, no un movimiento independiente.
- El costo final de una orden se calcula como `costo_total` (mano de obra) mas la suma de `cantidad x costo_unitario` de sus materiales.

## Preguntas que responde la base de datos

1. Que ordenes existen, con que cliente y que tecnico.
2. Que ordenes no estan entregadas todavia.
3. Que tecnico tiene mas ordenes asignadas.
4. Como se ordenan las ordenes por fecha.
5. Cual es el costo final de cada orden (mano de obra + materiales), para decidir cuales priorizar al cobrar.
