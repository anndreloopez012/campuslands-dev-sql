# Evidencias - Solicitudes SQL - Ejercicio 025 (Track Day Hiperdeportivos)

## Comandos ejecutados

```bash
sqlite3 ejercicio-025.db < ddl/schema.sql
sqlite3 ejercicio-025.db < dml/inserts.sql
sqlite3 ejercicio-025.db < dml/operaciones.sql
sqlite3 ejercicio-025.db < dql/consultas.sql
```

## Resultados

**1. Todas las sesiones, con JOIN encadenado (pilotos -> vehiculos -> sesiones), ya sin la duplicada y con la revision resuelta:**

```text
id_sesion | nombre_piloto | modelo                    | tiempo_vuelta_segundos | clima    | estado
1         | Andres Lopez    | Ferrari SF90                | 92.45                   | seco      | valida
2         | Marta Vega      | Lamborghini Huracan STO     | 98.12                   | seco      | valida
3         | Carlos Ruiz     | Porsche 911 GT3             | 105.78                  | seco      | valida
4         | Diana Cruz      | McLaren 720S                | 95.34                   | lluvia    | valida
5         | Andres Lopez    | Ferrari SF90                | 91.98                   | seco      | valida
6         | Pedro Gomez     | Nissan GT-R Nismo           | 99.65                   | nublado   | valida
7         | Marta Vega      | Lamborghini Huracan STO     | 97.5                    | seco      | valida
8         | Diana Cruz      | McLaren 720S                | 94.87                   | seco      | valida
```

Quedan 8 sesiones (empezaron 9, se elimino la duplicada del `id_sesion = 9`).

**2. Sesiones que no estan validas todavia:**

```text
(sin filas)
```

La sesion del Porsche (id_sesion = 3) ya no aparece aqui porque `operaciones.sql` la confirmo tras la revision.

**3. Piloto con mas sesiones corridas:**

```text
nombre_piloto   | total_sesiones
Andres Lopez      | 2
Marta Vega         | 2
Diana Cruz         | 2
Carlos Ruiz        | 1
Pedro Gomez        | 1
```

**4. Sesiones ordenadas por fecha:** ver tabla completa arriba, de 2026-08-10 a 2026-08-12.

**5. Mejor tiempo de vuelta (record) por piloto:**

```text
nombre_piloto   | modelo                    | mejor_tiempo
Andres Lopez      | Ferrari SF90                | 91.98
Diana Cruz         | McLaren 720S                | 94.87
Marta Vega         | Lamborghini Huracan STO     | 97.5
Pedro Gomez        | Nissan GT-R Nismo           | 99.65
Carlos Ruiz        | Porsche 911 GT3             | 105.78
```

Andres Lopez tiene el record de la pista con 91.98 segundos, manejando el Ferrari SF90.

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO sesiones (id_vehiculo, tiempo_vuelta_segundos, clima) VALUES (3, 0, 'seco');` → `CHECK constraint failed: tiempo_vuelta_segundos > 0`.

## Operaciones de mantenimiento verificadas

- `UPDATE sesiones SET estado = 'valida' WHERE id_sesion = 3 AND estado = 'en_revision';` → la sesion del Porsche 911 GT3 paso de `en_revision` a `valida`.
- `UPDATE pilotos SET categoria = 'profesional' WHERE id_piloto = 2;` → Marta Vega ascendio de `semi_profesional` a `profesional`.
- `DELETE FROM sesiones WHERE id_sesion = 9;` → la sesion duplicada desaparecio; el conteo final es 8, no 9.

## Aprendizaje

La cadena `pilotos -> vehiculos -> sesiones` obligo a encadenar tres `JOIN` para llegar del nombre del piloto hasta el tiempo de vuelta (la tabla mas lejana). La consulta 5 (mejor tiempo por piloto) muestra por que el orden de `ORDER BY` depende del significado del dato: en un ranking de dinero o kills, mayor es mejor (`DESC`); en un ranking de tiempos de carrera, menor es mejor (`ASC`). Usar el orden equivocado habria mostrado al piloto mas lento como si fuera el mejor.
