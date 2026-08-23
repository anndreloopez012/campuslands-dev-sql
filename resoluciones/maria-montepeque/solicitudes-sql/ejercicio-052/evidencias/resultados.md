# Evidencias - Solicitudes SQL - Ejercicio 052 (Taller de Motos)

## Comandos ejecutados

```bash
sqlite3 ejercicio-052.db < ddl/schema.sql
sqlite3 ejercicio-052.db < dml/inserts.sql
sqlite3 ejercicio-052.db < dml/operaciones.sql
sqlite3 ejercicio-052.db < dql/consultas.sql
```

## Resultados

**1. Todas las ordenes, con JOIN a clientes y mecanicos, y el costo total calculado (ya sin la duplicada, con la orden 5 en reparacion, la orden 3 entregada y el repuesto de la orden 7 eliminado):**

```text
id_orden | nombre_cliente    | nombre_mecanico | placa_moto | fecha_orden | estado          | costo_total
1         | Herminio Coy      | Tono Reyes       | M001ABC     | 2026-08-01    | entregado        | 500.0
2         | Paulina Xicay     | Kimberly Sac     | M002DEF     | 2026-08-02    | entregado        | 260.0
3         | Rodrigo Batres    | Marvin Us        | M003GHI     | 2026-08-04    | entregado        | 315.0
4         | Susana Lemus      | Tono Reyes       | M004JKL     | 2026-08-05    | en_reparacion    | 710.0
5         | Herminio Coy      | Elena Poou       | M005MNO     | 2026-08-07    | en_reparacion    | 150.0
6         | Wilmer Chiquin    | Kimberly Sac     | M006PQR     | 2026-08-08    | entregado        | 480.0
7         | Paulina Xicay     | Marvin Us        | M007STU     | 2026-08-10    | cancelada        | 220.0
8         | Rodrigo Batres    | Tono Reyes       | M008VWX     | 2026-08-11    | en_reparacion    | 490.0
9         | Herminio Coy      | Elena Poou       | M009YZA     | 2026-08-13    | recibida         | 180.0
```

La orden 7 quedo en 220.0 (solo mano de obra) porque su repuesto se elimino al ser una orden cancelada. Quedan 9 ordenes (empezaron 10, se elimino la duplicada `id_orden = 10`) y 8 repuestos usados (empezaban 9, se elimino el de la orden cancelada).

**2. Ordenes que no estan entregadas todavia:**

```text
id_orden | id_cliente | id_mecanico | fecha_orden | estado
4         | 4          | 1            | 2026-08-05    | en_reparacion
5         | 1          | 4            | 2026-08-07    | en_reparacion
7         | 2          | 3            | 2026-08-10    | cancelada
8         | 3          | 1            | 2026-08-11    | en_reparacion
9         | 1          | 4            | 2026-08-13    | recibida
```

**3. Mecanico con mas ordenes asignadas:**

```text
nombre_mecanico | total_ordenes
Tono Reyes       | 3
Elena Poou       | 2
Kimberly Sac     | 2
Marvin Us        | 2
```

**4. Ordenes ordenadas por fecha:** ver tabla completa arriba, de 2026-08-01 a 2026-08-13.

**5. Costo total de cada orden (mano de obra + repuestos), de mayor a menor, para decidir a quien cobrar o entregar primero:**

```text
id_orden | nombre_cliente    | placa_moto | costo_total
4         | Susana Lemus      | M004JKL     | 710.0
1         | Herminio Coy      | M001ABC     | 500.0
8         | Rodrigo Batres    | M008VWX     | 490.0
6         | Wilmer Chiquin    | M006PQR     | 480.0
3         | Rodrigo Batres    | M003GHI     | 315.0
2         | Paulina Xicay     | M002DEF     | 260.0
7         | Paulina Xicay     | M007STU     | 220.0
9         | Herminio Coy      | M009YZA     | 180.0
5         | Herminio Coy      | M005MNO     | 150.0
```

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- Registro repetido: `INSERT INTO mecanicos (nombre_mecanico, ...) VALUES ('Tono Reyes', ...);` → `UNIQUE constraint failed: mecanicos.nombre_mecanico`.
- Valor fuera de rango: `INSERT INTO repuestos_usados (..., cantidad, ...) VALUES (..., 0, ...);` → `CHECK constraint failed: cantidad > 0`.

## Operaciones de mantenimiento verificadas

- `UPDATE ordenes_servicio SET estado = 'en_reparacion' WHERE id_orden = 5 AND estado = 'recibida';` → la moto de Herminio Coy con Elena Poou paso a `en_reparacion`.
- `UPDATE ordenes_servicio SET estado = 'entregado' WHERE id_orden = 3 AND estado = 'listo';` → la moto de Rodrigo Batres quedo `entregado`.
- `DELETE FROM repuestos_usados WHERE id_orden = 7 AND EXISTS (...);` → **DELETE controlado**: elimino unicamente el repuesto de la orden cancelada de Paulina Xicay. El encabezado de la orden (id_orden = 7) se conservo intacto.
- `DELETE FROM ordenes_servicio WHERE id_orden = 10;` → la orden duplicada desaparecio. Conteo final verificado: 9 ordenes, 8 repuestos usados, sin huerfanos.

## Aprendizaje

El costo total de cada orden (consultas 1 y 5) combina dos fuentes reales (mano de obra + repuestos), dandole al taller un numero verdadero para decidir a quien cobrar o entregar primero: responde exactamente lo que pidio el cliente sobre "cuanto dinero representa cada movimiento". El `DELETE` controlado con `EXISTS` protege el detalle de cualquier orden que siga activa o ya entregada: solo el repuesto de una orden cancelada se puede borrar.
