# Evidencias - Ejercicio 106

## Tema

Triggers

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-106.db < ddl/schema.sql
sqlite3 ejercicio-106.db < dml/inserts.sql
sqlite3 ejercicio-106.db < dql/consultas.sql
```

## Resultados

**4. Total de partidas por equipo (despues del DELETE de Halcones):**

```text
id_equipo   total_partidas
1             2
3             2
```

(El equipo 2, "Halcones Nocturnos", ya no aparece: se elimino su
unica partida.)

**5. Reporte de negocio: tabla de posiciones (puntaje_total vs SUM real):**

```text
nombre_equipo         puntaje_total   puntaje_calculado
Dragones Digitales         190              190
Fenix Cibernetico           120              120
Halcones Nocturnos            0                0
```

Verificacion manual: Dragones Digitales jugo 2 partidas (100 + 90,
tras la correccion del UPDATE) = 190; Fenix Cibernetico jugo 2
partidas (70 + 50) = 120; Halcones Nocturnos se quedo sin partidas
tras el DELETE, total 0. Los 3 equipos tienen `puntaje_total`
identico a `puntaje_calculado`, confirmando que los 3 triggers
mantuvieron la columna sincronizada durante toda la secuencia de
INSERT, UPDATE y DELETE.

**Caso comentado verificado (CHECK):**

- `INSERT INTO partidas (..., puntaje, ...) VALUES (1, -10, '2026-08-14', 'derrota');` → `CHECK constraint failed: puntaje >= 0`.

**Caso comentado verificado (UPDATE manual desincroniza puntaje_total):**

```text
UPDATE equipos SET puntaje_total = 9999 WHERE id_equipo = 1;
```

→ se ejecuta sin ningun error. Al comparar de nuevo contra el `SUM`
real:

```text
nombre_equipo         puntaje_total   puntaje_calculado
Dragones Digitales          9999             190
```

`puntaje_total` (9999) ya no coincide con el `SUM(puntaje)` real de
las partidas de "Dragones Digitales" (190): el `UPDATE` manual
bypaseo por completo la logica de los 3 triggers.

## Aprendizaje

Los triggers permiten mantener una columna desnormalizada (una copia
calculada, como `puntaje_total`) sincronizada automaticamente ante
cada evento relevante de la tabla de origen (`INSERT`, `UPDATE` y
`DELETE` sobre `partidas`), evitando recalcular un `SUM` completo cada
vez que se necesita el dato. Pero esa sincronizacion solo funciona si
TODOS los cambios pasan por el camino que los triggers vigilan: nada
impide, a nivel de motor, que alguien escriba directamente sobre la
columna desnormalizada (`equipos.puntaje_total`) sin tocar
`partidas`, y en ese caso el valor guardado deja de reflejar la
realidad sin que SQL avise de ningun error. Por eso una columna
mantenida por triggers necesita, ademas, disciplina en el equipo de
desarrollo (o restricciones adicionales, como permisos, si el motor
las soporta) para que nadie la modifique por otra via.
