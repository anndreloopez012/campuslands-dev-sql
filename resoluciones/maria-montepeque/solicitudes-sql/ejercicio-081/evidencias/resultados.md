# Evidencias - Solicitudes SQL - Ejercicio 081 (Renta Autos de Lujo)

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-081.db < ddl/schema.sql
sqlite3 ejercicio-081.db < dml/inserts.sql
sqlite3 ejercicio-081.db < dml/operaciones.sql
sqlite3 ejercicio-081.db < dql/consultas.sql
```

## Resultados

Datos base tras `dml/inserts.sql`: 4 clientes, 4 vehiculos, 4 reservas
(2 `finalizada` con pago, 1 `en_curso` sin pago, 1 `reservada` con una
inspeccion cargada por error), 2 pagos y 6 inspecciones.

**Caso comentado verificado** (el problema central del cliente):

- `INSERT INTO pagos (id_reserva, ...) VALUES (1, ...);` (segundo pago para la reserva 1) → `UNIQUE constraint failed: pagos.id_reserva`.

**1. Resumen de reservas via `vista_resumen_reservas`:**

```text
id_reserva | nombre_cliente          | modelo                | categoria    | fecha_inicio | fecha_fin   | estado      | monto_pagado
1           | Manuel Estrada           | Ferrari 488             | deportivo      | 2026-08-01      | 2026-08-03     | finalizada     | 2400.0
2           | Alejandra Chinchilla     | Rolls Royce Phantom     | lujo           | 2026-08-02      | 2026-08-05     | finalizada     | 6000.0
3           | Byron Xicay              | Lamborghini Huracan     | deportivo      | 2026-08-06      | 2026-08-08     | en_curso       | (NULL)
4           | Cristina Barrios         | Mustang Convertible     | convertible    | 2026-08-04      | 2026-08-05     | cancelada      | (NULL)
```

(La vista usa `LEFT JOIN` con `pagos`, por eso las reservas 3 y 4, que
todavia no tienen pago, aparecen con `monto_pagado = NULL` en vez de
desaparecer del resultado.)

**3. Cliente con mas reservas:** los 4 clientes tienen exactamente 1
reserva cada uno.

**5. Ingresos totales por categoria de vehiculo (para decidir en
cual invertir mas flota):**

```text
categoria    ingresos_totales
lujo           6000.0
deportivo      2400.0
```

(Convertible no aparece: su unica reserva se cancelo y nunca genero
pago.)

## Operaciones de mantenimiento verificadas

- `UPDATE reservas SET estado = 'cancelada' WHERE id_reserva = 4 ...;` → la reserva del Mustang Convertible se cancelo antes de que Cristina recogiera el vehiculo.
- **DELETE controlado**: se elimino la unica inspeccion de entrega que habia quedado invalida en la reserva 4, apenas se marco `cancelada`. Total de inspecciones: 6 -> 5. Ninguna inspeccion de una reserva `en_curso` o `finalizada` se toco.

## Aprendizaje

El `UNIQUE (id_reserva)` en `pagos` y el `UNIQUE (id_reserva, tipo_inspeccion)` en `inspecciones` resuelven directamente el problema que
trajo el cliente: datos duplicados por varias personas trabajando
sobre la misma hoja de calculo. La vista `vista_resumen_reservas`
demuestra la habilidad de nivel 5 de "crear vistas": centraliza el
`JOIN` de 4 tablas en un solo objeto reutilizable, y con `LEFT JOIN`
maneja correctamente el caso ambiguo de una reserva que todavia no
tiene pago, sin que desaparezca del reporte. La decision de no
validar traslape de fechas entre reservas del mismo vehiculo con un
`CHECK` (SQLite no lo permite sin `TRIGGER`) se documento
explicitamente en el analisis en vez de dejarla como un vacio sin
explicar.
