# == Campus Shop ==
**Autor:** Brandon Estiben Ixen  
**Fecha:** 22 de agosto de 2026

> **Campus Shop** es una tienda dedicada a la venta de productos tecnológicos.

**Problema detectado y planteado por el cliente:** Actualmente Campus Shop cuenta con el problema de la difícil gestión del inventario de ventas, ya que registra manualmente productos, categorías, clientes y ventas, lo que provoca duplicidad, errores de captura y dificultad para generar reportes.

La base de datos **campus_shop** con el objetivo de resolver la mala gestión de inventarios, registros y ventas realizadas, cuenta con cuatro tablas principales que a continuación se detallan.

tablas:

> **categorias** Esta tabla almacena los diferentes tipos de productos disponibles en la tienda, registrando el nombre único de la categoría y una descripción opcional. Recibe un **id** autoincrementable por cada categoría.

> **productos** Aquí se registran todos los productos de la tienda, recopilando nombre único, categoría a la que pertenece, cantidad en stock y precio. Tiene llave foránea hacia **categorias**. Recibe un **id** autoincrementable por cada producto.

> **clientes** En esta tabla se registran todos los clientes que realizan compras, guardando su nombre obligatoriamente, teléfono de forma única, dirección y correo electrónico. Recibe un **id** autoincrementable por cada cliente.

> **ventas** Almacena todas las ventas realizadas en la tienda, registrando el cliente, el producto, la cantidad vendida y la fecha. Esta tabla permite llamar todos los datos necesarios sobre productos y clientes para registrar la venta y mantener un historial.

---
---

## Datos de prueba.

Los datos de prueba representan cinco categorías, cinco productos, cinco clientes y diez ventas. Las ventas relacionan clientes y productos mediante sus identificadores, por lo que permiten comprobar el historial de compras y las consultas con `JOIN`.

### Categorías registradas

| ID | Categoría | Descripción |
| --- | --- | --- |
| 1 | Computadoras | Laptops, desktops y componentes |
| 2 | Accesorios | Periféricos y accesorios |
| 3 | Pantallas | Monitores y pantallas |
| 4 | Audio | Audífonos, bocinas |
| 5 | Redes | Routers, switches y cables |

### Productos registrados

| ID | Producto | Categoría | Stock | Precio |
| --- | --- | --- | ---: | ---: |
| 1 | Laptop Lenovo IdeaPad | Computadoras | 10 | Q5,500.00 |
| 2 | Mouse Logitech MX | Accesorios | 50 | Q350.00 |
| 3 | Teclado Mecánico K200 | Accesorios | 30 | Q480.00 |
| 4 | Monitor Samsung 24" | Pantallas | 20 | Q1,800.00 |
| 5 | Audífonos Sony WH | Audio | 25 | Q950.00 |

### Clientes registrados

| ID | Cliente | Teléfono | Dirección |
| --- | --- | --- | --- |
| 1 | Juan Pérez | 5551234 | Zona 1, Guatemala |
| 2 | María López | 5555678 | Zona 10, Guatemala |
| 3 | Carlos Gómez | 5559012 | Mixco, Guatemala |
| 4 | Ana Martínez | 5553456 | Villa Nueva, Guatemala |
| 5 | Roberto Díaz | 5557890 | Zona 15, Guatemala |

### Ventas registradas

| Cliente | Producto | Cantidad | Fecha |
| --- | --- | --- | --- |
| Juan Pérez | Laptop Lenovo IdeaPad | 1 | 2026-08-01 |
| María López | Mouse Logitech MX | 2 | 2026-08-02 |
| Carlos Gómez | Teclado Mecánico K200 | 1 | 2026-08-05 |
| Ana Martínez | Monitor Samsung 24" | 1 | 2026-08-08 |
| Juan Pérez | Mouse Logitech MX | 1 | 2026-08-10 |

## Relaciones entre tablas

- `categorias` clasifica los productos del inventario; `productos` tiene llave foránea `id_categoria`.
- `clientes` almacena los compradores y se relaciona con `ventas` mediante `ventas.id_cliente`.
- `productos` se relaciona con `ventas` mediante `ventas.id_producto`.
- `ventas` funciona como tabla transaccional: cada registro representa una compra con su fecha y cantidad.

## Restricciones aplicadas

- Cada tabla tiene una llave primaria autoincrementable.
- `categorias.nombre_categoria` y `productos.nombre_producto` son únicos mediante `UNIQUE`.
- `clientes.nombre_cliente` es obligatorio con `NOT NULL`.
- `clientes.telefono` debe ser único mediante `UNIQUE`.
- `productos.cantidad_stock` debe ser mayor o igual a cero con `CHECK (cantidad_stock >= 0)`.
- `productos.precio` debe ser mayor a cero con `CHECK (precio > 0)`.
- `ventas.cantidad` debe ser mayor a cero con `CHECK (cantidad > 0)`.
- Las llaves foráneas en `productos` y `ventas` evitan referencias a registros inexistentes.
- `PRAGMA foreign_keys = ON` activa la integridad referencial en SQLite.

## Consultas y reportes

El archivo `dql/consultas.sql` contiene las consultas solicitadas para revisar la información de la base de datos:

1. Lista las ventas ordenadas de la más reciente a la más antigua.
2. Muestra el producto vendido y la fecha de venta.
3. Filtra los productos con precio mayor a Q500.
4. Ordena los productos alfabéticamente por nombre.
5. Muestra las cinco ventas más recientes.
6. Cuenta la cantidad de productos registrados.
7. Calcula el precio promedio, mínimo y máximo.
8. Agrupa las ventas para conocer el total vendido por producto.
9. Une productos y categorías para mostrar el inventario clasificado.
10. Consulta las últimas cinco compras realizadas por el cliente con ID 1.
11. Genera un reporte con nombres de columnas legibles.
12. Identifica los productos con mayor cantidad de ventas para apoyar decisiones de inventario.

## Archivos de la solución

- `ddl/schema.sql`: creación de la base de datos y sus tablas.
- `dml/inserts.sql`: inserción de categorías, productos, clientes y ventas.
- `dml/operaciones.sql`: espacio destinado a operaciones `INSERT`, `UPDATE` y `DELETE` adicionales.
- `dql/consultas.sql`: consultas de análisis y reportes.

## Como ejecutar

Desde la raíz de la solución:

```bash
sqlite3 ejercicio-02.db < ddl/schema.sql
sqlite3 ejercicio-02.db < dml/inserts.sql
sqlite3 ejercicio-02.db < dml/operaciones.sql
sqlite3 ejercicio-02.db < dql/consultas.sql
```

No subir archivos `.db`, `.sqlite` ni `.sqlite3`.
