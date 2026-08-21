# Ejercicio 062: Solicitud de cliente - Club Futbol Sala

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-21

## Que entendi de la solicitud

El club necesita dejar de llevar el registro de jugadores, partidos,
goles y tarjetas de forma manual. Quiere una base de datos que permita
corregir estados de partido, registrar movimientos (goles y tarjetas de
cada partido) y sacar reportes, como saber que jugador anota mas o que
equipo acumula mas sanciones. El detalle completo del analisis esta en
[`analisis/requerimiento.md`](analisis/requerimiento.md).

## Tablas y por que se crearon

- `equipos`: catalogo de equipos del club.
- `jugadores`: pertenece a un equipo; se repite en goles y tarjetas.
- `partidos`: tabla transaccional central; enfrenta a dos equipos
  (local/visitante) en una fecha, con un estado.
- `goles`: movimiento del partido; se separa de `partidos` porque un
  partido tiene muchos goles de distintos jugadores.
- `tarjetas`: movimiento del partido; se separa de `goles` porque tiene
  su propia regla de negocio (tipo amarilla/roja) y responde a una
  pregunta distinta del cliente (disciplina, no marcador).

## Como se relacionan

`equipos` 1—N `jugadores`; `equipos` 1—N `partidos` (como local y como
visitante, con dos llaves foraneas distintas); `partidos` 1—N `goles`;
`jugadores` 1—N `goles`; `partidos` 1—N `tarjetas`; `jugadores` 1—N
`tarjetas`.

## Datos de prueba

3 equipos, 9 jugadores (3 por equipo), 4 partidos (2 finalizados, 1 en
curso, 1 programado), 6 goles y 5 tarjetas (una de ellas duplicada por
error a proposito, para corregirse en `operaciones.sql`).

## Operaciones (`dml/operaciones.sql`)

- `UPDATE`: el partido en curso pasa a `'finalizado'`.
- `UPDATE`: se corrige el minuto de un gol mal registrado.
- `DELETE` controlado (con `WHERE`): se elimina una tarjeta duplicada por
  error, dejando la original.
- Caso comentado que debe fallar: eliminar un equipo con jugadores
  asociados viola la `FOREIGN KEY` de `jugadores.id_equipo`.

## Consultas que responden al cliente

1. Todos los goles con jugador, equipo y partido (`JOIN`).
2. Partidos filtrados por estado (`programado`, `en_curso`,
   `finalizado`).
3. Ranking de goleadores (`GROUP BY` + `ORDER BY`).
4. Partidos ordenados por fecha, del mas reciente al mas antiguo.
5. Reporte de decision de negocio: equipos con mas de una tarjeta
   acumulada (`GROUP BY` + `HAVING`), para decisiones disciplinarias.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` ->
`consultas`) con Python (modulo `sqlite3`), ya que no se tenia el
binario `sqlite3` disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos base: 3 equipos, 9 jugadores, 4 partidos, 6 goles, 5 tarjetas.
- Tras `operaciones.sql`: 4 partidos finalizados/programados
  correctamente, 4 tarjetas (se elimino la duplicada).
- Reporte final: Halcones FS es el unico equipo con mas de una tarjeta
  acumulada (2).

## Como validar

```bash
sqlite3 ejercicio-062.db < ddl/schema.sql
sqlite3 ejercicio-062.db < dml/inserts.sql
sqlite3 ejercicio-062.db < dml/operaciones.sql
sqlite3 ejercicio-062.db < dql/consultas.sql
```
