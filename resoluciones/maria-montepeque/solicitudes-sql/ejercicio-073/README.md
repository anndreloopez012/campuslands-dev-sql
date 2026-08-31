# Solicitud SQL - Ejercicio 073: Clanes Shooter

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Solicitud del cliente

Una plataforma de shooter administra clanes, scrims, mapas y
resultados. El cliente quiere evitar registros incompletos porque
despues no puede hacer reportes confiables. Pidio convertir esa
operacion en una base de datos que permita consultar datos, corregir
estados, registrar movimientos y sacar reportes utiles.

## Que entendi de la solicitud

El problema central no es "guardar resultados", es garantizar que
cada scrim tenga como maximo un resultado oficial: sin eso, cualquier
reporte de victorias o de actividad queda contaminado por registros
duplicados o incompletos. El nivel pedido (4, reportes y
agrupaciones) exige ademas `JOIN`, `GROUP BY`, `HAVING`, totales y
ranking. El detalle completo del analisis esta en
[analisis/requerimiento.md](analisis/requerimiento.md).

## Que tablas cree y por que

- `clanes`: catalogo de clanes registrados.
- `jugadores`: catalogo de jugadores, cada uno miembro de un clan.
- `mapas`: catalogo de mapas disponibles para scrims.
- `scrims`: tabla transaccional, cada enfrentamiento entre dos clanes
  en un mapa.
- `resultados`: registro oficial del resultado de un scrim. Aqui esta
  la restriccion que ataca el problema del cliente: un
  `UNIQUE (id_scrim)` garantiza que un scrim nunca tenga mas de un
  resultado.

## Como se relacionan

`clanes` 1:N `jugadores`; `clanes` 1:N `scrims` (como local y como
visitante); `mapas` 1:N `scrims`; `scrims` 1:1 `resultados`. El
diagrama esta en [diagramas/diagrama-er.svg](diagramas/diagrama-er.svg).

## Que datos de prueba use

4 clanes, 8 jugadores, 4 mapas, 5 scrims (4 marcados `jugado` en algun
momento, 1 `programado`) y 4 resultados, incluido uno cargado por
error para un scrim que despues se descubrio que habia que cancelar.
Tambien un `INSERT` comentado que reproduce exactamente el problema
del cliente (dos resultados para el mismo scrim) y debe fallar.
Detalle en [dml/inserts.sql](dml/inserts.sql).

## Que operaciones de mantenimiento incluyo

En [dml/operaciones.sql](dml/operaciones.sql): un `UPDATE` de estado
(el scrim que se cayo a la mitad pasa a `cancelado`) y un `DELETE`
controlado que limpia el resultado huerfano de ese scrim, sin tocar
ningun resultado de un scrim ya `jugado`.

## Que consultas responden al cliente

En [dql/consultas.sql](dql/consultas.sql): que scrims existen (JOIN
clan local-clan visitante-mapa), en que estado esta cada uno, que clan
jugo mas scrims, los scrims ordenados por fecha, y un reporte con
`GROUP BY` + `HAVING` de victorias por clan, para decidir quien
clasifica a playoffs.

## Evidencias

Resultados de ejecutar todo en orden, incluyendo la verificacion del
caso de duplicado y de las operaciones de mantenimiento, en
[evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-073.db < ddl/schema.sql
sqlite3 ejercicio-073.db < dml/inserts.sql
sqlite3 ejercicio-073.db < dml/operaciones.sql
sqlite3 ejercicio-073.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite`, `.sqlite3` ni `.dump`.
