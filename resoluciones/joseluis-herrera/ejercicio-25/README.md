# Ejercicio 25: Reportes Biblioteca

## Información

- Nombre completo: Jose Luis Tot Herrera
- Fecha: 2026-08-20
- Motor: SQLite

## Descripción

Sistema de biblioteca para administrar sedes, libros, usuarios y préstamos, generando reportes mediante consultas con `JOIN` y `GROUP BY`.

## Modelo implementado

- `sedes`
- `libros`
- `usuarios`
- `prestamos`

## Relaciones

- Una sede almacena varios libros.
- Un libro puede registrarse en múltiples préstamos.
- Un usuario puede realizar varios préstamos.

## Estructura

```text
resoluciones/
└── joseluis-herrera/
    └── ejercicio-25/
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