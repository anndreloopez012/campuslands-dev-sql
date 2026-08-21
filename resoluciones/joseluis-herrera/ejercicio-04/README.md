### README.md

# Ejercicio 04: Restaurante Campus

## Información

- Nombre: Jose Luis Herrera
- Fecha: 2026-08-20
- Motor: SQLite
- Ejercicio: 04
- Rama: `alumno/joseluis-herrera/ejercicio-04`

## Descripción

El restaurante necesita reemplazar el registro manual de mesas, platos, pedidos y detalles por una base de datos relacional que permita controlar el consumo por mesa, consultar pedidos y generar reportes de ventas.

## Modelo implementado

La solución utiliza cuatro tablas:

- `mesas`: administra las mesas y su estado.
- `platos`: almacena los platos ofrecidos y sus precios.
- `pedidos`: registra cada pedido realizado en una mesa.
- `detalle_pedido`: registra los platos y cantidades asociadas a cada pedido.

## Relaciones

```text
MESAS 1 ─────── N PEDIDOS
PEDIDOS 1 ───── N DETALLE_PEDIDO
PLATOS 1 ────── N DETALLE_PEDIDO
```

`detalle_pedido` funciona como tabla de relación entre `pedidos` y `platos`.

## Restricciones

- Todas las tablas poseen `PRIMARY KEY`.
- `pedidos.id_mesa` referencia `mesas.id_mesa`.
- `detalle_pedido.id_pedido` referencia `pedidos.id_pedido`.
- `detalle_pedido.id_plato` referencia `platos.id_plato`.
- `mesas.numero_mesa` posee `UNIQUE`.
- `platos.nombre` posee `UNIQUE`.
- `NOT NULL` se utiliza en los campos obligatorios.
- La capacidad de las mesas utiliza `CHECK`.
- El estado de las mesas utiliza `CHECK`.
- El precio de los platos utiliza `CHECK`.
- La disponibilidad de los platos utiliza `CHECK`.
- El estado de los pedidos utiliza `CHECK`.
- La cantidad de platos utiliza `CHECK`.
- El precio unitario utiliza `CHECK`.
- La combinación `id_pedido` e `id_plato` utiliza `UNIQUE`.
- Las llaves foráneas se activan mediante `PRAGMA foreign_keys = ON`.

## Datos

```text
Mesas: 5 registros base
Platos: 5 registros base
Pedidos: 10 registros base
Detalles de pedido: 10 registros base
```

Los pedidos incluyen diferentes mesas, fechas, estados, platos y cantidades para permitir las consultas requeridas.


## Consultas

El archivo `dql/consultas.sql` contiene las doce consultas requeridas:

```text
1. Listado completo de pedidos.
2. Seleccion de dos columnas de pedidos.
3. Filtro de pedidos por condicion numerica.
4. Ordenamiento por fecha.
5. Top 5 platos segun unidades vendidas.
6. Conteo total de pedidos.
7. Promedio, minimo y maximo de precios.
8. Agrupacion de pedidos por estado.
9. JOIN entre pedidos y mesas.
10. WHERE + ORDER BY + LIMIT.
11. Reporte de pedidos con alias legibles y total calculado.
12. Consulta de decision sobre demanda y disponibilidad de platos.
```

## Decisiones de diseño

La tabla `pedidos` funciona como entidad transaccional central porque representa cada consumo realizado en una mesa.

La tabla `detalle_pedido` separa los datos del pedido de los platos consumidos, permitiendo registrar cantidades y precios específicos para cada plato.

La información de mesas y platos se mantiene independiente para evitar duplicidad y facilitar consultas sobre consumo, ventas y estado de las mesas.