# Ejercicio 12: Streaming Musica

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-05

## Descripcion del problema

Una plataforma de musica necesita reemplazar el registro manual de artistas, albumes, canciones y reproducciones por una base de datos relacional que evite duplicidad, errores de captura y permita generar reportes de consumo.

## Tablas y relaciones

- `artistas`: catalogo de artistas (nombre, pais).
- `albumes`: catalogo de albumes de un artista (titulo, anio de lanzamiento).
- `canciones`: catalogo de canciones de un album (titulo, duracion, genero).
- `reproducciones`: registro transaccional de cada reproduccion de una cancion (usuario, fecha/hora, dispositivo).

Relaciones: `artistas` 1—N `albumes`, `albumes` 1—N `canciones`, `canciones` 1—N `reproducciones`.

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 4 tablas.
- `FOREIGN KEY`: `albumes.id_artista`, `canciones.id_album`, `reproducciones.id_cancion`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `artistas.nombre`, `(id_artista, titulo)` en `albumes`, `(id_album, titulo)` en `canciones`.
- `CHECK`: `albumes.anio_lanzamiento BETWEEN 1900 AND 2100`, `canciones.duracion_segundos > 0`, `reproducciones.dispositivo IN ('movil','web','escritorio','tablet')`.
- `PRAGMA foreign_keys = ON;` activado en `ddl/schema.sql`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con SQLite:

- Datos base: 5 artistas, 5 albumes, 5 canciones, 10 reproducciones.
- Tras aplicar `operaciones.sql`: 6 artistas, 5 albumes, 5 canciones y 9 reproducciones (se insertan 2, se eliminan 2 con `WHERE`).
- Las 2 operaciones comentadas en `dml/operaciones.sql` fallan al descomentarlas: una por `CHECK (duracion_segundos > 0)` y otra por `FOREIGN KEY` (id_cancion inexistente).
- Consulta de decision de negocio (cancion mas reproducida): `Barrio Alto` con 3 reproducciones.

## Como ejecutar

```bash
sqlite3 ejercicio-12.db < ddl/schema.sql
sqlite3 ejercicio-12.db < dml/inserts.sql
sqlite3 ejercicio-12.db < dml/operaciones.sql
sqlite3 ejercicio-12.db < dql/consultas.sql
```
