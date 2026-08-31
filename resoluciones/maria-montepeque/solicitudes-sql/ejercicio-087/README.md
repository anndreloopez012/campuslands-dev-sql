# Solicitud SQL - Ejercicio 087: Club Futbol Sala

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Solicitud del cliente

Un club registra jugadores, partidos, goles, tarjetas y posiciones. El
cliente pide que el sistema permita corregir estados sin borrar
informacion importante. Pidio convertir esa operacion en una base de
datos que permita consultar datos, corregir estados, registrar
movimientos y sacar reportes utiles.

## Que entendi de la solicitud

Los goles y tarjetas de un partido ya jugado son historico oficial
del torneo: no se borran, se corrige el estado del partido con
`UPDATE` cuando algo cambia. Es un nivel 5 (solicitud profesional):
ademas del modelo, se pide interpretar ambiguedad, normalizar datos,
documentar decisiones y crear al menos una vista SQL. El detalle
completo del analisis esta en
[analisis/requerimiento.md](analisis/requerimiento.md).

## Que tablas cree y por que

- `equipos`: catalogo de equipos del torneo.
- `jugadores`: catalogo de jugadores. `UNIQUE (id_equipo,
  numero_camiseta)` impide repetir un numero de camiseta en el mismo
  equipo.
- `partidos`: tabla transaccional, cada enfrentamiento entre dos
  equipos.
- `goles`, `tarjetas`: historico oficial de cada partido.

## Vista SQL

`vista_resumen_partidos` (definida en
[ddl/schema.sql](ddl/schema.sql)) junta partido con los nombres de
ambos equipos, sin repetir el doble `JOIN` cada vez.

## Como se relacionan

`equipos` 1:N `jugadores`; `equipos` 1:N `partidos` (como local y como
visitante); `partidos` 1:N `goles` y `tarjetas`; `jugadores` 1:N
`goles` y `tarjetas`. El diagrama esta en
[diagramas/diagrama-er.svg](diagramas/diagrama-er.svg).

## Que datos de prueba use

3 equipos, 6 jugadores, 3 partidos (marcados `finalizado` en algun
momento), 7 goles y 4 tarjetas, incluidos un gol y una tarjeta
cargados por error para un partido que despues se descubrio que habia
que suspender. Tambien un `INSERT` comentado que reproduce el problema
de repetir un numero de camiseta y debe fallar. Detalle en
[dml/inserts.sql](dml/inserts.sql).

## Que operaciones de mantenimiento incluyo

En [dml/operaciones.sql](dml/operaciones.sql): un `UPDATE` de estado
(el partido con corte de luz pasa a `suspendido`) y dos `DELETE`
controlados que limpian el gol y la tarjeta huerfanos de ese partido,
sin tocar ningun gol ni tarjeta de un partido ya `finalizado`.

## Que consultas responden al cliente

En [dql/consultas.sql](dql/consultas.sql): el resumen de partidos
usando la vista, en que estado esta cada partido, que jugador tiene
mas goles, los goles ordenados por partido y minuto, y un reporte con
`GROUP BY` + `HAVING` de jugadores con 2 o mas goles, candidatos a
mejor jugador del torneo.

## Evidencias

Resultados de ejecutar todo en orden, incluyendo la verificacion del
caso de duplicado y de las operaciones de mantenimiento, en
[evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-087.db < ddl/schema.sql
sqlite3 ejercicio-087.db < dml/inserts.sql
sqlite3 ejercicio-087.db < dml/operaciones.sql
sqlite3 ejercicio-087.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite`, `.sqlite3` ni `.dump`.
