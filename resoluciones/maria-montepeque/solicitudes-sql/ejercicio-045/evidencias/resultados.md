# Evidencias - Solicitudes SQL - Ejercicio 045 (Soldadura Industrial)

## Comandos ejecutados

```bash
sqlite3 ejercicio-045.db < ddl/schema.sql
sqlite3 ejercicio-045.db < dml/inserts.sql
sqlite3 ejercicio-045.db < dml/operaciones.sql
sqlite3 ejercicio-045.db < dql/consultas.sql
```

## Resultados

**1. Todas las ordenes, con JOIN doble a clientes y tecnicos (ya sin la duplicada, con la reja perimetral en proceso y la rampa de carga entregada):**

```text
id_orden | nombre_cliente          | nombre_tecnico   | descripcion                          | fecha_orden | costo_total | estado
1         | Metalurgica San Jose    | Manuel Xitumul    | Reparacion de estructura metalica     | 2026-08-01    | 1200.0       | entregada
2         | Constructora Andina     | Brenda Coyoy      | Soldadura de portones industriales    | 2026-08-03    | 800.0        | en_proceso
3         | Talleres Vial           | Herberth Sical    | Refuerzo de rampa de carga             | 2026-08-05    | 1500.0       | entregada
4         | Industrias Quetzal      | Manuel Xitumul    | Fabricacion de soporte de tanque       | 2026-08-06    | 2000.0       | recibida
5         | Metalurgica San Jose    | Manuel Xitumul    | Soldadura de tuberia industrial        | 2026-08-08    | 950.0        | en_proceso
6         | Ferreteria Central      | Herberth Sical    | Reparacion de reja perimetral          | 2026-08-09    | 600.0        | en_proceso
7         | Constructora Andina     | Yesenia Tzul      | Refuerzo de plataforma                 | 2026-08-11    | 1800.0       | rechazada
8         | Talleres Vial           | Brenda Coyoy      | Soldadura de escalera industrial       | 2026-08-12    | 700.0        | recibida
```

Quedan 8 ordenes (empezaron 9, se elimino la duplicada `id_orden = 9`).

**2. Ordenes que no estan entregadas todavia:**

```text
id_orden | id_cliente | id_tecnico | fecha_orden | estado
2         | 2          | 2           | 2026-08-03    | en_proceso
4         | 4          | 1           | 2026-08-06    | recibida
5         | 1          | 1           | 2026-08-08    | en_proceso
6         | 5          | 3           | 2026-08-09    | en_proceso
7         | 2          | 4           | 2026-08-11    | rechazada
8         | 3          | 2           | 2026-08-12    | recibida
```

**3. Tecnico con mas ordenes asignadas:**

```text
nombre_tecnico   | total_ordenes
Manuel Xitumul   | 3
Brenda Coyoy     | 2
Herberth Sical   | 2
Yesenia Tzul     | 1
```

**4. Ordenes ordenadas por fecha:** ver tabla completa arriba, de 2026-08-01 a 2026-08-12.

**5. Costo final de cada orden (mano de obra + materiales), para decidir cuales priorizar al cobrar:**

```text
id_orden | nombre_cliente          | descripcion                          | mano_de_obra | costo_materiales | costo_final
4         | Industrias Quetzal      | Fabricacion de soporte de tanque       | 2000.0        | 540.0             | 2540.0
3         | Talleres Vial           | Refuerzo de rampa de carga             | 1500.0        | 880.0             | 2380.0
7         | Constructora Andina     | Refuerzo de plataforma                 | 1800.0        | 0.0               | 1800.0
1         | Metalurgica San Jose    | Reparacion de estructura metalica      | 1200.0        | 550.0             | 1750.0
2         | Constructora Andina     | Soldadura de portones industriales     | 800.0         | 450.0             | 1250.0
5         | Metalurgica San Jose    | Soldadura de tuberia industrial        | 950.0         | 200.0             | 1150.0
6         | Ferreteria Central      | Reparacion de reja perimetral          | 600.0         | 120.0             | 720.0
8         | Talleres Vial           | Soldadura de escalera industrial       | 700.0         | 0.0               | 700.0
```

La orden 8 (Talleres Vial) quedo en 700.0 sin materiales porque su electrodo se elimino con el `DELETE` controlado del punto 3 de operaciones.

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- Registro repetido: `INSERT INTO tecnicos (nombre_tecnico, ...) VALUES ('Manuel Xitumul', ...);` → `UNIQUE constraint failed: tecnicos.nombre_tecnico`.
- Valor fuera de rango: `INSERT INTO ordenes (..., costo_total) VALUES (..., 0);` → `CHECK constraint failed: costo_total > 0`.

## Operaciones de mantenimiento verificadas

- `UPDATE ordenes SET estado = 'en_proceso' WHERE id_orden = 6 AND estado = 'recibida';` → la reja perimetral de Ferreteria Central paso de `recibida` a `en_proceso`.
- `UPDATE ordenes SET estado = 'entregada' WHERE id_orden = 3 AND estado = 'inspeccion';` → la rampa de carga de Talleres Vial paso la inspeccion y quedo `entregada`.
- `DELETE FROM materiales WHERE id_material = 8 AND EXISTS (...);` → **DELETE controlado**: elimino el electrodo de la orden 8 unicamente porque esa orden seguia `recibida`. Si la orden hubiera avanzado de estado, la condicion `EXISTS` habria fallado y el material no se hubiera borrado.
- `DELETE FROM ordenes WHERE id_orden = 9;` → la orden duplicada desaparecio. Conteo final verificado: 8 ordenes, 7 materiales, sin huerfanos.

## Aprendizaje

El costo final de una orden (consulta 5) combina dos fuentes reales (`costo_total` de mano de obra y la suma de `materiales`), lo que le da al taller un numero verdadero para decidir a quien cobrar primero. El `DELETE` controlado de materiales usa `EXISTS` sobre el estado de la orden: eso evita que alguien borre por error un material que ya se uso en un trabajo que esta `en_proceso` o mas adelante, protegiendo el costo real de esa orden.
