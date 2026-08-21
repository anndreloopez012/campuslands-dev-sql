# Evidencias - Solicitudes SQL - Ejercicio 005 (Cine Horror Nights)

## Comandos ejecutados

```bash
sqlite3 ejercicio-005.db < ddl/schema.sql
sqlite3 ejercicio-005.db < dml/inserts.sql
sqlite3 ejercicio-005.db < dml/operaciones.sql
sqlite3 ejercicio-005.db < dql/consultas.sql
```

## Resultados

**1. Todos los boletos (ya con la entrada de prueba eliminada y el estado de Ana Gomez corregido):**

```text
id_boleto | id_pelicula | nombre_cliente   | asiento | precio_pagado | fecha_compra       | estado
1         | 1           | Ana Gomez         | A1      | 45.0          | 2026-08-15 19:00   | usado
2         | 1           | Luis Marroquin    | A2      | 45.0          | 2026-08-15 19:00   | vendido
3         | 2           | Karen Solis       | B1      | 45.0          | 2026-08-15 21:00   | vendido
4         | 3           | Diego Paz         | C1      | 40.0          | 2026-08-16 18:00   | vendido
5         | 4           | Rosa Chavez       | D1      | 50.0          | 2026-08-16 20:00   | vendido
6         | 1           | Ana Gomez         | A3      | 45.0          | 2026-08-15 19:00   | reembolsado
7         | 2           | Luis Marroquin    | B2      | 45.0          | 2026-08-15 21:00   | vendido
8         | 5           | Karen Solis       | E1      | 35.0          | 2026-08-17 17:00   | vendido
```

Quedan 8 boletos (empezaron 9, se elimino la entrada de prueba del `id_boleto = 9`).

**2. Boletos que ya no son una venta activa normal (usados o reembolsados):**

```text
id_boleto | id_pelicula | nombre_cliente | asiento | estado
1         | 1           | Ana Gomez       | A1      | usado
6         | 1           | Ana Gomez       | A3      | reembolsado
```

**3. Pelicula con mas boletos vendidos:**

```text
titulo                    | total_boletos
El Grito Final              | 3
Medianoche Sangrienta       | 2
El Legado Maldito           | 1
La Casa del Silencio        | 1
Posesion 13                 | 1
```

**4. Boletos ordenados por fecha de compra:** ver tabla completa arriba, ordenada de 2026-08-15 a 2026-08-17.

**5. Reporte para el cine: ingresos por pelicula (excluyendo reembolsos):**

```text
titulo                    | sala_asignada | ingresos | boletos_validos
El Grito Final              | Sala 1        | 90.0     | 2
Medianoche Sangrienta       | Sala 2        | 90.0     | 2
Posesion 13                 | Sala 3        | 50.0     | 1
La Casa del Silencio        | Sala 1        | 40.0     | 1
El Legado Maldito           | Sala 2        | 35.0     | 1
```

`El Grito Final` y `Medianoche Sangrienta` empatan como las de mayor ingreso (90.0 cada una); el reembolso del boleto A3 es justamente lo que evita que `El Grito Final` aparezca con 135.0 en vez de 90.0.

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO boletos (id_pelicula, nombre_cliente, asiento, precio_pagado) VALUES (1, 'Mario Paz', 'A1', 45.00);` → `UNIQUE constraint failed: boletos.id_pelicula, boletos.asiento` (el asiento A1 de la pelicula 1 ya estaba vendido).

## Operaciones de mantenimiento verificadas

- `UPDATE boletos SET estado = 'usado' WHERE id_boleto = 1 AND estado = 'vendido';` → el boleto de Ana Gomez paso de `vendido` a `usado`.
- `UPDATE peliculas SET precio_boleto = 30.00 WHERE id_pelicula = 5;` → el precio de `El Legado Maldito` bajo de 35.00 a 30.00 (promocion).
- `DELETE FROM boletos WHERE id_boleto = 9;` → la entrada de prueba desaparecio; el conteo final de boletos es 8, no 9.

## Aprendizaje

El `UNIQUE (id_pelicula, asiento)` es la pieza clave de este modelo: traduce literalmente la operacion diaria del cine ("no se puede vender el mismo asiento dos veces para la misma funcion") en una regla que SQLite hace cumplir sola, sin necesidad de que el cajero revise manualmente si el asiento ya esta ocupado. El reporte de ingresos (consulta 5) tambien muestra por que el estado del boleto importa para un reporte financiero real: si se sumaran los boletos `reembolsado` junto con los `vendido`/`usado`, el ingreso reportado seria mayor al dinero que realmente se quedo el cine. Filtrar por `estado <> 'reembolsado'` es lo que hace que el numero sea confiable.
