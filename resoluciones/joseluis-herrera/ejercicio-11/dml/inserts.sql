INSERT INTO rutas (id_ruta, origen, destino, distancia_km) VALUES
(1, 'Ciudad de Guatemala', 'Antigua Guatemala', 39.5),
(2, 'Ciudad de Guatemala', 'Quetzaltenango', 201.0),
(3, 'Ciudad de Guatemala', 'Escuintla', 58.0),
(4, 'Ciudad de Guatemala', 'Cobán', 214.0),
(5, 'Antigua Guatemala', 'Escuintla', 76.0);

INSERT INTO buses (id_bus, placa, modelo, capacidad) VALUES
(1, 'CBA-101', 'Mercedes-Benz Sprinter', 30),
(2, 'CBA-202', 'Toyota Coaster', 35),
(3, 'CBA-303', 'Mercedes-Benz Citaro', 45),
(4, 'CBA-404', 'Volvo B8R', 50),
(5, 'CBA-505', 'Scania K360', 55);

INSERT INTO conductores (id_conductor, nombre_completo, licencia, experiencia_anios) VALUES
(1, 'Carlos Ramirez', 'LIC-1001', 8),
(2, 'Miguel Hernandez', 'LIC-1002', 12),
(3, 'Juan Perez', 'LIC-1003', 5),
(4, 'Andres Lopez', 'LIC-1004', 10),
(5, 'Roberto Castillo', 'LIC-1005', 15);

INSERT INTO viajes (id_viaje, id_ruta, id_bus, id_conductor, fecha_viaje, hora_salida, pasajeros, estado) VALUES
(1, 1, 1, 1, '2026-08-21', '07:00', 24, 'Programado'),
(2, 2, 2, 2, '2026-08-21', '08:30', 31, 'Programado'),
(3, 3, 3, 3, '2026-08-21', '09:00', 40, 'Programado'),
(4, 4, 4, 4, '2026-08-22', '06:30', 45, 'Programado'),
(5, 5, 5, 5, '2026-08-22', '10:00', 52, 'Programado'),
(6, 1, 2, 3, '2026-08-23', '07:30', 28, 'Programado'),
(7, 2, 3, 4, '2026-08-23', '08:00', 42, 'En curso'),
(8, 3, 4, 5, '2026-08-24', '09:30', 47, 'Programado'),
(9, 4, 5, 1, '2026-08-24', '06:00', 50, 'Programado'),
(10, 5, 1, 2, '2026-08-25', '11:00', 26, 'Finalizado');