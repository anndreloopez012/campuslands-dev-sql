# Evidencias - Solicitudes SQL - Ejercicio 082 (Academia Kickboxing)

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-082.db < ddl/schema.sql
sqlite3 ejercicio-082.db < dml/inserts.sql
sqlite3 ejercicio-082.db < dml/operaciones.sql
sqlite3 ejercicio-082.db < dql/consultas.sql
```

## Resultados

Datos base tras `dml/inserts.sql`: 4 alumnos, 3 planes, 2
entrenadores, 7 asistencias (incluye la cargada por error para Byron
Xicay) y 4 pagos (2 `pendiente`, 2 `pagado`).

**Caso comentado verificado:**

- `INSERT INTO asistencias (id_alumno, id_entrenador, fecha_clase) VALUES (1, 1, '2026-08-01');` (repetir la asistencia de Manuel Estrada) → `UNIQUE constraint failed: asistencias.id_alumno, asistencias.id_entrenador, asistencias.fecha_clase`.

**1. Quien pago, que plan, cuando y cuanto, via `vista_pagos_alumnos`
(ya con el pago de Manuel Estrada confirmado):**

```text
id_pago | nombre_alumno         | nombre_plan       | monto  | fecha_pago   | estado
1        | Manuel Estrada          | Plan Intermedio     | 400.0    | 2026-08-25      | pagado
2        | Alejandra Chinchilla    | Plan Basico         | 250.0    | 2026-08-25      | pagado
3        | Byron Xicay             | Plan Premium        | 600.0    | 2026-08-25      | pendiente
4        | Cristina Barrios        | Plan Basico         | 250.0    | 2026-08-25      | pagado
```

**3. Alumno con mas asistencias:**

```text
nombre_alumno            total_asistencias
Alejandra Chinchilla       2
Manuel Estrada             2
Byron Xicay                1
Cristina Barrios           1
```

(Byron Xicay quedo en 1 asistencia real, no 2: la que se le habia
marcado por error ya se elimino.)

**5. Ingresos totales por plan (solo pagos `pagado`), para decidir en
cual invertir mas promocion:**

```text
nombre_plan          ingresos_totales
Plan Basico             500.0
Plan Intermedio         400.0
```

(Plan Premium no aparece: su unico pago sigue `pendiente`.)

## Operaciones de mantenimiento verificadas

- **DELETE controlado**: se elimino la asistencia que se le habia marcado por error a Byron Xicay el 2026-08-05. Total de asistencias: 7 -> 6.
- `UPDATE pagos SET estado = 'pagado' WHERE id_alumno = 1 ...;` → el pago de Manuel Estrada se confirmo.

## Aprendizaje

El `UNIQUE (id_alumno, id_entrenador, fecha_clase)` en `asistencias`
evita registrar la misma clase dos veces para el mismo alumno, aunque
el cliente no lo pidiera explicitamente: es una buena practica que se
aplico igual, y se documento como tal en el analisis. La vista
`vista_pagos_alumnos` responde literalmente la pregunta que trajo el
cliente (quien compro, que, cuando y cuanto), demostrando que a veces
la solicitud del cliente encaja de forma directa con el dominio del
negocio, sin necesitar una reinterpretacion forzada. El `DELETE`
controlado solo corrige errores de captura confirmados; el historico
real de asistencias nunca se borra.
