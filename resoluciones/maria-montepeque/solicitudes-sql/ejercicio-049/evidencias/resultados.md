# Evidencias - Solicitudes SQL - Ejercicio 049 (Liga Videojuego Futbol)

## Comandos ejecutados

```bash
sqlite3 ejercicio-049.db < ddl/schema.sql
sqlite3 ejercicio-049.db < dml/inserts.sql
sqlite3 ejercicio-049.db < dml/operaciones.sql
sqlite3 ejercicio-049.db < dql/consultas.sql
```

## Resultados

**1. Todos los partidos, con JOIN a usuarios, jornadas y ambos clubes (ya sin el duplicado, sin el partido anulado sin marcador, con el partido 7 jugado y el marcador del partido 8 corregido):**

```text
id_partido | nombre_usuario   | numero_jornada | club_usuario      | club_rival        | fecha_partido | goles_usuario | goles_rival | estado
1           | Player_Rayo      | 1               | Real Boreal FC     | Manchester Azul     | 2026-08-01      | 3              | 1            | jugado
2           | Player_Nova      | 1               | Juvenil Milan      | Bavaria United      | 2026-08-01      | 2              | 2            | jugado
3           | Player_Kael      | 1               | Atletico Sur       | London Rovers       | 2026-08-02      | 0              | 4            | jugado
4           | Player_Rayo      | 2               | Real Boreal FC     | Juvenil Milan       | 2026-08-08      | 5              | 0            | jugado
5           | Player_Xiomara   | 2               | Manchester Azul    | Bavaria United      | 2026-08-08      | 1              | 1            | jugado
6           | Player_Nova      | 2               | Juvenil Milan      | Atletico Sur        | 2026-08-09      | 3              | 2            | jugado
7           | Player_Bruno     | 3               | London Rovers      | Real Boreal FC      | 2026-08-15      | 2              | 2            | jugado
8           | Player_Rayo      | 3               | Real Boreal FC     | Bavaria United      | 2026-08-16      | 5              | 3            | jugado
10          | Player_Rayo      | 4               | Real Boreal FC     | Atletico Sur        | 2026-08-22      | 6              | 2            | jugado
11          | Player_Nova      | 4               | Juvenil Milan      | London Rovers       | 2026-08-23      | 1              | 1            | en_revision
```

Quedan 10 partidos (empezaron 12: se elimino el duplicado `id_partido = 12` y el partido sin marcador real `id_partido = 9`).

**2. Partidos que no estan jugados todavia:**

```text
id_partido | id_usuario | fecha_partido | estado
11          | 2          | 2026-08-23      | en_revision
```

**3. Usuario con mas partidos jugados:**

```text
nombre_usuario   | total_partidos
Player_Rayo      | 4
Player_Nova      | 3
Player_Bruno     | 1
Player_Kael      | 1
Player_Xiomara   | 1
```

**4. Partidos ordenados por fecha:** ver tabla completa arriba, de 2026-08-01 a 2026-08-23.

**5. Usuario con mas goles anotados (solo partidos jugados), para decidir a quien destacar como jugador del mes:**

```text
nombre_usuario   | goles_totales
Player_Rayo      | 19
Player_Nova      | 5
Player_Bruno     | 2
Player_Xiomara   | 1
Player_Kael      | 0
```

Player_Rayo es el candidato claro a jugador del mes: casi cuadruplica al segundo lugar.

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- Registro repetido: `INSERT INTO jornadas (numero_jornada, ...) VALUES (2, ...);` → `UNIQUE constraint failed: jornadas.numero_jornada`.
- Valor fuera de rango: `INSERT INTO partidos (..., goles_usuario, ...) VALUES (..., -1, ...);` → `CHECK constraint failed: goles_usuario >= 0`.

## Operaciones de mantenimiento verificadas

- `UPDATE partidos SET estado = 'jugado', fecha_ultimo_cambio = '2026-08-17' WHERE id_partido = 7 AND estado = 'en_revision';` → el partido de Player_Bruno se confirmo legitimo y quedo `jugado`.
- `UPDATE partidos SET goles_usuario = 5, fecha_ultimo_cambio = '2026-08-18' WHERE id_partido = 8;` → el marcador del partido de Player_Rayo se corrigio de 4 a 5 goles tras revisar el replay.
- `DELETE FROM partidos WHERE id_partido = 9 AND estado = 'anulado' AND goles_usuario = 0 AND goles_rival = 0;` → **DELETE controlado**: elimino unicamente el partido 9 (anulado, 0-0, nunca hubo marcador real). El partido 11, que sigue `en_revision` (no anulado), no se toco.
- `DELETE FROM partidos WHERE id_partido = 12;` → el partido duplicado desaparecio. Conteo final verificado: 10 partidos (empezaron 12).

## Aprendizaje

Cada correccion de estado (partido 7) o de marcador (partido 8) actualiza `fecha_ultimo_cambio`, lo que responde directamente a la pregunta de auditoria "que paso y cuando paso" sin reconstruir nada a mano. El `DELETE` controlado exige estado `anulado` y marcador en cero a la vez: eso evita borrar por error un partido que sigue en revision (como el partido 11), aunque tambien tenga un estado distinto de `jugado`.
