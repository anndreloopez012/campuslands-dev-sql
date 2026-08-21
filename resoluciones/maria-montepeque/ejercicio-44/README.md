# Ejercicio 44: PRIMARY KEY Nivel Basico

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-17

## Tema central

PRIMARY KEY

## Descripcion del problema

Sistema de registro de campers inscritos en rutas de entrenamiento: `campers` (tabla principal), `rutas` e `inscripciones`. El ejercicio se enfoca en como una `PRIMARY KEY` identifica de forma unica cada fila y evita duplicados, usando dos variantes: una llave simple autoincremental y una llave compuesta.

## Que aprendi sobre PRIMARY KEY

- **PRIMARY KEY simple (llave subrogada)**: `campers.id_camper` es un entero autoincremental que no tiene significado de negocio, solo identifica la fila. Se prefirio esta llave subrogada sobre `documento` (que tambien es unico en la vida real) porque un documento puede escribirse mal y corregirse; si fuera la `PRIMARY KEY`, corregirlo obligaria a actualizar esa llave en todas las tablas que la referencian. `documento` se dejo como `UNIQUE`, no como `PRIMARY KEY`.
- **PRIMARY KEY compuesta**: `inscripciones` no tiene una columna `id_inscripcion` propia; su `PRIMARY KEY` es la combinacion `(id_camper, id_ruta)`. Esto demuestra el proposito central del tema: la llave primaria evita duplicados **del negocio**, no solo duplicados tecnicos. Un camper puede tener varias filas en `inscripciones` (una por cada ruta en la que se inscribe), pero la base de datos misma impide, sin necesidad de una restriccion extra, que el mismo camper quede inscrito dos veces en la misma ruta.
- **Duplicar una PRIMARY KEY siempre falla**, sea simple o compuesta: lo verifique con los dos casos comentados (uno intenta repetir `id_camper = 1` en `campers`, el otro intenta repetir la combinacion `(3, 1)` en `inscripciones`) y ambos fallan con `UNIQUE constraint failed` sobre las columnas de la `PRIMARY KEY`.

## Como ejecutar

```bash
sqlite3 ejercicio-44.db < ddl/schema.sql
sqlite3 ejercicio-44.db < dml/inserts.sql
sqlite3 ejercicio-44.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
