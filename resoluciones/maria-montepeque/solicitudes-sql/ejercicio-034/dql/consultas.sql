.headers on
.mode column

-- Ejercicio 034: Estudio Animacion 3D
-- Consultas de validacion.

-- 1. Que registros principales existen (con JOIN doble para mostrar el
--    cliente y el artista en vez de solo los id).
SELECT
    p.id_proyecto,
    c.nombre_cliente,
    a.nombre_artista,
    p.nombre_proyecto,
    p.fecha_entrega,
    p.presupuesto,
    p.estado
FROM proyectos p
JOIN clientes c ON c.id_cliente = p.id_cliente
JOIN artistas a ON a.id_artista = p.id_artista;

-- 2. Que proyectos no estan finalizados todavia.
SELECT id_proyecto, id_cliente, id_artista, presupuesto, estado
FROM proyectos
WHERE estado <> 'finalizado';

-- 3. Que artista tiene mas proyectos asignados en total.
SELECT a.nombre_artista, COUNT(*) AS total_proyectos
FROM artistas a
JOIN proyectos p ON p.id_artista = a.id_artista
GROUP BY a.id_artista, a.nombre_artista
ORDER BY total_proyectos DESC, a.nombre_artista;

-- 4. Proyectos ordenados por fecha de entrega.
SELECT c.nombre_cliente, a.nombre_artista, p.nombre_proyecto, p.fecha_entrega
FROM proyectos p
JOIN clientes c ON c.id_cliente = p.id_cliente
JOIN artistas a ON a.id_artista = p.id_artista
ORDER BY p.fecha_entrega;

-- 5. Carga de trabajo activa por artista (pendiente, en_progreso o
--    en_revision), para decidir a quien asignar el siguiente proyecto.
SELECT a.nombre_artista, COUNT(*) AS proyectos_activos
FROM artistas a
JOIN proyectos p ON p.id_artista = a.id_artista
WHERE p.estado IN ('pendiente', 'en_progreso', 'en_revision')
GROUP BY a.id_artista, a.nombre_artista
ORDER BY proyectos_activos DESC, a.nombre_artista;
