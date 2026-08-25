INSERT INTO aeropuertos (
    id_aeropuerto,
    codigo,
    nombre,
    ciudad,
    pais
) VALUES
(1, 'GUA', 'Aeropuerto Internacional La Aurora', 'Guatemala', 'Guatemala'),
(2, 'MEX', 'Aeropuerto Internacional Benito Juarez', 'Ciudad de Mexico', 'Mexico'),
(3, 'SAL', 'Aeropuerto Internacional Monseñor Romero', 'San Salvador', 'El Salvador'),
(4, 'PTY', 'Aeropuerto Internacional Tocumen', 'Ciudad de Panama', 'Panama'),
(5, 'BOG', 'Aeropuerto Internacional El Dorado', 'Bogota', 'Colombia');

INSERT INTO aviones (
    id_avion,
    matricula,
    modelo,
    capacidad,
    estado
) VALUES
(1, 'N101AA', 'Airbus A320', 180, 'activo'),
(2, 'N202BB', 'Boeing 737-800', 189, 'activo'),
(3, 'N303CC', 'Airbus A321', 220, 'activo'),
(4, 'N404DD', 'Embraer E190', 100, 'mantenimiento'),
(5, 'N505EE', 'Boeing 737 MAX 8', 178, 'activo');

INSERT INTO vuelos (
    id_vuelo,
    codigo_vuelo,
    id_avion,
    id_origen,
    id_destino,
    fecha_salida,
    fecha_llegada,
    precio,
    estado
) VALUES
(1, 'CM101', 1, 1, 2, '2026-08-21 08:00:00', '2026-08-21 10:30:00', 185.00, 'programado'),
(2, 'CM202', 2, 2, 1, '2026-08-21 12:00:00', '2026-08-21 14:30:00', 195.00, 'programado'),
(3, 'AV303', 3, 1, 3, '2026-08-22 07:30:00', '2026-08-22 08:45:00', 120.00, 'programado'),
(4, 'AV404', 5, 3, 1, '2026-08-22 15:00:00', '2026-08-22 16:15:00', 125.00, 'programado'),
(5, 'LA505', 1, 1, 4, '2026-08-23 09:00:00', '2026-08-23 12:30:00', 275.00, 'programado'),
(6, 'LA606', 2, 4, 1, '2026-08-23 14:00:00', '2026-08-23 17:30:00', 285.00, 'programado'),
(7, 'AV707', 3, 2, 5, '2026-08-24 06:30:00', '2026-08-24 11:00:00', 320.00, 'programado'),
(8, 'AV808', 5, 5, 2, '2026-08-24 13:00:00', '2026-08-24 17:30:00', 315.00, 'programado'),
(9, 'CM909', 1, 1, 5, '2026-08-25 10:00:00', '2026-08-25 14:30:00', 330.00, 'programado'),
(10, 'CM010', 2, 5, 1, '2026-08-25 16:00:00', '2026-08-25 20:30:00', 325.00, 'programado');

INSERT INTO reservas (
    id_reserva,
    id_vuelo,
    nombre_pasajero,
    documento_pasajero,
    asiento,
    fecha_reserva,
    estado
) VALUES
(1, 1, 'Carlos Ramirez', 'DOC001', '12A', '2026-08-15', 'confirmada'),
(2, 1, 'Ana Lopez', 'DOC002', '12B', '2026-08-15', 'confirmada'),
(3, 2, 'Luis Martinez', 'DOC003', '8A', '2026-08-16', 'confirmada'),
(4, 3, 'Sofia Garcia', 'DOC004', '15C', '2026-08-16', 'pendiente'),
(5, 4, 'Diego Castillo', 'DOC005', '10D', '2026-08-17', 'confirmada'),
(6, 5, 'Maria Hernandez', 'DOC006', '20A', '2026-08-17', 'confirmada'),
(7, 6, 'Jose Morales', 'DOC007', '18B', '2026-08-18', 'pendiente'),
(8, 7, 'Laura Perez', 'DOC008', '22C', '2026-08-18', 'confirmada'),
(9, 8, 'Daniel Gomez', 'DOC009', '14A', '2026-08-19', 'confirmada'),
(10, 9, 'Andrea Torres', 'DOC010', '16B', '2026-08-19', 'pendiente');