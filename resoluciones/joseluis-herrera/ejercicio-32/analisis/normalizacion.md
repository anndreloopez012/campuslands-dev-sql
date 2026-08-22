## Modelo original sin normalizar

La estructura de partida contiene:

```text
mesa
mesero
platos
categorias
precios
cantidades
fecha_pedido
```

Los campos `platos`, `categorias`, `precios` y `cantidades` pueden contener múltiples valores asociados a un mismo pedido, generando grupos repetidos y violando la Primera Forma Normal.

## Dependencias funcionales

Las principales dependencias identificadas son:

```text
numero_mesa -> capacidad, estado
nombre_completo_mesero -> turno, estado
nombre_categoria -> datos de la categoria
nombre_plato -> id_categoria, precio, estado
id_pedido -> id_mesa, id_mesero, fecha_pedido, estado
(id_pedido, id_plato) -> cantidad, precio_unitario
```

## Primera Forma Normal

Para cumplir 1FN se eliminan los grupos repetidos de platos, categorías, precios y cantidades.

Cada combinación de pedido y plato pasa a representar un registro independiente en `detalle_pedido`.

```text
PEDIDOS
id_pedido
mesa
mesero
fecha_pedido
estado

DETALLE_PEDIDO
id_pedido
plato
categoria
precio
cantidad
```

## Segunda Forma Normal

Para cumplir 2FN se eliminan las dependencias parciales de la clave compuesta del detalle.

La información propia del pedido se almacena en `pedidos`.

La información propia del plato se almacena en `platos`.

La relación entre pedido y plato se almacena en `detalle_pedido`.

```text
PEDIDOS
id_pedido -> id_mesa, id_mesero, fecha_pedido, estado

PLATOS
id_plato -> nombre, id_categoria, precio, estado

DETALLE_PEDIDO
(id_pedido, id_plato) -> cantidad, precio_unitario
```

## Tercera Forma Normal

Para cumplir 3FN se eliminan las dependencias transitivas.

Las categorías se separan de los platos, las mesas se separan de los pedidos y los meseros se separan de los pedidos.

```text
MESAS
id_mesa -> numero_mesa, capacidad, estado

MESEROS
id_mesero -> nombre_completo, turno, estado

CATEGORIAS
id_categoria -> nombre

PLATOS
id_plato -> nombre, id_categoria, precio, estado

PEDIDOS
id_pedido -> id_mesa, id_mesero, fecha_pedido, estado

DETALLE_PEDIDO
(id_pedido, id_plato) -> cantidad, precio_unitario
```

## Tablas finales

### mesas

Almacena las mesas disponibles en el restaurante.

### meseros

Almacena los empleados responsables de atender los pedidos.

### categorias

Almacena las categorías de los platos.

### platos

Almacena cada plato y su categoría, precio y estado.

### pedidos

Representa cada pedido realizado en una mesa y atendido por un mesero.

### detalle_pedido

Relaciona los pedidos con los platos e indica la cantidad y el precio utilizado en la transacción.