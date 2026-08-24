# Ejercicio 15: Taller de Motos

## Información

- Nombre completo: Jose Luis Tot Herrera
- Ejercicio: 15
- Fecha: 2026-08-20
- Motor de base de datos: SQLite
- Contexto: Taller mecanico de motocicletas

## Descripción

La base de datos permite administrar clientes, motocicletas, servicios disponibles y ordenes de servicio realizadas en un taller mecanico.

El modelo reemplaza el registro manual de informacion y permite consultar servicios realizados, costos, kilometraje, clientes y rendimiento de los servicios.

## Modelo implementado

La solución utiliza cuatro tablas:

- `clientes`: almacena la información de los clientes.
- `motos`: registra las motocicletas y su propietario.
- `servicios`: contiene el catalogo de servicios ofrecidos por el taller.
- `ordenes_servicio`: registra los servicios realizados a cada motocicleta.

## Relaciones

- Un cliente puede tener varias motos.
- Cada moto pertenece a un cliente.
- Una moto puede tener varias ordenes de servicio.
- Cada orden corresponde a una moto.
- Un servicio puede aparecer en varias ordenes.
- Cada orden utiliza un servicio del catalogo.

## Datos

Se registran:

- 5 clientes.
- 5 motos.
- 5 servicios.
- 10 ordenes de servicio.

Los datos permiten realizar consultas de filtrado, ordenamiento, agregación, agrupación y relaciones entre las tablas.

## Consultas

`dql/consultas.sql` contiene consultas para:

1. Listar todas las ordenes de servicio.
2. Mostrar columnas específicas de las ordenes.
3. Filtrar ordenes por kilometraje.
4. Ordenar ordenes por fecha.
5. Obtener los cinco servicios de mayor costo.
6. Contar el total de ordenes.
7. Calcular costo promedio, mínimo y máximo.
8. Agrupar ordenes por estado.
9. Relacionar clientes, motos, servicios y ordenes.
10. Obtener las cinco ordenes finalizadas de mayor costo.
11. Generar un reporte de ingresos por tipo de servicio.
12. Identificar motos que requieren mantenimiento prioritario.

## Estructura

```text
resoluciones/
└── joseluis-herrera/
    └── ejercicio-015/
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