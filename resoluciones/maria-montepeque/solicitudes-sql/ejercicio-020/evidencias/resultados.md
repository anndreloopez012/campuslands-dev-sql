# Evidencias - Solicitudes SQL - Ejercicio 020 (Soldadura Industrial)

## Comandos ejecutados

```bash
sqlite3 ejercicio-020.db < ddl/schema.sql
sqlite3 ejercicio-020.db < dml/inserts.sql
sqlite3 ejercicio-020.db < dml/operaciones.sql
sqlite3 ejercicio-020.db < dql/consultas.sql
```

## Resultados

**1. Todas las ordenes (ya con la de prueba eliminada y ORD-003 aprobada):**

```text
id_orden | id_tecnico | codigo_orden | descripcion                                       | costo  | fecha_orden | estado
1        | 1          | ORD-001       | Soldadura de estructura metalica nave industrial  | 4500.0 | 2026-07-01   | aprobada
2        | 3          | ORD-002       | Reparacion de tuberia de alta presion             | 2800.0 | 2026-07-03   | aprobada
3        | 2          | ORD-003       | Soldadura de tanque de almacenamiento             | 3200.0 | 2026-07-05   | aprobada
4        | 1          | ORD-004       | Refuerzo estructural puente peatonal              | 5200.0 | 2026-07-08   | en_proceso
5        | 4          | ORD-005       | Soldadura de baranda industrial                   | 800.0  | 2026-07-10   | aprobada
6        | 5          | ORD-006       | Reparacion de valvula industrial                  | 1500.0 | 2026-07-12   | rechazada
7        | 3          | ORD-007       | Soldadura de escalera de emergencia               | 1200.0 | 2026-07-15   | aprobada
8        | 2          | ORD-008       | Fabricacion de soporte metalico                   | 950.0  | 2026-07-18   | inspeccionada
```

Quedan 8 ordenes (empezaron 9, se elimino la de prueba del `id_orden = 9`).

**2. Ordenes que no estan aprobadas todavia:**

```text
id_orden | codigo_orden | id_tecnico | fecha_orden | estado
4        | ORD-004       | 1          | 2026-07-08   | en_proceso
6        | ORD-006       | 5          | 2026-07-12   | rechazada
8        | ORD-008       | 2          | 2026-07-18   | inspeccionada
```

**3. Tecnico con mas ordenes:**

```text
nombre_tecnico   | total_ordenes
Carlos Ruiz         | 2
Pedro Gomez          | 2
Ana Castillo         | 2
Luis Marin           | 1
Sofia Reyes          | 1
```

**4. Ordenes ordenadas por fecha:** ver tabla completa arriba, de 2026-07-01 a 2026-07-18.

**5. Costo total generado por tecnico (sin ordenes rechazadas):**

```text
nombre_tecnico   | certificacion | costo_total
Carlos Ruiz         | avanzada       | 9700.0
Pedro Gomez          | intermedia     | 4150.0
Ana Castillo         | avanzada       | 4000.0
Luis Marin           | basica         | 800.0
```

Sofia Reyes no aparece en este reporte porque su unica orden esta `rechazada`; el `WHERE o.estado <> 'rechazada'` la excluye correctamente.

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO tecnicos (nombre_tecnico, certificacion, anios_experiencia) VALUES ('Diego Paz', 'basica', 80);` → `CHECK constraint failed: anios_experiencia BETWEEN 0 AND 50`.

## Operaciones de mantenimiento verificadas

- `UPDATE ordenes SET estado = 'aprobada' WHERE id_orden = 3 AND estado = 'inspeccionada';` → ORD-003 paso de `inspeccionada` a `aprobada`.
- `UPDATE tecnicos SET certificacion = 'avanzada' WHERE id_tecnico = 5;` → Sofia Reyes subio de `intermedia` a `avanzada`.
- `DELETE FROM ordenes WHERE id_orden = 9;` → la orden de prueba desaparecio; el conteo final es 8, no 9.

## Aprendizaje

Las tres formas de "error" que preocupaban al cliente en este ejercicio son las mismas que en la biblioteca sci-fi, aplicadas a un dominio distinto: `FOREIGN KEY` en `ordenes.id_tecnico` impide una **relacion invalida** (una orden asignada a un tecnico que no existe); `CHECK (anios_experiencia BETWEEN 0 AND 50)` detecta un **valor fuera de rango** (el caso comentado con 80 anios lo prueba); y `UNIQUE` en `tecnicos.nombre_tecnico` y `ordenes.codigo_orden` impide un **registro repetido**. Reconocer el mismo patron en dos contextos distintos (bibliotecas, taller industrial) confirma que estas tres reglas de integridad son de proposito general, no trucos especificos de un dominio.
