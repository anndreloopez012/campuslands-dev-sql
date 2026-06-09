PRAGMA foreign_keys = ON;

-- Inserte aqui los datos de prueba.
-- Requisitos minimos:
-- 5 peliculas, 5 salas, 8 funciones y 10 boletos.

-- Casos de error sugeridos:
-- Mantenga comentadas las inserciones que deben fallar para que el script principal ejecute correctamente.

INSERT INTO peliculas (pelicula_nombre, duracion, clasificacion) VALUES 
('Inception', 148, 'B'),
('The Dark Knight', 152, 'C'),
('Toy Story', 81, 'AA'),
('Pulp Fiction', 154, 'B15'),
('Interstellar', 169, 'B');

INSERT INTO sala (sala_nombre, capacidad) VALUES 
('Sala 1', 150),
('Sala 2', 100),
('Sala 3', 50),
('Sala 4', 200),
('Sala 5', 300);

INSERT INTO funciones (pelicula_id, sala_id, fecha_hora, precio) VALUES 
(1, 1, '2026-06-10 14:00', 45.00),
(1, 1, '2026-06-10 18:00', 45.00),
(2, 2, '2026-06-10 15:00', 40.00),
(3, 3, '2026-06-10 11:00', 60.00),
(4, 4, '2026-06-10 21:00', 35.00),
(5, 5, '2026-06-11 13:00', 50.00),
(3, 2, '2026-06-11 16:00', 40.00),
(2, 1, '2026-06-11 19:00', 45.00);

INSERT INTO boletos (funcion_id, numero_asiento, fecha_compra) VALUES 
(1, 'A1', '2026-06-01'), 
(1, 'A2', '2026-06-01'), 
(1, 'B5', '2026-06-01'),
(2, 'C10', '2026-06-01'), 
(2, 'C11', '2026-06-01'),
(3, 'F4', '2026-06-01'),
(4, 'A1', '2026-06-01'),
(5, 'H12', '2026-06-01'), 
(5, 'H13', '2026-06-01'),
(6, 'J1', '2026-06-01');

-- ============================================================================
-- INSERCIONES QUE GENERAN ERROR
-- ============================================================================

-- Error 1: Violación de CHECK (Clasificación inválida para la tabla películas)
-- INSERT INTO peliculas (pelicula_nombre, duracion, clasificacion) VALUES ('Película Errónea', 120, 'Z');

-- Error 2: Violación de UNIQUE (Mismo asiento vendido dos veces para la misma función)
-- INSERT INTO boletos (funcion_id, numero_asiento, fecha_compra) VALUES (1, 'A1', '2026-06-02');