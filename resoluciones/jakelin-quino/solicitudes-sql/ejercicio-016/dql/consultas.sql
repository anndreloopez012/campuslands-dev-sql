.headers on
.mode column

-- Ejercicio 016: Hotel Gamers
-- 1. Habitaciones disponibles y equipamiento
SELECT id, numero, consola, precio_noche FROM habitaciones;

-- 2. Reservas registradas
SELECT r.id, h.gamertag, hab.numero, hab.consola, r.noches, (r.noches * hab.precio_noche) AS total FROM reservas r JOIN huespedes h ON h.id = r.huesped_id JOIN habitaciones hab ON hab.id = r.habitacion_id;

-- 3. Ingresos totales por habitacion
SELECT hab.numero, SUM(r.noches * hab.precio_noche) AS ingresos FROM reservas r JOIN habitaciones hab ON hab.id = r.habitacion_id GROUP BY hab.id, hab.numero;