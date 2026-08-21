# Ejercicio 067: Solicitud de cliente - Streaming Musica

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-21

## Que entendi de la solicitud

La plataforma pide explicitamente que el sistema permita corregir
estados sin borrar informacion importante: una playlist sin uso se debe
archivar, no eliminar. Se necesita una base de datos que permita
consultar reproducciones, corregir estados, registrar movimientos y
sacar reportes, como saber que cancion es mas popular o que genero
prefieren los usuarios premium. El detalle completo del analisis esta
en [`analisis/requerimiento.md`](analisis/requerimiento.md).

## Tablas y por que se crearon

- `artistas`: catalogo de interpretes.
- `canciones`: catalogo de canciones, cada una de un artista.
- `usuarios`: catalogo de cuentas de la plataforma, con su plan.
- `playlists`: operacion del usuario; su `estado` se corrige
  (`'activa'` / `'archivada'`) en vez de eliminarla, tal como pidio el
  cliente.
- `reproducciones`: movimiento que registra que usuario escucho que
  cancion y cuando; a diferencia de una playlist, un registro erroneo
  aqui si se elimina con `DELETE`.

## Como se relacionan

`artistas` 1—N `canciones`; `usuarios` 1—N `playlists`; `usuarios` 1—N
`reproducciones`; `canciones` 1—N `reproducciones`.

## Datos de prueba

4 artistas, 6 canciones, 5 usuarios, 5 playlists y 12 reproducciones
(una de ellas un duplicado exacto por error, corregido en
`operaciones.sql`).

## Operaciones (`dml/operaciones.sql`)

- `UPDATE`: una playlist sin uso se archiva (`'activa'` ->
  `'archivada'`) en vez de eliminarse, siguiendo la regla que pidio el
  cliente.
- `UPDATE`: un usuario actualiza su cuenta a plan `'premium'`.
- `DELETE` controlado (con `WHERE`): se elimina una reproduccion
  duplicada por error (a diferencia de una playlist, este si es un
  caso valido de `DELETE` real).
- Caso comentado que debe fallar: eliminar una cancion con
  reproducciones asociadas viola la `FOREIGN KEY` de
  `reproducciones.id_cancion`.

## Consultas que responden al cliente

1. Todas las reproducciones con usuario y cancion (`JOIN`).
2. Playlists filtradas por estado (`activa`, `archivada`).
3. Ranking de canciones por numero de reproducciones (`GROUP BY` +
   `ORDER BY`).
4. Reproducciones ordenadas por fecha, de la mas reciente a la mas
   antigua.
5. Reporte de decision de negocio: genero mas reproducido entre
   usuarios premium, filtrando los que superan 1 reproduccion
   (`GROUP BY` + `HAVING`).

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` ->
`consultas`) con Python (modulo `sqlite3`), ya que no se tenia el
binario `sqlite3` disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos base: 4 artistas, 6 canciones, 5 usuarios, 5 playlists, 12
  reproducciones.
- Tras `operaciones.sql`: 11 reproducciones (se elimino el duplicado),
  playlist 5 archivada, Cristina Barrios ahora premium.
- Reporte final: entre usuarios premium, el genero "pop" se reproduce
  mas (6 veces) frente a "electronica" (3 veces).

## Como validar

```bash
sqlite3 ejercicio-067.db < ddl/schema.sql
sqlite3 ejercicio-067.db < dml/inserts.sql
sqlite3 ejercicio-067.db < dml/operaciones.sql
sqlite3 ejercicio-067.db < dql/consultas.sql
```
