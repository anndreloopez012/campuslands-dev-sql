# Evidencias - Solicitudes SQL - Ejercicio 088 (Clinica de Tatuajes)

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-088.db < ddl/schema.sql
sqlite3 ejercicio-088.db < dml/inserts.sql
sqlite3 ejercicio-088.db < dml/operaciones.sql
sqlite3 ejercicio-088.db < dql/consultas.sql
```

## Resultados

Datos base tras `dml/inserts.sql`: 4 clientes, 3 artistas, 3 estilos,
5 sesiones (3 `finalizada` con pago, 1 `programada`, 1 marcada
`finalizada` por error con pago) y 4 pagos.

**Caso comentado verificado:**

- `INSERT INTO pagos (id_sesion, ...) VALUES (1, ...);` (segundo pago para la sesion 1) → `UNIQUE constraint failed: pagos.id_sesion`.

**1. Resumen completo via `vista_resumen_sesiones` (ya con la sesion 5
cancelada y sin pago):**

```text
id_sesion | nombre_cliente        | nombre_artista    | nombre_estilo            | fecha_sesion   | duracion_horas | estado      | monto_pagado
1           | Manuel Estrada          | Karla Rivas         | Realismo                    | 2026-08-01        | 3.0                | finalizada     | 900.0
2           | Alejandra Chinchilla    | Bryan Solis         | Tradicional Americano       | 2026-08-02        | 2.0                | finalizada     | 500.0
3           | Byron Xicay             | Fernanda Lopez      | Blackwork                   | 2026-08-03        | 4.0                | finalizada     | 1200.0
4           | Cristina Barrios        | Karla Rivas         | Realismo                    | 2026-08-08        | 3.0                | programada     | (NULL)
5           | Manuel Estrada          | Bryan Solis         | Tradicional Americano       | 2026-08-05        | 2.0                | cancelada      | (NULL)
```

**3. Ranking: artistas con mas sesiones:**

```text
nombre_artista     total_sesiones
Bryan Solis          2
Karla Rivas          2
Fernanda Lopez       1
```

**5. Totales: ingresos por artista (para decidir a quien asignar mas
horarios):**

```text
nombre_artista     ingresos_totales
Fernanda Lopez       1200.0
Karla Rivas           900.0
Bryan Solis           500.0
```

## Operaciones de mantenimiento verificadas

- `UPDATE sesiones SET estado = 'cancelada' WHERE id_sesion = 5 ...;` → la sesion de Manuel Estrada se corrigio despues de confirmarse el aplazamiento.
- **DELETE controlado**: se elimino el pago que habia quedado invalido en la sesion 5. Total de pagos: 4 -> 3. Ningun pago de una sesion `finalizada` se toco.

## Aprendizaje

La vista `vista_resumen_sesiones` es la base comun para los tres tipos
de reporte que pidio el cliente: el ranking de artistas usa `ORDER BY`
+ `LIMIT` sobre un `GROUP BY`, los totales usan `GROUP BY` + `HAVING`
sobre la misma vista, y los casos pendientes son simplemente un
`WHERE estado = 'programada'`. El `UNIQUE (id_sesion)` en `pagos`
evita registrar dos pagos para la misma sesion, y el `DELETE`
controlado solo corrige pagos de sesiones canceladas, nunca de una ya
`finalizada`.
