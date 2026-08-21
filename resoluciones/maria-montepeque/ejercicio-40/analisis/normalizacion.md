# Analisis de Normalizacion - Ejercicio 40

## Tabla original

Archivo `datos/datos-sin-normalizar.csv`:

```text
id_operacion,cliente,vendedor,productos,pagos,cuotas,entregas,estados
1,Sergio Ramos,Lucia Diaz,Tablet|Case,Tarjeta|Efectivo,1|0,Envio Norte|Tienda,Pagado|Entregado
2,Paola Mejia,Lucia Diaz,Laptop|Mouse,Credito,3,Envio Centro,Pendiente
3,Sergio Ramos,Mateo Ruiz,Monitor|Cable HDMI,Transferencia,1,Envio Norte,Pagado
```

Es una tabla plana con **dos grupos repetidos independientes** en la misma fila: `productos` (la lista de productos comprados) y el conjunto `pagos`/`cuotas`/`entregas`/`estados` (los eventos de pago y entrega de esa operacion). Este es el ejercicio integrador: no basta con quitar un solo grupo repetido, hay que reconocer que hay **mas de un** hecho multivaluado sobre la misma operacion.

## Problemas detectados

- **Dos grupos repetidos, no uno**: `productos` tiene su propia cantidad de valores por fila (siempre 2 en las 3 filas). `pagos`, `cuotas`, `entregas` y `estados` tienen, cada fila, la MISMA cantidad de valores entre si (2 en la fila 1; 1 en las filas 2 y 3), pero esa cantidad es **independiente** de la cantidad de productos. Esto es la evidencia clave de que son dos hechos multivaluados distintos sobre la operacion, no uno solo.
- **Grupo compuesto**: dentro del segundo grupo, `pagos[i]`, `cuotas[i]`, `entregas[i]` y `estados[i]` siempre aparecen en la misma cantidad y en el mismo orden dentro de cada fila (por ejemplo, en la fila 1: `Tarjeta` va con `1` cuota, `Envio Norte` y `Pagado`; `Efectivo` va con `0` cuotas, `Tienda` y `Entregado`). Eso indica que las cuatro columnas describen, juntas, un unico evento (un pago parcial con su entrega y estado), no cuatro grupos repetidos independientes entre si.
- **Datos duplicados**: "Sergio Ramos" aparece en las filas 1 y 3 (con vendedores distintos); "Lucia Diaz" aparece en las filas 1 y 2.
- **Dependencias parciales**: si se usara una clave que combine `id_operacion` con el producto o con el evento de pago/entrega, el resto de columnas de la operacion (`cliente`, `vendedor`) dependerian solo de `id_operacion`.
- **Anomalias de insercion**: no se puede registrar un producto o un cliente nuevo sin inventar una operacion.
- **Anomalias de actualizacion**: si el nombre de "Sergio Ramos" cambiara, habria que corregirlo en las filas 1 y 3.
- **Anomalias de eliminacion**: eliminar la fila 2 borraria tambien la unica referencia a "Paola Mejia" como cliente.

## Dependencias funcionales

```text
id_operacion -> cliente, vendedor
id_operacion ->> producto                              (multivaluada, independiente)
id_operacion ->> (metodo_pago, cuotas, zona_entrega, estado)   (multivaluada, valores agrupados)
```

## Primera Forma Normal (1FN)

Se identificaron los dos grupos repetidos por separado (no se asumio que `productos` estuviera alineado con `pagos`, a pesar de que en la fila 1 ambos tienen 2 valores: las filas 2 y 3 muestran 2 productos pero solo 1 pago/entrega/estado, lo que descarta esa alineacion). Cada producto paso a ser una fila propia, y cada combinacion `(pago, cuota, entrega, estado)` tambien paso a ser una fila propia.

## Segunda Forma Normal (2FN)

