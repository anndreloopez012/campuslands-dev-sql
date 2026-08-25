# Solicitud SQL - Ejercicio 080: Cine Horror Nights

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Solicitud del cliente

Un cine organiza funciones de peliculas de miedo, salas y ventas de
boletos. El cliente pidio detectar tres tipos de error: registros
repetidos, relaciones invalidas y valores fuera de rango. Ademas
queria poder consultar datos, corregir estados, registrar movimientos
y sacar reportes utiles.

## Que entendi de la solicitud

En un cine, el "registro repetido" mas clasico es vender el mismo
asiento dos veces para la misma funcion; eso es lo primero que el
modelo debe impedir. El nivel pedido (4, reportes y agrupaciones)
exige ademas `JOIN`, `GROUP BY`, `HAVING`, totales y ranking. El
detalle completo del analisis esta en
[analisis/requerimiento.md](analisis/requerimiento.md).

## Que tablas cree y por que

- `peliculas`: catalogo de peliculas de terror.
- `salas`: catalogo de salas del cine.
- `funciones`: tabla transaccional, una pelicula proyectada en una
  sala, en fecha y hora.
- `boletos`: detalle de cada funcion. Aqui esta el
  `UNIQUE (id_funcion, asiento)` que impide vender el mismo asiento
  dos veces.
- `pagos`: resultado de un boleto. El `UNIQUE (id_boleto)` garantiza
  un solo pago oficial por boleto.

## Como se relacionan

`peliculas` 1:N `funciones`; `salas` 1:N `funciones`; `funciones` 1:N
`boletos`; `boletos` 1:1 `pagos`. El diagrama esta en
[diagramas/diagrama-er.svg](diagramas/diagrama-er.svg).

## Que datos de prueba use

2 peliculas, 2 salas, 4 funciones (3 marcadas `finalizada` en algun
momento, 1 `programada`), 6 boletos (incluido uno vendido por error en
una funcion que despues se descubrio que habia que cancelar, todavia
sin pago) y 5 pagos. Tambien un `INSERT` comentado que reproduce el
problema de vender dos veces el mismo asiento y debe fallar. Detalle
en [dml/inserts.sql](dml/inserts.sql).

## Que operaciones de mantenimiento incluyo

En [dml/operaciones.sql](dml/operaciones.sql): un `UPDATE` de estado
(la funcion con falla de proyector pasa a `cancelada`) y un `DELETE`
controlado que elimina el boleto sin pagar de esa funcion, sin tocar
ningun boleto ya pagado.

## Que consultas responden al cliente

En [dql/consultas.sql](dql/consultas.sql): que boletos existen (JOIN
pelicula-sala-funcion), en que estado esta cada funcion, que pelicula
vendio mas boletos, los boletos ordenados por precio, y un reporte con
`GROUP BY` + `HAVING` de ingresos totales por pelicula, para decidir
cual mantener en cartelera.

## Evidencias

Resultados de ejecutar todo en orden, incluyendo la verificacion del
caso de duplicado y de las operaciones de mantenimiento, en
[evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-080.db < ddl/schema.sql
sqlite3 ejercicio-080.db < dml/inserts.sql
sqlite3 ejercicio-080.db < dml/operaciones.sql
sqlite3 ejercicio-080.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite`, `.sqlite3` ni `.dump`.
