# Evidencias - Solicitudes SQL - Ejercicio 084 (Estudio Animacion 3D)

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-084.db < ddl/schema.sql
sqlite3 ejercicio-084.db < dml/inserts.sql
sqlite3 ejercicio-084.db < dml/operaciones.sql
sqlite3 ejercicio-084.db < dql/consultas.sql
```

## Resultados

Datos base tras `dml/inserts.sql`: 3 clientes, 4 artistas, 3
proyectos, 8 tareas (incluye la cargada por error para el alcance
cancelado) y 4 entregas semanales (1 sin aprobar todavia).

**Caso comentado verificado:**

- `INSERT INTO entregas (id_proyecto, semana, ...) VALUES (1, 1, ...);` (segunda entrega para la semana 1 del proyecto 1) → `UNIQUE constraint failed: entregas.id_proyecto, entregas.semana`.

**1. Reporte rapido semanal via `vista_reporte_semanal` (ya con la
entrega de la semana 2 del proyecto 1 aprobada):**

```text
id_entrega | nombre_cliente         | nombre_proyecto              | estado      | semana | fecha_entrega | aprobada
1           | Manuel Estrada           | Serie Aventuras Espaciales     | en_curso      | 1        | 2026-08-07       | 1
2           | Alejandra Chinchilla     | Comercial Bebida Energetica    | en_curso      | 1        | 2026-08-07       | 1
3           | Byron Xicay              | Pelicula Corta Fantasia        | finalizado    | 5        | 2026-07-30       | 1
4           | Manuel Estrada           | Serie Aventuras Espaciales     | en_curso      | 2        | 2026-08-14       | 1
```

**3. Artista con mas horas trabajadas:**

```text
nombre_artista     horas_totales
Fernanda Lopez        25.0
Karla Rivas            20.0
Bryan Solis            10.0
Jorge Cifuentes        5.0
```

**5. Horas totales por proyecto (para decidir donde reforzar el
equipo):**

```text
nombre_proyecto                  horas_totales
Pelicula Corta Fantasia            27.0
Serie Aventuras Espaciales         24.0
Comercial Bebida Energetica        9.0
```

(El proyecto de la bebida energetica quedo con solo 9 horas porque la
tarea del alcance cancelado, 3 horas, ya se elimino.)

## Operaciones de mantenimiento verificadas

- **DELETE controlado**: se elimino la tarea del alcance extra que el cliente cancelo (proyecto 2). Total de tareas: 8 -> 7.
- `UPDATE entregas SET aprobada = 1 WHERE id_proyecto = 1 AND semana = 2 ...;` → el cliente reviso y aprobo la entrega de la semana 2 del proyecto 1.

## Aprendizaje

El `UNIQUE (id_proyecto, semana)` en `entregas` garantiza que el
reporte semanal que pidio el cliente sea siempre confiable: nunca
habra dos checkpoints oficiales para la misma semana del mismo
proyecto. La vista `vista_reporte_semanal` responde directamente "que
paso esta semana en cada proyecto", que era exactamente la necesidad
de la solicitud original. El `DELETE` controlado solo corrige tareas
de un alcance que el cliente confirmo que se cancelo; el historico
real de trabajo nunca se borra.
