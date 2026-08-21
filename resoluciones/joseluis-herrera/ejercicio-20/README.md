# Ejercicio 20: Eventos Boletos

## Información

- Nombre completo: Jose Luis Tot Herrera
- Ejercicio: 20
- Fecha: 2026-08-20
- Motor de base de datos: SQLite
- Contexto: Venta y control de boletos para eventos

## Descripción

La base de datos permite administrar lugares, eventos, asistentes y boletos vendidos para una plataforma de eventos.

El modelo permite relacionar cada evento con su lugar, registrar los asistentes y controlar los boletos adquiridos, incluyendo su precio, fecha de compra y estado.

## Modelo implementado

La solución utiliza cuatro tablas:

- `lugares`: almacena los espacios donde se realizan los eventos.
- `eventos`: almacena la información de cada evento y su lugar.
- `asistentes`: almacena la información de las personas que compran boletos.
- `boletos`: registra las compras de boletos y relaciona eventos con asistentes.

## Relaciones

- Un lugar puede contener múltiples eventos.
- Un evento pertenece a un lugar.
- Un evento puede tener múltiples boletos.
- Un boleto pertenece a un evento.
- Un asistente puede comprar múltiples boletos.
- Un boleto pertenece a un asistente.

La tabla `boletos` funciona como entidad transaccional y relaciona los eventos con los asistentes.

## Datos

Se registran:

- 5 lugares.
- 5 eventos.
- 5 asistentes.
- 10 boletos.

Los datos permiten realizar consultas sobre ventas, ingresos, ocupación, eventos y estados de los boletos.

## Consultas

`dql/consultas.sql` contiene consultas para:

1. Listar todos los boletos.
2. Mostrar dos columnas relevantes de los boletos.
3. Filtrar boletos por precio.
4. Ordenar boletos por fecha.
5. Obtener los cinco boletos de mayor valor.
6. Contar boletos vendidos.
7. Calcular precio promedio, mínimo y máximo.
8. Agrupar boletos por evento.
9. Relacionar boletos, eventos y asistentes mediante `JOIN`.
10. Obtener los cinco boletos activos de mayor valor mediante `WHERE`, `ORDER BY` y `LIMIT`.
11. Generar un reporte de eventos y lugares.
12. Analizar ingresos generados por evento.
13. Calcular el porcentaje de ocupación de los lugares.
14. Generar una recomendación comercial según la cantidad de boletos vendidos.

## Estructura

```text
resoluciones/
└── joseluis-herrera/
    └── ejercicio-20/
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