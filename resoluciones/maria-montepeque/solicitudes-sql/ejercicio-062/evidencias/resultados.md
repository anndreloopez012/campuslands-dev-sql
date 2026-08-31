# Evidencias - Ejercicio 062

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-062.db < ddl/schema.sql
sqlite3 ejercicio-062.db < dml/inserts.sql
sqlite3 ejercicio-062.db < dml/operaciones.sql
sqlite3 ejercicio-062.db < dql/consultas.sql
```

## Resultados importantes

Conteo de datos base (despues de `inserts.sql`):

```text
equipos -> 3
jugadores -> 9
partidos -> 4
goles -> 6
tarjetas -> 5
```

Caso que debe fallar - dorsal duplicado en el mismo equipo (`UNIQUE`):

```text
Fallo como se esperaba: UNIQUE constraint failed: jugadores.id_equipo, jugadores.dorsal
```

Despues de `operaciones.sql`:

```text
tarjetas -> 4   (se elimino la tarjeta duplicada por error)
```

Caso que debe fallar - eliminar equipo con jugadores asociados (`FOREIGN KEY`):

```text
Fallo como se esperaba: FOREIGN KEY constraint failed
```

Consulta 3 (ranking de goleadores):

```text
jugador            equipo         goles_anotados
Oscar Choc         Panteras FS     2
Diego Marroquin    Tigres FS       2
Kevin Ramos        Halcones FS     2
```

Consulta 5 (equipos con mas de una tarjeta, HAVING > 1):

```text
equipo         total_tarjetas
Halcones FS     2
```

## Explicacion final

El modelo separa catalogos (`equipos`, `jugadores`) de dos tablas de
movimientos distintas (`goles` y `tarjetas`), en vez de una sola tabla de
"eventos" mezclada. Esto permite corregir el estado de un partido y el
minuto de un gol sin tocar el resto de los datos, eliminar un registro
erroneo con `WHERE` especifico, y responder con `JOIN`, `GROUP BY` y
`HAVING` las preguntas reales del cliente: quien anota mas y que equipo
acumula mas sanciones disciplinarias.
