# Evidencias - Solicitudes SQL - Ejercicio 015 (Laboratorio Quimico)

## Comandos ejecutados

```bash
sqlite3 ejercicio-015.db < ddl/schema.sql
sqlite3 ejercicio-015.db < dml/inserts.sql
sqlite3 ejercicio-015.db < dml/operaciones.sql
sqlite3 ejercicio-015.db < dql/consultas.sql
```

## Resultados

**1. Todas las muestras (ya con la de prueba eliminada y M-003 completada):**

```text
id_muestra | id_reactivo | codigo_muestra | fecha_analisis | resultado                        | estado
1          | 1           | M-001           | 2026-07-01       | Positivo - concentracion 4.2%     | completado
2          | 2           | M-002           | 2026-07-02       | Negativo                          | completado
3          | 3           | M-003           | 2026-07-03       | Positivo - concentracion 2.5%     | completado
4          | 1           | M-004           | 2026-07-04       | None                               | contaminada
5          | 4           | M-005           | 2026-07-05       | Positivo - concentracion 1.8%     | completado
6          | 5           | M-006           | 2026-07-06       | None                               | en_analisis
7          | 2           | M-007           | 2026-07-07       | Negativo                          | completado
8          | 3           | M-008           | 2026-07-08       | None                               | en_analisis
```

Quedan 8 muestras (empezaron 9, se elimino la entrada de prueba del `id_muestra = 9`).

**2. Muestras que no estan completadas todavia:**

```text
id_muestra | codigo_muestra | id_reactivo | fecha_analisis | estado
4          | M-004           | 1           | 2026-07-04       | contaminada
6          | M-006           | 5           | 2026-07-06       | en_analisis
8          | M-008           | 3           | 2026-07-08       | en_analisis
```

**3. Reactivo mas usado:**

```text
nombre_reactivo      | veces_usado
Acido Sulfurico         | 2
Hidroxido de Sodio       | 2
Etanol                   | 2
Cloruro de Sodio         | 1
Nitrato de Plata          | 1
```

**4. Muestras ordenadas por fecha de analisis:** ver tabla completa arriba, de 2026-07-01 a 2026-07-08.

**5. Muestras por estado (tasa de contaminacion del laboratorio):**

```text
estado         | total_muestras
completado       | 5
en_analisis       | 2
contaminada       | 1
```

De 8 muestras, 1 se contamino (12.5%), un dato util para que el laboratorio evalue sus procedimientos de manejo de muestras.

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO reactivos (nombre_reactivo, unidad_medida, stock_disponible) VALUES ('Oxigeno', 'kg', 20);` → `CHECK constraint failed: unidad_medida IN ('ml', 'g', 'mol', 'L')`.

## Operaciones de mantenimiento verificadas

- `UPDATE muestras SET estado = 'completado', resultado = 'Positivo - concentracion 2.5%' WHERE id_muestra = 3 AND estado = 'en_analisis';` → la muestra M-003 paso de `en_analisis` a `completado`, con su resultado registrado.
- `UPDATE reactivos SET stock_disponible = stock_disponible - 50 WHERE id_reactivo = 1;` → el stock de Acido Sulfurico bajo de 500 a 450.
- `DELETE FROM muestras WHERE id_muestra = 9;` → la muestra de prueba desaparecio; el conteo final es 8, no 9.

## Aprendizaje

Traducir la operacion diaria de un laboratorio (sin que el cliente hable en terminos de tablas) significo identificar que "una muestra" es siempre lo mismo, sin importar si su resultado es positivo, negativo o si se contamino: por eso una sola tabla `muestras` con `resultado` opcional (NULL mientras esta en analisis) y `estado` controlado por `CHECK` cubre los tres casos. Dejar `resultado` sin `NOT NULL` es una decision deliberada: forzar un valor ahi habria obligado a inventar un resultado falso para las muestras que legítimamente todavia no lo tienen.
