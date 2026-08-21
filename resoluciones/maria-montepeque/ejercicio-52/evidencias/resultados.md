# Evidencias - Ejercicio 52

## Tema

UNIQUE

## Comandos ejecutados

```bash
sqlite3 ejercicio-52.db < ddl/schema.sql
sqlite3 ejercicio-52.db < dml/inserts.sql
sqlite3 ejercicio-52.db < dql/consultas.sql
```

## Resultados

**5.a Nicknames normalizados (mismo numero = sin casi-duplicados por mayus/minus):**

```text
total_jugadores | nicknames_normalizados_distintos
6                | 6
```

**5.b Enfrentamientos repetidos en la misma fecha — 0 filas:**

```text
equipo_local | equipo_visitante | fecha_partida | veces
(sin resultados)
```

**Reporte final: tabla de posiciones del torneo:**

```text
equipo             | victorias | empates | derrotas
Dragones Rojos      | 3         | 0       | 0
Lobos Nocturnos     | 1         | 0       | 1
Tigres Blancos      | 0         | 2       | 0
Halcones Negros     | 0         | 1       | 1
Fenix Gaming        | 0         | 1       | 2
```

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- `INSERT INTO jugadores (..., nickname) VALUES (..., 'reddragon');` (choca con "RedDragon" al normalizar a minusculas) → `UNIQUE constraint failed: index 'idx_jugadores_nickname_lower'`.
- `INSERT INTO partidas (equipo_local, equipo_visitante, fecha_partida, ...) VALUES (1, 2, '2026-07-01', ...);` (enfrentamiento ya registrado) → `UNIQUE constraint failed: partidas.equipo_local, partidas.equipo_visitante, partidas.fecha_partida`.

## Aprendizaje

Este ejercicio cierra la serie de UNIQUE mostrando que la restriccion no esta limitada a "esta columna, tal cual se escribio". Un indice unico por expresion (`CREATE UNIQUE INDEX ... ON tabla (expresion)`) permite definir la unicidad segun una version normalizada del dato — en este caso, ignorando mayusculas y minusculas — algo que ni un `UNIQUE` de columna simple ni uno compuesto pueden hacer por si solos. Combinado con el `UNIQUE` compuesto de `partidas`, el modelo cubre tres formas distintas de evitar duplicados: por columna, por combinacion de columnas, y por expresion.
