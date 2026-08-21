# Evidencias - Solicitudes SQL - Ejercicio 016 (Hotel Gamers)

## Comandos ejecutados

```bash
sqlite3 ejercicio-016.db < ddl/schema.sql
sqlite3 ejercicio-016.db < dml/inserts.sql
sqlite3 ejercicio-016.db < dml/operaciones.sql
sqlite3 ejercicio-016.db < dql/consultas.sql
```

## Resultados

**1. Todas las reservas (ya con la de prueba eliminada y el estado de Karen Solis corregido):**

```text
id_reserva | id_habitacion | nombre_huesped   | fecha_entrada | fecha_salida | monto_total | estado
1          | 1             | Ana Gomez         | 2026-08-01     | 2026-08-03    | 700.0        | finalizada
2          | 3             | Luis Marroquin    | 2026-08-02     | 2026-08-05    | 2850.0       | finalizada
3          | 2             | Karen Solis       | 2026-08-05     | 2026-08-07    | 1100.0       | finalizada
4          | 4             | Diego Paz         | 2026-08-06     | 2026-08-08    | 1900.0       | confirmada
5          | 5             | Rosa Chavez       | 2026-08-08     | 2026-08-10    | 1100.0       | confirmada
6          | 1             | Julio Perez       | 2026-08-10     | 2026-08-11    | 350.0        | cancelada
7          | 3             | Ana Gomez         | 2026-08-12     | 2026-08-14    | 1900.0       | confirmada
8          | 2             | Luis Marroquin    | 2026-08-13     | 2026-08-15    | 1100.0       | finalizada
```

Quedan 8 reservas (empezaron 9, se elimino la de prueba del `id_reserva = 9`).

**2. Reservas que todavia no terminan:**

```text
id_reserva | id_habitacion | nombre_huesped | fecha_entrada | estado
4          | 4             | Diego Paz       | 2026-08-06     | confirmada
5          | 5             | Rosa Chavez     | 2026-08-08     | confirmada
6          | 1             | Julio Perez     | 2026-08-10     | cancelada
7          | 3             | Ana Gomez       | 2026-08-12     | confirmada
```

Karen Solis ya no aparece aqui porque `operaciones.sql` corrigio su reserva de `en_curso` a `finalizada`.

**3. Huesped que mas reserva:**

```text
nombre_huesped    | total_reservas
Luis Marroquin      | 2
Ana Gomez            | 2
Rosa Chavez          | 1
Karen Solis          | 1
Julio Perez          | 1
Diego Paz            | 1
```

**4. Reservas ordenadas por fecha de entrada:** ver tabla completa arriba, de 2026-08-01 a 2026-08-13.

**5. Reporte para el hotel: ingresos por habitacion (sin contar canceladas):**

```text
numero_habitacion | tipo          | ingresos_generados | reservas_validas
201                 | suite_gamer    | 4750.0              | 2
102                 | doble          | 2200.0              | 2
202                 | suite_gamer    | 1900.0              | 1
301                 | doble          | 1100.0              | 1
101                 | individual     | 700.0               | 1
```

La suite gamer 201 es la habitacion que mas ingresos genera, buena candidata para priorizar en mantenimiento y promocion.

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO reservas (..., monto_total) VALUES (..., 0);` → `CHECK constraint failed: monto_total > 0`.

## Operaciones de mantenimiento verificadas

- `UPDATE reservas SET estado = 'finalizada' WHERE id_reserva = 3 AND estado = 'en_curso';` → la reserva de Karen Solis paso de `en_curso` a `finalizada`.
- `UPDATE habitaciones SET estado = 'mantenimiento' WHERE id_habitacion = 1;` → la habitacion 101 paso de `disponible` a `mantenimiento`.
- `DELETE FROM reservas WHERE id_reserva = 9;` → la reserva de prueba desaparecio; el conteo final es 8, no 9.

## Aprendizaje

Igual que en el ejercicio de renta de autos de lujo, separar catalogo (`habitaciones`) de movimiento (`reservas`) evita repetir datos permanentes (numero, tipo, precio) en cada estadia, y permite que cada tabla tenga su propio ciclo de estados sin que se pisen entre si: una habitacion puede entrar a `mantenimiento` sin afectar el historial de reservas que ya tuvo, y una reserva puede `finalizarse` sin que eso cambie automaticamente el estado fisico de la habitacion (ese cambio se hace explicito con su propio `UPDATE`). Mezclar ambos conceptos en una sola tabla habria hecho ambiguo que significa "estado" en cada fila.
