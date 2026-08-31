# Ejercicio 88: ORDER BY Nivel Aplicado

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Tema central

ORDER BY

## Descripcion del problema

Un torneo de videojuegos necesita su tabla de posiciones oficial:
cada equipo ordenado por puntos, con la diferencia de goles como
desempate y el nombre del equipo como ultimo criterio, calculado
directamente desde el historial de partidas jugadas. Es el caso de
negocio con reporte final propio del nivel aplicado.

## Tablas y relaciones

- `equipos`: catalogo de equipos participantes.
- `jugadores`: catalogo de jugadores, cada uno de un equipo.
- `partidas`: tabla principal, cada enfrentamiento entre dos equipos.
  `equipos` 1—N `jugadores`; `equipos` 1—N `partidas` (dos veces:
  como local y como visitante).

## Uso de ORDER BY

La consulta 5 en `dql/consultas.sql` es la tabla de posiciones:

1. Tres subconsultas correlacionadas calculan, por cada equipo,
   `puntos` (3 por victoria, 1 por empate, 0 por derrota),
   `goles_favor` y `goles_contra`, contando solo partidas `'jugada'`.
2. El `ORDER BY` final usa multiples criterios de desempate, igual
   que una tabla de posiciones real: `puntos DESC`, despues
   `(goles_favor - goles_contra) DESC` (una expresion que combina dos
   alias definidos en el propio `SELECT`), y por ultimo
   `nombre_equipo ASC`.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `jugadores.id_equipo`, `partidas.id_equipo_local`,
  `partidas.id_equipo_visitante`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `equipos.nombre_equipo`.
- `CHECK`: `partidas.estado IN (...)`, `puntaje_local >= 0`,
  `puntaje_visitante >= 0`.
- `DEFAULT` en `partidas.puntaje_local`, `puntaje_visitante` y
  `estado`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dql/consultas.sql`)

Repetir la consulta 1 pero con `ORDER BY 9` falla porque esa consulta
solo tiene 6 columnas, no 9. Se valido con Python (`sqlite3`): lanza
`1st ORDER BY term out of range - should be between 1 and 6`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Tabla de posiciones final: Dragones del Norte (7 pts), Halcones del
  Centro (4 pts), Tigres del Oeste (2 pts), Lobos del Sur (0 pts),
  verificada a mano contra los resultados de las 5 partidas jugadas.

## Como ejecutar

```bash
sqlite3 ejercicio-88.db < ddl/schema.sql
sqlite3 ejercicio-88.db < dml/inserts.sql
sqlite3 ejercicio-88.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
