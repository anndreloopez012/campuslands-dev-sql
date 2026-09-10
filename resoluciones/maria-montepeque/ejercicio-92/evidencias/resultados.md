# Evidencias - Ejercicio 92

## Tema

HAVING

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-92.db < ddl/schema.sql
sqlite3 ejercicio-92.db < dml/inserts.sql
sqlite3 ejercicio-92.db < dql/consultas.sql
```

## Resultados

**4. Total de partidas por equipo:**

```text
id_equipo   total_partidas
1             4
2             2
3             3
4             1
```

**5. Equipos con 2 o mas victorias (HAVING):**

```text
nombre_equipo         total_victorias
Dragones Digitales          3
Fenix Cibernetico            2
```

Verificacion manual: Dragones Digitales gano 3 de sus 4 partidas,
Fenix Cibernetico gano 2 de sus 3 partidas. Halcones Nocturnos gano
solo 1 de 2 y Titanes de Acero gano 0 de 1, por lo que ambos quedan
por debajo del umbral y no aparecen en el resultado.

**Caso comentado verificado (CHECK):**

- `INSERT INTO partidas (..., resultado) VALUES (1, '2026-08-11', 'sabotaje');` → `CHECK constraint failed: resultado IN ('victoria', 'derrota', 'empate', 'pendiente')`.

**Caso comentado verificado (HAVING con columna no agrupada):**

```text
SELECT id_equipo, COUNT(*) AS total_partidas
FROM partidas
GROUP BY id_equipo
HAVING resultado = 'victoria';
```

```text
id_equipo   total_partidas
1             4
2             2
3             3
```

No hay error, pero el resultado es incorrecto: se esperaba contar
solo victorias (3, 1 y 2 para los equipos 1, 2 y 3), y en cambio se
devuelve el total de partidas de cada equipo (4, 2 y 3), porque
`COUNT(*)` no filtro nada, y el equipo 4 solo se excluyo porque su
primera partida registrada resulto ser 'derrota'.

## Aprendizaje

`HAVING` filtra los grupos que ya formo `GROUP BY`, evaluando el
resultado de funciones de agregacion como `COUNT()`; por eso puede
comparar contra un valor agregado (`COUNT(*) >= 2`) donde `WHERE` no
podria. Pero `HAVING` no reemplaza a `WHERE`: si se necesita contar
solo cierto tipo de filas (por ejemplo, solo las victorias), ese
filtro debe ir en `WHERE` antes del `GROUP BY`, para que la agregacion
se calcule sobre las filas correctas. Usar en `HAVING` una columna que
no esta ni agregada ni en el `GROUP BY` no produce un error en
SQLite, pero el valor que compara es arbitrario y el resultado final
puede ser incorrecto sin que nada lo advierta.
