# Evidencias - Ejercicio 58

## Tema

CHECK

## Comandos ejecutados

```bash
sqlite3 ejercicio-58.db < ddl/schema.sql
sqlite3 ejercicio-58.db < dml/inserts.sql
sqlite3 ejercicio-58.db < dql/consultas.sql
```

## Resultados

**4. Reporte final del caso de negocio: cupo ocupado y disponible por ruta:**

```text
nombre_ruta       | cupo_maximo | cupo_ocupado | cupo_disponible
Cumbre Extrema     | 4           | 1            | 3
Ruta del Volcan    | 2           | 2            | 0
Sendero del Canon  | 3           | 3            | 0
```

`Ruta del Volcan` y `Sendero del Canon` quedan con cupo lleno; `Cumbre Extrema` todavia tiene espacio. La inscripcion cancelada de `Cumbre Extrema` no cuenta como cupo ocupado.

**5.a Rango numerico: toda calificacion_final registrada esta entre 0 y 100:**

```text
calificacion_minima | calificacion_maxima
78                    | 92
```

**5.b Regla de negocio entre columnas: ninguna inscripcion tiene calificacion sin estar completada:**

```text
inscripciones_invalidas
0
```

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- `INSERT INTO campers (..., nivel) VALUES (..., 'experto');` → `CHECK constraint failed: nivel IN ('principiante', 'intermedio', 'avanzado')`.
- `INSERT INTO rutas (..., cupo_maximo) VALUES (..., 0);` → `CHECK constraint failed: cupo_maximo > 0`.
- `INSERT INTO inscripciones (..., calificacion_final) VALUES (..., 150);` → `CHECK constraint failed: calificacion_final BETWEEN 0 AND 100`.
- `INSERT INTO inscripciones (..., estado, calificacion_final) VALUES (..., 'activa', 90);` → `CHECK constraint failed: calificacion_final IS NULL OR estado = 'completada'`.

## Aprendizaje

En un caso de negocio aplicado, `CHECK` no solo valida columnas por separado: tambien puede imponer una regla que relaciona dos columnas de la misma fila. `CHECK (calificacion_final IS NULL OR estado = 'completada')` en `inscripciones` garantiza que nunca exista una calificacion "huerfana" en una inscripcion que todavia esta `activa` o que fue `cancelada`; sin esa regla, el reporte de cupo (consulta 4) podria mezclar datos inconsistentes y nadie lo notaria hasta revisar caso por caso. Confirmar la regla con `COUNT(*)` sobre inscripciones que la violan (consulta 5.b, resultado 0) es la forma mas directa de probar que el `CHECK` cumplio su proposito con datos reales, no solo en la definicion de la tabla.
