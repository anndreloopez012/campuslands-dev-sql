### README.md

# Ejercicio 10: Hotel Reservas

## Información

- Nombre: Jose Luis Herrera
- Fecha: 2026-08-20
- Motor: SQLite
- Ejercicio: 10
- Rama: `alumno/joseluis-herrera/ejercicio-10`

## Descripción

La organización necesita reemplazar el registro manual de huéspedes, habitaciones, reservas y pagos por una base de datos relacional que permita controlar las reservas, conocer la ocupación y generar reportes sobre los ingresos y disponibilidad del hotel.

## Modelo implementado

La solución utiliza cuatro tablas:

- `huespedes`: almacena los datos de los huéspedes.
- `habitaciones`: registra las habitaciones, su capacidad, tipo, precio y estado.
- `reservas`: registra las reservas realizadas por los huéspedes.
- `pagos`: almacena los pagos asociados a cada reserva.

## Relaciones

```text
HUESPEDES    1 ───────── N RESERVAS
HABITACIONES 1 ───────── N RESERVAS
RESERVAS     1 ───────── N PAGOS
```

La tabla `reservas` funciona como entidad transaccional central porque relaciona huéspedes y habitaciones y controla el periodo de ocupación.

La tabla `pagos` mantiene separadas las operaciones financieras asociadas a cada reserva.


## Datos

```text
Huéspedes: 5 registros base
Habitaciones: 5 registros base
Reservas: 10 registros base
Pagos: 10 registros base
```


## Consultas

El archivo `dql/consultas.sql` contiene las doce consultas requeridas:

```text
1. Listado completo de reservas.
2. Selección de dos columnas relevantes.
3. Filtrado de reservas por fecha.
4. Ordenamiento cronológico.
5. Top 5 habitaciones según cantidad de reservas.
6. Conteo total de reservas.
7. Promedio, mínimo y máximo de pagos.
8. Agrupación de reservas por estado.
9. JOIN entre reservas, huéspedes y habitaciones.
10. WHERE + ORDER BY + LIMIT.
11. Reporte completo de reservas con alias.
12. Consulta de decisión sobre demanda de habitaciones.
```

## Decisiones de diseño

La tabla `reservas` representa la operación central del hotel porque relaciona a cada huésped con una habitación durante un periodo determinado.

La tabla `pagos` se mantiene independiente porque una reserva puede registrar múltiples pagos.

Las restricciones de capacidad, precios, fechas, estados y montos ayudan a mantener la integridad de la información.