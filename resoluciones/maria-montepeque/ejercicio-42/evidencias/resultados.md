# Evidencias - Ejercicio 42

## Tema

Tipos de datos

## Comandos ejecutados

```bash
sqlite3 ejercicio-42.db < ddl/schema.sql
sqlite3 ejercicio-42.db < dml/inserts.sql
sqlite3 ejercicio-42.db < dql/consultas.sql
```

## Resultados

**2. Campers becados** (BOOLEAN simulado, `WHERE becado = 1`):

```text
nombre               | correo                          | fecha_nacimiento
Manuel Estrada       | manuel.estrada@correo.com        | 2001-03-15
Cristina Barrios     | cristina.barrios@correo.com      | 2002-01-30
```

**3. Notas ordenadas** (REAL, excluyendo NULL con `WHERE nota_final IS NOT NULL`):

```text
ruta                    | nota_final
Desarrollo Web          | 92.0
Infraestructura Cloud   | 88.0
Ciencia de Datos        | 78.5
Ciberseguridad          | 55.0
```

**4. Resumen** (`AVG(nota_final)` ignora automaticamente los NULL: promedia solo las 4 inscripciones finalizadas, no las 7 totales):

```text
total_inscripciones | aprobados | no_aprobados | promedio_notas
7                    | 3         | 4            | 78.38
```

**5.a Fechas de nacimiento** (DATE simulado, orden alfabetico = orden cronologico):

```text
nombre                | fecha_nacimiento
Alejandra Chinchilla  | 2000-07-22
Douglas Pineda        | 2000-09-12
Manuel Estrada        | 2001-03-15
Cristina Barrios      | 2002-01-30
```

**5.b Estado de curso derivado del REAL nullable:**

```text
camper                | ruta                    | estado_curso | aprobado
Manuel Estrada        | Desarrollo Web          | Finalizado   | 1
Alejandra Chinchilla  | Ciencia de Datos        | Finalizado   | 1
Byron Xicay           | Desarrollo Web          | En curso     | 0
Cristina Barrios      | Infraestructura Cloud   | Finalizado   | 1
Douglas Pineda        | Ciberseguridad          | Finalizado   | 0
Manuel Estrada        | Ciencia de Datos        | En curso     | 0
Alejandra Chinchilla  | Infraestructura Cloud   | En curso     | 0
```

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- `INSERT INTO inscripciones (... nota_final ...) VALUES (..., 150.0, ...);` → `CHECK constraint failed: nota_final IS NULL OR (nota_final >= 0 AND nota_final <= 100)`.
- `INSERT INTO campers (... becado) VALUES (..., 'si');` → `CHECK constraint failed: becado IN (0, 1)`.

## Aprendizaje

Este ejercicio agrego un matiz importante frente al 41: un tipo de dato correcto (`REAL`) puede ademas necesitar aceptar `NULL` quando el valor todavia no existe (nota de un curso en progreso), sin que eso se confunda con un valor real como `0`. El `CHECK` se escribio para permitir explicitamente `NULL` y, al mismo tiempo, seguir validando el rango cuando si hay dato. Combinado con que `AVG()`/`COUNT()` ignoran `NULL` de forma nativa, el modelo refleja fielmente la realidad del negocio (cursos en progreso vs. finalizados) sin necesidad de un valor centinela artificial como `-1` o `0`.
