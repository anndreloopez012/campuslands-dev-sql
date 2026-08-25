# Ejercicio 36: Normalización Hotel Reservas

## Información

- Ejercicio: 36
- Tema: Normalización de datos
- Nivel: Intermedio
- Estudiante: Jose Luis Herrera

## Descripción

El ejercicio parte de un archivo plano para administrar huéspedes, habitaciones, servicios, costos y fechas de reservas.

La estructura original contiene grupos repetidos y múltiples valores dentro de una misma celda.

La solución transforma el diseño hasta tercera forma normal (3FN).

## Modelo implementado

Las relaciones principales son:

```text
HUESPEDES
    |
RESERVAS
    |
HABITACIONES

RESERVAS
    |
DETALLE_SERVICIO
    |
SERVICIOS
```

## Consultas

El archivo `dql/consultas.sql` contiene consultas para:

1. Reconstruir una vista similar al archivo original mediante `JOIN`.
2. Listar huéspedes, habitaciones y servicios sin duplicados.
3. Contar reservas por estado.
4. Contar habitaciones por tipo.
5. Calcular el total de alojamiento por reserva.
6. Calcular el total de servicios por reserva.
7. Calcular el total general de cada reserva.
8. Obtener promedios, mínimos y máximos.
9. Buscar huéspedes y servicios mediante `LIKE`.
10. Filtrar reservas por fecha.
11. Filtrar habitaciones por rango de precio.
12. Obtener el top 5 de servicios por cantidad.
13. Detectar reservas sin servicios.
14. Detectar habitaciones sin reservas.
15. Generar un reporte final con alias legibles.

## Resultado esperado

La información queda separada en entidades independientes y relacionadas mediante claves primarias y foráneas.

El modelo permite administrar huéspedes, habitaciones, reservas y servicios sin almacenar múltiples valores dentro de una misma celda.