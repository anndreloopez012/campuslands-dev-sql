.headers on
.mode column

-- Ejercicio 034: Estudio Animacion 3D
-- 1. Proyectos por cliente
SELECT p.id, c.empresa, p.nombre, p.presupuesto FROM proyectos p JOIN clientes c ON c.id = p.cliente_id;

-- 2. Renders pendientes o en proceso
SELECT r.id, p.nombre AS proyecto, r.escena, r.tiempo_horas FROM renders r JOIN proyectos p ON p.id = r.proyecto_id WHERE r.estado = 'en_proceso';

-- 3. Horas totales de render por proyecto
SELECT p.nombre, SUM(r.tiempo_horas) AS total_horas FROM renders r JOIN proyectos p ON p.id = r.proyecto_id GROUP BY p.id, p.nombre;