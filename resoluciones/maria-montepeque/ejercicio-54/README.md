# Ejercicio 54: NOT NULL Nivel Intermedio

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-17

## Tema central

NOT NULL

## Descripcion del problema

Sistema de torneo de videojuegos con tres tablas relacionadas: `equipos`, `jugadores` (cada jugador pertenece a un equipo) y `partidas` (cada partida enfrenta a dos equipos, tabla principal). El ejercicio se enfoca en distinguir, a traves de varias tablas ligadas por llave foranea, que campos son obligatorios (`NOT NULL`) y cuales son opcionales por naturaleza del negocio.

## Que aprendi sobre NOT NULL

- **NOT NULL tambien aplica a las relaciones entre tablas, no solo a datos simples**: `jugadores.id_equipo` es `NOT NULL` porque en este torneo un jugador no puede existir sin estar inscrito en un equipo; la relacion en si es un dato obligatorio.
- **Lo obligatorio puede depender del momento del dato, no solo del tipo de columna**: en `partidas`, `fecha_partida` es `NOT NULL` porque toda partida necesita programarse con fecha, pero `puntaje_local` y `puntaje_visitante` se dejan sin `NOT NULL` a proposito, porque ese dato simplemente no existe todavia cuando la partida esta `programada`. De las 7 partidas de prueba, solo las 3 marcadas como `jugada` tienen puntaje.
- **Confirme la obligatoriedad con datos, no solo con el caso que falla**: la consulta 5.a compara `COUNT(*)` contra `COUNT(fecha_partida)` en `partidas` (7 y 7, coinciden) — si `NOT NULL` no estuviera aplicado a `fecha_partida`, podria haber partidas sin fecha y esos numeros diferirian. La consulta 5.b hace el contraste opuesto con `puntaje_local` (campo opcional), donde SI es normal que los numeros no coincidan (7 partidas, solo 3 con puntaje).
- Los dos casos comentados muestran `NOT NULL` en columnas de tablas distintas: `equipos.nombre_equipo` y `partidas.fecha_partida`. Ambos fallan con `NOT NULL constraint failed` sobre la columna correspondiente.

## Como ejecutar

```bash
sqlite3 ejercicio-54.db < ddl/schema.sql
sqlite3 ejercicio-54.db < dml/inserts.sql
sqlite3 ejercicio-54.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
