# Evidencias - Solicitudes SQL - Ejercicio 033 (Viajes y Paracaidismo)

## Comandos ejecutados

```bash
sqlite3 ejercicio-033.db < ddl/schema.sql
sqlite3 ejercicio-033.db < dml/inserts.sql
sqlite3 ejercicio-033.db < dml/operaciones.sql
sqlite3 ejercicio-033.db < dql/consultas.sql
```

## Resultados

**1. Todas las reservas, con JOIN doble a clientes y experiencias (ya sin la duplicada y con la reserva de Karen Solis confirmada):**

```text
id_reserva | nombre_cliente   | nombre_experiencia            | fecha_reserva | monto_pagado | estado
1          | Ana Gomez          | Salto en Paracaidas Nivel 1     | 2026-07-01     | 1500.0        | completada
2          | Luis Marroquin     | Tour Volcanes Guatemala         | 2026-07-05     | 2200.0        | completada
3          | Karen Solis        | Salto en Paracaidas Tandem      | 2026-07-10     | 1800.0        | confirmada
4          | Diego Paz          | Salto en Paracaidas Nivel 1     | 2026-07-12     | 1500.0        | confirmada
5          | Rosa Chavez        | Aventura Selva Peten            | 2026-07-15     | 3200.0        | completada
6          | Ana Gomez          | Ruta Cafetera                    | 2026-07-18     | 950.0         | cancelada
7          | Ana Gomez          | Salto en Paracaidas Nivel 1     | 2026-07-20     | 1500.0        | pendiente
8          | Luis Marroquin     | Salto en Paracaidas Tandem      | 2026-07-22     | 1800.0        | completada
```

Quedan 8 reservas (empezaron 9, se elimino la duplicada del `id_reserva = 9`).

**2. Reservas que no estan completadas todavia:**

```text
id_reserva | id_cliente | id_experiencia | monto_pagado | estado
3          | 3           | 2               | 1800.0        | confirmada
4          | 4           | 1               | 1500.0        | confirmada
6          | 1           | 5               | 950.0         | cancelada
7          | 1           | 1               | 1500.0        | pendiente
```

**3. Cliente con mas reservas:**

```text
nombre_cliente   | total_reservas
Ana Gomez           | 3
Luis Marroquin       | 2
Karen Solis           | 1
Diego Paz             | 1
Rosa Chavez            | 1
```

**4. Reservas ordenadas por fecha:** ver tabla completa arriba, de 2026-07-01 a 2026-07-22.

**5. Totales: cuanto genera cada experiencia (sin canceladas):**

```text
nombre_experiencia               | tipo            | total_generado
Salto en Paracaidas Nivel 1        | paracaidismo     | 4500.0
Salto en Paracaidas Tandem         | paracaidismo     | 3600.0
Aventura Selva Peten                | viaje            | 3200.0
Tour Volcanes Guatemala              | turismo          | 2200.0
```

`Ruta Cafetera` no aparece porque su unica reserva esta `cancelada`; el `WHERE r.estado <> 'cancelada'` la excluye correctamente.

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO reservas (..., monto_pagado) VALUES (..., 0);` → `CHECK constraint failed: monto_pagado > 0`.

## Operaciones de mantenimiento verificadas

- `UPDATE reservas SET estado = 'confirmada' WHERE id_reserva = 3 AND estado = 'pendiente';` → la reserva de Karen Solis paso de `pendiente` a `confirmada`.
- `UPDATE experiencias SET precio = 1900.00 WHERE id_experiencia = 2;` → el precio del salto en tandem subio de 1800.00 a 1900.00.
- `DELETE FROM reservas WHERE id_reserva = 9;` → la reserva duplicada desaparecio; el conteo final es 8, no 9.

## Aprendizaje

Con `clientes` como tabla real (no como texto dentro de la reserva), el conteo de "cliente con mas reservas" (consulta 3) queda protegido contra el problema exacto que preocupa al cliente: si "Ana Gomez" se escribiera con una variacion minima en una reserva, el reporte la contaria como una persona distinta y el total de 3 reservas se veria incompleto. La `FOREIGN KEY` obliga a que cada reserva apunte siempre al mismo `id_cliente`, garantizando que el reporte final sea confiable.
