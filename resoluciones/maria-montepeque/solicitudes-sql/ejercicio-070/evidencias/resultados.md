# Evidencias - Solicitudes SQL - Ejercicio 070 (Soldadura Industrial)

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-070.db < ddl/schema.sql
sqlite3 ejercicio-070.db < dml/inserts.sql
sqlite3 ejercicio-070.db < dml/operaciones.sql
sqlite3 ejercicio-070.db < dql/consultas.sql
```

## Resultados

Datos base tras `dml/inserts.sql`: 3 clientes, 3 tecnicos, 4 ordenes,
6 materiales (incluye el duplicado por error) y 3 inspecciones.

**Casos comentados verificados** (descomentados y ejecutados por
separado para confirmar que cada uno falla, uno por cada tipo de error
que pidio detectar el cliente):

- Registro repetido: `INSERT INTO clientes (nombre_cliente, ...) VALUES ('Constructora Los Pinos', ...);` → `UNIQUE constraint failed: clientes.nombre_cliente`.
- Relacion invalida: `INSERT INTO ordenes (id_cliente, id_tecnico, ...) VALUES (1, 99, ...);` → `FOREIGN KEY constraint failed`.
- Valor fuera de rango: `INSERT INTO materiales (..., cantidad, ...) VALUES (..., -5, ...);` → `CHECK constraint failed: cantidad > 0`.

**1. Todas las ordenes, con JOIN a clientes y tecnicos:**

```text
id_orden | nombre_cliente          | nombre_tecnico     | descripcion                              | fecha_orden | estado
1         | Constructora Los Pinos   | Hugo Marroquin      | Reparacion de estructura metalica de bodega | 2026-08-01    | finalizada
2         | Metalurgica Sur          | Cristina Barrios    | Fabricacion de portones industriales        | 2026-08-03    | en_proceso
3         | Talleres Andrade         | Hugo Marroquin      | Refuerzo de vigas de techo                  | 2026-08-05    | en_proceso
4         | Constructora Los Pinos   | Esteban Cifuentes   | Soldadura de tuberia de gas                 | 2026-08-06    | cancelada
```

(La orden 3 ya aparece como `en_proceso`: paso de `pendiente` con el
`UPDATE` de `dml/operaciones.sql`.)

**2. Ordenes pendientes o en proceso:**

```text
id_orden | descripcion                              | estado
2         | Fabricacion de portones industriales        | en_proceso
3         | Refuerzo de vigas de techo                  | en_proceso
```

**3. Tecnico con mas ordenes asignadas:**

```text
nombre_tecnico     | total_ordenes
Hugo Marroquin       | 2
Cristina Barrios     | 1
Esteban Cifuentes    | 1
```

**4. Materiales ordenados por costo total (cantidad x costo unitario),
de mayor a menor:**

```text
id_orden | nombre_material         | cantidad | costo_unitario | costo_total
1         | Lamina de acero 3mm      | 4          | 45.00            | 180.00
2         | Tubo cuadrado 2x2        | 6          | 28.75            | 172.50
2         | Electrodo 7018           | 30         | 4.20              | 126.00
3         | Lamina de acero 5mm      | 2          | 60.00            | 120.00
1         | Electrodo 6011           | 20         | 3.50              | 70.00
```

Quedan 5 materiales (empezaron 6, se elimino el duplicado exacto de
`Electrodo 7018` en la orden 2).

**5. Ordenes con inspecciones rechazadas (para saber cuales corregir
antes de entregar):**

```text
id_orden | descripcion                | inspecciones_rechazadas
3         | Refuerzo de vigas de techo  | 1
```

## Operaciones de mantenimiento verificadas

- `UPDATE ordenes SET estado = 'en_proceso' WHERE id_orden = 3 ...;` → la orden de refuerzo de vigas paso de `pendiente` a `en_proceso` porque el tecnico ya empezo a corregir.
- Nueva inspeccion registrada para la orden 3 (`aprobada`, "Uniones reforzadas..."): la inspeccion `rechazada` original **no se borro ni se modifico**, sigue en el historico junto a la nueva.
- **DELETE controlado**: se elimino el material duplicado (`id_material` mas alto que coincidia en material, cantidad y costo, y solo porque la orden 2 no tenia ninguna inspeccion todavia). Materiales de la orden 2 despues del `DELETE`: solo `Electrodo 7018` (fila original) y `Tubo cuadrado 2x2`. Conteo final: 5 materiales (empezaron 6).

## Aprendizaje

Los tres errores que preocupaban al cliente (repetidos, relaciones
invalidas, valores fuera de rango) se bloquean desde el `INSERT`
gracias a `UNIQUE`, `FOREIGN KEY` y `CHECK`. El modelo ademas protege
el historico de calidad: una inspeccion rechazada nunca se borra ni se
sobrescribe, se corrige registrando una inspeccion nueva, igual que en
una auditoria real. El `DELETE` controlado de materiales solo se
permite cuando el error es de captura y la orden todavia no tiene
ningun historico de inspeccion que dependa de ese costo.
