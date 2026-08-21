# Analisis del requerimiento - Ejercicio 026

## Solicitud entendida

Una cafeteria cerca del campus quiere controlar productos, ventas rapidas y pagos de estudiantes. El cliente pidio explicitamente diferenciar catalogos, operaciones y resultados para no mezclar informacion permanente con movimientos. A diferencia de una version mas basica de este mismo caso, aqui se pide una relacion real (con `FOREIGN KEY` y `JOIN`) entre productos, clientes y ventas.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| clientes | Es el catalogo permanente de estudiantes que compran en la cafeteria. | nombre_cliente (unico), carne_estudiantil (unico) |
| productos | Es el catalogo permanente de lo que vende la cafeteria. | nombre_producto (unico), categoria, precio |
| ventas | Es el registro transaccional (el movimiento) de cada venta: que producto, que cliente, cuanto se cobro y en que estado va. Es exactamente lo que el cliente pidio separar de los catalogos. | id_producto (FK), id_cliente (FK), cantidad, monto_total, fecha_venta, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| productos -> ventas | 1:N | Un producto puede aparecer en muchas ventas, pero cada venta es de un unico producto. |
| clientes -> ventas | 1:N | Un cliente puede tener muchas ventas, pero cada venta pertenece a un unico cliente. |

## Reglas de negocio

- Regla 1: Toda venta debe apuntar a un producto real y a un cliente real (`FOREIGN KEY` doble).
- Regla 2: `precio`, `cantidad` y `monto_total` siempre deben ser mayores a cero (`CHECK`).
- Regla 3: Una venta puede estar `pagada`, `pendiente` o `cancelada` (`CHECK`); la cafeteria necesita poder corregir este estado (por ejemplo, cuando un estudiante que quedo a deber por fin paga).
- Regla 4: `nombre_producto`, `nombre_cliente` y `carne_estudiantil` no se repiten (`UNIQUE`).

## Supuestos

- A diferencia de una version mas simple de este mismo caso (donde el cliente se guardaba como texto dentro de la venta), aqui se creo una tabla `clientes` real con `FOREIGN KEY`, siguiendo el alcance de este nivel (2 a 3 tablas con relaciones uno a muchos y consultas con `JOIN`).
- `monto_total` se guarda en la venta (no solo se calcula desde `productos.precio` por cantidad) porque el precio de catalogo puede cambiar con el tiempo, y la venta debe conservar lo que realmente se cobro.

## Preguntas que responde la base de datos

1. Que ventas existen y en que estado quedo cada una.
2. Que ventas no estan pagadas todavia.
3. Que cliente tiene mas actividad (mas compras pagadas).
4. Como se ordenan las ventas por fecha.
5. Que producto genera mas ingresos (sin contar canceladas), para decidir que reabastecer.
