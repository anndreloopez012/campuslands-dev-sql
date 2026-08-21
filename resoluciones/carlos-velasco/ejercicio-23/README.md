### README.md

# Ejercicio 23: Facturacion Simple

## Información

- **Nombre:** Carlos Velasco
- **Fecha:** 2026-08-20
- **Motor:** SQLite
- **Ejercicio:** 23
- **Tema:** Facturación, subtotales e impuestos

## Descripción

El ejercicio implementa una base de datos relacional para gestionar un sistema de facturación. El modelo permite registrar clientes, productos, facturas y los productos incluidos en cada factura.

La solución busca evitar duplicidad de información y facilitar la generación de reportes relacionados con ventas, subtotales, impuestos y comportamiento de los productos.

## Modelo implementado

La solución utiliza cuatro tablas:

| Tabla | Responsabilidad |
| --- | --- |
| `clientes` | Almacena la información de los clientes. |
| `productos` | Almacena los productos disponibles y su inventario. |
| `facturas` | Registra las facturas emitidas a los clientes. |
| `detalle_factura` | Registra los productos, cantidades y precios asociados a cada factura. |

### Relaciones

- Un cliente puede tener muchas facturas.
- Una factura pertenece a un único cliente.
- Una factura puede contener varios productos.
- Un producto puede aparecer en múltiples facturas.
- `detalle_factura` relaciona las facturas con los productos.

## Restricciones

El modelo incluye:

- `PRIMARY KEY` en todas las tablas.
- `FOREIGN KEY` para mantener la integridad referencial.
- `NOT NULL` en los campos obligatorios.
- `UNIQUE` para documentos, correos, nombres de productos y números de factura.
- `CHECK` para validar precios, cantidades, stock, impuestos, estados y fechas.
- `DEFAULT` para el impuesto, el estado de la factura y el stock.
- `PRAGMA foreign_keys = ON` para activar las claves foráneas en SQLite.

## Datos

Se registraron:

- 5 clientes.
- 5 productos.
- 5 facturas.
- 10 detalles de factura.

Además, `operaciones.sql` contiene 2 inserciones adicionales, 2 actualizaciones y 2 eliminaciones controladas.

## Operaciones

Las operaciones válidas incluyen:

- Registro de un cliente adicional.
- Registro de un producto adicional.
- Actualización de un teléfono de cliente.
- Actualización del precio de un producto.
- Eliminación controlada del cliente adicional.
- Eliminación controlada del producto adicional.

También se incluyen dos operaciones inválidas comentadas:

- Un producto con precio negativo para provocar un error de `CHECK`.
- Una factura con número de factura repetido para provocar un error de `UNIQUE`.

Las operaciones inválidas permanecen comentadas para evitar que interrumpan la ejecución normal del script.

## Consultas

El archivo `dql/consultas.sql` contiene las doce consultas solicitadas:

1. Listado de facturas.
2. Selección de dos columnas.
3. Filtrado por fecha.
4. Ordenamiento por fecha.
5. Top 5 de facturas según subtotal.
6. Conteo de facturas.
7. Promedio, mínimo y máximo de precios.
8. Agrupación de facturas por estado.
9. Consulta con múltiples `JOIN`.
10. Consulta con `WHERE`, `ORDER BY` y `LIMIT`.
11. Reporte con alias legibles.
12. Reporte para identificar productos que requieren reabastecimiento o prioridad comercial.

## Ejecución

Desde la raíz de la solución:

```bash
sqlite3 ejercicio-23.db < ddl/schema.sql
sqlite3 ejercicio-23.db < dml/inserts.sql
sqlite3 ejercicio-23.db < dml/operaciones.sql
sqlite3 ejercicio-23.db < dql/consultas.sql
```

No se debe subir el archivo de base de datos generado.

## Validaciones

Para comprobar la integridad referencial y las restricciones se pueden ejecutar:

```sql
PRAGMA foreign_keys;
PRAGMA integrity_check;
```

El resultado esperado para la integridad de la base de datos es:

```text
ok
```

La consulta de `PRAGMA foreign_keys` debe devolver:

```text
1
```

## Decisiones de diseño

`detalle_factura` se utiliza como tabla asociativa porque una factura puede contener varios productos y un producto puede aparecer en múltiples facturas.

El precio unitario se almacena en `detalle_factura` para conservar el precio aplicado en el momento de la venta, independientemente de futuras modificaciones del precio actual del producto.

El impuesto se almacena en `facturas` para permitir que cada factura conserve la tasa utilizada al momento de su emisión.

Los totales se calculan mediante consultas a partir de cantidades, precios unitarios e impuesto, evitando almacenar valores derivados innecesarios.

## Evidencias de resultados relevantes

El conjunto inicial permite generar reportes de facturación, consultar subtotales, calcular impuestos, comparar precios y analizar los productos vendidos.

La consulta de decisión de negocio clasifica los productos según sus unidades vendidas e inventario actual, permitiendo identificar productos que requieren reabastecimiento o seguimiento comercial.