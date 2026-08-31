PRAGMA foreign_keys = ON;

-- Ejercicio 066: Hotel Gamers
-- Datos base: 5 huespedes, 5 habitaciones, 3 eventos, 7 reservas,
-- 10 consumos.

INSERT INTO huespedes (nombre, telefono) VALUES
    ('Manuel Estrada', '5555-5001'),
    ('Alejandra Chinchilla', '5555-5002'),
    ('Byron Xicay', '5555-5003'),
    ('Cristina Barrios', '5555-5004'),
    ('Douglas Pineda', '5555-5005');

INSERT INTO habitaciones (numero, tipo, precio_noche) VALUES
    ('101', 'individual', 250.00),
    ('102', 'doble', 350.00),
    ('201', 'suite_gamer', 600.00),
    ('202', 'doble', 350.00),
    ('103', 'individual', 250.00);

INSERT INTO eventos (nombre, fecha_evento, costo_inscripcion) VALUES
    ('Torneo Valorant Nocturno', '2026-08-15', 50.00),
    ('Copa FIFA Hotel', '2026-08-20', 30.00),
    ('Maraton Speedrun', '2026-08-25', 20.00);

INSERT INTO reservas (id_huesped, id_habitacion, fecha_entrada, fecha_salida, estado) VALUES
    (1, 1, '2026-08-10', '2026-08-13', 'finalizada'),
    (2, 3, '2026-08-12', '2026-08-15', 'finalizada'),
    (3, 2, '2026-08-14', '2026-08-16', 'activa'),
    (4, 4, '2026-08-15', '2026-08-18', 'activa'),
    (5, 5, '2026-08-16', '2026-08-17', 'cancelada'),
    (1, 3, '2026-08-20', '2026-08-23', 'activa'),
    (2, 1, '2026-08-22', '2026-08-24', 'activa');

-- consumos: la reserva 5 (cancelada) no genera ningun consumo.
INSERT INTO consumos (id_reserva, id_evento, descripcion, monto) VALUES
    (1, NULL, 'Servicio a la habitacion', 80.00),
    (1, 1, 'Inscripcion Torneo Valorant Nocturno', 50.00),
    (2, NULL, 'Minibar', 45.00),
    (2, 1, 'Inscripcion Torneo Valorant Nocturno', 50.00),
    (3, NULL, 'Lavanderia', 30.00),
    (4, 2, 'Inscripcion Copa FIFA Hotel', 30.00),
    (4, NULL, 'Restaurante', 120.00),
    (6, 3, 'Inscripcion Maraton Speedrun', 20.00),
    (6, NULL, 'Snacks gamer', 25.00),
    (7, NULL, 'Servicio a la habitacion', 60.00);

-- Caso que debe fallar (queda comentado): registrar un consumo con un
-- evento que no existe viola la FOREIGN KEY de consumos.id_evento.
-- INSERT INTO consumos (id_reserva, id_evento, descripcion, monto) VALUES (1, 999, 'Inscripcion invalida', 10.00);
