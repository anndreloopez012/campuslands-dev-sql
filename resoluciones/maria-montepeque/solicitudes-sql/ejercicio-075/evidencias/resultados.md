# Evidencias - Solicitudes SQL - Ejercicio 075 (Track Day Hiperdeportivos)

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-075.db < ddl/schema.sql
sqlite3 ejercicio-075.db < dml/inserts.sql
sqlite3 ejercicio-075.db < dml/operaciones.sql
sqlite3 ejercicio-075.db < dql/consultas.sql
```

## Resultados

Datos base tras `dml/inserts.sql`: 3 pilotos, 3 vehiculos, 3 sesiones
(las 3 marcadas `finalizada` en algun momento), 13 tiempos (incluye
el cargado por error para la sesion que se debia cancelar) y 6 pagos
`pendiente`.

**Caso comentado verificado:**

- `INSERT INTO tiempos (id_sesion, id_piloto, ...) VALUES (1, 1, ..., 1, ...);` (repetir a Fernanda Lopez en la vuelta 1 de la sesion 1) → `UNIQUE constraint failed: tiempos.id_sesion, tiempos.id_piloto, tiempos.vuelta`.

**3. Piloto con mas vueltas registradas:**

```text
nombre_piloto     total_vueltas
Bryan Solis         4
Fernanda Lopez      4
Karla Rivas         4
```

(Los tres corrieron 2 vueltas en cada una de las 2 sesiones reales; el
tiempo huerfano de la sesion cancelada ya no cuenta.)

**5. Pilotos con mejor tiempo promedio (candidatos a invitar al
siguiente evento, promedio menor a 93 segundos):**

```text
nombre_piloto     promedio_segundos
Fernanda Lopez      91.316
Bryan Solis          92.67
```

Karla Rivas quedo fuera del reporte con un promedio de 94.558
segundos, por encima del umbral.

## Operaciones de mantenimiento verificadas

- `UPDATE sesiones SET estado = 'cancelada' WHERE id_sesion = 3 ...;` → la sesion del 2026-08-05 se anulo despues de confirmarse la falla del cronometraje.
- **DELETE controlado**: se elimino el unico tiempo que habia quedado huerfano (el de la sesion 3), apenas se marco `cancelada`. Total de tiempos: 13 -> 12. Ningun tiempo de una sesion `finalizada` se toco.
- **UPDATE multiple de pagos**: los 6 pagos de las sesiones 1 y 2 pasaron de `pendiente` a `pagado` con un solo `UPDATE`, con `fecha_pago` registrada.

## Aprendizaje

El `UNIQUE (id_sesion, id_piloto, vuelta)` en `tiempos` evita que un
piloto quede cargado dos veces en la misma vuelta de la misma sesion.
El `DELETE` controlado solo alcanza tiempos de sesiones `cancelada`,
protegiendo cualquier resultado ya oficial (`finalizada`). El reporte
de tiempo promedio (`GROUP BY` + `HAVING`) responde directamente la
necesidad del cliente, aunque el describio su operacion en lenguaje
cotidiano y no en terminos de tablas: traducir "quiero saber a quien
invitar al siguiente evento" en una consulta con umbral de tiempo
promedio es justo el trabajo de analisis que pedia la solicitud.
