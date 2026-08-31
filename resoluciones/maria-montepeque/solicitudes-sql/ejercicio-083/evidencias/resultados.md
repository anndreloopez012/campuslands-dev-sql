# Evidencias - Solicitudes SQL - Ejercicio 083 (Viajes y Paracaidismo)

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-083.db < ddl/schema.sql
sqlite3 ejercicio-083.db < dml/inserts.sql
sqlite3 ejercicio-083.db < dml/operaciones.sql
sqlite3 ejercicio-083.db < dql/consultas.sql
```

## Resultados

Datos base tras `dml/inserts.sql`: 4 clientes, 3 experiencias, 2
instructores, 4 reservas (3 marcadas `realizada` en algun momento, 1
`confirmada`) y 3 pagos.

**Caso comentado verificado** (el problema central del cliente):

- `INSERT INTO reservas (id_cliente, id_experiencia, ..., fecha_reserva) VALUES (1, 1, ..., '2026-08-01');` (repetir la reserva de Manuel Estrada) → `UNIQUE constraint failed: reservas.id_cliente, reservas.id_experiencia, reservas.fecha_reserva`.

**1. Resumen de reservas via `vista_resumen_reservas`:**

```text
id_reserva | nombre_cliente        | nombre_experiencia  | tipo            | nombre_instructor      | fecha_reserva | estado      | monto_pagado
1           | Manuel Estrada          | Salto en Tandem       | paracaidismo      | Hugo Marroquin           | 2026-08-01      | realizada     | 1800.0
2           | Alejandra Chinchilla    | Tour Volcan Pacaya    | tour              | Cristina Barrios Guia    | 2026-08-02      | realizada     | 450.0
3           | Byron Xicay             | Buceo en Arrecife     | buceo             | Cristina Barrios Guia    | 2026-08-05      | confirmada    | (NULL)
4           | Cristina Barrios        | Salto en Tandem       | paracaidismo      | Cristina Barrios Guia    | 2026-08-06      | cancelada     | (NULL)
```

(La reserva 3 nunca tuvo pago y la 4 perdio el suyo al corregirse; la
vista muestra ambos casos con `monto_pagado = NULL` en vez de
ocultarlos, tal como pidio el cliente para tener reportes confiables.)

**5. Ingresos totales por tipo de experiencia (para decidir en cual
invertir mas promocion):**

```text
tipo            ingresos_totales
paracaidismo      1800.0
tour              450.0
```

(Buceo no aparece: su unica reserva sigue sin pago.)

## Operaciones de mantenimiento verificadas

- `UPDATE reservas SET estado = 'cancelada' WHERE id_reserva = 4 ...;` → la reserva de Cristina Barrios se corrigio despues de confirmarse que cancelo antes de saltar.
- **DELETE controlado**: se elimino el pago que habia quedado invalido en la reserva 4, apenas se marco `cancelada`. Total de pagos: 3 -> 2. Ningun pago de una reserva `realizada` se toco.

## Aprendizaje

El `UNIQUE (id_cliente, id_experiencia, fecha_reserva)` en `reservas`
y el `UNIQUE (id_reserva)` en `pagos` resuelven directamente el
problema que trajo el cliente: registros incompletos o duplicados que
arruinan los reportes. La vista `vista_resumen_reservas`, con
`LEFT JOIN` a `pagos`, hace visible con `NULL` cuando una reserva
todavia no tiene pago, en vez de ocultarla del reporte como haria un
`JOIN` normal: eso es justo lo que hace que un reporte sea confiable,
porque no esconde informacion incompleta, la muestra explicitamente.
