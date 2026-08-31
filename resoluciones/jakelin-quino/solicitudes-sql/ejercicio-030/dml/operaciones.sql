PRAGMA foreign_keys = ON;

-- Ejercicio 030: Cine Horror Nights
INSERT INTO funciones (pelicula_id, sala_id, horario, precio) VALUES (1, 2, '22:30', 12.00);

UPDATE funciones SET precio = 10.00 WHERE id = 1;

DELETE FROM peliculas WHERE id = 3 AND NOT EXISTS (SELECT 1 FROM funciones WHERE pelicula_id = peliculas.id);