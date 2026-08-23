# Ejercicio 58: CHECK Nivel Aplicado

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-17

## Tema central

CHECK

## Descripcion del problema

Sistema de registro de campers inscritos en rutas de entrenamiento: `campers`, `rutas` e `inscripciones` (tabla principal). El caso de negocio requiere un reporte final de cupo por ruta y una regla que garantice que una calificacion solo pueda existir si la inscripcion realmente se completo.

## Que aprendi sobre CHECK

- **CHECK puede combinar varias columnas en una sola regla de negocio**: `inscripciones` tiene `CHECK (calificacion_final IS NULL OR estado = 'completada')`, que impide asignar una calificacion a una inscripcion que sigue `activa` o que fue `cancelada`. Esta es la parte mas util del ejercicio: el rango numerico (`BETWEEN 0 AND 100`) valida el valor de `calificacion_final`, pero esta segunda regla valida *cuando* ese valor tiene sentido de existir.
- **Un reporte de negocio confiable depende de que las reglas de dominio se hayan cumplido desde el `INSERT`**: el reporte de cupo por ruta (consulta 4) cuenta inscripciones `activa`/`completada` como cupo ocupado; si `estado` hubiera aceptado cualquier texto, el reporte no sabria que contar. Gracias al `CHECK (estado IN (...))`, el reporte es confiable sin validaciones extra.
- **El mismo patron de "valores permitidos" y "rango numerico" se repite en las tres tablas**: `campers.nivel`, `rutas.dificultad` e `inscripciones.estado` usan `IN (...)`; `rutas.cupo_maximo` e `inscripciones.calificacion_final` usan comparaciones numericas. Aplicar la misma tecnica en varias tablas del mismo modelo confirma que `CHECK` es una herramienta general, no un caso especial de una sola columna.
- El reporte final (consulta 4) muestra que `Ruta del Volcan` y `Sendero del Canon` llegaron a su cupo maximo mientras `Cumbre Extrema` todavia tiene espacio; la inscripcion `cancelada` de esa ultima ruta correctamente no cuenta como cupo ocupado.
- Los cuatro casos comentados prueban cada `CHECK` por separado (nivel invalido, cupo en cero, calificacion fuera de rango, calificacion sin estado completada) y los cuatro fallan con `CHECK constraint failed` mostrando la condicion exacta violada.

## Como ejecutar

```bash
sqlite3 ejercicio-58.db < ddl/schema.sql
sqlite3 ejercicio-58.db < dml/inserts.sql
sqlite3 ejercicio-58.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
