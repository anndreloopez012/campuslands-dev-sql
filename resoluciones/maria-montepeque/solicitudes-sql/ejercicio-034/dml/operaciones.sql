PRAGMA foreign_keys = ON;

-- Ejercicio 034: Estudio Animacion 3D
-- Operaciones de mantenimiento (UPDATE / DELETE controlados).

-- 1. Diego Ruiz empezo a trabajar en las texturas del mapa de Andes
--    (id_proyecto = 3): se corrige el estado de 'pendiente' a
--    'en_progreso'. WHERE especifico por PK + estado actual.
UPDATE proyectos
SET estado = 'en_progreso'
WHERE id_proyecto = 3 AND estado = 'pendiente';

-- 2. El estudio ajusta el presupuesto del personaje principal de Pixel
--    Forge (id_proyecto = 2) de 6200.00 a 6800.00.
UPDATE proyectos
SET presupuesto = 6800.00
WHERE id_proyecto = 2;

-- 3. Se elimina el proyecto duplicado (id_proyecto = 10): es una copia
--    exacta del proyecto 1 por error de digitacion. DELETE seguro
--    porque usa el id exacto de la fila.
DELETE FROM proyectos
WHERE id_proyecto = 10;
