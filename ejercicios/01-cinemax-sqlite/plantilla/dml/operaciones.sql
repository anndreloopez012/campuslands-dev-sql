PRAGMA foreign_keys = ON;

-- Ejercicio 01: CineMax SQLite
-- Operaciones adicionales: INSERT, UPDATE, DELETE y restricciones

-- INSERT válido adicional
INSERT INTO boletos (funcion_id, numero_asiento, estado) 
VALUES (3, 'C4', 'vendido');

-- UPDATE con WHERE válido
UPDATE funciones 
SET precio = 14.00 
WHERE id = 2;

-- DELETE controlado con WHERE
DELETE FROM boletos 
WHERE estado = 'cancelado';

-- Casos que deben fallar por restricciones (déjalos comentados como indica la plantilla):
-- INSERT INTO salas (nombre_sala, capacidad, tipo_pantalla) VALUES ('Sala 4', -10, '2D'); -- Debe fallar por el CHECK de capacidad
-- INSERT INTO funciones (pelicula_id, sala_id, fecha_hora, precio) VALUES (999, 1, '2026-08-27 20:00:00', 10.00); -- Debe fallar por la Foreign Key de película inexistente