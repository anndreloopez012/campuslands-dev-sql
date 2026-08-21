# Evidencias - Solicitudes SQL - Ejercicio 007 (Academia Kickboxing)

## Comandos ejecutados

```bash
sqlite3 ejercicio-007.db < ddl/schema.sql
sqlite3 ejercicio-007.db < dml/inserts.sql
sqlite3 ejercicio-007.db < dml/operaciones.sql
sqlite3 ejercicio-007.db < dql/consultas.sql
```

## Resultados

**1. Todos los alumnos (ya con la entrada de prueba eliminada y el estado de Diana Cruz corregido):**

```text
id_alumno | id_plan | nombre_completo | fecha_inscripcion | estado
1         | 1       | Andres Lopez     | 2026-06-01         | activo
2         | 2       | Marta Vega       | 2026-06-05         | activo
3         | 3       | Carlos Ruiz      | 2026-06-10         | activo
4         | 1       | Diana Cruz       | 2026-06-15         | activo
5         | 4       | Pedro Gomez      | 2026-07-01         | activo
6         | 2       | Laura Ortiz      | 2026-07-05         | inactivo
7         | 5       | Sofia Reyes      | 2026-07-10         | activo
8         | 3       | Mario Paz        | 2026-05-01         | graduado
```

Quedan 8 alumnos (empezaron 9, se elimino la unica fila que de verdad debia borrarse: la entrada de prueba del `id_alumno = 9`).

**2. Alumnos que no estan activos:**

```text
id_alumno | nombre_completo | id_plan | estado
6         | Laura Ortiz      | 2       | inactivo
8         | Mario Paz        | 3       | graduado
```

Diana Cruz ya no aparece aqui porque `operaciones.sql` corrigio su estado de `suspendido` a `activo`, sin borrar su registro.

**3. Plan con mas alumnos activos:**

```text
nombre_plan                | alumnos_activos
Plan Basico                  | 2
Plan Intermedio              | 1
Plan Avanzado                | 1
Plan Elite Personalizado     | 1
Plan Kids                    | 1
```

**4. Alumnos ordenados por fecha de inscripcion:** ver tabla completa arriba, de 2026-05-01 a 2026-07-10.

**5. Reporte para la academia: ingreso mensual estimado por plan (solo alumnos activos):**

```text
nombre_plan                | precio_mensual | alumnos_activos | ingreso_mensual_estimado
Plan Elite Personalizado     | 700.0          | 1                | 700.0
Plan Basico                  | 250.0          | 2                | 500.0
Plan Avanzado                | 480.0          | 1                | 480.0
Plan Intermedio              | 380.0          | 1                | 380.0
Plan Kids                    | 180.0          | 1                | 180.0
```

El Plan Elite Personalizado genera el mayor ingreso a pesar de tener un solo alumno activo, por su precio alto.

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO planes (..., clases_por_semana) VALUES (..., 0);` → `CHECK constraint failed: clases_por_semana > 0`.

## Operaciones de mantenimiento verificadas

- `UPDATE alumnos SET estado = 'activo' WHERE id_alumno = 4 AND estado = 'suspendido';` → Diana Cruz paso de `suspendido` a `activo` sin perder su registro ni su fecha de inscripcion original.
- `UPDATE planes SET precio_mensual = 380.00 WHERE id_plan = 2;` → el Plan Intermedio subio de 350.00 a 380.00.
- `DELETE FROM alumnos WHERE id_alumno = 9;` → la entrada de prueba desaparecio; el conteo final de alumnos es 8, no 9.

## Aprendizaje

La peticion del cliente ("permita corregir estados sin borrar informacion importante") se ve clara al comparar las tres operaciones de mantenimiento: dos de ellas son `UPDATE` (corregir el estado de Diana Cruz, ajustar el precio de un plan) y solo una es `DELETE`, y esa unica eliminacion es para un registro que nunca debio existir (una entrada de prueba), no para un alumno real. Un alumno que se suspende, se retira temporalmente o se gradua conserva su fila completa (`fecha_inscripcion`, historial, etc.) y solo cambia su `estado`; borrar esa fila habria significado perder informacion que la academia si necesita (por ejemplo, saber cuando se inscribio Mario Paz aunque ya se haya graduado).
