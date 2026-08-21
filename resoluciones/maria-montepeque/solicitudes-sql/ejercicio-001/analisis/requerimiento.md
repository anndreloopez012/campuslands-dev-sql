# Analisis del requerimiento - Ejercicio 001

## Solicitud entendida

La cafeteria del campus hoy controla todo en hojas de calculo: productos, ventas y pagos de estudiantes. Varias personas registran lo mismo sin darse cuenta y terminan con datos duplicados. El cliente quiere una base de datos donde pueda consultar informacion real, corregir el estado de una venta (por ejemplo, cuando un estudiante que quedo debiendo por fin paga), registrar movimientos de venta y sacar reportes utiles (que se vende mas, quien compra mas, etc.).

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| productos | Es el catalogo de lo que la cafeteria vende (bebidas, comida, snacks); sin catalogo no se puede registrar ninguna venta de forma consistente. | nombre_producto (unico), precio, categoria, stock |
| ventas | Es el registro transaccional de cada venta rapida: que producto, a quien, cuanto y en que estado quedo el pago. Es la tabla donde vive el problema real del cliente (duplicados, estados, reportes). | id_producto (FK), nombre_cliente, cantidad, precio_pagado, fecha_venta, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| productos -> ventas | 1:N | Un producto del catalogo puede aparecer en muchas ventas distintas, pero cada venta apunta a un unico producto. |

## Reglas de negocio

- Regla 1: Toda venta debe tener un producto valido del catalogo (`FOREIGN KEY`), no se puede vender algo que no existe.
- Regla 2: El precio de un producto y el monto pagado en una venta siempre deben ser mayores a cero (`CHECK`); un precio en cero o negativo no tiene sentido de negocio.
- Regla 3: Una venta puede quedar en tres estados (`pagada`, `pendiente`, `cancelada`); el cliente necesita poder corregir ese estado cuando un estudiante paga lo que debia.
- Regla 4: El nombre del producto no se repite en el catalogo (`UNIQUE`), evitando el problema de duplicados que menciona el cliente.

## Supuestos

- No se creo una tabla `clientes` separada porque el alcance tecnico pide 1 a 2 tablas para este nivel; el nombre del estudiante se guarda como dato dentro de `ventas`. Si mas adelante se necesita historial completo por estudiante (correo, carne, etc.), se podria separar en su propia tabla.
- `precio_pagado` se guarda en la venta (y no solo se calcula desde `productos.precio`) porque el precio de catalogo puede cambiar con el tiempo y la venta debe conservar el precio real que se cobro ese dia.
- El estado por defecto de una venta nueva es `pagada`, porque la mayoria de ventas en una cafeteria se pagan al momento; `pendiente` es la excepcion (el estudiante promete pagar despues).

## Preguntas que responde la base de datos

1. Que ventas existen y en que estado quedo cada una.
2. Que ventas estan pendientes de cobro.
3. Que estudiante le compra mas a la cafeteria.
4. Como se ordenan las ventas por fecha, para revisar el dia a dia.
5. Que producto genera mas ingresos, para decidir que reabastecer primero.
