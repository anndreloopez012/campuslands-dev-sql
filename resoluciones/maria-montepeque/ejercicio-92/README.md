# Ejercicio 92: HAVING Nivel Basico

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-31

## Tema central

HAVING

## Descripcion del problema

Un torneo de videojuegos necesita saber que equipos tienen un
desempeno destacado, entendido como haber ganado 2 o mas partidas, sin
tener que contar las victorias de cada equipo a mano.

## Tablas y relaciones

- `equipos`: catalogo de equipos.
- `partidas`: tabla principal, cada fila es una partida jugada por un
  equipo con su `resultado`. `equipos` 1—N `partidas`.

## Uso de HAVING

En `dql/consultas.sql`:

1. Conteo simple (consulta 4): `GROUP BY id_equipo` con `COUNT(*)`,
   sin filtrar todavia los grupos.
2. Validacion especifica de `HAVING` (consulta 5): primero `WHERE
   resultado = 'victoria'` deja solo las partidas ganadas (filtro por
   fila, antes de agrupar), luego `GROUP BY id_equipo` agrupa esas
   victorias por equipo, y `HAVING COUNT(*) >= 2` filtra los grupos ya
   formados, quedandose solo con los equipos que ganaron 2 partidas o
   mas (Dragones Digitales con 3, Fenix Cibernetico con 2).

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 2 tablas.
- `FOREIGN KEY`: `partidas.id_equipo`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `equipos.nombre_equipo`.
- `CHECK`: `partidas.resultado IN (...)`.
- `DEFAULT` en `partidas.resultado`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dql/consultas.sql`)

Usar `HAVING resultado = 'victoria'` despues de `GROUP BY id_equipo`,
sin que `resultado` este agregada ni forme parte del `GROUP BY`, para
tratar de contar solo victorias. SQLite no lanza error (a diferencia
de MySQL en modo estricto `ONLY_FULL_GROUP_BY`), pero se verifico con
Python (`sqlite3`) que el resultado es incorrecto: el `resultado` que
evalua `HAVING` es arbitrario (uno cualquiera del grupo) y `COUNT(*)`
sigue contando todas las partidas del equipo, no solo las ganadas. La
consulta devuelve los equipos 1, 2 y 3 con `total_partidas` 4, 2 y 3
(sus totales de partidas jugadas), cuando sus victorias reales son 3,
1 y 2; y el equipo 4 solo queda excluido por coincidencia, porque su
primer resultado registrado es `'derrota'`. La forma correcta es la
de la consulta 5.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-92.db < ddl/schema.sql
sqlite3 ejercicio-92.db < dml/inserts.sql
sqlite3 ejercicio-92.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
