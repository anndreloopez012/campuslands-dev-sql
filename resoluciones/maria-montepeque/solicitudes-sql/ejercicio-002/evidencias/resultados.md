# Evidencias - Solicitudes SQL - Ejercicio 002 (Taller de Motos)

## Comandos ejecutados

```bash
sqlite3 ejercicio-002.db < ddl/schema.sql
sqlite3 ejercicio-002.db < dml/inserts.sql
sqlite3 ejercicio-002.db < dml/operaciones.sql
sqlite3 ejercicio-002.db < dql/consultas.sql
```

## Resultados

**1. Todas las ordenes de trabajo (ya con la duplicada eliminada y el estado corregido):**

```text
id_orden | id_moto | descripcion_servicio        | mecanico_asignado | costo | fecha_orden       | estado
1        | 1       | Cambio de aceite y filtro    | Pedro Ruiz        | 150.0 | 2026-08-01 09:00  | completada
2        | 2       | Revision de frenos           | Ana Castillo      | 220.0 | 2026-08-02 10:30  | completada
3        | 1       | Ajuste de cadena             | Pedro Ruiz        | 80.0  | 2026-08-05 11:00  | completada
4        | 3       | Cambio de llantas            | Luis Marin        | 450.0 | 2026-08-06 08:00  | completada
5        | 4       | Diagnostico electrico        | Ana Castillo      | 100.0 | 2026-08-07 09:30  | completada
6        | 5       | Cambio de aceite y filtro    | Pedro Ruiz        | 150.0 | 2026-08-08 10:00  | cancelada
7        | 2       | Pintura de tanque            | Luis Marin        | 300.0 | 2026-08-09 14:00  | completada
9        | 2       | Cambio de bujias             | Pedro Ruiz        | 60.0  | 2026-08-10 09:00  | completada
```

Quedan 8 ordenes (empezaron 9, se elimino la duplicada del `id_orden = 8`).

**2. Ordenes que no terminaron en exito (canceladas; ya no hay 'en_proceso' porque se corrigio la de la moto 1):**

```text
id_orden | id_moto | descripcion_servicio        | costo | fecha_orden       | estado
6        | 5       | Cambio de aceite y filtro    | 150.0 | 2026-08-08 10:00  | cancelada
```

**3. Moto (y cliente) con mas actividad:**

```text
placa    | nombre_dueno       | total_ordenes
P002BBB  | Rosa Mendez         | 3
P001AAA  | Jorge Alvarado      | 2
P003CCC  | Tomas Blanco        | 1
P004DDD  | Karla Diaz Lopez    | 1
P005EEE  | Julio Perez         | 1
```

La moto de Rosa Mendez (P002BBB) es la que mas ordenes de trabajo genera.

**4. Ordenes ordenadas por fecha:** ver tabla completa arriba, ordenada de 2026-08-01 a 2026-08-10.

**5. Reporte para el cliente: ingresos generados por mecanico (solo ordenes completadas):**

```text
mecanico_asignado | total_generado | ordenes_completadas
Luis Marin          | 750.0          | 2
Ana Castillo        | 320.0          | 2
Pedro Ruiz          | 290.0          | 3
```

Luis Marin genera el mayor ingreso total aunque tiene menos ordenes que Pedro Ruiz (sus servicios son de mayor costo, como cambio de llantas y pintura).

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO ordenes_trabajo (..., costo) VALUES (..., 0);` → `CHECK constraint failed: costo > 0`.

## Operaciones de mantenimiento verificadas

- `UPDATE ordenes_trabajo SET estado = 'completada' WHERE id_orden = 3 AND estado = 'en_proceso';` → la orden de ajuste de cadena de la moto 1 paso de `en_proceso` a `completada`.
- `UPDATE motos SET nombre_dueno = 'Karla Diaz Lopez' WHERE id_moto = 4;` → se corrigio el nombre incompleto del dueno de la moto 4.
- `DELETE FROM ordenes_trabajo WHERE id_orden = 8;` → la orden duplicada (copia exacta de la orden 2) desaparecio; el conteo final de ordenes es 8, no 9.

## Aprendizaje

La solicitud del cliente ("quiero saber quien compro, que compro, cuando ocurrio y cuanto dinero representa cada movimiento") se resuelve con una sola tabla transaccional bien diseñada (`ordenes_trabajo`) apoyada en un catalogo (`motos`): el "quien" sale de la relacion con `motos` (via `FOREIGN KEY`), el "que" es `descripcion_servicio`, el "cuando" es `fecha_orden` y el "cuanto" es `costo`. Igual que en el ejercicio anterior, las correcciones se hacen sin perder historial: un `UPDATE` con `WHERE` especifico cambia el estado de una orden real en vez de borrarla y volver a crearla, y el `DELETE` de la orden duplicada usa el `id_orden` exacto para no arriesgar otros registros.
