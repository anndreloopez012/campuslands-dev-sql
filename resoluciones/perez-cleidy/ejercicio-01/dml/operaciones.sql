PRAGMA foreign_keys = ON;

-- Ejercicio 01: CineMax SQLite
-- Agregue aqui INSERT, UPDATE y DELETE adicionales.

-- INSERT validos:
UPDATE peliculas SET director = 'A. Smith' WHERE director = 'Angel Smith';
-- UPDATE validos con WHERE:
UPDATE funcion SET precio =200 WHERE id_funcion =4;

-- DELETE controlados con WHERE:
DELETE FROM peliculas WHERE nombre = 'Cenicienta' AND id_pelicula =1;
-- Casos que deben fallar por restricciones, dejelos comentados:
-- INSERT INTO ...;funcion (nombre, id_pelicula, id_sala, fecha, hora, precio) VALUES ('Función Inexistente', 15, 1, '2026-05-20', '18:00', 120);
-- (Falla porque no existe la película con ID 15, violando la llave foránea)
