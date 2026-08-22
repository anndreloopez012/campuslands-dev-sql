# Análisis de normalización

## Tabla original sin normalizar

La estructura inicial del archivo plano contiene:

```text
comprador
productos
cupon
metodo_pago
direccion_envio
transportadora
```

## Problemas detectados

La estructura original presenta:

- Datos repetidos de compradores.
- Datos repetidos de productos.
- Datos repetidos de transportadoras.
- Información de pago mezclada con la orden.
- Información de envío mezclada con la orden.
- Información de cupones repetida.
- Múltiples productos dentro de una misma celda.
- Dificultad para modificar los datos de un comprador.
- Dificultad para actualizar el precio de un producto.
- Anomalías de inserción.
- Anomalías de actualización.
- Anomalías de eliminación.
- Consultas complejas para conocer los productos de una orden.

## Primera Forma Normal

La estructura original viola 1FN cuando varios productos se almacenan en una misma celda.

Por ejemplo:

```text
productos = "Laptop, Mouse, Teclado"
```

Cada producto debe convertirse en un registro independiente.

La información queda separada mediante:

```text
ORDENES
DETALLE_ORDEN
```

Los atributos pasan a contener valores atómicos.

## Segunda Forma Normal

Para alcanzar 2FN se eliminan dependencias parciales.

Los datos propios del comprador se separan en `compradores`.

Los datos propios de cada producto se separan en `productos`.

Los datos de los cupones se almacenan en `cupones`.

Los datos de las transportadoras se almacenan en `transportadoras`.

La información específica de cada orden queda en `ordenes`.

Los productos pertenecientes a una orden quedan en `detalle_orden`.

## Tercera Forma Normal

Para alcanzar 3FN se eliminan dependencias transitivas.

La información de compradores no se repite en las órdenes.

La información de productos no se repite en los detalles.

La información de los cupones no se repite en las órdenes.

La información de las transportadoras no se repite en los envíos.

La información de pago se almacena en `pagos`.

La información logística se almacena en `envios`.

Cada tabla contiene atributos que dependen directamente de su clave primaria.

## Justificación de las tablas finales

### compradores

Almacena la información de cada comprador.

### productos

Centraliza los productos disponibles y evita repetir nombres, precios y existencias.

### cupones

Almacena los códigos promocionales y sus condiciones.

### transportadoras

Centraliza las empresas responsables de los envíos.

### ordenes

Representa la compra realizada por un comprador.

### detalle_orden

Relaciona cada orden con sus productos y almacena la cantidad y precio utilizado en la operación.

### pagos

Registra el método, monto, fecha y estado del pago asociado a una orden.

### envios

Registra la información logística de una orden y la transportadora utilizada.