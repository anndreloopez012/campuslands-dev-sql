.headers on
.mode column

-- Ejercicio 013: Clinica Tatuajes
-- 1. Artistas y sus estilos
SELECT id, nombre, estilo FROM artistas;

-- 2. Citas agendadas
SELECT c.id, cl.nombre AS cliente, a.nombre AS artista, c.diseno, c.costo FROM citas c JOIN clientes cl ON cl.id = c.cliente_id JOIN artistas a ON a.id = c.artista_id;

-- 3. Recaudacion por artista
SELECT a.nombre, SUM(c.costo) AS total_generado FROM citas c JOIN artistas a ON a.id = c.artista_id GROUP BY a.id, a.nombre;