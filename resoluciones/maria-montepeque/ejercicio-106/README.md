# Ejercicio 106: Triggers Nivel Aplicado

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-31

## Tema central

Triggers

## Descripcion del problema

Un torneo de videojuegos necesita una tabla de posiciones con el
puntaje total de cada equipo siempre actualizado, sin tener que
recalcular `SUM(puntaje)` sobre todas las partidas cada vez que
alguien consulta el ranking.

## Tablas y relaciones

- `equipos`: catalogo de equipos, con su `puntaje_total`
  (desnormalizado: una copia calculada que mantienen los triggers).
- `jugadores`: catalogo de jugadores, cada uno de un equipo.
- `partidas`: tabla principal, cada fila es una partida con su
  `puntaje`. `equipos` 1—N `jugadores`; `equipos` 1—N `partidas`.

## Uso de Triggers

En `ddl/schema.sql` se definen 3 triggers, uno por cada evento posible
sobre `partidas` (el objetivo del ejercicio: "automatizar acciones
ante INSERT, UPDATE o DELETE"):

1. `trg_sumar_puntaje_partida_insert` (`AFTER INSERT`): suma el
   puntaje de la partida nueva al `puntaje_total` de su equipo.
2. `trg_ajustar_puntaje_partida_update` (`AFTER UPDATE OF puntaje`,
   con `WHEN OLD.puntaje <> NEW.puntaje`): cuando se corrige el
   puntaje de una partida existente, ajusta el total solo por la
   diferencia (`NEW.puntaje - OLD.puntaje`).
3. `trg_restar_puntaje_partida_delete` (`AFTER DELETE`): al eliminar
   una partida, resta su puntaje del total del equipo.

En `dml/inserts.sql` se ejercitan los 3: 5 `INSERT`, 1 `UPDATE` (se
corrige una partida de 80 a 100 puntos) y 1 `DELETE` (se elimina la
unica partida de "Halcones Nocturnos"). La consulta 5 en
`dql/consultas.sql` es el reporte/validacion final de negocio:
compara `puntaje_total` (mantenido por los triggers) contra un
`SUM(puntaje)` calculado en el momento desde `partidas`, y ambos
coinciden exactamente para los 3 equipos.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `jugadores.id_equipo`, `partidas.id_equipo`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `equipos.nombre_equipo`, `jugadores.gamer_tag`.
- `CHECK`: `equipos.puntaje_total >= 0`, `partidas.puntaje >= 0`,
  `partidas.resultado IN (...)`.
- `DEFAULT` en `equipos.puntaje_total` y `partidas.resultado`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dql/consultas.sql`)

Modificar `equipos.puntaje_total` directamente con un `UPDATE`, en vez
de dejar que los triggers lo mantengan a traves de cambios en
`partidas`. La sentencia no falla (no hay ningun `CHECK` que la
impida, solo que el valor sea `>= 0`), pero se verifico con Python
(`sqlite3`) que, despues de este `UPDATE` manual, `puntaje_total`
(`9999`) para "Dragones Digitales" deja de coincidir con el
`SUM(puntaje)` real de sus partidas (`190`), que es exactamente la
comparacion de la consulta 5. Bypasear los triggers escribiendo
directo sobre la columna desnormalizada la desincroniza en silencio,
sin ningun error que avise del problema.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-106.db < ddl/schema.sql
sqlite3 ejercicio-106.db < dml/inserts.sql
sqlite3 ejercicio-106.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
