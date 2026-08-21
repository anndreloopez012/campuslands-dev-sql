PRAGMA foreign_keys = ON;

-- Ejercicio 016: Hotel Gamers
-- Datos de prueba.

INSERT INTO habitaciones (numero_habitacion, tipo, precio_noche, estado) VALUES
    ('101', 'individual', 350.00, 'disponible'),
    ('102', 'doble', 550.00, 'disponible'),
    ('201', 'suite_gamer', 950.00, 'disponible'),
    ('202', 'suite_gamer', 950.00, 'disponible'),
    ('301', 'doble', 550.00, 'disponible');

-- La reserva 9 es una entrada de prueba (huesped "Cuenta de Prueba") que
-- se cargo por error: se elimina en dml/operaciones.sql.
INSERT INTO reservas (id_habitacion, nombre_huesped, fecha_entrada, fecha_salida, monto_total, estado) VALUES
    (1, 'Ana Gomez', '2026-08-01', '2026-08-03', 700.00, 'finalizada'),
    (3, 'Luis Marroquin', '2026-08-02', '2026-08-05', 2850.00, 'finalizada'),
    (2, 'Karen Solis', '2026-08-05', '2026-08-07', 1100.00, 'en_curso'),
    (4, 'Diego Paz', '2026-08-06', '2026-08-08', 1900.00, 'confirmada'),
    (5, 'Rosa Chavez', '2026-08-08', '2026-08-10', 1100.00, 'confirmada'),
    (1, 'Julio Perez', '2026-08-10', '2026-08-11', 350.00, 'cancelada'),
    (3, 'Ana Gomez', '2026-08-12', '2026-08-14', 1900.00, 'confirmada'),
    (2, 'Luis Marroquin', '2026-08-13', '2026-08-15', 1100.00, 'finalizada'),
    (1, 'Cuenta de Prueba', '2026-08-01', '2026-08-03', 700.00, 'confirmada');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- monto_total en cero, viola el CHECK de reservas.
-- INSERT INTO reservas (id_habitacion, nombre_huesped, fecha_entrada, fecha_salida, monto_total) VALUES (2, 'Tomas Blanco', '2026-08-20', '2026-08-21', 0);
