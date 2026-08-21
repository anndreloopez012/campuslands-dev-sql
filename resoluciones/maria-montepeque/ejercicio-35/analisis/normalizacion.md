# Analisis de Normalizacion - Ejercicio 35

## Tabla original

Archivo `datos/datos-sin-normalizar.csv`:

```text
id_movimiento,producto,categoria,proveedor,telefono_proveedor,entradas,salidas,bodega
1,Laptop X1,Computadoras,TecnoMayor,5551-1000,10,2,Bodega Norte
2,Mouse Pro,Accesorios,TecnoMayor,5551-1000,50,12,Bodega Norte
3,Silla Gamer,Mobiliario,Muebles GT,5551-2000,8,1,Bodega Sur
```

Es una tabla plana donde cada fila mezcla el catalogo de un producto (categoria, proveedor, telefono del proveedor) con datos de inventario de esa fila (`entradas`, `salidas`, `bodega`). A diferencia de otros ejercicios de esta serie, aqui no hay un separador `|` explicito: el grupo repetido esta escondido en dos columnas (`entradas` y `salidas`) que en realidad representan dos movimientos de inventario distintos (uno de entrada y uno de salida) comprimidos en una sola fila por producto.

## Problemas detectados

- **Grupos repetidos**: `entradas` y `salidas` son en realidad dos movimientos de inventario (dos eventos, cada uno con su propia cantidad) representados como columnas fijas en lugar de filas independientes. Esto ademas limita el modelo a un unico par entrada/salida por producto: no hay forma de registrar un segundo movimiento del mismo producto sin agregar otra fila que repita todo el catalogo.
- **Datos duplicados**: `proveedor` y `telefono_proveedor` de "TecnoMayor" se repiten en las filas 1 y 2 (surte tanto "Laptop X1" como "Mouse Pro").
- **Dependencias parciales**: si se usara como clave compuesta `(id_movimiento, tipo_movimiento)` para separar entrada y salida en filas, datos como `producto`, `categoria`, `proveedor`, `telefono_proveedor` y `bodega` dependerian solo de `id_movimiento` (parte de la clave), no de la clave completa.
- **Dependencias transitivas**: `telefono_proveedor` depende de `proveedor` (cada proveedor tiene siempre el mismo telefono), y `proveedor` depende de `producto` (cada producto lo surte siempre el mismo proveedor); por lo tanto `telefono_proveedor` depende transitivamente del producto. Lo mismo ocurre con `categoria`, que depende del producto y no directamente del movimiento.
- **Anomalias de insercion**: no se puede registrar un proveedor nuevo (con su telefono) si todavia no surte ningun producto, ni una categoria nueva sin inventar un producto ficticio.
- **Anomalias de actualizacion**: si el telefono de "TecnoMayor" cambia, hay que actualizarlo en todas las filas donde aparece (filas 1 y 2); si se olvida una, quedan telefonos inconsistentes para el mismo proveedor.
- **Anomalias de eliminacion**: si se elimina la fila 3 (el unico movimiento de "Silla Gamer"), se pierde tambien la referencia al proveedor "Muebles GT" y a la categoria "Mobiliario", aunque en realidad ambos siguen existiendo.

## Dependencias funcionales

```text
producto -> categoria, proveedor
proveedor -> telefono_proveedor
id_movimiento -> producto, bodega, tipo_movimiento, cantidad
```

## Primera Forma Normal (1FN)

Se elimino el grupo repetido escondido en `entradas` y `salidas` convirtiendo cada una en su propia fila de movimiento, con una columna `tipo_movimiento` (`'entrada'` o `'salida'`) y una sola columna `cantidad`. Cada fila del CSV origino dos filas normalizadas (una de entrada y una de salida), con un unico valor atomico por celda.

## Segunda Forma Normal (2FN)

Con la clave compuesta `(producto, tipo_movimiento)` que resultaria de la 1FN, los atributos `categoria`, `proveedor` y `telefono_proveedor` dependian solo de `producto` (dependencia parcial), no de la combinacion completa. Se separaron en una tabla de catalogo:

- `productos` (nombre, categoria, proveedor), con clave `id_producto`.
- `movimientos` (tipo, cantidad, bodega y fecha del movimiento), con clave propia `id_movimiento` y FK a `productos`.

## Tercera Forma Normal (3FN)

Dentro de `productos` seguia existiendo una dependencia transitiva: `telefono_proveedor` dependia de `proveedor` (no directamente del producto). Se separaron en catalogos independientes:

- `categorias` (nombre), referenciada desde `productos` por `id_categoria`.
- `proveedores` (nombre, telefono), referenciado desde `productos` por `id_proveedor`.
- `bodegas` (nombre), referenciada desde `movimientos` por `id_bodega`.

Con esto, `productos` solo guarda referencias (`id_categoria`, `id_proveedor`) y `movimientos` solo guarda referencias (`id_producto`, `id_bodega`) mas los datos que dependen unicamente del movimiento (`tipo_movimiento`, `cantidad`, `fecha_movimiento`).

## Modelo final

| Tabla | Llave primaria | Llaves foraneas | Proposito |
| --- | --- | --- | --- |
| `categorias` | `id_categoria` | - | Catalogo de categorias de producto. |
| `proveedores` | `id_proveedor` | - | Catalogo de proveedores (nombre, telefono). |
| `bodegas` | `id_bodega` | - | Catalogo de bodegas. |
| `productos` | `id_producto` | `id_categoria` -> `categorias`, `id_proveedor` -> `proveedores` | Catalogo de productos, cada uno con su categoria y proveedor. |
| `movimientos` | `id_movimiento` | `id_producto` -> `productos`, `id_bodega` -> `bodegas` | Detalle de cada entrada o salida de un producto en una bodega. |

## Justificacion

El modelo final elimina el grupo repetido escondido (1FN) al convertir las columnas `entradas`/`salidas` en filas independientes de `movimientos`, cada una con su `tipo_movimiento` y `cantidad`; esto ademas permite registrar cualquier numero de movimientos futuros por producto, no solo un par fijo. Elimina las dependencias parciales (2FN) al sacar del movimiento todo lo que no depende del movimiento completo: categoria y proveedor pasan a ser atributos del producto en `productos`. Elimina las dependencias transitivas (3FN) al separar `categorias`, `proveedores` y `bodegas` de `productos`/`movimientos`, de modo que el telefono del proveedor ya no depende indirectamente del producto, sino directamente de `id_proveedor`.

Con esto: actualizar el telefono de un proveedor requiere un solo `UPDATE`; se puede registrar un proveedor, una categoria o una bodega nueva sin necesidad de un movimiento; y eliminar un movimiento ya no borra el producto, la categoria ni el proveedor asociados, porque existen de forma independiente en sus propias tablas.
