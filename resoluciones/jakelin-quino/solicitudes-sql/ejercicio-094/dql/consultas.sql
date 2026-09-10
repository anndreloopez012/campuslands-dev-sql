.headers on
.mode column

-- Ejercicio 094: Diseno 3D Arquitectura
-- 1. Proyectos con cliente
SELECT p.nombre, p.area_m2, c.empresa FROM proyectos p JOIN clientes c ON c.id = p.cliente_id;

-- 2. Renders por proyecto
SELECT r.id, p.nombre AS proyecto, r.vista, r.costo FROM renders r JOIN proyectos p ON p.id = r.proyecto_id;

-- 3. Costo acumulado en renders por proyecto
SELECT p.nombre, SUM(r.costo) AS total_renders FROM renders r JOIN proyectos p ON p.id = r.proyecto_id GROUP BY p.id, p.nombre;