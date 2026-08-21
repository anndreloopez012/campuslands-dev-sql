# Analisis de Normalizacion - Ejercicio 31

## Tabla original

Archivo `datos/datos-sin-normalizar.csv`:

```text
id_venta,cliente_nombre,cliente_email,productos_comprados,precios,cantidades,vendedor,sucursal
1,Ana Perez,ana@mail.com,Mouse Gamer|Teclado RGB,125|260,1|2,Luis Rojas,Sede Norte
2,Carlos Diaz,carlos@mail.com,Monitor 24|Mouse Gamer,1450|125,1|1,Marta Lopez,Sede Centro
3,Ana Perez,ana@mail.com,USB 64GB|Base Laptop,75|180,3|1,Luis Rojas,Sede Norte
```

Es una unica tabla plana donde cada fila es una venta completa, pero `productos_comprados`, `precios` y `cantidades` guardan varios valores separados por `|` dentro de una sola celda (un grupo repetido por cada producto de la venta).

## Problemas detectados

- **Grupos repetidos**: `productos_comprados`, `precios` y `cantidades` contienen listas de valores (uno por producto) dentro de una misma celda, en vez de una fila por producto.
- **Datos duplicados**: `cliente_nombre` y `cliente_email` de "Ana Perez" se repiten en las filas 1 y 3; `vendedor` y `sucursal` de "Luis Rojas" / "Sede Norte" tambien se repiten.
- **Dependencias parciales**: si se usara como clave compuesta `(id_venta, producto)` para representar cada linea de producto, datos como `cliente_nombre`, `cliente_email`, `vendedor` y `sucursal` dependerian solo de `id_venta` (parte de la clave), no de la clave completa.
- **Dependencias transitivas**: `sucursal` depende de `vendedor` (cada vendedor trabaja siempre en la misma sucursal), y `vendedor` depende de `id_venta`; por lo tanto `sucursal` depende transitivamente de `id_venta` a traves de `vendedor`.
- **Anomalias de insercion**: no se puede registrar un producto nuevo en el catalogo (por ejemplo, un producto que aun no se ha vendido) sin inventar una venta ficticia, porque el producto solo existe dentro de la lista `productos_comprados` de alguna venta.
- **Anomalias de actualizacion**: si el correo de "Ana Perez" cambia, hay que actualizarlo en todas las filas donde aparece (fila 1 y fila 3); si se olvida una, quedan datos inconsistentes. Lo mismo ocurre si cambia la sucursal de un vendedor.
- **Anomalias de eliminacion**: si se elimina la venta 2 (la unica venta de Carlos Diaz), se pierde tambien toda la informacion del cliente Carlos Diaz y de la vendedora Marta Lopez, aunque en realidad siguen existiendo como cliente y vendedora.

## Dependencias funcionales

```text
id_venta -> cliente_nombre, cliente_email, vendedor, sucursal
cliente_nombre -> cliente_email
vendedor -> sucursal
producto -> precio_unitario
(id_venta, producto) -> cantidad
```

## Primera Forma Normal (1FN)

Se elimino el grupo repetido dividiendo cada venta en una fila por cada producto comprado (usando el separador `|` como guia). La clave paso a ser compuesta `(id_venta, producto)`, y cada celda quedo con un unico valor atomico (un producto, un precio, una cantidad por fila).

## Segunda Forma Normal (2FN)

Con la clave compuesta `(id_venta, producto)`, los atributos `cliente_nombre`, `cliente_email`, `vendedor` y `sucursal` dependian solo de `id_venta` (dependencia parcial), y `precio_unitario` dependia solo de `producto`. Se separaron en tablas independientes:

- `ventas` (encabezado de la venta: cliente, vendedor, fecha), con clave `id_venta`.
- `productos` (catalogo de productos con su precio), con clave `id_producto`.
- `detalle_venta` (linea de producto por venta: cantidad y precio unitario al momento de la venta), con clave compuesta `(id_venta, id_producto)`.

## Tercera Forma Normal (3FN)

Dentro de `ventas` seguian existiendo dependencias transitivas: `cliente_email` dependia de `cliente_nombre` (no directamente de `id_venta`) y `sucursal` dependia de `vendedor` (no directamente de `id_venta`). Se separaron en catalogos propios:

- `clientes` (nombre, correo), referenciado desde `ventas` por `id_cliente`.
- `vendedores` (nombre, sucursal), referenciado desde `ventas` por `id_vendedor`.

Con esto, `ventas` solo guarda referencias (`id_cliente`, `id_vendedor`) y datos que dependen unicamente de `id_venta` (la fecha).

## Modelo final

| Tabla | Llave primaria | Llaves foraneas | Proposito |
| --- | --- | --- | --- |
| `clientes` | `id_cliente` | - | Catalogo de clientes (nombre, correo unico). |
| `productos` | `id_producto` | - | Catalogo de productos con su precio de lista. |
| `vendedores` | `id_vendedor` | - | Catalogo de vendedores y su sucursal. |
| `ventas` | `id_venta` | `id_cliente` -> `clientes`, `id_vendedor` -> `vendedores` | Encabezado de cada venta (quien compro, quien vendio, cuando). |
| `detalle_venta` | `id_detalle` | `id_venta` -> `ventas`, `id_producto` -> `productos` | Linea de producto de una venta (cantidad y precio unitario aplicado). |

## Justificacion

El modelo final elimina los grupos repetidos (1FN) al dar una fila por cada producto vendido en `detalle_venta`. Elimina las dependencias parciales (2FN) al sacar de la venta todo lo que no depende de la venta completa: los productos y sus precios de catalogo pasan a `productos`, y la cantidad/precio de cada linea queda en `detalle_venta`. Elimina las dependencias transitivas (3FN) al separar `clientes` y `vendedores` de `ventas`, de modo que el correo del cliente y la sucursal del vendedor ya no dependen indirectamente de `id_venta`, sino directamente de sus propias llaves primarias.

Con esto: actualizar el correo de un cliente o la sucursal de un vendedor requiere un solo `UPDATE`; se puede registrar un producto o un cliente nuevo sin necesidad de una venta; y eliminar una venta ya no borra al cliente ni al vendedor asociados, porque existen de forma independiente en sus propias tablas.
