# Evidencias - Ejercicio 76

## Tema

UPDATE

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-76.db < ddl/schema.sql
sqlite3 ejercicio-76.db < dml/inserts.sql
sqlite3 ejercicio-76.db < dql/consultas.sql
```

## Resultados

Estado final de `rutas` tras `dml/inserts.sql` (6 inscripciones, 1
cancelada, con sus `UPDATE` de cupo correspondientes):

```text
id_ruta | nombre_ruta        | cupo_maximo | cupo_disponible
1        | Cumbre Extrema       | 3              | 1
2        | Sendero del Canon    | 5              | 3
3        | Ruta del Volcan      | 10             | 9
```

**Caso comentado verificado** (probado en el punto exacto de la
secuencia donde aparece comentado, justo despues de llenar Cumbre
Extrema con 3 inscripciones, cuando `cupo_disponible` ya esta en 0):

- `INSERT INTO inscripciones ...; UPDATE rutas SET cupo_disponible = cupo_disponible - 1 WHERE id_ruta = 1;` → `CHECK constraint failed: cupo_disponible >= 0`.

**4. Resumen: inscripciones por estado:**

```text
estado       total
activa        5
cancelada     1
```

**5. Reporte final del caso de negocio (nivel aplicado): cupo
guardado en la tabla vs. cupo calculado desde cero con las
inscripciones activas:**

```text
nombre_ruta        cupo_maximo | cupo_guardado | cupo_calculado
Cumbre Extrema        3            | 1                | 1
Ruta del Volcan        10           | 9                | 9
Sendero del Canon      5            | 3                | 3
```

Las tres rutas coinciden exactamente entre lo que quedo guardado por
los `UPDATE` y lo que se recalcula desde cero contando inscripciones
`activa`: los `UPDATE` de cupo cumplieron su proposito.

## Aprendizaje

Cada `UPDATE` de este ejercicio corrige un valor derivado
(`cupo_disponible`) a partir de un evento real (una inscripcion nueva
o una cancelacion), usando la propia columna como base
(`cupo_disponible ± 1`) en vez de recalcular todo desde cero cada vez.
El `CHECK (cupo_disponible >= 0)` actua como una red de seguridad: si
algun `UPDATE` intentara dejar mas inscritos que cupo disponible, la
base de datos lo rechaza en el momento, como se confirmo con el caso
comentado. La consulta 5 es la validacion final propia del nivel
aplicado: demuestra, con una subconsulta independiente, que la columna
mantenida a mano con `UPDATE` sigue siendo consistente con la realidad
de las inscripciones activas.
