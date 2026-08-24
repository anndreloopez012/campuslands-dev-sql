# Ejercicio 28: Vistas y Reportes

## Información

- Nombre: Jose Luis Herrera
- Ejercicio: 28
- Tema: Vistas y Reportes

## Descripción

La organización necesita reemplazar el manejo manual de clientes, vendedores, ventas y pagos por una base de datos relacional que permita mantener información consistente y generar reportes mediante vistas SQL.

La solución utiliza cuatro tablas relacionadas y tres vistas especializadas para consultar información de ventas, pagos y rendimiento de vendedores.

## Modelo implementado

Las tablas utilizadas son:

- `clientes`: almacena la información de los clientes.
- `vendedores`: almacena los vendedores y su porcentaje de comisión.
- `ventas`: registra las operaciones comerciales.
- `pagos`: registra los pagos asociados a cada venta.

Las relaciones principales son:

- `clientes` 1:N `ventas`.
- `vendedores` 1:N `ventas`.
- `ventas` 1:N `pagos`.


## Índices

Se crearon índices para las columnas utilizadas frecuentemente en relaciones y consultas:

- `ventas.id_cliente`.
- `ventas.id_vendedor`.
- `ventas.fecha_venta`.
- `pagos.id_venta`.
- `pagos.fecha_pago`.

## Vistas

### vw_resumen_ventas

Integra ventas con clientes y vendedores para obtener un reporte general con:

- Número de venta.
- Fecha.
- Cliente.
- Vendedor.
- Total.
- Estado.

### vw_estado_pagos

Permite identificar el estado financiero de cada venta mediante:

- Total de la venta.
- Total de pagos aprobados.
- Saldo pendiente.

### vw_ventas_vendedores

Resume el desempeño comercial de cada vendedor mediante:

- Cantidad de ventas completadas.
- Total vendido.
- Comisión generada.


## Consultas

El archivo `dql/consultas.sql` incluye:

- Listado completo de ventas.
- Selección de columnas relevantes.
- Filtros numéricos.
- Ordenamiento por fecha.
- Top 5 de ventas completadas.
- Conteo de ventas.
- Promedio, mínimo y máximo de ventas.
- Agrupaciones por estado.
- Consultas con `JOIN`.
- Consultas con `WHERE`, `ORDER BY` y `LIMIT`.
- Reportes utilizando alias.
- Consultas sobre las vistas creadas.
- Análisis de saldos pendientes.
- Análisis de rendimiento de vendedores.
- Identificación de clientes con mayor volumen de compra.

## Estructura 

resoluciones/
└── joseluis-herrera/
    └── ejercicio-28/
        ├── README.md
        ├── diagramas/
        │   └── README.md
        ├── ddl/
        │   └── schema.sql
        ├── dml/
        │   ├── inserts.sql
        │   └── operaciones.sql
        └── dql/
            └── consultas.sql