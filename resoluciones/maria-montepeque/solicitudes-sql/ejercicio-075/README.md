# Solicitud SQL - Ejercicio 075: Track Day Hiperdeportivos

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Solicitud del cliente

Una pista organiza sesiones con vehiculos hiperdeportivos, pilotos y
tiempos. El cliente no sabe hablar en terminos de tablas: solo
describe su operacion diaria y espera que se traduzca a SQL. Pidio
convertir esa operacion en una base de datos que permita consultar
datos, corregir estados, registrar movimientos y sacar reportes
utiles.

## Que entendi de la solicitud

Detras de la descripcion informal hay una operacion clara: pilotos
que corren vueltas cronometradas en sesiones, con un vehiculo
distinto en cada una, y que pagan por participar. El nivel pedido (4,
reportes y agrupaciones) exige ademas `JOIN`, `GROUP BY`, `HAVING`,
totales y ranking. El detalle completo del analisis esta en
[analisis/requerimiento.md](analisis/requerimiento.md).

## Que tablas cree y por que

- `pilotos`: catalogo de pilotos inscritos.
- `vehiculos`: catalogo de vehiculos hiperdeportivos disponibles.
- `sesiones`: tabla transaccional, cada dia de track day.
- `tiempos`: detalle de cada sesion (tiempo de cada vuelta de cada
  piloto). Aqui esta el `UNIQUE (id_sesion, id_piloto, vuelta)` que
  impide cargar dos veces la misma vuelta del mismo piloto.
- `pagos`: lo que cada piloto pago por participar en una sesion.

## Como se relacionan

`sesiones` 1:N `tiempos`; `pilotos` 1:N `tiempos`; `vehiculos` 1:N
`tiempos`; `pilotos` 1:N `pagos`; `sesiones` 1:N `pagos`. El diagrama
esta en [diagramas/diagrama-er.svg](diagramas/diagrama-er.svg).

## Que datos de prueba use

3 pilotos, 3 vehiculos, 3 sesiones (marcadas `finalizada` en algun
momento), 13 tiempos (incluye uno cargado por error para una sesion
que despues se descubrio que habia que cancelar) y 6 pagos, ademas de
un `INSERT` comentado que reproduce el problema de cargar dos veces la
misma vuelta del mismo piloto y debe fallar. Detalle en
[dml/inserts.sql](dml/inserts.sql).

## Que operaciones de mantenimiento incluyo

En [dml/operaciones.sql](dml/operaciones.sql): un `UPDATE` de estado
(la sesion con falla de cronometraje pasa a `cancelada`), un `DELETE`
controlado que limpia el tiempo huerfano de esa sesion, y un `UPDATE`
multiple que confirma como `pagado` los 6 pagos pendientes de las
sesiones ya finalizadas.

## Que consultas responden al cliente

En [dql/consultas.sql](dql/consultas.sql): que tiempos existen (JOIN
piloto-vehiculo-sesion), en que estado esta cada sesion, que piloto
tiene mas vueltas registradas, los tiempos ordenados de mas rapido a
mas lento, y un reporte con `GROUP BY` + `HAVING` de que pilotos
tienen el mejor tiempo promedio, para decidir a quienes invitar al
siguiente evento.

## Evidencias

Resultados de ejecutar todo en orden, incluyendo la verificacion del
caso de duplicado y de las operaciones de mantenimiento, en
[evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-075.db < ddl/schema.sql
sqlite3 ejercicio-075.db < dml/inserts.sql
sqlite3 ejercicio-075.db < dml/operaciones.sql
sqlite3 ejercicio-075.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite`, `.sqlite3` ni `.dump`.
