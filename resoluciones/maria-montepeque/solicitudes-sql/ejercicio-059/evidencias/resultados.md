# Evidencias - Solicitudes SQL - Ejercicio 059 (Estudio Animacion 3D)

## Comandos ejecutados

```bash
sqlite3 ejercicio-059.db < ddl/schema.sql
sqlite3 ejercicio-059.db < dml/inserts.sql
sqlite3 ejercicio-059.db < dml/operaciones.sql
sqlite3 ejercicio-059.db < dql/consultas.sql
```

## Resultados

**1. Todas las tareas, con JOIN a proyectos, clientes y artistas (ya sin la duplicada, sin la tarea del proyecto cancelado, con la tarea 4 completada y el proyecto 3 entregado):**

```text
id_tarea | nombre_proyecto                 | nombre_cliente        | nombre_artista  | descripcion                        | fecha_asignacion | estado
1         | Trailer Nova 2026                | Estudio Nova Films     | Karla Fong       | Modelado escena principal           | 2026-07-02          | completada
2         | Trailer Nova 2026                | Estudio Nova Films     | Douglas Perez    | Iluminacion trailer                 | 2026-07-05          | completada
3         | Personaje Principal PixelForge   | Pixel Forge Studios    | Mateo Solis      | Animacion caminata personaje        | 2026-07-11          | en_progreso
4         | Personaje Principal PixelForge   | Pixel Forge Studios    | Karla Fong       | Modelado personaje secundario       | 2026-07-12          | completada
5         | Cinematica Andes                 | Andes Interactive      | Ximena Ac        | Texturizado escenario               | 2026-07-16          | en_progreso
6         | Cinematica Andes                 | Andes Interactive      | Mateo Solis      | Animacion camara                    | 2026-07-17          | pendiente
7         | Comercial Luna 30s                | Luna Producciones      | Douglas Perez    | Iluminacion comercial               | 2026-07-21          | completada
8         | Comercial Luna 30s                | Luna Producciones      | Valeria Tum      | Modelado producto                   | 2026-07-22          | en_progreso
10        | Trailer Nova Fase 2               | Estudio Nova Films     | Karla Fong       | Modelado trailer fase2              | 2026-08-02          | pendiente
```

Quedan 9 tareas (empezaron 11: se elimino la duplicada `id_tarea = 11` y la tarea pendiente del proyecto cancelado `id_tarea = 9`).

**2. Tareas que no estan completadas todavia:**

```text
id_tarea | id_proyecto | id_artista | fecha_asignacion | estado
3         | 2           | 2           | 2026-07-11          | en_progreso
5         | 3           | 3           | 2026-07-16          | en_progreso
6         | 3           | 2           | 2026-07-17          | pendiente
8         | 4           | 5           | 2026-07-22          | en_progreso
10        | 6           | 1           | 2026-08-02          | pendiente
```

**3. Artista con mas tareas asignadas:**

```text
nombre_artista  | total_tareas
Karla Fong      | 3
Douglas Perez   | 2
Mateo Solis     | 2
Valeria Tum     | 1
Ximena Ac       | 1
```

**4. Tareas ordenadas por fecha de asignacion:** ver tabla completa arriba, de 2026-07-02 a 2026-08-02.

**5. Tareas 'en_progreso' ordenadas por fecha de ultimo cambio (las mas antiguas sin actualizar primero), para decidir cuales necesitan seguimiento urgente:**

```text
nombre_proyecto                 | nombre_artista | descripcion                   | fecha_ultimo_cambio
Personaje Principal PixelForge   | Mateo Solis     | Animacion caminata personaje   | 2026-07-15
Cinematica Andes                 | Ximena Ac       | Texturizado escenario          | 2026-07-18
Comercial Luna 30s                | Valeria Tum     | Modelado producto              | 2026-07-23
```

La tarea de Mateo Solis lleva mas tiempo sin actualizarse: es la primera que el estudio deberia revisar.

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- Registro repetido: `INSERT INTO proyectos (..., nombre_proyecto, ...) VALUES (..., 'Trailer Nova 2026', ...);` → `UNIQUE constraint failed: proyectos.nombre_proyecto`.
- Valor fuera de rango: `INSERT INTO tareas (..., estado, ...) VALUES (..., 'archivada', ...);` → `CHECK constraint failed: estado IN ('pendiente', 'en_progreso', 'completada')`.

## Operaciones de mantenimiento verificadas

- `UPDATE tareas SET estado = 'completada', fecha_ultimo_cambio = '2026-07-20' WHERE id_tarea = 4 AND estado = 'pendiente';` → Karla Fong termino el modelado del personaje secundario.
- `UPDATE proyectos SET estado = 'entregado' WHERE id_proyecto = 3 AND estado = 'revision';` → Cinematica Andes paso la revision y se entrego.
- `DELETE FROM tareas WHERE id_tarea = 9 AND estado = 'pendiente' AND EXISTS (...);` → **DELETE controlado**: elimino unicamente la tarea del proyecto cancelado (Nivel Quetzal 1). La tarea 6, pendiente pero de un proyecto activo, no se toco.
- `DELETE FROM tareas WHERE id_tarea = 11;` → la tarea duplicada desaparecio. Conteo final verificado: 9 tareas (empezaron 11).

## Aprendizaje

Guardar `fecha_ultimo_cambio` junto con `estado` es lo que le permite al estudio responder la pregunta central de una auditoria ("que paso y cuando paso") y ademas detectar tareas estancadas (consulta 5) sin reconstruir nada a mano. El `DELETE` controlado con `EXISTS` protege cualquier tarea pendiente de un proyecto que sigue activo: solo se limpia el trabajo pendiente de un proyecto que realmente ya no va a continuar.
