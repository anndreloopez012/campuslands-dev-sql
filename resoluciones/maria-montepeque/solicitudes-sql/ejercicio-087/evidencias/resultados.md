# Evidencias - Solicitudes SQL - Ejercicio 087 (Club Futbol Sala)

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-087.db < ddl/schema.sql
sqlite3 ejercicio-087.db < dml/inserts.sql
sqlite3 ejercicio-087.db < dml/operaciones.sql
sqlite3 ejercicio-087.db < dql/consultas.sql
```

## Resultados

Datos base tras `dml/inserts.sql`: 3 equipos, 6 jugadores, 3 partidos
(3 marcados `finalizado` en algun momento), 7 goles y 4 tarjetas
(incluye el gol y la tarjeta cargados por error en el partido que se
debia suspender).

**Caso comentado verificado:**

- `INSERT INTO jugadores (nombre_jugador, id_equipo, numero_camiseta) VALUES ('Jugador Nuevo', 1, 7);` (repetir la camiseta 7 en Halcones FS) → `UNIQUE constraint failed: jugadores.id_equipo, jugadores.numero_camiseta`.

**1. Resumen de partidos via `vista_resumen_partidos` (el partido 3 ya
aparece `suspendido`):**

```text
id_partido | equipo_local     | equipo_visitante   | fecha_partido   | estado
1           | Halcones FS        | Titanes FS            | 2026-08-01        | finalizado
2           | Titanes FS         | Rayos FS              | 2026-08-03        | finalizado
3           | Halcones FS        | Rayos FS              | 2026-08-05        | suspendido
```

**3. Jugador con mas goles (empate a 2 entre tres jugadores):**

```text
nombre_jugador     total_goles
Diana Perez           2
Kevin Us               2
Melissa Ordonez        2
```

**5. Jugadores con 2 o mas goles (candidatos a mejor jugador del
torneo):** los mismos tres jugadores de la consulta 3.

## Operaciones de mantenimiento verificadas

- `UPDATE partidos SET estado = 'suspendido' WHERE id_partido = 3 ...;` → el partido del 2026-08-05 se suspendio despues de confirmarse el corte de luz.
- **DELETE controlado (goles y tarjetas)**: se eliminaron el gol y la tarjeta que habian quedado huerfanos en el partido 3, apenas se marco `suspendido`. Total de goles: 7 -> 6; total de tarjetas: 4 -> 3. Ningun gol ni tarjeta de un partido `finalizado` se toco.

## Aprendizaje

El `UNIQUE (id_equipo, numero_camiseta)` en `jugadores` evita que un
equipo repita el mismo numero de camiseta en dos jugadores. Los goles
y tarjetas de un partido `finalizado` son historico oficial y nunca se
borran, tal como pidio el cliente ("corregir estados sin borrar
informacion importante"): el `DELETE` controlado solo alcanza
registros de un partido `suspendido`, y unicamente cuando resultaron
ser un error de captura confirmado. La vista `vista_resumen_partidos`
demuestra la habilidad de nivel 5 de "crear vistas": centraliza el
doble `JOIN` a `equipos` (local y visitante) en un solo objeto
reutilizable.
