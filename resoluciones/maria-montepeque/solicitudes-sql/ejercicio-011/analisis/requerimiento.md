# Analisis del requerimiento - Ejercicio 011

## Solicitud entendida

Un negocio de comida a domicilio recibe pedidos, tiene repartidores, un menu y calificaciones de los clientes. Hoy todo se maneja en hojas de calculo y varias personas duplican datos sin darse cuenta. El cliente pidio una base de datos que permita consultar datos, corregir estados de un pedido y sacar reportes utiles.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| menus | Es el catalogo de platillos que ofrece el negocio, cada uno con su categoria y precio. | nombre_platillo (unico), categoria, precio |
| pedidos | Es el registro transaccional de cada pedido: que platillo, que cliente, que repartidor lo lleva, cuanto se cobro, en que estado va y (si ya se entrego) que calificacion dejo el cliente. | id_menu (FK), nombre_cliente, repartidor, cantidad, monto_total, fecha_pedido, estado, calificacion |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| menus -> pedidos | 1:N | Un platillo del menu puede aparecer en muchos pedidos, pero cada pedido es de un unico platillo (para mantener el modelo simple en este nivel). |

## Reglas de negocio

- Regla 1: Todo pedido debe apuntar a un platillo real del menu (`FOREIGN KEY`).
- Regla 2: `precio`, `cantidad` y `monto_total` siempre deben ser mayores a cero (`CHECK`).
- Regla 3: Un pedido puede estar `recibido`, `en_camino`, `entregado` o `cancelado` (`CHECK`); el negocio necesita poder corregir este estado a medida que avanza la entrega.
- Regla 4: `calificacion`, cuando existe, debe estar entre 1 y 5 (`CHECK`); pero se deja sin `NOT NULL` porque un pedido que todavia no se entrega no puede tener calificacion.
- Regla 5: El nombre del platillo no se repite en el menu (`UNIQUE`), evita el problema de duplicados que menciona el cliente.

## Supuestos

- No se creo una tabla `clientes` ni `repartidores` separada: el alcance de este nivel pide 1 a 2 tablas, asi que ambos se guardan como texto dentro de `pedidos`.
- Se asume que cada pedido es de un solo platillo (no un carrito con varios items), para mantener el modelo en 2 tablas segun el alcance tecnico de este nivel.
- `calificacion` solo tiene sentido cuando el pedido esta `entregado`; se deja `NULL` en los demas casos.

## Preguntas que responde la base de datos

1. Que pedidos existen y en que estado quedo cada uno.
2. Que pedidos no estan entregados todavia.
3. Que cliente tiene mas pedidos.
4. Como se ordenan los pedidos por fecha.
5. Que repartidor tiene mas entregas completadas, para decisiones de desempeno.
