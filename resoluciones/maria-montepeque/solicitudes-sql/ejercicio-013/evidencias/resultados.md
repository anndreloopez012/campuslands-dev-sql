# Evidencias - Solicitudes SQL - Ejercicio 013 (Clinica de Tatuajes)

## Comandos ejecutados

```bash
sqlite3 ejercicio-013.db < ddl/schema.sql
sqlite3 ejercicio-013.db < dml/inserts.sql
sqlite3 ejercicio-013.db < dml/operaciones.sql
sqlite3 ejercicio-013.db < dql/consultas.sql
```

## Resultados

**1. Todas las sesiones (ya con la de prueba eliminada y la de Karen Solis con Ingrid Say completada):**

```text
id_sesion | id_artista | nombre_cliente   | fecha_sesion | monto_pagado | estado
1         | 1          | Ana Gomez         | 2026-07-01    | 1200.0        | completada
2         | 2          | Luis Marroquin    | 2026-07-03    | 800.0         | completada
3         | 3          | Karen Solis       | 2026-07-05    | 950.0         | completada
4         | 1          | Diego Paz         | 2026-07-08    | 1500.0        | completada
5         | 4          | Rosa Mendez       | 2026-07-10    | 650.0         | cancelada
6         | 5          | Julio Perez       | 2026-07-12    | 400.0         | completada
7         | 1          | Ana Gomez         | 2026-07-15    | 1200.0        | agendada
8         | 2          | Karen Solis       | 2026-07-18    | 800.0         | completada
```

Quedan 8 sesiones (empezaron 9, se elimino la entrada de prueba del `id_sesion = 9`).

**2. Sesiones que no estan completadas todavia:**

```text
id_sesion | nombre_cliente | fecha_sesion | estado
5         | Rosa Mendez     | 2026-07-10    | cancelada
7         | Ana Gomez       | 2026-07-15    | agendada
```

**3. Artista con mas sesiones completadas:**

```text
nombre_artista   | sesiones_completadas
Karla Diaz         | 2
Julio Perez         | 2
Ingrid Say          | 1
Rosa Chavez         | 1
```

**4. Sesiones ordenadas por fecha:** ver tabla completa arriba, de 2026-07-01 a 2026-07-18.

**5. Ingresos generados por artista (solo sesiones completadas):**

```text
nombre_artista   | estilo_principal | ingresos_generados
Karla Diaz         | realismo          | 2700.0
Julio Perez         | tradicional       | 1600.0
Ingrid Say          | blackwork         | 950.0
Rosa Chavez         | minimalista       | 400.0
```

Karla Diaz genera el mayor ingreso a pesar de tener el mismo numero de sesiones completadas que Julio Perez, porque sus sesiones tienen un monto mas alto.

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO sesiones (..., monto_pagado) VALUES (..., 0);` → `CHECK constraint failed: monto_pagado > 0`.

## Operaciones de mantenimiento verificadas

- `UPDATE sesiones SET estado = 'completada' WHERE id_sesion = 3 AND estado = 'agendada';` → la sesion de Karen Solis con Ingrid Say paso de `agendada` a `completada`.
- `UPDATE artistas SET estilo_principal = 'realismo' WHERE id_artista = 4;` → Mario Ixtabalan cambio de `acuarela` a `realismo`.
- `DELETE FROM sesiones WHERE id_sesion = 9;` → la entrada de prueba desaparecio; el conteo final de sesiones es 8, no 9.

## Aprendizaje

Evitar registros incompletos (lo que pidio el cliente) no es solo poner `NOT NULL` en todo: es identificar cuales campos son indispensables para que un reporte tenga sentido. Aqui `monto_pagado` es el ejemplo mas claro: si pudiera quedar vacio, el reporte de ingresos por artista (consulta 5) daria un `SUM` incompleto sin ningun error visible, y el estudio tomaria decisiones de comision con datos incorrectos. Por eso `monto_pagado`, `nombre_cliente` y `fecha_sesion` son `NOT NULL` en `sesiones`: son exactamente los datos que un reporte confiable necesita que siempre existan.
