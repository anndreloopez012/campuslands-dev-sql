# Evidencias - Ejercicio 72

## Tema

INSERT

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-72.db < ddl/schema.sql
sqlite3 ejercicio-72.db < dml/inserts.sql
sqlite3 ejercicio-72.db < dql/consultas.sql
```

## Resultados

Datos base tras `dml/inserts.sql`: 4 equipos, 5 jugadores, 4 partidas
(2 de la jornada 1, ya jugadas, y 2 de la jornada 2, generadas con
`INSERT ... SELECT`).

**Casos comentados verificados** (descomentados y ejecutados por
separado para confirmar que cada uno falla):

- `INSERT INTO equipos (nombre_equipo, ...) VALUES ('Dragones del Norte', ...);` → `UNIQUE constraint failed: equipos.nombre_equipo`.
- `INSERT INTO jugadores (nombre, id_equipo) VALUES ('Jugador Fantasma', 99);` → `FOREIGN KEY constraint failed`.
- `INSERT INTO partidas (..., estado) VALUES (..., 'suspendida');` → `CHECK constraint failed: estado IN ('programada', 'jugada', 'cancelada')`.

**1. Todas las partidas, con JOIN a equipo local y visitante:**

```text
id_partida | equipo_local           | equipo_visitante        | fecha_partida | puntaje_local | puntaje_visitante | estado
1           | Dragones del Norte       | Lobos del Sur             | 2026-08-01       | 3                 | 1                     | jugada
2           | Halcones del Centro      | Tigres del Oeste          | 2026-08-02       | 2                 | 2                     | jugada
3           | Lobos del Sur            | Dragones del Norte        | 2026-08-08       | 0                 | 0                     | programada
4           | Tigres del Oeste         | Halcones del Centro       | 2026-08-09       | 0                 | 0                     | programada
```

**2. Partidas ya jugadas:**

```text
id_partida | fecha_partida   | puntaje_local | puntaje_visitante
1           | 2026-08-01        | 3                 | 1
2           | 2026-08-02        | 2                 | 2
```

**3. Partidas ordenadas por fecha:** ver tabla completa arriba, de
2026-08-01 a 2026-08-09.

**4. Resumen: partidas por estado:**

```text
estado         total
jugada          2
programada      2
```

**5. Validacion especifica de INSERT (`INSERT ... SELECT`): por cada
partida jugada de la jornada 1 existe su partida de vuelta,
programada, con local y visitante invertidos:**

```text
id_ida | local_ida            | visitante_ida        | id_vuelta | local_vuelta          | visitante_vuelta      | fecha_vuelta   | estado_vuelta
1       | Dragones del Norte     | Lobos del Sur           | 3          | Lobos del Sur           | Dragones del Norte      | 2026-08-08        | programada
2       | Halcones del Centro    | Tigres del Oeste        | 4          | Tigres del Oeste        | Halcones del Centro     | 2026-08-09        | programada
```

## Aprendizaje

Ademas de `INSERT` de una fila y `INSERT` multiple con
`VALUES (...), (...)` (visto en el nivel basico), este ejercicio
demostro `INSERT ... SELECT`: en vez de escribir a mano la jornada de
vuelta, se genero automaticamente a partir de la jornada 1 ya jugada,
invirtiendo local y visitante y sumando una semana a la fecha con
`date(fecha_partida, '+7 days')`. Las columnas que no se listaron en
el `INSERT` (`puntaje_local`, `puntaje_visitante`, `estado`) quedaron
en su `DEFAULT`, exactamente igual que si se hubieran insertado a
mano: `INSERT ... SELECT` respeta las mismas restricciones y valores
por defecto que cualquier otro `INSERT`.
