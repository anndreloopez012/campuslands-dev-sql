# Evidencias - Solicitudes SQL - Ejercicio 053 (Torneo Esports)

## Comandos ejecutados

```bash
sqlite3 ejercicio-053.db < ddl/schema.sql
sqlite3 ejercicio-053.db < dml/inserts.sql
sqlite3 ejercicio-053.db < dml/operaciones.sql
sqlite3 ejercicio-053.db < dql/consultas.sql
```

## Resultados

**1. Todas las partidas, con JOIN al equipo rival (ya sin la duplicada, sin la partida sin estadisticas, con la partida 7 jugada y el resultado de la partida 4 corregido):**

```text
id_partida | rival             | fecha_partida | resultado | estado
1           | Kraken Digital     | 2026-08-01      | victoria   | jugada
2           | Aurora Gaming      | 2026-08-03      | derrota    | jugada
3           | Jade Command       | 2026-08-05      | victoria   | jugada
4           | Kraken Digital     | 2026-08-07      | derrota    | jugada
5           | Titan Frontier     | 2026-08-09      | derrota    | jugada
6           | Nova Syndicate     | 2026-08-11      | victoria   | jugada
7           | Aurora Gaming      | 2026-08-13      | victoria   | jugada
9           | Kraken Digital     | 2026-08-17      | victoria   | programada
```

Quedan 8 partidas (empezaron 10: se elimino la duplicada `id_partida = 10` y la partida sin estadisticas `id_partida = 8`).

**2. Partidas que no estan jugadas todavia:**

```text
id_partida | id_equipo_rival | fecha_partida | estado
9           | 2                | 2026-08-17      | programada
```

**3. Jugador con mas partidas jugadas:**

```text
nombre_jugador | partidas_jugadas
ZeroPixel      | 4
LunaStrike     | 3
NyxRunner      | 3
EchoWave       | 2
KaijuByte      | 2
```

**4. Partidas ordenadas por fecha:** ver tabla completa arriba, de 2026-08-01 a 2026-08-17.

**5. Jugador con mejor promedio de puntos por partida, para decidir el MVP del equipo:**

```text
nombre_jugador | puntos_totales | partidas_jugadas | promedio_puntos
ZeroPixel      | 59              | 4                  | 14.75
EchoWave       | 28              | 2                  | 14.0
LunaStrike     | 41              | 3                  | 13.67
NyxRunner      | 37              | 3                  | 12.33
KaijuByte      | 13              | 2                  | 6.5
```

ZeroPixel es el candidato claro a MVP: lidera tanto en puntos totales como en promedio por partida.

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- Registro repetido: `INSERT INTO equipos (nombre_equipo, region) VALUES ('Kraken Digital', ...);` → `UNIQUE constraint failed: equipos.nombre_equipo`.
- Valor fuera de rango: `INSERT INTO estadisticas (..., puntos, ...) VALUES (..., -5, ...);` → `CHECK constraint failed: puntos >= 0`.

## Operaciones de mantenimiento verificadas

- `UPDATE partidas SET estado = 'jugada' WHERE id_partida = 7 AND estado = 'programada';` → la partida contra Aurora Gaming quedo jugada.
- `UPDATE partidas SET resultado = 'derrota' WHERE id_partida = 4;` → se corrigio el resultado de la partida contra Kraken Digital, sin borrar el registro ni las estadisticas asociadas.
- `DELETE FROM partidas WHERE id_partida = 8 AND estado = 'pospuesta' AND NOT EXISTS (...);` → **DELETE controlado**: elimino unicamente la partida 8 (pospuesta, sin ninguna estadistica). Una partida pospuesta con estadisticas reales no hubiera cumplido esta condicion.
- `DELETE FROM partidas WHERE id_partida = 10;` → la partida duplicada desaparecio. Conteo final verificado: 8 partidas (empezaron 10).

## Aprendizaje

Hacer `fecha_partida` y `resultado` `NOT NULL` resuelve directamente la queja del cliente sobre registros incompletos: ninguna partida puede existir sin esos datos, asi que ningun reporte (como el ranking de la consulta 5) puede quedar con huecos. El `DELETE` controlado con `NOT EXISTS` protege cualquier partida que ya haya generado informacion real, sin importar en que estado administrativo quede despues.
