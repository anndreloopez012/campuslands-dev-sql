# Evidencias - Solicitudes SQL - Ejercicio 073 (Clanes Shooter)

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-073.db < ddl/schema.sql
sqlite3 ejercicio-073.db < dml/inserts.sql
sqlite3 ejercicio-073.db < dml/operaciones.sql
sqlite3 ejercicio-073.db < dql/consultas.sql
```

## Resultados

Datos base tras `dml/inserts.sql`: 4 clanes, 8 jugadores, 4 mapas, 5
scrims (4 `jugado`, 1 `programado`) y 4 resultados (incluye el
cargado por error para el scrim que se debia cancelar).

**Caso comentado verificado** (el problema central del cliente):

- `INSERT INTO resultados (id_scrim, ...) VALUES (1, ...);` (segundo resultado para el scrim 1) → `UNIQUE constraint failed: resultados.id_scrim`.

**1. Todos los scrims, con JOIN a clan local, clan visitante y mapa:**

```text
id_scrim | clan_local        | clan_visitante     | nombre_mapa        | fecha_scrim   | estado
1         | Furia Roja          | Sombra Digital       | Bunker Norte          | 2026-08-01       | jugado
2         | Sombra Digital      | Vertigo              | Zona Industrial       | 2026-08-03       | jugado
3         | Vertigo             | Nova Tactica         | Puerto Fantasma       | 2026-08-05       | jugado
4         | Furia Roja          | Vertigo              | Complejo Alfa         | 2026-08-08       | programado
5         | Nova Tactica        | Sombra Digital       | Bunker Norte          | 2026-08-02       | cancelado
```

**2. Scrims por estado:** ver tabla completa arriba (el scrim 5 ya
aparece `cancelado`, se corrigio con el `UPDATE` de
`dml/operaciones.sql`).

**3. Clan con mas scrims jugados (actividad total, local +
visitante):**

```text
nombre_clan       total_scrims
Sombra Digital      3
Vertigo             3
Furia Roja          2
Nova Tactica         2
```

**4. Scrims ordenados por fecha:** de 2026-08-01 a 2026-08-08.

**5. Victorias por clan (reporte de clasificacion a playoffs):**

```text
nombre_clan     victorias
Furia Roja        1
Nova Tactica       1
```

(El scrim 2 termino en empate, sin ganador, por eso Sombra Digital y
Vertigo no aparecen en este reporte aunque jugaron mas scrims.)

## Operaciones de mantenimiento verificadas

- `UPDATE scrims SET estado = 'cancelado' WHERE id_scrim = 5 ...;` → el scrim de Bunker Norte del 2026-08-02 se anulo despues de confirmarse la caida del servidor.
- **DELETE controlado**: se elimino el unico resultado que habia quedado huerfano (el del scrim 5), apenas se marco `cancelado`. Total de resultados: 4 -> 3. Ningun resultado de un scrim `jugado` se toco.

## Aprendizaje

El `UNIQUE (id_scrim)` en `resultados` es la restriccion que resuelve
directamente el problema que trajo el cliente: ya no es posible
registrar dos resultados para el mismo scrim, lo que garantiza que
cualquier reporte que se construya sobre esta tabla sea confiable. El
`DELETE` controlado solo alcanza resultados de scrims `cancelado`,
nunca de uno `jugado` cuyo resultado ya es un dato oficial de la liga.
El reporte de victorias por clan (`GROUP BY` + `HAVING`) demuestra que
un modelo sin registros incompletos permite responder con confianza
una pregunta real del negocio: quien clasifica a playoffs.
