# Evidencias - Solicitudes SQL - Ejercicio 023 (Clanes Shooter)

## Comandos ejecutados

```bash
sqlite3 ejercicio-023.db < ddl/schema.sql
sqlite3 ejercicio-023.db < dml/inserts.sql
sqlite3 ejercicio-023.db < dml/operaciones.sql
sqlite3 ejercicio-023.db < dql/consultas.sql
```

## Resultados

**1. Todos los scrims, con JOIN doble a clanes (local y rival), ya sin la duplicada y con la disputa resuelta:**

```text
id_scrim | clan_local          | clan_rival          | mapa      | marcador_local | marcador_rival | estado
1        | Lobos Nocturnos       | Fenix Squad           | bunker     | 13              | 9               | jugado
2        | Serpientes Negras     | Aguilas de Fuego      | puerto     | 10              | 13              | jugado
3        | Lobos Nocturnos       | Titanes del Norte     | ciudad     | 13              | 11              | jugado
4        | Fenix Squad            | Serpientes Negras     | desierto   | 13              | 7               | jugado
5        | Aguilas de Fuego       | Lobos Nocturnos       | bunker     | 8               | 13              | jugado
6        | Titanes del Norte      | Fenix Squad           | puerto     | 14              | 12              | jugado
7        | Serpientes Negras      | Lobos Nocturnos       | ciudad     | 6               | 13              | jugado
8        | Aguilas de Fuego       | Titanes del Norte     | desierto   | 13              | 10              | jugado
```

Quedan 8 scrims (empezaron 9, se elimino la duplicada del `id_scrim = 9`).

**2. Scrims que no estan confirmados todavia:**

```text
(sin filas)
```

El scrim en disputa (id_scrim = 3) ya no aparece aqui porque `operaciones.sql` lo confirmo tras la revision del replay.

**3. Jugadores por clan (referencia de plantilla):**

```text
nombre_clan          | total_jugadores
Lobos Nocturnos         | 2
Fenix Squad              | 1
Serpientes Negras        | 1
Aguilas de Fuego         | 1
Titanes del Norte        | 1
```

**4. Scrims ordenados por fecha:** ver tabla completa arriba, de 2026-08-01 a 2026-08-08.

**5. Ranking de victorias por clan (contando cuando gano como local o como rival):**

```text
nombre_clan          | victorias
Lobos Nocturnos         | 4
Aguilas de Fuego         | 2
Fenix Squad              | 1
Titanes del Norte        | 1
```

Lobos Nocturnos lidera claramente con 4 victorias de 4 scrims jugados (perfecto record); Serpientes Negras no aparece porque no gano ningun scrim.

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO scrims (id_clan_local, id_clan_rival, ...) VALUES (1, 1, ...);` → `CHECK constraint failed: id_clan_local <> id_clan_rival`.

## Operaciones de mantenimiento verificadas

- `UPDATE scrims SET estado = 'jugado' WHERE id_scrim = 3 AND estado = 'disputado';` → el scrim en disputa se confirmo tras revision del replay.
- `UPDATE jugadores SET rol = 'entry' WHERE id_jugador = 2;` → SilentBlade cambio de rol `sniper` a `entry`.
- `DELETE FROM scrims WHERE id_scrim = 9;` → el scrim duplicado desaparecio; el conteo final es 8, no 9.

## Aprendizaje

La peticion del cliente ("evitar registros incompletos porque no puede hacer reportes confiables") se resuelve con `NOT NULL` en `marcador_local` y `marcador_rival`: el ranking de victorias (consulta 5) depende de comparar esos dos numeros, y si alguno pudiera faltar, la comparacion daria un resultado impredecible sin que nadie lo note. Ademas, este ejercicio mostro que una sola tabla (`scrims`) puede tener dos llaves foraneas distintas hacia el mismo catalogo (`clanes`), una para el clan local y otra para el rival — y que calcular "victorias" en ese escenario requiere combinar ambos lados con `UNION ALL` antes de agrupar, porque ganar puede pasar en cualquiera de los dos roles.
