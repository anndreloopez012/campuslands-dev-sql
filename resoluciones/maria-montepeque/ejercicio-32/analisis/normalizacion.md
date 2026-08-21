# Analisis de Normalizacion - Ejercicio 32

## Tabla original

Archivo `datos/datos-sin-normalizar.csv`:

```text
id_pedido,mesa,mesero,platos,categorias,precios,cantidades,fecha_pedido
1,Mesa 4,Sofia Mendez,Pizza|Limonada,Comida|Bebida,85|18,2|2,2026-06-01
2,Mesa 2,Sofia Mendez,Hamburguesa|Papas,Comida|Acompanamiento,55|22,1|1,2026-06-01
3,Mesa 4,Diego Ruiz,Cafe|Pastel,Bebida|Postre,15|30,2|1,2026-06-02
```

Es una tabla plana donde cada fila es un pedido completo, pero `platos`, `categorias`, `precios` y `cantidades` guardan varios valores separados por `|` dentro de una sola celda (un grupo repetido por cada plato del pedido).

## Problemas detectados

- **Grupos repetidos**: `platos`, `categorias`, `precios` y `cantidades` contienen listas de valores (uno por plato) dentro de una misma celda en lugar de una fila por plato.
- **Datos duplicados**: "Mesa 4" aparece en los pedidos 1 y 3; "Sofia Mendez" aparece en los pedidos 1 y 2; la categoria de "Pizza" ("Comida") tendria que repetirse cada vez que se pide una pizza.
- **Dependencias parciales**: si se usara como clave compuesta `(id_pedido, plato)` para representar cada linea de plato, datos como `mesa`, `mesero` y `fecha_pedido` dependerian solo de `id_pedido` (parte de la clave), no de la clave completa.
- **Dependencias transitivas**: `categoria` y `precio` dependen del `plato` (cada plato tiene siempre la misma categoria y el mismo precio de menu), y el `plato` depende de `id_pedido`; por lo tanto `categoria` y `precio` dependen transitivamente de `id_pedido` a traves del `plato`.
- **Anomalias de insercion**: no se puede agregar un plato nuevo al menu (por ejemplo, uno que todavia no se ha pedido) sin inventar un pedido ficticio, porque el plato solo existe dentro de la lista `platos` de algun pedido.
- **Anomalias de actualizacion**: si el precio de "Pizza" cambia, hay que actualizarlo en todas las filas donde aparece; si se olvida una, quedan precios inconsistentes para el mismo plato.
- **Anomalias de eliminacion**: si se elimina el pedido 2 (el unico pedido de "Mesa 2"), se pierde la referencia a esa mesa aunque en realidad la mesa sigue existiendo en el restaurante.

## Dependencias funcionales

```text
id_pedido -> mesa, mesero, fecha_pedido
plato -> categoria, precio
(id_pedido, plato) -> cantidad
```

## Primera Forma Normal (1FN)

Se elimino el grupo repetido dividiendo cada pedido en una fila por cada plato solicitado (usando el separador `|` como guia). La clave paso a ser compuesta `(id_pedido, plato)`, y cada celda quedo con un unico valor atomico (un plato, una categoria, un precio, una cantidad por fila).

## Segunda Forma Normal (2FN)

Con la clave compuesta `(id_pedido, plato)`, los atributos `mesa`, `mesero` y `fecha_pedido` dependian solo de `id_pedido` (dependencia parcial), y `categoria` y `precio` dependian solo de `plato`. Se separaron en tablas independientes:

- `pedidos` (encabezado del pedido: mesa, mesero, fecha), con clave `id_pedido`.
- `platos` (catalogo de platos con su categoria y precio), con clave `id_plato`.
- `detalle_pedido` (linea de plato por pedido: cantidad y precio unitario al momento del pedido), con clave compuesta `(id_pedido, id_plato)`.

## Tercera Forma Normal (3FN)

Dentro de `pedidos` seguia existiendo una dependencia parcial cubierta arriba, pero ademas `mesa` y `mesero` son entidades propias que se repetian por texto en cada fila. Aunque `categoria` ya quedo directamente en `platos` (dependencia no transitiva dentro de esa tabla), se formalizo la separacion de `mesa` y `mesero` como catalogos independientes para que `pedidos` solo guarde referencias:

- `mesas` (numero de mesa), referenciada desde `pedidos` por `id_mesa`.
- `meseros` (nombre del mesero), referenciada desde `pedidos` por `id_mesero`.

Con esto, `pedidos` solo guarda referencias (`id_mesa`, `id_mesero`) y el dato que depende unicamente de `id_pedido` (la fecha), sin repetir texto de mesas ni de meseros.

## Modelo final

| Tabla | Llave primaria | Llaves foraneas | Proposito |
| --- | --- | --- | --- |
| `mesas` | `id_mesa` | - | Catalogo de mesas del restaurante. |
| `meseros` | `id_mesero` | - | Catalogo de meseros. |
| `platos` | `id_plato` | - | Catalogo de platos del menu con su categoria y precio. |
| `pedidos` | `id_pedido` | `id_mesa` -> `mesas`, `id_mesero` -> `meseros` | Encabezado de cada pedido (mesa, mesero, fecha). |
| `detalle_pedido` | `id_detalle` | `id_pedido` -> `pedidos`, `id_plato` -> `platos` | Linea de plato de un pedido (cantidad y precio aplicado). |

## Justificacion

El modelo final elimina los grupos repetidos (1FN) al dar una fila por cada plato pedido en `detalle_pedido`. Elimina las dependencias parciales (2FN) al sacar del pedido todo lo que no depende del pedido completo: los platos y su categoria/precio de menu pasan a `platos`, y la cantidad de cada linea queda en `detalle_pedido`. Elimina las dependencias transitivas (3FN) al separar `mesas` y `meseros` de `pedidos`, de modo que sus datos ya no se repiten como texto libre en cada pedido, sino que se referencian por llave.

Con esto: actualizar el precio de un plato requiere un solo `UPDATE` en `platos`; se puede registrar un plato o una mesa nueva sin necesidad de un pedido; y eliminar un pedido ya no borra la mesa ni el mesero asociados, porque existen de forma independiente en sus propias tablas.
