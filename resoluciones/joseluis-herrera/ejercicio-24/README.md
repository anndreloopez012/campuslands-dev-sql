# Ejercicio 24: Recursos Humanos

## Información

- Nombre completo: Jose Luis Tot Herrera
- Fecha: 2026-08-20

## Descripción

Sistema de talento humano para administrar departamentos, cargos, empleados y contratos laborales, permitiendo generar reportes básicos de nómina.

## Modelo implementado

- `departamentos`
- `cargos`
- `empleados`
- `contratos`

## Relaciones

- Un departamento tiene varios empleados.
- Un cargo puede ser ocupado por varios empleados.
- Un empleado puede tener varios contratos.

## Estructura

```text
resoluciones/
└── joseluis-herrera/
    └── ejercicio-24/
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