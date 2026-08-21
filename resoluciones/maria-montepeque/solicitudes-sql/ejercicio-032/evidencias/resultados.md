# Evidencias - Solicitudes SQL - Ejercicio 032 (Academia Kickboxing)

## Comandos ejecutados

```bash
sqlite3 ejercicio-032.db < ddl/schema.sql
sqlite3 ejercicio-032.db < dml/inserts.sql
sqlite3 ejercicio-032.db < dml/operaciones.sql
sqlite3 ejercicio-032.db < dql/consultas.sql
```

## Resultados

**1. Todos los pagos, con JOIN a alumnos (ya sin la duplicada y con la transferencia de Carlos Ruiz confirmada):**

```text
id_pago | nombre_completo | monto_pagado | fecha_pago        | metodo_pago     | estado
1       | Andres Lopez      | 250.0         | 2026-08-01 09:00   | efectivo         | confirmado
2       | Marta Vega        | 350.0         | 2026-08-01 10:00   | tarjeta          | confirmado
3       | Carlos Ruiz       | 480.0         | 2026-08-02 09:30   | transferencia    | confirmado
4       | Diana Cruz        | 250.0         | 2026-08-02 11:00   | efectivo         | confirmado
5       | Pedro Gomez       | 700.0         | 2026-08-03 09:00   | tarjeta          | confirmado
6       | Andres Lopez      | 250.0         | 2026-09-01 09:00   | efectivo         | confirmado
7       | Marta Vega        | 350.0         | 2026-09-01 10:00   | tarjeta          | rechazado
8       | Diana Cruz        | 250.0         | 2026-09-02 11:00   | efectivo         | confirmado
```

Quedan 8 pagos (empezaron 9, se elimino la duplicada del `id_pago = 9`).

**2. Pagos que no estan confirmados todavia:**

```text
id_pago | id_alumno | monto_pagado | estado
7       | 2          | 350.0         | rechazado
```

El pago de Carlos Ruiz (id_pago = 3) ya no aparece aqui porque `operaciones.sql` lo confirmo tras verificar la transferencia.

**3. Alumno con mas pagos registrados:**

```text
nombre_completo   | total_pagos
Andres Lopez         | 2
Marta Vega            | 2
Diana Cruz            | 2
Carlos Ruiz           | 1
Pedro Gomez            | 1
```

**4. Pagos ordenados por fecha:** ver tabla completa arriba, de 2026-08-01 a 2026-09-02.

**5. Total recaudado por plan (sin pagos rechazados), JOIN de las tres tablas:**

```text
nombre_plan               | total_recaudado
Plan Basico                 | 1000.0
Plan Elite Personalizado    | 700.0
Plan Avanzado                | 480.0
Plan Intermedio               | 350.0
```

El pago rechazado de Marta Vega (Plan Intermedio) correctamente no cuenta en este total; por eso el Plan Intermedio queda con solo 350.0, no 700.0.

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO pagos (id_alumno, monto_pagado, metodo_pago) VALUES (3, 0, 'efectivo');` → `CHECK constraint failed: monto_pagado > 0`.

## Operaciones de mantenimiento verificadas

- `UPDATE pagos SET estado = 'confirmado' WHERE id_pago = 3 AND estado = 'pendiente';` → el pago de Carlos Ruiz paso de `pendiente` a `confirmado`.
- `UPDATE alumnos SET entrenador_asignado = 'Luis Marin' WHERE id_alumno = 1;` → Andres Lopez cambio de entrenador.
- `DELETE FROM pagos WHERE id_pago = 9;` → el pago duplicado desaparecio; el conteo final es 8, no 9.

## Aprendizaje

La respuesta a "quien compro, que compro, cuando ocurrio y cuanto dinero representa" no necesito repetir el nombre del plan en cada pago: el "que" se resuelve encadenando `pagos` -> `alumnos` -> `planes` a traves de las llaves foraneas, exactamente como en el reporte financiero por plan (consulta 5). Esto evita duplicar el precio del plan en cada fila de pago y, de paso, deja claro que un pago `rechazado` (como el de Marta Vega) no debe contarse como dinero real recaudado, aunque el alumno haya intentado pagar.
