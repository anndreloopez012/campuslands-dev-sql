# Evidencias - Solicitudes SQL - Ejercicio 031 (Renta Autos de Lujo)

## Comandos ejecutados

```bash
sqlite3 ejercicio-031.db < ddl/schema.sql
sqlite3 ejercicio-031.db < dml/inserts.sql
sqlite3 ejercicio-031.db < dml/operaciones.sql
sqlite3 ejercicio-031.db < dql/consultas.sql
```

## Resultados

**1. Todas las reservas, con JOIN doble a clientes y vehiculos (ya sin la duplicada y con Tomas Blanco finalizada):**

```text
id_reserva | nombre_cliente   | marca           | modelo        | fecha_inicio | fecha_fin  | monto_total | estado
1          | Jorge Alvarado     | Ferrari           | 488 GTB        | 2026-08-10    | 2026-08-12  | 2400.0       | finalizada
2          | Rosa Mendez        | Porsche           | 911 Carrera    | 2026-08-11    | 2026-08-14  | 2400.0       | finalizada
3          | Tomas Blanco       | Lamborghini       | Huracan        | 2026-08-15    | 2026-08-17  | 2800.0       | finalizada
4          | Karla Diaz         | Mercedes-Benz     | AMG GT         | 2026-08-16    | 2026-08-18  | 1900.0       | confirmada
5          | Julio Perez        | Aston Martin      | DB11           | 2026-08-18    | 2026-08-20  | 2200.0       | confirmada
6          | Rosa Mendez        | Ferrari           | 488 GTB        | 2026-08-20    | 2026-08-21  | 1200.0       | cancelada
7          | Jorge Alvarado     | Porsche           | 911 Carrera    | 2026-08-22    | 2026-08-23  | 800.0        | confirmada
8          | Rosa Mendez        | Lamborghini       | Huracan        | 2026-08-13    | 2026-08-15  | 1100.0       | finalizada
```

Quedan 8 reservas (empezaron 9, se elimino la duplicada del `id_reserva = 9`).

**2. Reservas que todavia no terminan:**

```text
id_reserva | id_cliente | id_vehiculo | fecha_inicio | estado
4          | 4           | 4            | 2026-08-16    | confirmada
5          | 5           | 5            | 2026-08-18    | confirmada
6          | 2           | 1            | 2026-08-20    | cancelada
7          | 1           | 3            | 2026-08-22    | confirmada
```

**3. Cliente que mas reserva:**

```text
nombre_cliente   | total_reservas
Rosa Mendez         | 3
Jorge Alvarado       | 2
Tomas Blanco         | 1
Karla Diaz           | 1
Julio Perez          | 1
```

**4. Reservas ordenadas por fecha de inicio:** ver tabla completa arriba, de 2026-08-10 a 2026-08-22.

**5. Ingresos por vehiculo (sin contar canceladas):**

```text
marca            | modelo        | placa    | ingresos_generados | reservas_validas
Lamborghini         | Huracan        | LUX-002  | 3900.0              | 2
Porsche             | 911 Carrera    | LUX-003  | 3200.0              | 2
Ferrari              | 488 GTB        | LUX-001  | 2400.0              | 1
Aston Martin          | DB11           | LUX-005  | 2200.0              | 1
Mercedes-Benz          | AMG GT         | LUX-004  | 1900.0              | 1
```

El Lamborghini Huracan es el vehiculo que mas ingresos genera.

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO reservas (..., monto_total) VALUES (..., 0);` → `CHECK constraint failed: monto_total > 0`.

## Operaciones de mantenimiento verificadas

- `UPDATE reservas SET estado = 'finalizada' WHERE id_reserva = 3 AND estado = 'en_curso';` → la reserva de Tomas Blanco paso de `en_curso` a `finalizada`.
- `UPDATE vehiculos SET estado = 'mantenimiento' WHERE id_vehiculo = 1;` → el Ferrari 488 GTB paso de `disponible` a `mantenimiento`.
- `DELETE FROM reservas WHERE id_reserva = 9;` → la reserva duplicada desaparecio; el conteo final es 8, no 9.

## Aprendizaje

Con `clientes` como tabla real, la consulta 3 ("cliente que mas reserva") ya no depende de que el nombre del cliente se haya escrito exactamente igual en cada reserva: la `FOREIGN KEY` garantiza que siempre apunta al mismo `id_cliente`, eliminando el riesgo de contar a Rosa Mendez como dos personas distintas si alguien escribio "Rosa Mendes" por error en una reserva. Esto es justamente el problema de duplicados que menciono el cliente al inicio de la solicitud.
