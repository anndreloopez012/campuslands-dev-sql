# Evidencias - Solicitudes SQL - Ejercicio 058 (Viajes y Paracaidismo)

## Comandos ejecutados

```bash
sqlite3 ejercicio-058.db < ddl/schema.sql
sqlite3 ejercicio-058.db < dml/inserts.sql
sqlite3 ejercicio-058.db < dml/operaciones.sql
sqlite3 ejercicio-058.db < dql/consultas.sql
```

## Resultados

**1. Todas las reservas, con JOIN a clientes y experiencias, y el total pagado (ya sin la duplicada, sin la reserva cancelada que nunca pago, con la reserva 7 confirmada y la reserva 3 completada):**

```text
id_reserva | nombre_cliente    | nombre_experiencia            | fecha_reserva | estado       | total_pagado
1           | Ana Gomez          | Salto en Paracaidas Nivel 1    | 2026-07-01      | completada    | 1500.0
2           | Luis Marroquin     | Tour Volcanes Guatemala        | 2026-07-05      | completada    | 2200.0
3           | Karen Solis        | Salto en Paracaidas Tandem     | 2026-07-10      | completada    | 900.0
4           | Diego Paz          | Salto en Paracaidas Nivel 1    | 2026-07-12      | confirmada    | 1500.0
5           | Rosa Chavez        | Aventura Selva Peten           | 2026-07-15      | completada    | 3200.0
6           | Ana Gomez          | Ruta Cafetera                  | 2026-07-18      | cancelada     | 0
7           | Ana Gomez          | Salto en Paracaidas Nivel 1    | 2026-07-20      | confirmada    | 0
8           | Luis Marroquin     | Salto en Paracaidas Tandem     | 2026-07-22      | completada    | 1800.0
```

Quedan 8 reservas (empezaron 10: se elimino la duplicada `id_reserva = 10` y la cancelada sin pago `id_reserva = 9`) y 7 pagos.

**2. Reservas que no estan completadas todavia (casos pendientes):**

```text
id_reserva | id_cliente | id_experiencia | fecha_reserva | estado
4           | 4          | 1               | 2026-07-12      | confirmada
6           | 1          | 5               | 2026-07-18      | cancelada
7           | 1          | 1               | 2026-07-20      | confirmada
```

**3. Cliente con mas reservas (ranking de actividad):**

```text
nombre_cliente    | total_reservas
Ana Gomez          | 3
Luis Marroquin     | 2
Diego Paz          | 1
Karen Solis        | 1
Rosa Chavez        | 1
```

**4. Reservas ordenadas por fecha:** ver tabla completa arriba, de 2026-07-01 a 2026-07-22.

**5. Total recaudado por experiencia (solo pagos completados), para decidir cual promocionar mas:**

```text
nombre_experiencia            | total_recaudado
Aventura Selva Peten           | 3200.0
Salto en Paracaidas Nivel 1    | 3000.0
Salto en Paracaidas Tandem     | 2700.0
Tour Volcanes Guatemala        | 2200.0
```

`Ruta Cafetera` no aparece en este ranking porque su unico pago fue reembolsado (no cuenta como recaudado).

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- Registro repetido: `INSERT INTO experiencias (nombre_experiencia, ...) VALUES ('Tour Volcanes Guatemala', ...);` → `UNIQUE constraint failed: experiencias.nombre_experiencia`.
- Valor fuera de rango: `INSERT INTO pagos (..., monto, ...) VALUES (..., 0, ...);` → `CHECK constraint failed: monto > 0`.

## Operaciones de mantenimiento verificadas

- `UPDATE reservas SET estado = 'confirmada' WHERE id_reserva = 7 AND estado = 'pendiente';` → la segunda reserva de Ana Gomez quedo confirmada.
- `UPDATE reservas SET estado = 'completada' WHERE id_reserva = 3 AND estado = 'confirmada';` → el salto en tandem de Karen Solis quedo completado.
- `DELETE FROM reservas WHERE id_reserva = 9 AND estado = 'cancelada' AND NOT EXISTS (...);` → **DELETE controlado**: elimino unicamente la reserva 9 (cancelada, sin ningun pago registrado). La reserva 6, tambien cancelada pero con un deposito ya reembolsado, no se toco: se conservo como historial financiero.
- `DELETE FROM reservas WHERE id_reserva = 10;` → la reserva duplicada desaparecio. Conteo final verificado: 8 reservas, 7 pagos, sin huerfanos.

## Aprendizaje

El `DELETE` controlado usa `NOT EXISTS` sobre `pagos` para decidir si una reserva cancelada se puede borrar: solo si nunca genero ningun movimiento de dinero. Eso protege el historial financiero de la agencia, incluso en una reserva cancelada, siempre que ya haya un pago (aunque sea reembolsado) de por medio. El ranking de recaudacion por experiencia (consulta 5) responde exactamente lo que pidio el cliente: totales reales, no solo el precio de catalogo.
