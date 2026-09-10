# Evidencias - Ejercicio 94

## Tema

HAVING

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-94.db < ddl/schema.sql
sqlite3 ejercicio-94.db < dml/inserts.sql
sqlite3 ejercicio-94.db < dql/consultas.sql
```

## Resultados

**4. Total de inscripciones por ruta (sin distinguir estado):**

```text
id_ruta   nombre_ruta             total_inscripciones
1           Ruta Backend Nivel 1        4
2           Ruta Frontend Nivel 1       4
3           Ruta DevOps Nivel 2         3
```

**5. Reporte de negocio: rutas en sobrecupo real (HAVING sobre inscripciones activas):**

```text
nombre_ruta             cupo_maximo   inscritos_activos
Ruta Backend Nivel 1         3               4
Ruta DevOps Nivel 2          2               3
```

Verificacion manual: Ruta Backend Nivel 1 tiene 4 inscripciones y las
4 estan activas (4 > cupo 3, sobrecupo real). Ruta Frontend Nivel 1
tiene 4 inscripciones pero solo 2 activas (2 <= cupo 3, sin sobrecupo
real; las otras 2 son un retiro y una ruta completada). Ruta DevOps
Nivel 2 tiene 3 inscripciones, las 3 activas (3 > cupo 2, sobrecupo
real).

**Caso comentado verificado (CHECK):**

- `INSERT INTO inscripciones (..., estado) VALUES (1, 1, '2026-08-07', 'suspendido');` → `CHECK constraint failed: estado IN ('activo', 'retirado', 'completado')`.

**Caso comentado verificado (sobrecupo sin filtrar por estado activo):**

```text
SELECT r.nombre_ruta, r.cupo_maximo, COUNT(*) AS total_inscripciones
FROM inscripciones i
JOIN rutas r ON r.id_ruta = i.id_ruta
GROUP BY r.id_ruta, r.nombre_ruta, r.cupo_maximo
HAVING COUNT(*) > r.cupo_maximo;
```

```text
nombre_ruta             cupo_maximo   total_inscripciones
Ruta Backend Nivel 1         3               4
Ruta Frontend Nivel 1        3               4
Ruta DevOps Nivel 2          2               3
```

Sin error, pero el resultado es incorrecto para el negocio: incluye a
"Ruta Frontend Nivel 1" como sobrecupada, cuando en realidad tiene
cupo disponible (solo 2 de sus 4 inscripciones estan activas). La
consulta 5, que filtra con `WHERE estado = 'activo'` antes de agrupar
y contar, es la que refleja el sobrecupo real.

## Aprendizaje

`HAVING` filtra los grupos que arma `GROUP BY` evaluando un valor
agregado (`COUNT(*)` en este caso), y puede compararse contra otra
columna del grupo que sea funcionalmente dependiente, como
`r.cupo_maximo`. Pero el resultado de `HAVING` solo es tan correcto
como las filas que llegaron a agruparse: si primero no se filtra con
`WHERE` las filas relevantes para el caso de negocio (aqui, solo las
inscripciones `activo`), el `COUNT(*)` agrupado incluye datos que no
deberian contar (retiros, inscripciones completadas), y `HAVING`
termina filtrando sobre un total inflado que produce conclusiones de
negocio equivocadas sin que SQL avise de ningun error.
