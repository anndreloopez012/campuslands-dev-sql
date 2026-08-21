# Evidencias - Ejercicio 54

## Tema

NOT NULL

## Comandos ejecutados

```bash
sqlite3 ejercicio-54.db < ddl/schema.sql
sqlite3 ejercicio-54.db < dml/inserts.sql
sqlite3 ejercicio-54.db < dql/consultas.sql
```

## Resultados

**5.a Campo obligatorio (fecha_partida): ningun partido queda sin fecha:**

```text
total_partidas | partidas_con_fecha
7               | 7
```

**5.b Campo opcional (puntaje_local): es normal que falten valores mientras el partido no se ha jugado:**

```text
total_partidas | partidas_con_puntaje | partidas_sin_puntaje
7               | 3                     | 4
```

**4. Resumen: jugadores registrados por equipo (LEFT JOIN, incluye equipos sin jugadores):**

```text
nombre_equipo    | total_jugadores
Aguilas Negras    | 1
Dragones Rojos    | 2
Fenix Gaming      | 2
Halcones del Sur  | 0
Lobos del Norte   | 2
Titanes FC        | 1
```

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- `INSERT INTO equipos (nombre_equipo, pais) VALUES (NULL, 'Bolivia');` → `NOT NULL constraint failed: equipos.nombre_equipo`.
- `INSERT INTO partidas (id_equipo_local, id_equipo_visitante, fecha_partida) VALUES (1, 2, NULL);` → `NOT NULL constraint failed: partidas.fecha_partida`.

## Aprendizaje

En un modelo con varias tablas relacionadas, `NOT NULL` no se decide tabla por tabla sino columna por columna, incluso entre tablas ligadas por llave foranea. `equipos.nombre_equipo`, `jugadores.nombre`, `jugadores.id_equipo` (la relacion misma) y `partidas.fecha_partida` son obligatorios porque sin ellos el registro no tiene sentido de negocio: un jugador sin equipo o una partida sin fecha no se pueden operar. En cambio `equipos.logo_url`, `jugadores.apodo` y `partidas.puntaje_local/puntaje_visitante` se dejan sin `NOT NULL` a proposito, porque son datos que legitimamente no existen todavia (el logo puede subirse despues, el apodo puede no usarse, el puntaje solo existe cuando la partida ya se jugo). Comparar `COUNT(*)` contra `COUNT(columna)` lo confirma con datos reales: en `fecha_partida` ambos numeros coinciden (7 y 7), mientras que en `puntaje_local` no coinciden (7 y 3) porque todavia hay partidas `programada` o `cancelada` sin resultado.
