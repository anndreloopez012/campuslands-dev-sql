PRAGMA foreign_keys = ON;

-- Ejercicio 03: Biblioteca Tech
-- Agregue aqui INSERT, UPDATE y DELETE adicionales.

-- INSERT validos:
INSERT INTO campers (nombre, apellido, email, telefono, id_sede)
    VALUES ('Amilcar','Hernan', 'herndasndez23@gmadil.com','1989534',3)
           ('Pedro','Juarez', 'Juarez23@gmail.com','10925155',7)

INSERT INTO campers (nombre, apellido, email, telefono, id_sede)
    VALUES ('Adres','Hernandez', 'hernandez23@gmail.com','14451534',1)

INSERT INTO sedes_campus (departamento)
    VALUES ('Huhuetenango')

-- UPDATE validos con WHERE:
UPDATE libros SET cantidad = 10 WHERE cantidad >= 9;
UPDATE prestamos SET punto_de_vista = 'Prueba de update' WHERE id_libro = 3;

-- DELETE controlados con WHERE:
DELETE FROM prestamos WHERE id BETWEEN 11 AND 20;
DELETE FROM prestamos WHERE fecha_prestamo = '2026-08-01 08:30:00';

TRUNCATE TABLE prestamos;

-- Casos que deben fallar por restricciones, dejelos comentados:
-- INSERT INTO ...;



SELECT * FROM prestamos;
SELECT * FROM editorial;
SELECT * FROM campers;
SELECT * FROM sedes_campus;
SELECT * FROM libros;

