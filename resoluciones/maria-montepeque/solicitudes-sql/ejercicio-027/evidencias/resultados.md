# Evidencias - Solicitudes SQL - Ejercicio 027 (Taller de Motos)

## Comandos ejecutados

```bash
sqlite3 ejercicio-027.db < ddl/schema.sql
sqlite3 ejercicio-027.db < dml/inserts.sql
sqlite3 ejercicio-027.db < dml/operaciones.sql
sqlite3 ejercicio-027.db < dql/consultas.sql
```

## Resultados

**1. Todas las ordenes, con JOIN encadenado (clientes -> motos -> ordenes), ya sin la duplicada y con el ajuste de cadena completado:**

```text
id_orden | nombre_cliente   | placa    | descripcion_servicio        | costo  | estado
1        | Jorge Alvarado     | P001AAA   | Cambio de aceite y filtro     | 150.0  | completada
2        | Rosa Mendez        | P002BBB   | Revision de frenos            | 220.0  | completada
3        | Jorge Alvarado     | P001AAA   | Ajuste de cadena               | 80.0   | completada
4        | Tomas Blanco       | P003CCC   | Cambio de llantas              | 450.0  | completada
5        | Karla Diaz         | P004DDD   | Diagnostico electrico          | 100.0  | completada
6        | Julio Perez        | P005EEE   | Cambio de aceite y filtro     | 150.0  | cancelada
7        | Rosa Mendez        | P002BBB   | Pintura de tanque              | 300.0  | completada
8        | Tomas Blanco       | P003CCC   | Revision electrica             | 120.0  | en_proceso
```

Quedan 8 ordenes (empezaron 9, se elimino la duplicada del `id_orden = 9`).

**2. Ordenes que no estan completadas todavia:**

```text
id_orden | id_moto | descripcion_servicio     | costo  | estado
6        | 5        | Cambio de aceite y filtro | 150.0  | cancelada
8        | 3        | Revision electrica         | 120.0  | en_proceso
```

**3. Cliente con mas actividad:**

```text
nombre_cliente    | total_ordenes
Jorge Alvarado       | 2
Rosa Mendez           | 2
Tomas Blanco          | 2
Karla Diaz            | 1
Julio Perez           | 1
```

**4. Ordenes ordenadas por fecha:** ver tabla completa arriba, de 2026-08-01 a 2026-08-10.

**5. Costo total generado por mecanico (sin canceladas):**

```text
mecanico_asignado | total_generado | ordenes_validas
Luis Marin           | 750.0          | 2
Ana Castillo          | 440.0          | 3
Pedro Ruiz            | 230.0          | 2
```

Luis Marin genera el mayor ingreso con solo 2 ordenes, por el valor de sus servicios (cambio de llantas, pintura de tanque).

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO ordenes_servicio (..., costo) VALUES (..., 0);` → `CHECK constraint failed: costo > 0`.

## Operaciones de mantenimiento verificadas

- `UPDATE ordenes_servicio SET estado = 'completada' WHERE id_orden = 3 AND estado = 'en_proceso';` → el ajuste de cadena paso de `en_proceso` a `completada`.
- `UPDATE clientes SET telefono = '5559001' WHERE id_cliente = 4;` → se actualizo el telefono de Karla Diaz.
- `DELETE FROM ordenes_servicio WHERE id_orden = 9;` → la orden duplicada desaparecio; el conteo final es 8, no 9.

## Aprendizaje

Con `clientes` como tabla real (no como texto dentro de `motos`), el reporte de "cliente con mas actividad" (consulta 3) tuvo que encadenar dos `JOIN`: de `ordenes_servicio` a `motos`, y de `motos` a `clientes`. Esto confirma un patron que se repite en varios ejercicios de este bloque: cuando el cliente pide "corregir estados sin borrar", casi siempre las operaciones de mantenimiento se dividen en dos `UPDATE` (uno de estado, otro de un dato del catalogo) y un solo `DELETE`, reservado exclusivamente para registros que nunca debieron existir.
