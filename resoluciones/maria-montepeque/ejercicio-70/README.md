# Ejercicio 70: DROP Nivel Aplicado

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Tema central

DROP

## Descripcion del problema

Un torneo de videojuegos registra equipos, jugadores y partidas con su
puntaje. Los resultados de la primera jornada llegaron en una tabla
temporal de importacion que, una vez migrada a la tabla definitiva, ya
no sirve para nada. Ademas, el torneo necesita generar un reporte
oficial de posiciones (caso de negocio con validacion final, propio del
nivel aplicado) usando objetos de apoyo que se descartan despues de
usarlos.

## Tablas y relaciones

- `equipos`: catalogo de equipos participantes, tabla definitiva y
  permanente.
- `jugadores`: catalogo de jugadores, cada uno ligado a un equipo.
- `partidas`: relaciona un equipo local con un equipo visitante en una
  fecha, con puntaje y estado. `equipos` 1—N `jugadores`; `equipos`
  1—N `partidas` (dos veces: como local y como visitante).

## Uso de DROP

En `ddl/schema.sql`, despues de crear las 3 tablas y migrar los
resultados de la primera jornada desde una tabla temporal de
importacion:

1. `DROP TABLE partidas_temporal;`: elimina la tabla temporal una vez
   que sus datos ya se copiaron a `partidas`. El riesgo real de `DROP`
   se explica en un comentario: ejecutarlo antes de migrar los datos
   habria perdido esos resultados para siempre.

En `dql/consultas.sql` (consulta 5), el caso de negocio del nivel
aplicado:

2. `CREATE INDEX idx_partidas_estado` y
   `CREATE VIEW vista_tabla_posiciones ...`: se arma un reporte oficial
   de la jornada (tabla de posiciones por equipo). Se genera el reporte
   consultando la vista, y una vez entregado, `DROP VIEW` y
   `DROP INDEX` los eliminan porque ya cumplieron su proposito puntual.
   Ninguno de los dos afecta los datos de `equipos`, `jugadores` ni
   `partidas`.

La ultima parte de la consulta 5 confirma, consultando `sqlite_master`,
que la tabla temporal, la vista y el indice ya no existen, mientras que
las 5 partidas reales (con las que se armo el reporte) siguen
disponibles.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `jugadores.id_equipo`, `partidas.id_equipo_local`,
  `partidas.id_equipo_visitante`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `equipos.nombre_equipo`.
- `CHECK`: `partidas.estado IN (...)`, `puntaje_local >= 0`,
  `puntaje_visitante >= 0`.
- `DEFAULT` en `partidas.puntaje_local`, `puntaje_visitante` y
  `estado`.
- `PRAGMA foreign_keys = ON;` activado al inicio de cada script.

## Caso que falla / no recomendable (comentado en `ddl/schema.sql`)

`DROP TABLE equipos;` falla porque `jugadores` y `partidas` todavia
tienen filas que dependen de `equipos` por `FOREIGN KEY`, y SQLite (con
`PRAGMA foreign_keys = ON`) no permite eliminar una tabla que sigue
siendo referenciada. Se valido con Python (`sqlite3`): lanza
`IntegrityError: FOREIGN KEY constraint failed`. Para poder eliminar
`equipos` habria que primero eliminar o reasignar los jugadores y
partidas que dependen de el.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos finales: 4 equipos, 6 jugadores, 5 partidas (3 jugadas, 2
  programadas).
- Reporte final: Dragones del Norte lidera la tabla de posiciones con
  2 partidas ganadas de 2 jugadas.

## Como ejecutar

```bash
sqlite3 ejercicio-70.db < ddl/schema.sql
sqlite3 ejercicio-70.db < dml/inserts.sql
sqlite3 ejercicio-70.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
