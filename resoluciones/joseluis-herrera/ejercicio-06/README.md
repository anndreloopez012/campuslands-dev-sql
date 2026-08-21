### README.md

# Ejercicio 06: Torneo Esports

## Información

- Nombre: Jose Luis Herrera
- Fecha: 2026-08-20
- Motor: SQLite
- Ejercicio: 06
- Rama: `alumno/joseluis-herrera/ejercicio-06`

## Descripción

La organización necesita reemplazar el registro manual de equipos, jugadores, partidas y resultados por una base de datos relacional que permita controlar los enfrentamientos de un torneo esports, almacenar marcadores y generar reportes sobre el rendimiento de los equipos.

## Modelo implementado

La solución utiliza cuatro tablas:

- `equipos`: almacena los equipos participantes.
- `jugadores`: registra los jugadores y el equipo al que pertenecen.
- `partidas`: registra los enfrentamientos entre dos equipos.
- `resultados`: almacena los marcadores y el ganador de cada partida.

## Relaciones

```text
EQUIPOS 1 ───────── N JUGADORES
EQUIPOS 1 ───────── N PARTIDAS
PARTIDAS 1 ──────── 1 RESULTADOS
```
## Datos

```text
Equipos: 5 registros base
Jugadores: 5 registros base
Partidas: 10 registros base
Resultados: 10 registros base
```

Los datos incluyen partidas de cuartos de final, semifinal, final y tercer puesto, con diferentes marcadores para permitir análisis de rendimiento.


## Consultas

El archivo `dql/consultas.sql` contiene las doce consultas requeridas:

```text
1. Listado completo de partidas.
2. Seleccion de dos columnas de partidas.
3. Filtro de partidas por fecha.
4. Ordenamiento por fecha.
5. Top 5 partidas segun diferencia de marcador.
6. Conteo total de partidas.
7. Promedio, minimo y maximo de puntos.
8. Agrupacion de partidas por ronda.
9. JOIN entre partidas y equipos.
10. WHERE + ORDER BY + LIMIT.
11. Reporte de partidas con alias legibles.
12. Consulta de decision sobre rendimiento de los equipos.
```

## Decisiones de diseño

La tabla `partidas` funciona como entidad transaccional central porque registra cada enfrentamiento del torneo y relaciona dos equipos.

La tabla `resultados` mantiene separados los datos del marcador respecto a la información general de la partida.

La tabla `jugadores` permite asociar cada participante con un equipo sin duplicar la información del equipo.