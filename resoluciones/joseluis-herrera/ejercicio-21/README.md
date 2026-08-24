# Ejercicio 21: Logistica Envios

## Descripción

Sistema de gestión logística para registrar clientes, paquetes, rutas y envíos, permitiendo el seguimiento del estado y los costos de transporte.

## Modelo implementado

- `clientes`: información de los clientes.
- `rutas`: trayectos disponibles.
- `paquetes`: paquetes registrados por cliente.
- `envios`: seguimiento de cada envío.

## Relaciones

- Un cliente posee varios paquetes.
- Un paquete puede generar varios envíos.
- Una ruta puede ser utilizada por varios envíos.

## Estructura

```text
resoluciones/
└── joseluis-herrera/
    └── ejercicio-21/
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
```