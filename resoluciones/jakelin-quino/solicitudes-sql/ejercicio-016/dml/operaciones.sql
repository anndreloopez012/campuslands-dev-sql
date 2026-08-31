PRAGMA foreign_keys = ON;

-- Ejercicio 016: Hotel Gamers
INSERT INTO reservas (huesped_id, habitacion_id, noches) VALUES (1, 2, 1);

UPDATE habitaciones SET precio_noche = 90.00 WHERE id = 2;

DELETE FROM huespedes WHERE id = 2 AND NOT EXISTS (SELECT 1 FROM reservas WHERE huesped_id = huespedes.id);