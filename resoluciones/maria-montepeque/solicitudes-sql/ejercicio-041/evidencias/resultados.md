# Evidencias - Solicitudes SQL - Ejercicio 041 (Hotel Gamers)

## Comandos ejecutados

```bash
sqlite3 ejercicio-041.db < ddl/schema.sql
sqlite3 ejercicio-041.db < dml/inserts.sql
sqlite3 ejercicio-041.db < dml/operaciones.sql
sqlite3 ejercicio-041.db < dql/consultas.sql
```

## Resultados

**1. Todas las reservas, con JOIN doble a huespedes y habitaciones (ya sin la duplicada y sin la reserva 6 que se borro de forma controlada):**

```text
id_reserva | nombre_huesped      | numero_habitacion | tipo         | fecha_checkin | fecha_checkout | estado
1          | Kevin Barrios       | H-201              | suite_gamer   | 2026-08-01     | 2026-08-04      | finalizada
2          | Paola Fuentes       | H-101              | individual    | 2026-08-02     | 2026-08-03      | finalizada
3          | Marlon Chinchilla   | H-202              | suite_gamer   | 2026-08-05     | 2026-08-08      | finalizada
4          | Daniela Us          | H-102              | doble         | 2026-08-06     | 2026-08-07      | en_curso
5          | Kevin Barrios       | H-201              | suite_gamer   | 2026-08-10     | 2026-08-12      | confirmada
7          | Paola Fuentes       | H-101              | individual    | 2026-08-15     | 2026-08-16      | cancelada
8          | Marlon Chinchilla   | H-102              | doble         | 2026-08-18     | 2026-08-20      | confirmada
```

Quedan 7 reservas (empezaron 9: se elimino la duplicada `id_reserva = 9` y la cancelada sin consumos `id_reserva = 6`). La reserva 7, tambien cancelada, **no** se borro porque tiene un consumo asociado (un deposito ya cobrado).

**2. Reservas que no estan finalizadas todavia:**

```text
id_reserva | id_huesped | id_habitacion | fecha_checkin | estado
4          | 4          | 2             | 2026-08-06     | en_curso
5          | 1          | 3             | 2026-08-10     | confirmada
7          | 2          | 1             | 2026-08-15     | cancelada
8          | 3          | 2             | 2026-08-18     | confirmada
```

**3. Huesped con mas consumo acumulado:**

```text
nombre_huesped      | total_consumo
Kevin Barrios       | 280.0
Marlon Chinchilla   | 270.0
Paola Fuentes       | 80.0
```

**4. Reservas ordenadas por fecha de checkin:** ver tabla completa arriba, de 2026-08-01 a 2026-08-18.

**5. Total a facturar por reserva activa (habitacion + consumos), para priorizar el cobro de las cuentas mas altas:**

```text
nombre_huesped      | numero_habitacion | estado      | noches | costo_habitacion | total_consumos | total_a_facturar
Marlon Chinchilla   | H-202              | finalizada   | 3.0     | 2850.0            | 270.0           | 3120.0
Kevin Barrios       | H-201              | finalizada   | 3.0     | 2850.0            | 230.0           | 3080.0
Kevin Barrios       | H-201              | confirmada   | 2.0     | 1900.0            | 50.0            | 1950.0
Marlon Chinchilla   | H-102              | confirmada   | 2.0     | 1100.0            | 0.0             | 1100.0
Daniela Us          | H-102              | en_curso     | 1.0     | 550.0             | 0.0             | 550.0
Paola Fuentes       | H-101              | finalizada   | 1.0     | 350.0             | 50.0            | 400.0
```

La reserva cancelada (id_reserva = 7) no aparece aqui porque una estadia cancelada no factura noches de habitacion.

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- Registro repetido: `INSERT INTO habitaciones (numero_habitacion, ...) VALUES ('H-101', ...);` → `UNIQUE constraint failed: habitaciones.numero_habitacion`.
- Fechas invalidas: `INSERT INTO reservas (..., fecha_checkin, fecha_checkout) VALUES (..., '2026-08-20', '2026-08-18');` → `CHECK constraint failed: fecha_checkout > fecha_checkin`.

## Operaciones de mantenimiento verificadas

- `UPDATE reservas SET estado = 'en_curso' WHERE id_reserva = 4 AND estado = 'confirmada';` → la reserva de Daniela Us paso de `confirmada` a `en_curso`.
- `UPDATE reservas SET estado = 'finalizada' WHERE id_reserva = 3 AND estado = 'en_curso';` → la reserva de Marlon Chinchilla paso de `en_curso` a `finalizada`.
- `DELETE FROM reservas WHERE id_reserva = 6 AND estado = 'cancelada' AND NOT EXISTS (...);` → se borro la reserva 6 (Roberto Salazar) porque estaba cancelada **y** no tenia ningun consumo. La reserva 7 (tambien cancelada, pero con un consumo) no se toco: el `NOT EXISTS` la protegio.
- `DELETE FROM reservas WHERE id_reserva = 9;` → la reserva duplicada desaparecio; antes de este DELETE y el anterior habia 9 reservas, ahora quedan 7.

Conteo final verificado: 7 reservas, 7 consumos (ninguno quedo huerfano, porque el `DELETE` controlado nunca toco una reserva con consumos).

## Aprendizaje

El `DELETE` de este ejercicio no es "borrar por borrar": la condicion `NOT EXISTS (SELECT 1 FROM consumos WHERE consumos.id_reserva = reservas.id_reserva)` hace que solo se puedan eliminar reservas canceladas que no dejaron ningun rastro de cobro. Eso es justamente lo que pidio el cliente para nivel 3: operaciones controladas, no un `DELETE` que borre historial de negocio por accidente. Ademas, `UNIQUE` en `nombre_huesped`, `email` y `numero_habitacion` ataca directamente el problema que reporto el cliente: personas duplicando datos en las hojas de calculo sin darse cuenta.
