PRAGMA foreign_keys = ON;

-- Ejercicio 041: Hotel Gamers
-- Datos de prueba.

INSERT INTO huespedes (nombre_huesped, email) VALUES
    ('Kevin Barrios', 'kevin.barrios@correo.com'),
    ('Paola Fuentes', 'paola.fuentes@correo.com'),
    ('Marlon Chinchilla', 'marlon.chinchilla@correo.com'),
    ('Daniela Us', 'daniela.us@correo.com'),
    ('Roberto Salazar', 'roberto.salazar@correo.com');

INSERT INTO habitaciones (numero_habitacion, tipo, precio_noche) VALUES
    ('H-101', 'individual', 350.00),
    ('H-102', 'doble', 550.00),
    ('H-201', 'suite_gamer', 950.00),
    ('H-202', 'suite_gamer', 950.00),
    ('H-103', 'individual', 350.00);

-- La reserva 9 es un duplicado por error de digitacion (mismo
-- huesped, habitacion, fechas y estado que la reserva 1): se corrige
-- en dml/operaciones.sql. La reserva 6 (Roberto Salazar) se cancelo
-- sin generar ningun consumo, y se borrara de forma controlada.
INSERT INTO reservas (id_huesped, id_habitacion, fecha_checkin, fecha_checkout, estado) VALUES
    (1, 3, '2026-08-01', '2026-08-04', 'finalizada'),
    (2, 1, '2026-08-02', '2026-08-03', 'finalizada'),
    (3, 4, '2026-08-05', '2026-08-08', 'en_curso'),
    (4, 2, '2026-08-06', '2026-08-07', 'confirmada'),
    (1, 3, '2026-08-10', '2026-08-12', 'confirmada'),
    (5, 5, '2026-08-09', '2026-08-10', 'cancelada'),
    (2, 1, '2026-08-15', '2026-08-16', 'cancelada'),
    (3, 2, '2026-08-18', '2026-08-20', 'confirmada'),
    (1, 3, '2026-08-01', '2026-08-04', 'finalizada');

-- Consumos: notese que la reserva 6 (Roberto Salazar, cancelada) no
-- tiene ningun consumo, y la reserva 7 (Paola Fuentes, cancelada) si
-- tiene uno (un deposito ya cobrado). Esa diferencia es justo lo que
-- decide si una reserva cancelada se puede borrar o no.
INSERT INTO consumos (id_reserva, descripcion, monto, fecha_consumo) VALUES
    (1, 'Renta de consola extra', 150.00, '2026-08-01'),
    (1, 'Snacks y bebidas', 80.00, '2026-08-02'),
    (2, 'Torneo interno - inscripcion', 50.00, '2026-08-02'),
    (3, 'Renta de consola extra', 150.00, '2026-08-05'),
    (3, 'Snacks y bebidas', 120.00, '2026-08-06'),
    (5, 'Torneo interno - inscripcion', 50.00, '2026-08-10'),
    (7, 'Deposito no reembolsable', 30.00, '2026-08-15');

-- Casos comentados que deben fallar (no ser recomendables), dejar
-- comentados:

-- 1) Registro repetido: numero_habitacion ya existe, viola el UNIQUE.
-- INSERT INTO habitaciones (numero_habitacion, tipo, precio_noche) VALUES ('H-101', 'doble', 500.00);

-- 2) Fechas invalidas: fecha_checkout antes que fecha_checkin, viola el CHECK.
-- INSERT INTO reservas (id_huesped, id_habitacion, fecha_checkin, fecha_checkout) VALUES (4, 5, '2026-08-20', '2026-08-18');
