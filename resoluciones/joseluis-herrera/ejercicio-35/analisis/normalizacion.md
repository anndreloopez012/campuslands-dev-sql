# Análisis de normalización

## Tabla original sin normalizar

La estructura inicial del archivo plano contiene:

```text
producto
categoria
proveedor
telefono_proveedor
entradas
salidas
bodega
```

## Problemas detectados

La estructura original presenta:

- Datos repetidos de productos.
- Datos repetidos de categorías.
- Datos repetidos de proveedores.
- Teléfonos de proveedores almacenados repetidamente.
- Múltiples movimientos representados dentro de una misma fila.
- Dificultad para actualizar un proveedor sin modificar múltiples registros.
- Riesgo de inconsistencias en los datos de proveedores.
- Anomalías de inserción al no poder registrar fácilmente un proveedor sin un producto.
- Anomalías de eliminación al eliminar el último producto de un proveedor.
- Dificultad para determinar el inventario actual.
- Dificultad para realizar reportes por bodega.

## Primera Forma Normal

La tabla original no cumple completamente 1FN cuando `entradas` y `salidas` contienen varios movimientos en una misma celda.

Se transforma cada movimiento en un registro independiente:

```text
MOVIMIENTOS
id_movimiento
producto
bodega
tipo_movimiento
cantidad
fecha_movimiento
observacion
```

Cada atributo contiene ahora un valor atómico.

## Segunda Forma Normal

En 2FN se eliminan las dependencias parciales.

Los datos propios del producto se separan de los movimientos.

Los datos del proveedor se separan de los productos.

Las categorías y bodegas también se mantienen como entidades independientes.

El modelo queda:

```text
PRODUCTOS
id_producto -> nombre, categoria, proveedor, precio_unitario, stock_minimo

MOVIMIENTOS
id_movimiento -> producto, bodega, tipo_movimiento, cantidad, fecha_movimiento, observacion
```

## Tercera Forma Normal

En 3FN se eliminan las dependencias transitivas.

La categoría no se almacena directamente como texto repetido en cada producto.

El proveedor no se almacena directamente con sus datos repetidos en cada producto.

La bodega se administra de manera independiente.

El modelo final queda:

```text
CATEGORIAS
id_categoria -> nombre, descripcion

PROVEEDORES
id_proveedor -> nombre, telefono, email, estado

BODEGAS
id_bodega -> nombre, ubicacion, capacidad, estado

PRODUCTOS
id_producto -> nombre, id_categoria, id_proveedor, precio_unitario, stock_minimo, estado

MOVIMIENTOS
id_movimiento -> id_producto, id_bodega, tipo_movimiento, cantidad, fecha_movimiento, observacion
```

## Justificación de las tablas finales

### categorias

Centraliza las categorías para evitar repetir sus nombres y descripciones.

### proveedores

Centraliza los datos de cada proveedor, incluyendo su teléfono y correo.

### bodegas

Representa las ubicaciones físicas donde se almacena el inventario.

### productos

Contiene los datos propios de cada producto y referencia su categoría y proveedor.

### movimientos

Registra cada entrada o salida de inventario y relaciona el producto con una bodega.

## Resultado de la normalización

El modelo final está compuesto por:

```text
CATEGORIAS
PROVEEDORES
BODEGAS
PRODUCTOS
MOVIMIENTOS
```

La separación permite registrar movimientos individualmente, calcular existencias, consultar proveedores y generar reportes por categoría, producto y bodega sin almacenar grupos repetidos.