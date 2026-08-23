# Evidencias - Solicitudes SQL - Ejercicio 056 (Renta Autos de Lujo)

## Comandos ejecutados

```bash
sqlite3 ejercicio-056.db < ddl/schema.sql
sqlite3 ejercicio-056.db < dml/inserts.sql
sqlite3 ejercicio-056.db < dml/operaciones.sql
sqlite3 ejercicio-056.db < dql/consultas.sql
```

## Resultados

**1. Todas las reservas, con JOIN a clientes y vehiculos, y el total pagado (ya sin la duplicada, con la reserva 4 finalizada, la reserva 6 en curso y el pago reembolsado eliminado):**

```text
id_reserva | nombre_cliente      | modelo                | fecha_inicio | fecha_fin  | estado       | total_pagado
1           | Alejandro Duarte     | Porsche 911            | 2026-08-01     | 2026-08-03   | finalizada    | 7000.0
2           | Camila Rosales       | Ferrari Roma           | 2026-08-02     | 2026-08-04   | finalizada    | 9600.0
3           | Esteban Marroquin    | Lamborghini Huracan    | 2026-08-05     | 2026-08-08   | finalizada    | 15600.0
4           | Alejandro Duarte     | Mercedes AMG GT        | 2026-08-06     | 2026-08-07   | finalizada    | 3200.0
5           | Ligia Franco         | Porsche 911            | 2026-08-09     | 2026-08-11   | finalizada    | 7000.0
6           | Roberto Sagastume    | Audi R8                | 2026-08-10     | 2026-08-12   | en_curso      | 7800.0
7           | Camila Rosales       | Lamborghini Huracan    | 2026-08-13     | 2026-08-14   | cancelada     | 0
8           | Esteban Marroquin    | Ferrari Roma           | 2026-08-15     | 2026-08-17   | confirmada    | 9600.0
9           | Alejandro Duarte     | Audi R8                | 2026-08-18     | 2026-08-19   | confirmada    | 0
```

La reserva 9 sigue sin pago registrado (se pagara al recoger el auto), y la reserva 7 quedo en 0 porque su pago reembolsado se elimino. Quedan 9 reservas (empezaron 10, se elimino la duplicada `id_reserva = 10`) y 7 pagos (empezaban 8, se elimino el reembolsado de la reserva cancelada).

**2. Reservas que no estan finalizadas todavia:**

```text
id_reserva | id_cliente | id_vehiculo | fecha_inicio | estado
6           | 5          | 5            | 2026-08-10     | en_curso
7           | 2          | 3            | 2026-08-13     | cancelada
8           | 3          | 2            | 2026-08-15     | confirmada
9           | 1          | 5            | 2026-08-18     | confirmada
```

**3. Cliente con mas reservas:**

```text
nombre_cliente      | total_reservas
Alejandro Duarte     | 3
Camila Rosales       | 2
Esteban Marroquin    | 2
Ligia Franco         | 1
Roberto Sagastume    | 1
```

**4. Reservas ordenadas por fecha de inicio:** ver tabla completa arriba, de 2026-08-01 a 2026-08-18.

**5. Ingreso total por vehiculo (solo pagos completados), para decidir cual vehiculo es mas rentable:**

```text
modelo                | ingreso_total
Ferrari Roma           | 19200.0
Lamborghini Huracan    | 15600.0
Porsche 911            | 14000.0
Audi R8                | 7800.0
Mercedes AMG GT        | 3200.0
```

El Ferrari Roma es el vehiculo mas rentable de la flota.

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- Registro repetido: `INSERT INTO vehiculos (placa, ...) VALUES ('LUX101', ...);` → `UNIQUE constraint failed: vehiculos.placa`.
- Fechas invalidas: `INSERT INTO reservas (..., fecha_inicio, fecha_fin) VALUES (..., '2026-08-20', '2026-08-18');` → `CHECK constraint failed: fecha_fin > fecha_inicio`.

## Operaciones de mantenimiento verificadas

- `UPDATE reservas SET estado = 'finalizada' WHERE id_reserva = 4 AND estado = 'en_curso';` → la reserva del Mercedes AMG GT quedo finalizada.
- `UPDATE reservas SET estado = 'en_curso' WHERE id_reserva = 6 AND estado = 'confirmada';` → la reserva del Audi R8 de Roberto Sagastume comenzo.
- `DELETE FROM pagos WHERE estado = 'reembolsado' AND EXISTS (...);` → **DELETE controlado**: elimino unicamente el pago reembolsado de la reserva cancelada (reserva 7). Un pago reembolsado de una reserva activa no hubiera cumplido esta condicion.
- `DELETE FROM reservas WHERE id_reserva = 10;` → la reserva duplicada desaparecio. Conteo final verificado: 9 reservas, 7 pagos, sin huerfanos.

## Aprendizaje

Separar catalogos (`clientes`, `vehiculos`) de la operacion (`reservas`) y del resultado (`pagos`), tal como pidio el cliente, es lo que permite calcular el ingreso por vehiculo (consulta 5) sin mezclar informacion permanente con movimientos. El `DELETE` controlado usa el estado de la reserva padre para decidir si un reembolso se puede borrar: solo cuando la reserva completa esta cancelada, nunca en una reserva activa.
