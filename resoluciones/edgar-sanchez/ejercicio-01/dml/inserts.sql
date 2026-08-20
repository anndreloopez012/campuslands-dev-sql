PRAGMA foreign_keys = ON;

INSERT INTO peliculas (titulo, clasificacion, duracion_minutos, genero, precio_base) VALUES
('Inception', 'PG-13', 148, 'Ciencia Ficción', 45.00),
('The Dark Knight', 'PG-13', 152, 'Acción', 50.00),
('Interstellar', 'PG-13', 169, 'Ciencia Ficción', 50.00),
('Toy Story 4', 'G', 100, 'Animación', 35.00),
('Spider-Man: Across the Spider-Verse', 'PG', 140, 'Animación', 40.00);

INSERT INTO salas (nombre_sala, capacidad_asientos, tipo_pantalla) VALUES
('Sala 1 - Principal', 150, 'IMAX'),
('Sala 2 - MacroXE', 120, '3D'),
('Sala 3 - VIP', 50, '4DX'),
('Sala 4 - Junior', 80, 'Estándar'),
('Sala 5 - Tradicional', 100, 'Estándar');

INSERT INTO funciones (pelicula_id, sala_id, fecha_hora_inicio, precio_boleto) VALUES
(1, 1, '2026-08-25 14:00', 50.00),
(1, 1, '2026-08-25 18:00', 55.00),
(2, 2, '2026-08-25 15:30', 50.00),
(3, 1, '2026-08-26 20:00', 60.00),
(4, 4, '2026-08-25 11:00', 35.00);

INSERT INTO boletos (funcion_id, numero_asiento, fecha_venta, metodo_pago, monto_pagado) VALUES
(1, 'A1', '2026-08-20 10:15', 'Tarjeta', 50.00),
(1, 'A2', '2026-08-20 10:16', 'Tarjeta', 50.00),
(1, 'B5', '2026-08-20 11:30', 'Efectivo', 50.00),
(2, 'C10', '2026-08-20 12:00', 'Transferencia', 55.00),
(2, 'C11', '2026-08-20 12:01', 'Transferencia', 55.00),
(3, 'D1', '2026-08-20 13:45', 'Efectivo', 50.00),
(3, 'D2', '2026-08-20 13:46', 'Efectivo', 50.00),
(4, 'F8', '2026-08-20 14:20', 'Tarjeta', 60.00),
(4, 'F9', '2026-08-20 14:22', 'Tarjeta', 60.00),
(5, 'E3', '2026-08-20 15:10', 'Efectivo', 35.00);