# Evidencias - Solicitudes SQL - Ejercicio 022 (Liga MOBA)

## Comandos ejecutados

```bash
sqlite3 ejercicio-022.db < ddl/schema.sql
sqlite3 ejercicio-022.db < dml/inserts.sql
sqlite3 ejercicio-022.db < dml/operaciones.sql
sqlite3 ejercicio-022.db < dql/consultas.sql
```

## Resultados

**1. Todos los registros de partidas, con JOIN a jugadores (ya sin la duplicada y con la revision resuelta):**

```text
id_registro | nickname     | heroe_usado | fecha_partida       | resultado | premio_ganado | estado
1           | ShadowKing     | Zeratul      | 2026-08-01 18:00     | victoria   | 500.0          | confirmado
2           | NightBlade     | Thrall       | 2026-08-01 18:00     | derrota    | 0.0            | confirmado
3           | IronFist       | Muradin      | 2026-08-02 19:00     | victoria   | 300.0          | confirmado
4           | StormRider     | Valla        | 2026-08-02 19:00     | derrota    | 0.0            | confirmado
5           | ShadowKing     | Kael Thas    | 2026-08-03 20:00     | victoria   | 500.0          | confirmado
6           | FrostQueen     | Lucio        | 2026-08-03 20:00     | derrota    | 0.0            | confirmado
7           | VoidWalker     | Li Ming      | 2026-08-04 18:30     | victoria   | 400.0          | confirmado
8           | StormRider     | Valla        | 2026-08-04 18:30     | derrota    | 0.0            | confirmado
```

Quedan 8 registros (empezaron 9, se elimino la duplicada del `id_registro = 9`).

**2. Registros que no estan confirmados todavia:**

```text
(sin filas)
```

El registro de IronFist (id_registro = 3) ya no aparece aqui porque `operaciones.sql` lo confirmo tras la revision.

**3. Jugador con mas actividad:**

```text
nickname     | rol      | partidas_jugadas
ShadowKing     | medio     | 2
StormRider     | tirador   | 2
IronFist       | jungla    | 1
NightBlade     | jungla    | 1
FrostQueen     | soporte   | 1
VoidWalker     | medio     | 1
```

**4. Registros ordenados por fecha de partida:** ver tabla completa arriba, de 2026-08-01 a 2026-08-04.

**5. Dinero en premios generado por equipo (JOIN de las tres tablas):**

```text
nombre_equipo     | region   | premios_totales
Titanes Latam        | LATAM     | 1300.0
Furia Norte           | NA        | 400.0
Dragones EU            | EU        | 0.0
Samurai Gaming         | ASIA      | 0.0
```

Titanes Latam es el equipo con mas ganancias en premios, buen candidato para atraer patrocinios.

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO partidas_jugadas (id_jugador, heroe_usado, resultado, premio_ganado) VALUES (3, 'Sylvanas', 'victoria', -100);` → `CHECK constraint failed: premio_ganado >= 0`.

## Operaciones de mantenimiento verificadas

- `UPDATE partidas_jugadas SET estado = 'confirmado' WHERE id_registro = 3 AND estado = 'en_revision';` → el registro de IronFist paso de `en_revision` a `confirmado`.
- `UPDATE jugadores SET rol = 'jungla' WHERE id_jugador = 2;` → IronFist cambio de rol `top` a `jungla`.
- `DELETE FROM partidas_jugadas WHERE id_registro = 9;` → el registro duplicado desaparecio; el conteo final es 8, no 9.

## Aprendizaje

La cadena `equipos -> jugadores -> partidas_jugadas` es una relacion en dos niveles: para saber cuanto premio genero un equipo, no basta con un solo `JOIN`, hay que encadenar dos (`equipos` con `jugadores`, y ese resultado con `partidas_jugadas`). Esto demuestra que un `GROUP BY` con `SUM` puede agregar datos de una tabla que esta "dos saltos" de distancia del catalogo principal, siempre que las llaves foraneas conecten correctamente la cadena completa.
