# Ejercicio 42: Tipos de datos Nivel Intermedio

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-17

## Tema central

Tipos de datos

## Descripcion del problema

Sistema de registro de campers inscritos en rutas de entrenamiento: `rutas`, `campers` e `inscripciones`. Nivel intermedio: tres tablas con relaciones (`inscripciones` referencia a `campers` y a `rutas`), profundizando el mismo tema de tipos de dato del ejercicio 41 pero agregando un caso nuevo: un `REAL` que puede ser `NULL`.

## Tablas y relaciones

- `rutas`: catalogo de rutas (duracion, precio, si esta activa).
- `campers`: catalogo de estudiantes (fecha de nacimiento, si tiene beca).
- `inscripciones`: un camper inscrito en una ruta, con fecha de inscripcion, nota final y si aprobo. `campers` 1—N `inscripciones` y `rutas` 1—N `inscripciones`.

## Que aprendi sobre Tipos de datos

- **INTEGER**: llaves primarias/foraneas y `duracion_semanas` (unidad entera de tiempo, no tendria sentido "20.5 semanas" en este contexto de negocio).
- **REAL**: `precio` de la ruta y `nota_final` de la inscripcion, ambos con decimales reales.
- **REAL nullable, un caso nuevo frente al ejercicio 41**: `nota_final` acepta `NULL` porque un camper puede seguir cursando la ruta y todavia no tener nota. Esto es distinto de "nota cero": el `CHECK (nota_final IS NULL OR (nota_final >= 0 AND nota_final <= 100))` deja pasar el `NULL` explicitamente pero sigue validando el rango cuando si hay un valor. Ademas, funciones como `AVG()` **ignoran automaticamente los `NULL`** (lo demuestro en la consulta 4: el promedio se calcula solo sobre las 4 inscripciones que ya tienen nota, no sobre las 7 totales), lo que evita que "todavia no hay nota" se confunda con "nota cero" y distorsione el promedio.
- **TEXT**: nombres, correos (con `UNIQUE`).
- **DATE simulado**: `TEXT` en formato ISO `YYYY-MM-DD` para `fecha_nacimiento` y `fecha_inscripcion`, validado con `CHECK GLOB`. El orden alfabetico del texto coincide con el orden cronologico (consulta 5.a).
- **BOOLEAN simulado**: `INTEGER` restringido a `0/1` con `CHECK` + `DEFAULT` para `activa` (ruta), `becado` (camper) y `aprobado` (inscripcion). Permite `SUM(aprobado)` directo para contar aprobados sin conversion.
- Los dos casos comentados muestran limites distintos: `nota_final = 150` es un `REAL` valido en tipo pero fuera del rango del negocio (lo rechaza el `CHECK` de rango); `becado = 'si'` intenta usar texto donde se espera el `BOOLEAN` simulado (`INTEGER` 0/1), y lo rechaza el `CHECK (becado IN (0,1))`.

## Como ejecutar

```bash
sqlite3 ejercicio-42.db < ddl/schema.sql
sqlite3 ejercicio-42.db < dml/inserts.sql
sqlite3 ejercicio-42.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
