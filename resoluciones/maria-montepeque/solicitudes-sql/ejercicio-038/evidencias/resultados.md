# Evidencias - Solicitudes SQL - Ejercicio 038 (Clinica de Tatuajes)

## Comandos ejecutados

```bash
sqlite3 ejercicio-038.db < ddl/schema.sql
sqlite3 ejercicio-038.db < dml/inserts.sql
sqlite3 ejercicio-038.db < dml/operaciones.sql
sqlite3 ejercicio-038.db < dql/consultas.sql
```

## Resultados

**1. Todas las sesiones, con JOIN doble a clientes y artistas (ya sin la duplicada, con la sesion 4 completada y pagada y el saldo de la sesion 3 saldado):**

```text
id_sesion | nombre_cliente   | nombre_artista  | fecha_sesion | costo_total | monto_pagado | estado
1         | Cesar Molina     | Karla Fong      | 2026-08-01    | 1500.0       | 1500.0        | completada
2         | Andrea Recinos   | Mateo Solis     | 2026-08-03    | 800.0        | 800.0         | completada
3         | Josue Batz       | Karla Fong      | 2026-08-05    | 2000.0       | 2000.0        | completada
4         | Cesar Molina     | Karla Fong      | 2026-08-08    | 600.0        | 600.0         | completada
5         | Melany Choc      | Ximena Ac       | 2026-08-10    | 1800.0       | 900.0         | completada
6         | Ronald Pineda    | Douglas Perez   | 2026-08-12    | 400.0        | 400.0         | completada
7         | Andrea Recinos   | Valeria Tum     | 2026-08-14    | 2200.0       | 0.0           | cancelada
8         | Josue Batz       | Mateo Solis     | 2026-08-16    | 900.0        | 300.0         | agendada
9         | Cesar Molina     | Karla Fong      | 2026-08-18    | 500.0        | 500.0         | completada
```

Quedan 9 sesiones (empezaron 10, se elimino la duplicada del `id_sesion = 10`).

**2. Sesiones que no estan completadas todavia:**

```text
id_sesion | id_cliente | id_artista | fecha_sesion | estado
7         | 2          | 5          | 2026-08-14    | cancelada
8         | 3          | 2          | 2026-08-16    | agendada
```

**3. Ranking de artistas por total de sesiones:**

```text
nombre_artista  | total_sesiones
Karla Fong      | 4
Mateo Solis     | 2
Douglas Perez   | 1
Valeria Tum     | 1
Ximena Ac       | 1
```

**4. Sesiones ordenadas por fecha:** ver tabla completa arriba, de 2026-08-01 a 2026-08-18.

**5. Sesiones con saldo pendiente de pago (casos pendientes que hay que cobrar, sin contar canceladas):**

```text
nombre_cliente | nombre_artista | fecha_sesion | saldo_pendiente
Melany Choc    | Ximena Ac      | 2026-08-10    | 900.0
Josue Batz     | Mateo Solis    | 2026-08-16    | 600.0
```

La sesion cancelada de Andrea Recinos (id_sesion = 7, costo 2200.0 sin pagar) no aparece aqui porque un servicio cancelado no genera cobro pendiente.

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO sesiones (..., costo_total, monto_pagado) VALUES (..., 500.00, 600.00);` → `CHECK constraint failed: monto_pagado >= 0 AND monto_pagado <= costo_total`.

## Operaciones de mantenimiento verificadas

- `UPDATE sesiones SET estado = 'completada', monto_pagado = 600.00 WHERE id_sesion = 4 AND estado = 'agendada';` → la segunda sesion de Cesar Molina con Karla Fong quedo `completada` y pagada por completo.
- `UPDATE sesiones SET monto_pagado = 2000.00 WHERE id_sesion = 3;` → Josue Batz termino de pagar su sesion con Karla Fong (de 1000.0 a 2000.0).
- `DELETE FROM sesiones WHERE id_sesion = 10;` → la sesion duplicada desaparecio; el conteo final es 9, no 10.

## Aprendizaje

Guardar `costo_total` y `monto_pagado` como columnas reales (no como texto o notas sueltas) es lo que le permite al estudio pedir directamente el reporte de "casos pendientes" (consulta 5) sin calcular nada a mano: la resta `costo_total - monto_pagado` y el filtro por `estado` hacen el trabajo. El `CHECK` que impide pagar mas del costo total protege ese calculo de errores de captura que dejarian saldos negativos sin sentido.
