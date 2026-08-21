# Ejercicio 56: CHECK Nivel Basico

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-17

## Tema central

CHECK

## Descripcion del problema

Sistema de torneo de videojuegos con `equipos`, `jugadores` y `partidas` (tabla principal). El ejercicio se enfoca en usar `CHECK` para tres tipos de regla de dominio distintos: valores permitidos, rangos numericos y una regla de negocio entre columnas de una misma fila.

## Que aprendi sobre CHECK

- **CHECK con `IN (...)` restringe una columna a una lista cerrada de valores permitidos**: `equipos.region` solo acepta `'Norteamerica'`, `'Sudamerica'`, `'Europa'` o `'Asia'`; cualquier otro valor (por ejemplo `'Antartida'`) es rechazado.
- **CHECK con comparaciones numericas valida rangos**: `jugadores.edad` debe estar entre 14 y 45 (`BETWEEN`), y `partidas.puntaje_local`/`puntaje_visitante` no pueden ser negativos (`>= 0`). Ambos son reglas del negocio, no del tipo de dato: `INTEGER` por si solo permitiria -1 o 200 igual de bien.
- **CHECK tambien puede vivir a nivel de tabla y comparar varias columnas**: agregue `CHECK (id_equipo_local <> id_equipo_visitante)` en `partidas` para impedir que un equipo aparezca jugando contra si mismo. Esta regla no depende de una sola columna, sino de la relacion entre dos columnas de la misma fila.
- Confirme cada regla con datos: la consulta 5.a muestra que el minimo de los puntajes registrados en partidas `jugada` es 0 (nunca negativo), y la 5.b cuenta cuantas partidas tienen el mismo equipo como local y visitante (0, la regla nunca se violo).
- Los cuatro casos comentados prueban cada `CHECK` por separado (region invalida, edad fuera de rango, puntaje negativo, equipo contra si mismo) y los cuatro fallan con `CHECK constraint failed` mostrando exactamente la condicion violada.

## Como ejecutar

```bash
sqlite3 ejercicio-56.db < ddl/schema.sql
sqlite3 ejercicio-56.db < dml/inserts.sql
sqlite3 ejercicio-56.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
