# Analisis del requerimiento - Ejercicio 077

## Solicitud entendida

Un taller de motos recibe servicios, repuestos y mecanicos por orden
de trabajo. El cliente pide que el sistema permita corregir estados
sin borrar informacion importante: eso significa que el historial de
cada orden (que repuestos se usaron, en que estado quedo) no debe
desaparecer solo porque algo cambio. Se necesita una base de datos
que permita consultar datos, corregir estados, registrar movimientos
y sacar reportes utiles.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| clientes | Catalogo: quien es dueno de la moto | nombre_cliente, telefono (unico) |
| motos | Catalogo: cada moto que entra al taller | placa (unica), modelo |
| ordenes_servicio | Tabla transaccional: cada trabajo sobre una moto | descripcion, fecha_orden, estado |
| repuestos | Catalogo: cada repuesto disponible en el taller | nombre_repuesto (unico), precio_unitario |
| detalle_repuestos | Detalle de cada orden: que repuestos se usaron y cuantos | cantidad, precio_unitario |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| clientes -> motos | 1:N | Un cliente puede tener varias motos. |
| motos -> ordenes_servicio | 1:N | Una moto puede tener varias ordenes de servicio a lo largo del tiempo. |
| ordenes_servicio -> detalle_repuestos | 1:N | Una orden puede usar varios repuestos distintos. |
| repuestos -> detalle_repuestos | 1:N | Un repuesto se usa en muchas ordenes distintas. |

## Reglas de negocio

Esta es la regla central que pidio el cliente: corregir estados sin
borrar informacion importante.

- Regla 1 (relaciones invalidas): toda moto debe apuntar a un cliente
  real; toda orden debe apuntar a una moto real; todo detalle debe
  apuntar a una orden y a un repuesto reales (`FOREIGN KEY` en
  cadena).
- Regla 2 (registros repetidos): `clientes.telefono`, `motos.placa` y
  `repuestos.nombre_repuesto` no se repiten (`UNIQUE`); un repuesto no
  puede aparecer dos veces como linea separada en la misma orden
  (`UNIQUE (id_orden, id_repuesto)`).
- Regla 3 (valores fuera de rango): `detalle_repuestos.cantidad`
  siempre mayor que 0; `repuestos.precio_unitario` y
  `detalle_repuestos.precio_unitario` nunca negativos (`CHECK`).
- Regla 4: una orden nace `'recibida'` y avanza a `'en_reparacion'`,
  `'finalizada'` o `'cancelada'` (`CHECK`); se corrige siempre con
  `UPDATE`, nunca se borra una orden para "reiniciarla".
- Regla 5: un repuesto solo se puede quitar de una orden con `DELETE`
  mientras la orden sigue `'recibida'` (todavia no se empezo a
  trabajar). Una vez que la orden pasa a `'en_reparacion'` o
  `'finalizada'`, sus repuestos ya son parte del historial oficial del
  trabajo y no se borran; si algo estuvo mal, se corrige con `UPDATE`
  del estado de la orden, no eliminando el detalle.

## Supuestos

- El cliente no detallo si un mismo repuesto puede tener precio
  distinto en ordenes distintas (por ejemplo, si sube el precio de
  lista); se guarda `precio_unitario` tambien en `detalle_repuestos`
  para conservar el precio real que se cobro en esa orden.
- No se detallo si una moto puede cambiar de dueno; se asume que no,
  para el alcance de este nivel.
- Se asume que "corregir estados" se refiere principalmente al estado
  de la orden de servicio, que es el dato que mas cambia durante el
  proceso de reparacion.

## Preguntas que responde la base de datos

1. Que repuestos se usaron, en que orden y en que moto.
2. Que ordenes estan recibidas, en reparacion, finalizadas o
   canceladas.
3. Que moto tiene mas ordenes de servicio (ranking de actividad).
4. Como se ordenan las lineas de repuestos por su subtotal.
5. Que repuestos son los mas usados, para decidir cuales mantener
   siempre en stock.
