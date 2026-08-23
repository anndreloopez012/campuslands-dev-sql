# Ejercicio 52: UNIQUE Nivel Aplicado

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-17

## Tema central

UNIQUE

## Descripcion del problema

Sistema de un torneo de videojuegos: `equipos`, `jugadores` y `partidas`. Nivel aplicado: cierra la serie de UNIQUE (50 simple con NULL, 51 compuesto) agregando una tecnica mas avanzada — un **indice unico por expresion** — y un reporte final de negocio (tabla de posiciones).

## Tablas y relaciones

- `equipos`: catalogo de equipos, con `nombre` `UNIQUE` (simple).
- `jugadores`: catalogo de jugadores. `nickname` esta protegido por un **indice unico sobre `LOWER(nickname)`**, no por un `UNIQUE` de columna. `equipos` 1—N `jugadores`.
- `partidas`: cada enfrentamiento. `UNIQUE (equipo_local, equipo_visitante, fecha_partida)` (compuesto), mas `CHECK (equipo_local <> equipo_visitante)`.

## Que aprendi sobre UNIQUE

- **UNIQUE tambien se puede aplicar sobre una expresion, no solo sobre una columna tal cual**: `CREATE UNIQUE INDEX idx_jugadores_nickname_lower ON jugadores (LOWER(nickname));` hace que la unicidad se evalue sobre el nickname normalizado a minusculas. Con un `UNIQUE (nickname)` comun, `"RedDragon"` y `"reddragon"` se habrian aceptado como dos nicknames distintos (son cadenas de texto diferentes); con el indice por expresion, chocan entre si porque ambos normalizan al mismo valor. Lo verifique intentando registrar `'reddragon'` cuando ya existia `'RedDragon'`, y fallo con `UNIQUE constraint failed: index 'idx_jugadores_nickname_lower'`.
- **El UNIQUE compuesto sigue siendo la herramienta correcta para evitar registros de negocio duplicados**: `partidas` no deja registrar el mismo enfrentamiento (mismo local, mismo visitante, misma fecha) dos veces, retomando el concepto del ejercicio 51 en un contexto distinto.
- **Verificacion con datos, no solo con el caso que falla**: la consulta 5.a compara `COUNT(*)` de jugadores contra `COUNT(DISTINCT LOWER(nickname))` (6 y 6, coinciden), confirmando que no hay ningun nickname "casi duplicado" en los datos cargados. La consulta 5.b confirma lo mismo para las partidas, con `HAVING COUNT(*) > 1` devolviendo cero filas.
- El reporte final (tabla de posiciones) demuestra que estas restricciones `UNIQUE` no estorban un caso de negocio real: cada partida se cuenta una sola vez, tanto de local como de visitante, sin duplicados que distorsionen el conteo de victorias.

## Como ejecutar

```bash
sqlite3 ejercicio-52.db < ddl/schema.sql
sqlite3 ejercicio-52.db < dml/inserts.sql
sqlite3 ejercicio-52.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
