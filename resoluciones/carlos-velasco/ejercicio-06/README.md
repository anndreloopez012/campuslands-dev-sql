# Ejercicio 06: Torneo Esports

## Información

**Nombre:** Carlos Elias Tzoy Velasco  
**Fecha:** 2026-08-20  
**Tecnología:** SQLite  
**Ejercicio:** 06 - Torneo Esports

## Descripción del problema

El torneo Esports necesita reemplazar el registro manual de equipos, jugadores, partidas y marcadores por una base de datos relacional.

La solución permite administrar los equipos participantes, sus jugadores, las partidas disputadas y los resultados obtenidos.

El modelo también permite generar indicadores sobre victorias, rendimiento y duración de las partidas.

## Modelo implementado

La solución utiliza cuatro tablas:

### `equipos`

Representa los equipos participantes en el torneo.

Contiene:

- Nombre.
- Región.
- Fecha de fundación.

### `jugadores`

Registra los jugadores pertenecientes a cada equipo.

Contiene:

- Nickname.
- Nombre completo.
- Rol.
- Equipo.

### `partidas`

Registra los enfrentamientos entre equipos.

Contiene:

- Equipo local.
- Equipo visitante.
- Fecha y hora.
- Fase del torneo.

### `resultados`

Registra el resultado de cada partida.

Contiene:

- Partida.
- Equipo ganador.
- Puntos del equipo local.
- Puntos del equipo visitante.
- Duración.

## Relaciones

```text
equipos 1 ─────── N jugadores

equipos 1 ─────── N partidas
                  ├── equipo local
                  └── equipo visitante

partidas 1 ────── 1 resultados

equipos 1 ─────── N resultados
                  └── equipo ganador
```

El diseño utiliza la misma tabla `equipos` para representar los dos participantes de una partida mediante dos claves foráneas diferentes.

## Restricciones aplicadas

### PRIMARY KEY

Se utilizan:

- `equipos.id_equipo`
- `jugadores.id_jugador`
- `partidas.id_partida`
- `resultados.id_resultado`

### FOREIGN KEY

Se implementaron las relaciones:

```text
jugadores.id_equipo
    → equipos.id_equipo

partidas.id_equipo_local
    → equipos.id_equipo

partidas.id_equipo_visitante
    → equipos.id_equipo

resultados.id_partida
    → partidas.id_partida

resultados.ganador_id_equipo
    → equipos.id_equipo
```

Las claves foráneas están habilitadas mediante:

```sql
PRAGMA foreign_keys = ON;
```

### UNIQUE

Se aplicaron restricciones `UNIQUE` para:

- Nombre del equipo.
- Nickname del jugador.
- Relación entre resultado y partida.

### CHECK

Se aplicaron restricciones para:

- Validar roles de jugadores.
- Validar fases del torneo.
- Evitar que un equipo se enfrente contra sí mismo.
- Evitar puntos negativos.
- Evitar duraciones inválidas.
- Evitar resultados empatados.
- Validar fechas.

## Datos registrados

Los datos base contienen:

| Tabla | Registros |
| --- | ---: |
| equipos | 5 |
| jugadores | 10 |
| partidas | 10 |
| resultados | 10 |

Los datos permiten que todas las consultas solicitadas produzcan resultados.

## Operaciones DML

`dml/operaciones.sql` contiene:

- 2 `INSERT` adicionales.
- 2 `UPDATE` válidos.
- 2 `DELETE` controlados.
- 3 operaciones inválidas comentadas.

Las operaciones adicionales agregan temporalmente un equipo y un jugador. Posteriormente se actualizan y finalmente se eliminan mediante condiciones `WHERE`.

Las operaciones inválidas están comentadas para que el script pueda ejecutarse completamente.

## Operaciones inválidas documentadas

Se incluyen ejemplos de:

1. Violación de `CHECK` al intentar enfrentar un equipo contra sí mismo.
2. Violación de `UNIQUE` utilizando un nickname existente.
3. Violación de `FOREIGN KEY` utilizando un equipo inexistente.

## Consultas implementadas

El archivo `dql/consultas.sql` contiene las 12 consultas requeridas:

1. Listado de partidas.
2. Selección de dos columnas relevantes.
3. Filtrado por fecha.
4. Ordenamiento por fecha.
5. Top 5 equipos por victorias.
6. Conteo total de partidas.
7. Promedio, mínimo y máximo de duración.
8. Agrupación por fase.
9. JOIN entre partidas y equipos.
10. `WHERE + ORDER BY + LIMIT`.
11. Reporte completo con alias legibles.
12. Análisis de rendimiento para apoyar decisiones de patrocinio y estrategia competitiva.

## Ejecución

Desde la raíz de `ejercicio-06`:

```bash
sqlite3 ejercicio-06.db < ddl/schema.sql
sqlite3 ejercicio-06.db < dml/inserts.sql
sqlite3 ejercicio-06.db < dml/operaciones.sql
sqlite3 ejercicio-06.db < dql/consultas.sql
```

El archivo `ejercicio-06.db` es temporal y no debe subirse al repositorio.

## Validación de tablas

```bash
sqlite3 ejercicio-06.db ".tables"
```

Salida esperada:

```text
equipos  jugadores  partidas  resultados
```

## Validación de cantidades

```bash
sqlite3 ejercicio-06.db <<'SQL'
SELECT 'equipos' AS tabla, COUNT(*) AS registros FROM equipos
UNION ALL
SELECT 'jugadores', COUNT(*) FROM jugadores
UNION ALL
SELECT 'partidas', COUNT(*) FROM partidas
UNION ALL
SELECT 'resultados', COUNT(*) FROM resultados;
SQL
```

Salida esperada:

```text
equipos|5
jugadores|10
partidas|10
resultados|10
```

## Validación de claves foráneas

```bash
sqlite3 ejercicio-06.db "PRAGMA foreign_keys;"
```

Salida esperada:

```text
1
```

## Validación de marcadores

```sql
SELECT
    p.id_partida,
    local.nombre AS equipo_local,
    r.puntos_local,
    visitante.nombre AS equipo_visitante,
    r.puntos_visitante,
    ganador.nombre AS ganador
FROM partidas AS p
INNER JOIN resultados AS r
    ON p.id_partida = r.id_partida
INNER JOIN equipos AS local
    ON p.id_equipo_local = local.id_equipo
INNER JOIN equipos AS visitante
    ON p.id_equipo_visitante = visitante.id_equipo
INNER JOIN equipos AS ganador
    ON r.ganador_id_equipo = ganador.id_equipo
ORDER BY p.id_partida;
```

La consulta permite comprobar que cada partida tiene su marcador, participantes y equipo ganador correctamente relacionados.

## Resultado final

La solución implementa un modelo relacional de cuatro tablas para gestionar un torneo Esports.

El modelo permite conocer los participantes de cada partida, los jugadores de cada equipo, los marcadores obtenidos y el rendimiento competitivo de los equipos.

Las restricciones garantizan la integridad referencial, evitan duplicidades y controlan resultados inválidos. Las consultas permiten obtener estadísticas de victorias, duración, fases y rendimiento, además de generar información útil para decisiones de patrocinio y estrategia competitiva.