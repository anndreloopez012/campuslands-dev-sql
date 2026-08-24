# Evidencias - Solicitudes SQL - Ejercicio 074 (Liga Videojuego Futbol)

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-074.db < ddl/schema.sql
sqlite3 ejercicio-074.db < dml/inserts.sql
sqlite3 ejercicio-074.db < dml/operaciones.sql
sqlite3 ejercicio-074.db < dql/consultas.sql
```

## Resultados

Datos base tras `dml/inserts.sql`: 4 usuarios, 4 clubes, 2 jornadas,
4 partidos (3 `jugado`, 1 `programado`) y 9 goles (incluye el cargado
por error para el partido que se debia cancelar).

**Casos comentados verificados:**

- `INSERT INTO jornadas (numero_jornada, ...) VALUES (1, ...);` → `UNIQUE constraint failed: jornadas.numero_jornada`.
- `INSERT INTO goles (id_partido, id_club, ...) VALUES (1, 99, ...);` → `FOREIGN KEY constraint failed`.
- `INSERT INTO goles (..., minuto) VALUES (..., 130);` → `CHECK constraint failed: minuto BETWEEN 1 AND 120`.

**2. Partidos por estado (el partido 3 ya aparece `cancelado`, se
corrigio con el `UPDATE` de `dml/operaciones.sql`):**

```text
id_partido | fecha_partido   | estado
3           | 2026-08-04        | cancelado
1           | 2026-08-02        | jugado
2           | 2026-08-03        | jugado
4           | 2026-08-09        | programado
```

**3. Club con mas goles anotados en total:**

```text
nombre_club        goles_totales
Real Pixel           3
Deportivo Codigo      2
Union Byte            2
Atletico Bit          1
```

**5. Reporte rapido semanal: goles por club en la jornada 1 (minimo
2 goles):**

```text
nombre_club        goles_jornada
Real Pixel           3
Union Byte            2
Deportivo Codigo      2
```

(Atletico Bit anoto solo 1 gol en la jornada 1 y no llega al minimo
del reporte; el gol huerfano del partido 3 ya no cuenta porque se
elimino en las operaciones de mantenimiento.)

## Operaciones de mantenimiento verificadas

- `UPDATE partidos SET estado = 'cancelado' WHERE id_partido = 3 ...;` → el partido del 2026-08-04 se anulo despues de confirmarse la desconexion del servidor.
- **DELETE controlado**: se elimino el unico gol que habia quedado huerfano (el del partido 3), apenas se marco `cancelado`. Total de goles: 9 -> 8. Ningun gol de un partido `jugado` se toco.

## Aprendizaje

El marcador de un partido nunca se guarda como un numero fijo: se
calcula siempre sumando los goles registrados en `goles`, por eso el
reporte rapido semanal que pidio el cliente (`GROUP BY` + `HAVING`)
se puede construir directamente desde el historial de goles, sin
depender de que alguien haya actualizado a mano un marcador. El
`DELETE` controlado solo alcanza goles de partidos `cancelado`, nunca
de uno `jugado` cuyo resultado ya es oficial, lo que garantiza que el
reporte semanal siempre refleje datos confiables.