`cliente` y `vendedor` dependian solo de `id_operacion` (dependencia parcial respecto de cualquier clave compuesta con producto o con el evento de pago). Se separaron en:

- `operaciones` (cliente, vendedor), con clave `id_operacion`.
- `detalle_producto` (producto comprado), con clave compuesta `(id_operacion, id_producto)`.
- `movimientos` (metodo de pago, cuotas, zona de entrega, estado), con clave propia `id_movimiento` y FK a `id_operacion`.

## Tercera Forma Normal (3FN)

`cliente`, `vendedor` y `producto` seguian siendo texto libre repetido. Se separaron en catalogos:

- `clientes` (nombre), referenciado desde `operaciones` por `id_cliente`.
- `vendedores` (nombre), referenciado desde `operaciones` por `id_vendedor`.
- `productos` (nombre), referenciado desde `detalle_producto` por `id_producto`.

## Descomposicion adicional (4FN): por que `movimientos` no se separo en `pagos` y `entregas`

El enunciado pide justificar si alguna relacion requiere descomposicion adicional. La candidata natural es `movimientos`: en un sistema real, un pago y una entrega son procesos independientes (se podria pagar todo de una vez y entregar en varias partes, o al reves), lo que en teoria seria una dependencia multivaluada de 4FN que exigiria separar `pagos` de `entregas`.

Sin embargo, en **este** conjunto de datos, `pagos`, `cuotas`, `entregas` y `estados` siempre aparecen en la misma cantidad y en el mismo orden dentro de cada fila (verificado con la consulta 1, que reconstruye el CSV original exactamente). Esto es evidencia de que, para este negocio, cada movimiento de pago se registra siempre junto con su entrega y su estado como un unico evento, no como dos listas independientes. Por eso se decidio mantenerlos juntos en una sola tabla `movimientos`, evitando una separacion que en este caso no aporta (y que, sin una clave para volver a emparejar pago con entrega, generaria un producto cartesiano falso al hacer `JOIN` entre dos tablas independientes).

**Si el negocio cambiara** y un pago pudiera tener una cantidad distinta de entregas asociadas (por ejemplo, pagar en 1 sola cuota pero recibir el pedido en 3 envios separados), si se justificaria descomponer `movimientos` en `pagos` (metodo, cuotas, estado de pago) y `entregas` (zona, estado de entrega) por separado, cada una con su propia clave y FK a `operaciones`, aceptando que ya no habria una forma automatica de saber que pago corresponde a que entrega sin un campo adicional que las relacione.

## Modelo final

| Tabla | Llave primaria | Llaves foraneas | Proposito |
| --- | --- | --- | --- |
| `clientes` | `id_cliente` | - | Catalogo de clientes. |
| `vendedores` | `id_vendedor` | - | Catalogo de vendedores. |
| `productos` | `id_producto` | - | Catalogo de productos. |
| `operaciones` | `id_operacion` | `id_cliente` -> `clientes`, `id_vendedor` -> `vendedores` | Encabezado de cada operacion (venta). |
| `detalle_producto` | `id_detalle` | `id_operacion` -> `operaciones`, `id_producto` -> `productos` | Primer hecho multivaluado: productos comprados en la operacion. |
| `movimientos` | `id_movimiento` | `id_operacion` -> `operaciones` | Segundo hecho multivaluado: cada evento de pago con su entrega y estado. |

## Justificacion

El modelo final separa correctamente los **dos** hechos multivaluados independientes de la operacion (productos por un lado, movimientos de pago/entrega por el otro) en tablas distintas, evitando el error comun de asumir que ambos grupos estan alineados solo porque en una fila del CSV coinciden en cantidad. Dentro de `movimientos`, se documenta explicitamente por que no se aplico una descomposicion 4FN adicional (separar pago de entrega): los datos disponibles muestran que siempre se mueven juntos, y separarlos sin evidencia introduciria complejidad y el riesgo de un producto cartesiano al reconstruir la informacion.
