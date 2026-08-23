# Ejercicio 017: Solicitud de cliente - Streaming Musica

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Una plataforma musical necesita playlists, artistas, canciones y reproducciones, y pidio explicitamente poder corregir estados sin borrar informacion importante: si una cancion se bloquea o retira temporalmente, su registro no debe desaparecer.

## Tablas y relaciones

- `artistas`: catalogo de artistas de la plataforma (nombre unico, genero principal).
- `canciones`: registro central de cada cancion, con su estado (`artistas` 1—N `canciones`).

No se crearon tablas de `playlists` ni `reproducciones`: el alcance de este nivel pide 1 a 2 tablas, y el modelo se enfoca en donde vive la peticion central del cliente (documentado como supuesto en `analisis/requerimiento.md`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en ambas tablas.
- `FOREIGN KEY`: `canciones.id_artista` -> `artistas.id_artista`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `artistas.nombre_artista`.
- `CHECK`: `duracion_segundos > 0`, `genero_principal IN (...)`, `estado IN ('disponible', 'retirada_temporalmente', 'bloqueada_por_derechos')`.
- `DEFAULT`: `fecha_lanzamiento` con la fecha actual, `estado` en `'disponible'`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 5 artistas y 9 canciones base (una de ellas, la cancion 9, es una entrada de prueba insertada por error).
- `operaciones.sql` restaura una cancion retirada, corrige la clasificacion de genero de un artista y elimina la entrada de prueba (la unica fila que realmente se borra): quedan 8 canciones.
- El caso comentado (`duracion_segundos = 0`) falla al ejecutarlo: `CHECK constraint failed: duracion_segundos > 0`.
- Reporte de duracion total por artista: Los Rockeros lidera con 505 segundos de contenido.
- Artistas con mas canciones: Luna Estrella, Los Rockeros y DJ Pulso empatan con 2 cada uno.

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-017.db < ddl/schema.sql
sqlite3 ejercicio-017.db < dml/inserts.sql
sqlite3 ejercicio-017.db < dml/operaciones.sql
sqlite3 ejercicio-017.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
