# Solicitud SQL - Ejercicio 074: Liga Videojuego Futbol

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Solicitud del cliente

Una liga de videojuegos de futbol registra usuarios, clubes, jornadas
y goles. El cliente necesita un reporte rapido para tomar decisiones
al final de cada semana. Pidio convertir esa operacion en una base de
datos que permita consultar datos, corregir estados, registrar
movimientos y sacar reportes utiles.

## Que entendi de la solicitud

"Al final de cada semana" se traduce en "al final de cada jornada":
el modelo necesita poder responder, para una jornada especifica, que
club domino en goles. El nivel pedido (4, reportes y agrupaciones)
exige ademas `JOIN`, `GROUP BY`, `HAVING`, totales y ranking. El
detalle completo del analisis esta en
[analisis/requerimiento.md](analisis/requerimiento.md).

## Que tablas cree y por que

- `usuarios`: catalogo de jugadores humanos de la liga.
- `clubes`: catalogo de clubes de futbol del videojuego.
- `jornadas`: catalogo de semanas de competencia.
- `partidos`: tabla transaccional, cada uno dentro de una jornada,
  entre dos usuarios que juegan con dos clubes.
- `goles`: detalle de cada partido. El marcador no se guarda como
  numero fijo, se calcula sumando estas filas, lo que hace que el
  reporte semanal que pidio el cliente siempre sea confiable.

## Como se relacionan

`jornadas` 1:N `partidos`; `usuarios` 1:N `partidos` (como local y
como visitante); `clubes` 1:N `partidos` (como local y como
visitante); `partidos` 1:N `goles`; `clubes` 1:N `goles`. El diagrama
esta en [diagramas/diagrama-er.svg](diagramas/diagrama-er.svg).

## Que datos de prueba use

4 usuarios, 4 clubes, 2 jornadas, 4 partidos (3 marcados `jugado` en
algun momento, 1 `programado`) y 9 goles, incluido uno cargado por
error para un partido que despues se descubrio que habia que cancelar.
Tambien tres `INSERT` comentados que deben fallar (uno por cada
restriccion). Detalle en [dml/inserts.sql](dml/inserts.sql).

## Que operaciones de mantenimiento incluyo

En [dml/operaciones.sql](dml/operaciones.sql): un `UPDATE` de estado
(el partido que se desconecto a la mitad pasa a `cancelado`) y un
`DELETE` controlado que limpia el gol huerfano de ese partido, sin
tocar ningun gol de un partido ya `jugado`.

## Que consultas responden al cliente

En [dql/consultas.sql](dql/consultas.sql): que goles existen (JOIN
club-partido-jornada), en que estado esta cada partido, que club
anoto mas goles, los goles ordenados por minuto, y el reporte rapido
semanal con `GROUP BY` + `HAVING` de goles por club en una jornada
especifica.

## Evidencias

Resultados de ejecutar todo en orden, incluyendo la verificacion de
los tres casos de error y de las operaciones de mantenimiento, en
[evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-074.db < ddl/schema.sql
sqlite3 ejercicio-074.db < dml/inserts.sql
sqlite3 ejercicio-074.db < dml/operaciones.sql
sqlite3 ejercicio-074.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite`, `.sqlite3` ni `.dump`.
