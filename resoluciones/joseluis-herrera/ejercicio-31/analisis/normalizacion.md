# Análisis de Normalización

## 1. Tabla original sin normalizar

La estructura inicial representa la información de ventas en una única tabla conceptual:

| Campo | Descripción |
|---|---|
| cliente_nombre | Nombre del cliente |
| cliente_email | Correo del cliente |
| productos_comprados | Productos adquiridos |
| precios | Precios correspondientes |
| cantidades | Cantidades correspondientes |
| vendedor | Vendedor responsable |
| sucursal | Sucursal donde se realizó la venta |

La columna `productos_comprados` puede contener múltiples productos dentro de una misma celda. Lo mismo ocurre con `precios` y `cantidades`.

## 2. Problemas detectados

- Repetición de información de clientes.
- Repetición de información de productos.
- Repetición de información de vendedores.
- Repetición de información de sucursales.
- Múltiples valores dentro de una misma celda.
- Dificultad para modificar un cliente sin actualizar múltiples registros.
- Dificultad para modificar un producto sin actualizar múltiples registros.
- Posibles inconsistencias entre productos, precios y cantidades.
- Anomalías de inserción.
- Anomalías de actualización.
- Anomalías de eliminación.
- Dependencia de datos descriptivos para identificar una venta.

## 3. Clave candidata

En la tabla original, considerando que una venta puede contener varios productos, una clave candidata conceptual puede estar formada por:

`(cliente_email, vendedor, sucursal, fecha_venta, producto)`

Sin embargo, esta clave presenta información descriptiva y no es adecuada como identificador operativo.

En el modelo normalizado se introduce `id_venta` como clave primaria de la entidad `ventas` y `(id_venta, id_producto)` como clave primaria de `detalle_venta`.

## 4. Dependencias funcionales

Las principales dependencias funcionales identificadas son:

```text
cliente_email → cliente_nombre, telefono
id_producto → nombre_producto, categoria, precio, stock
id_vendedor → vendedor_nombre, vendedor_email
id_sucursal → sucursal_nombre, direccion, telefono
id_venta → id_cliente, id_vendedor, id_sucursal, fecha_venta
(id_venta, id_producto) → cantidad, precio_unitario
```