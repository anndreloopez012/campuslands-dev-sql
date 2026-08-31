# Evidencias - Solicitudes SQL - Ejercicio 089 (Mecanica de Autos)

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-089.db < ddl/schema.sql
sqlite3 ejercicio-089.db < dml/inserts.sql
sqlite3 ejercicio-089.db < dml/operaciones.sql
sqlite3 ejercicio-089.db < dql/consultas.sql
```

## Resultados

Datos base tras `dml/inserts.sql`: 3 clientes, 3 vehiculos, 4
diagnosticos, 4 reparaciones (2 `completada`, 2 `pendiente`), 4
repuestos y 5 lineas de detalle (incluye la cargada por error en la
reparacion 3, todavia pendiente).

**Caso comentado verificado:**

- `INSERT INTO reparaciones (id_diagnostico, ...) VALUES (1, ...);` (segunda reparacion oficial para el diagnostico 1) → `UNIQUE constraint failed: reparaciones.id_diagnostico`.

**1. Historial completo via `vista_historial_vehiculo` (ya con la
reparacion 3 en `en_proceso`):**

```text
id_diagnostico | nombre_cliente        | placa       | modelo             | fecha_diagnostico | descripcion              | gravedad   | fecha_reparacion | estado_reparacion | costo_mano_obra
1                | Manuel Estrada          | P-101ABC      | Toyota Corolla       | 2026-08-01           | Frenos desgastados         | moderada     | 2026-08-02          | completada           | 300.0
2                | Alejandra Chinchilla    | P-102DEF      | Honda Civic          | 2026-08-02           | Fuga de aceite             | grave        | 2026-08-03          | completada           | 500.0
3                | Byron Xicay             | P-103GHI      | Nissan Sentra        | 2026-08-03           | Bujias en mal estado       | leve         | 2026-08-04          | en_proceso           | 150.0
4                | Manuel Estrada          | P-101ABC      | Toyota Corolla       | 2026-08-10           | Bateria descargada         | leve         | 2026-08-11          | pendiente            | 100.0
```

**5. Gasto total por cliente (mano de obra + repuestos), para decidir
a quien ofrecer un programa de fidelidad:**

```text
nombre_cliente          gasto_total
Manuel Estrada             1250.0
Alejandra Chinchilla        580.0
Byron Xicay                  330.0
```

Verificacion manual:

- Reparacion 1 (Manuel, Corolla): 300.00 mano de obra + 1 Pastillas de Freno (250.00) = 550.00.
- Reparacion 4 (Manuel, Corolla): 100.00 + 1 Bateria 12V (600.00) = 700.00.
- Manuel Estrada total: 550.00 + 700.00 = **1250.00** (coincide).
- Reparacion 2 (Alejandra): 500.00 + 1 Filtro de Aceite (80.00) = **580.00** (coincide).
- Reparacion 3 (Byron, ya sin el filtro erroneo): 150.00 + 4 Bujia NGK (4 x 45.00 = 180.00) = **330.00** (coincide).

## Operaciones de mantenimiento verificadas

- **DELETE controlado**: se elimino el filtro de aceite cargado por error en la reparacion 3, mientras esta seguia `pendiente`. Total de lineas de detalle: 5 -> 4.
- `UPDATE reparaciones SET estado = 'en_proceso' WHERE id_reparacion = 3 ...;` → el mecanico ya empezo a trabajar en la reparacion de Byron Xicay.

## Aprendizaje

El reporte de gasto por cliente se construyo en dos niveles de
`GROUP BY`: primero una subconsulta agrupa por `id_reparacion` para
calcular el costo total de cada reparacion (mano de obra + suma de
sus repuestos), y despues la consulta externa agrupa esos totales por
cliente. Hacerlo en un solo nivel habria sido incorrecto: una
columna no agrupada dentro de una funcion de agregacion de un solo
nivel (como intentar sumar repuestos con una subconsulta correlacionada
sobre `r.id_reparacion` dentro de un `GROUP BY cliente`) solo habria
tomado un valor arbitrario por cliente en SQLite, no la suma real de
todas sus reparaciones. El `UNIQUE (id_diagnostico)` en `reparaciones`
es la restriccion que protege el historico de auditoria: nunca puede
haber dos reparaciones oficiales contradictorias para el mismo
diagnostico.
