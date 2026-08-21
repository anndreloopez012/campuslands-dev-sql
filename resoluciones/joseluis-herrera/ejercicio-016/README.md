# Ejercicio 16: Aerolinea Vuelos

## Información

- Nombre completo: Jose Luis Tot Herrera
- Ejercicio: 16
- Fecha: 2026-08-20
- Motor de base de datos: SQLite
- Contexto: Aerolinea y gestion de vuelos y reservas

## Descripción

La base de datos permite administrar aeropuertos, aviones, vuelos y reservas de pasajeros para una aerolinea.

El modelo permite controlar la programacion de vuelos, los aeropuertos de origen y destino, los aviones utilizados y las reservas realizadas por los pasajeros.

## Modelo implementado

La solución utiliza cuatro tablas:

- `aeropuertos`: almacena los aeropuertos disponibles.
- `aviones`: registra los aviones de la aerolinea.
- `vuelos`: representa los vuelos programados y relaciona aviones con aeropuertos.
- `reservas`: registra las reservas realizadas por pasajeros para cada vuelo.

## Relaciones

- Un aeropuerto puede ser origen de varios vuelos.
- Un aeropuerto puede ser destino de varios vuelos.
- Un avión puede operar varios vuelos.
- Un vuelo utiliza un avión.
- Un vuelo puede tener varias reservas.
- Cada reserva pertenece a un vuelo.

La tabla `vuelos` utiliza dos claves foráneas hacia `aeropuertos`, una para el aeropuerto de origen y otra para el aeropuerto de destino.

## Datos

Se registran:

- 5 aeropuertos.
- 5 aviones.
- 10 vuelos.
- 10 reservas.

Los datos permiten realizar consultas de vuelos, precios, reservas, ocupación, conexiones aeroportuarias e ingresos estimados.

## Consultas

`dql/consultas.sql` contiene consultas para:

1. Listar todos los vuelos.
2. Mostrar código y precio de los vuelos.
3. Filtrar vuelos por precio.
4. Ordenar vuelos por fecha de salida.
5. Obtener los cinco vuelos de mayor precio.
6. Contar vuelos totales.
7. Calcular precio promedio, mínimo y máximo.
8. Agrupar vuelos por estado.
9. Relacionar vuelos con aeropuertos mediante `JOIN`.
10. Obtener los vuelos programados con mayor cantidad de reservas.
11. Generar un reporte de conexiones por aeropuerto.
12. Generar un reporte de ingresos estimados por vuelo.
13. Clasificar la ocupación de los vuelos para apoyar decisiones comerciales.

## Estructura

```text
resoluciones/
└── joseluis-herrera/
    └── ejercicio-016/
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