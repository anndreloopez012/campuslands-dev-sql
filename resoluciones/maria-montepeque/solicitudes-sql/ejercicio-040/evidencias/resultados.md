# Evidencias - Solicitudes SQL - Ejercicio 040 (Laboratorio Quimico)

## Comandos ejecutados

```bash
sqlite3 ejercicio-040.db < ddl/schema.sql
sqlite3 ejercicio-040.db < dml/inserts.sql
sqlite3 ejercicio-040.db < dml/operaciones.sql
sqlite3 ejercicio-040.db < dql/consultas.sql
```

## Resultados

**1. Todas las muestras, con JOIN doble a formulas y reactivos (ya sin la duplicada, con la muestra 4 valida y la muestra 5 marcada para repetir):**

```text
id_muestra | nombre_formula      | nombre_reactivo      | fecha_analisis | concentracion | resultado
1          | Compuesto Alfa-7    | Acido Sulfurico       | 2026-08-01      | 85.5           | valido
2          | Solucion Beta-12    | Hidroxido de Sodio    | 2026-08-02      | 42.0           | valido
3          | Compuesto Alfa-7    | Cloruro de Sodio      | 2026-08-03      | 95.2           | valido
4          | Mezcla Gamma-3      | Etanol                | 2026-08-04      | 12.8           | valido
5          | Compuesto Alfa-7    | Hidroxido de Sodio    | 2026-08-05      | 5.5            | repetir
6          | Compuesto Delta-9   | Acido Sulfurico       | 2026-08-06      | 60.0           | valido
7          | Compuesto Alfa-7    | Etanol                | 2026-08-07      | 3.2            | invalido
8          | Solucion Epsilon-5  | Sulfato de Cobre      | 2026-08-08      | 77.0           | pendiente
9          | Solucion Beta-12    | Cloruro de Sodio      | 2026-08-09      | 50.0           | valido
```

Quedan 9 muestras (empezaron 10, se elimino la duplicada del `id_muestra = 10`).

**2. Muestras que todavia no tienen un resultado valido:**

```text
id_muestra | id_formula | id_reactivo | fecha_analisis | resultado
5          | 1          | 2           | 2026-08-05      | repetir
7          | 1          | 4           | 2026-08-07      | invalido
8          | 5          | 5           | 2026-08-08      | pendiente
```

**3. Formula con mas muestras analizadas:**

```text
nombre_formula      | total_muestras
Compuesto Alfa-7    | 4
Solucion Beta-12    | 2
Compuesto Delta-9   | 1
Mezcla Gamma-3       | 1
Solucion Epsilon-5   | 1
```

**4. Muestras ordenadas por fecha:** ver tabla completa arriba, de 2026-08-01 a 2026-08-09.

**5. Formula que acumula mas muestras invalidas o por repetir, para decidir cual revisar con prioridad:**

```text
nombre_formula   | muestras_problema
Compuesto Alfa-7 | 2
```

Compuesto Alfa-7 es a la vez la formula con mas muestras analizadas (consulta 3) y la unica con problemas de calidad acumulados: es la candidata clara para una revision de proceso.

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que cada uno falla, uno por cada tipo de error que pidio detectar el cliente):

- Registro repetido: `INSERT INTO formulas (nombre_formula, ...) VALUES ('Compuesto Alfa-7', ...);` → `UNIQUE constraint failed: formulas.nombre_formula`.
- Relacion invalida: `INSERT INTO muestras (id_formula, ...) VALUES (99, ...);` → `FOREIGN KEY constraint failed`.
- Valor fuera de rango: `INSERT INTO muestras (..., concentracion) VALUES (..., 150.0);` → `CHECK constraint failed: concentracion > 0 AND concentracion <= 100`.

## Operaciones de mantenimiento verificadas

- `UPDATE muestras SET resultado = 'valido' WHERE id_muestra = 4 AND resultado = 'pendiente';` → la muestra de Mezcla Gamma-3 paso de `pendiente` a `valido`.
- `UPDATE muestras SET resultado = 'repetir' WHERE id_muestra = 5;` → la muestra de Compuesto Alfa-7 se reclasifico de `invalido` a `repetir`.
- `DELETE FROM muestras WHERE id_muestra = 10;` → la muestra duplicada desaparecio; el conteo final es 9, no 10.

## Aprendizaje

Los tres errores que preocupaban al cliente (repetidos, relaciones invalidas, valores fuera de rango) no se detectan revisando reportes despues: se bloquean en el momento del `INSERT` gracias a `UNIQUE`, `FOREIGN KEY` y `CHECK`. Eso convierte a la base de datos en la primera linea de control de calidad del laboratorio, antes de que un dato malo llegue a un reporte.
