.headers on
.mode column

-- Ejercicio 084: Estudio Animacion 3D
-- Consultas que responden preguntas reales del cliente.

-- 1. Que registros principales existen: se usa la vista
-- vista_reporte_semanal (creada en ddl/schema.sql), el reporte rapido
-- que pidio el cliente para cada semana de cada proyecto.
SELECT *
FROM vista_reporte_semanal;

-- 2. Que proyectos estan en curso, pausados, finalizados o
-- cancelados.
SELECT id_proyecto, nombre_proyecto, estado
FROM proyectos
ORDER BY estado;

-- 3. Que artista tiene mas horas trabajadas (ranking de actividad).
SELECT a.nombre_artista, SUM(t.horas_trabajadas) AS horas_totales
FROM artistas a
JOIN tareas t ON t.id_artista = a.id_artista
GROUP BY a.id_artista, a.nombre_artista
ORDER BY horas_totales DESC, a.nombre_artista;

-- 4. Tareas ordenadas por fecha.
SELECT id_tarea, fecha_tarea, horas_trabajadas
FROM tareas
ORDER BY fecha_tarea;

-- 5. Reporte para decision de negocio: horas totales por proyecto,
-- para decidir donde reforzar el equipo (GROUP BY + HAVING).
SELECT pr.nombre_proyecto,
       SUM(t.horas_trabajadas) AS horas_totales
FROM tareas t
JOIN proyectos pr ON pr.id_proyecto = t.id_proyecto
GROUP BY pr.id_proyecto, pr.nombre_proyecto
HAVING SUM(t.horas_trabajadas) > 0
ORDER BY horas_totales DESC;
