# Analisis de Normalizacion - Ejercicio 38

## Tabla original

Archivo `datos/datos-sin-normalizar.csv`:

```text
id_orden,comprador,productos,cupon,metodo_pago,direccion_envio,transportadora
1,Nadia Cruz,Audifonos|Cable USB,CAMPUS10,Tarjeta,Zona 1,FastShip
2,Omar Valle,Laptop|Mochila,SIN_CUPON,Transferencia,Zona 10,CargoGT
3,Nadia Cruz,Mouse|Audifonos,CAMPUS10,Tarjeta,Zona 1,FastShip
```

Es una tabla plana donde cada fila mezcla el comprador, la lista de productos comprados (separada por `|`), el cupon usado y los datos de pago y envio, todo en una sola fila por orden.

## Problemas detectados

- **Grupo repetido**: `productos` contiene una lista de productos por orden separada por `|`, en vez de una fila por producto.
- **Datos duplicados**: `comprador` "Nadia Cruz" se repite en las filas 1 y 3; el cupon `CAMPUS10` tambien se repite igual en ambas.
- **Valor centinela en vez de ausencia real**: la columna `cupon` usa el texto `SIN_CUPON` para indicar que no se aplico ningun cupon, en vez de dejar el campo vacio/nulo; eso obligaria a tratar `SIN_CUPON` como si fuera un cupon valido mas si se guardara tal cual en un catalogo de cupones.
- **Dependencias parciales**: si se usara como clave compuesta `(id_orden, producto)`, el resto de columnas (`comprador`, `cupon`, `metodo_pago`, `direccion_envio`, `transportadora`) dependerian solo de `id_orden`, no de la clave completa.
- **Mezcla de conceptos distintos en una sola fila**: el pago (metodo de pago) y el envio (direccion, transportadora) son aspectos independientes de la orden, con su propio ciclo de vida, mezclados en las mismas columnas que el comprador y los productos.
- **Anomalias de insercion**: no se puede registrar un producto nuevo en el catalogo si todavia no aparece en ninguna orden, ni un cupon nuevo sin inventar una orden ficticia.
- **Anomalias de actualizacion**: si el nombre de "Nadia Cruz" cambiara, habria que corregirlo en las filas 1 y 3.
- **Anomalias de eliminacion**: si se elimina la fila 2 (la unica orden de "Omar Valle"), se pierde tambien la referencia a los productos "Laptop" y "Mochila" como si nunca hubieran existido en el catalogo.

## Dependencias funcionales

```text
id_orden -> comprador, cupon
id_orden ->> producto        (multivaluada: una orden tiene varios productos)
id_orden -> metodo_pago, monto      (pago)
id_orden -> direccion_envio, transportadora   (envio)
```

## Primera Forma Normal (1FN)

Se elimino el grupo repetido dividiendo cada orden en una fila por cada producto comprado. La clave paso a ser compuesta `(id_orden, producto)`, y cada celda quedo con un unico valor atomico.

## Segunda Forma Normal (2FN)

Con la clave compuesta `(id_orden, producto)`, los atributos `comprador`, `cupon`, `metodo_pago`, `direccion_envio` y `transportadora` dependian solo de `id_orden` (dependencia parcial). Se separaron en:

- `ordenes` (comprador y cupon de la orden), con clave `id_orden`.
- `detalle_orden` (producto, cantidad y precio aplicado dentro de esa orden), con clave compuesta `(id_orden, id_producto)`.

## Tercera Forma Normal (3FN)

Dentro de `ordenes` seguian mezclados conceptos independientes (pago y envio) y texto libre repetido (`comprador`, `cupon`). Se separaron en:

- `compradores` (nombre), referenciado desde `ordenes` por `id_comprador`.
- `productos` (nombre, precio), referenciado desde `detalle_orden` por `id_producto`.
- `cupones` (codigo), referenciado desde `ordenes` por `id_cupon`, permitiendo `NULL` cuando la orden no uso cupon (en vez del valor centinela `SIN_CUPON`).
- `pagos` (metodo de pago y monto), en relacion 1 a 1 con `ordenes` por `id_orden`.
- `envios` (direccion y transportadora), en relacion 1 a 1 con `ordenes` por `id_orden`.

## Modelo final

| Tabla | Llave primaria | Llaves foraneas | Proposito |
| --- | --- | --- | --- |
| `compradores` | `id_comprador` | - | Catalogo de compradores. |
| `productos` | `id_producto` | - | Catalogo de productos con su precio. |
| `cupones` | `id_cupon` | - | Catalogo de cupones. |
| `ordenes` | `id_orden` | `id_comprador` -> `compradores`, `id_cupon` -> `cupones` (opcional) | Encabezado de cada orden. |
| `detalle_orden` | `id_detalle` | `id_orden` -> `ordenes`, `id_producto` -> `productos` | Detalle de cada producto comprado en una orden (relacion N:M). |
| `pagos` | `id_pago` | `id_orden` -> `ordenes` (1 a 1) | Metodo y monto pagado de una orden. |
| `envios` | `id_envio` | `id_orden` -> `ordenes` (1 a 1) | Direccion y transportadora del envio de una orden. |

## Justificacion

El modelo final elimina el grupo repetido (1FN) al dar una fila por cada producto comprado en `detalle_orden`. Elimina las dependencias parciales (2FN) al sacar de la orden todo lo que no depende de la orden completa: el detalle de cada producto (cantidad, precio) queda en `detalle_orden`. Elimina las dependencias transitivas y la mezcla de conceptos (3FN) al separar `compradores`, `cupones`, `pagos` y `envios` en sus propias tablas, cada una con su responsabilidad clara.

Ademas, el modelo evita el valor centinela `SIN_CUPON` del archivo original: una orden sin cupon simplemente tiene `id_cupon = NULL`, en vez de apuntar a un registro falso en el catalogo de cupones. Con esto: actualizar el nombre de un comprador o el precio de un producto requiere un solo `UPDATE`; se puede registrar un producto o un cupon nuevo sin necesidad de una orden; y eliminar una orden no borra ni el producto ni el comprador asociados, porque existen de forma independiente en sus propias tablas.
