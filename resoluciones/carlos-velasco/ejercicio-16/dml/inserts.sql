PRAGMA foreign_keys = ON;

-- AEROPUERTOS

INSERT INTO aeropuertos (id_aeropuerto, codigo_iata, nombre, ciudad, pais) VALUES
(1, 'GUA', 'Aeropuerto Internacional La Aurora', 'Ciudad de Guatemala', 'Guatemala'),
(2, 'MEX', 'Aeropuerto Internacional Benito Juarez', 'Ciudad de Mexico', 'Mexico'),
(3, 'SAL', 'Aeropuerto Internacional El Salvador', 'San Salvador', 'El Salvador'),
(4, 'PTY', 'Aeropuerto Internacional de Tocumen', 'Ciudad de Panama', 'Panama'),
(5, 'BOG', 'Aeropuerto Internacional El Dorado', 'Bogota', 'Colombia');

-- AVIONES

INSERT INTO aviones (id_avion, matricula, modelo, capacidad, estado) VALUES
(1, 'N101CA', 'Airbus A320', 180, 'ACTIVO'),
(2, 'N202CA', 'Boeing 737-800', 189, 'ACTIVO'),
(3, 'N303CA', 'Airbus A321', 220, 'ACTIVO'),
(4, 'N404CA', 'Embraer E190', 100, 'MANTENIMIENTO'),
(5, 'N505CA', 'Boeing 737 MAX 8', 178, 'ACTIVO');

-- VUELOS

INSERT INTO vuelos (
    id_vuelo,
    codigo_vuelo,
    aeropuerto_origen_id,
    aeropuerto_destino_id,
    avion_id,
    fecha_salida,
    fecha_llegada,
    estado
) VALUES
(1, 'CA101', 1, 2, 1, '2026-09-01 06:30', '2026-09-01 09:15', 'PROGRAMADO'),
(2, 'CA102', 2, 1, 2, '2026-09-01 11:00', '2026-09-01 13:45', 'PROGRAMADO'),
(3, 'CA201', 1, 3, 3, '2026-09-02 08:00', '2026-09-02 09:00', 'PROGRAMADO'),
(4, 'CA202', 3, 1, 5, '2026-09-02 14:30', '2026-09-02 15:30', 'PROGRAMADO'),
(5, 'CA301', 1, 4, 1, '2026-09-03 07:15', '2026-09-03 10:00', 'PROGRAMADO'),
(6, 'CA302', 4, 1, 2, '2026-09-03 16:00', '2026-09-03 18:45', 'PROGRAMADO'),
(7, 'CA401', 2, 5, 3, '2026-09-04 09:20', '2026-09-04 14:10', 'PROGRAMADO'),
(8, 'CA402', 5, 2, 5, '2026-09-04 16:00', '2026-09-04 20:50', 'PROGRAMADO'),
(9, 'CA501', 1, 5, 2, '2026-09-05 10:30', '2026-09-05 14:30', 'PROGRAMADO'),
(10, 'CA502', 5, 1, 1, '2026-09-05 17:00', '2026-09-05 21:00', 'PROGRAMADO'),
(11, 'CA601', 3, 4, 3, '2026-09-06 08:45', '2026-09-06 11:00', 'PROGRAMADO'),
(12, 'CA602', 4, 3, 5, '2026-09-06 13:30', '2026-09-06 15:45', 'PROGRAMADO');

-- RESERVAS

INSERT INTO reservas (
    id_reserva,
    vuelo_id,
    nombre_pasajero,
    documento,
    asiento,
    fecha_reserva,
    estado
) VALUES
(1, 1, 'Carlos Ramirez', 'DOC1001', '12A', '2026-08-10', 'CONFIRMADA'),
(2, 1, 'Maria Lopez', 'DOC1002', '12B', '2026-08-11', 'CONFIRMADA'),
(3, 2, 'Juan Hernandez', 'DOC1003', '08C', '2026-08-12', 'CONFIRMADA'),
(4, 3, 'Ana Martinez', 'DOC1004', '15A', '2026-08-12', 'CONFIRMADA'),
(5, 3, 'Luis Garcia', 'DOC1005', '15B', '2026-08-13', 'PENDIENTE'),
(6, 4, 'Sofia Morales', 'DOC1006', '06C', '2026-08-14', 'CONFIRMADA'),
(7, 5, 'Diego Castillo', 'DOC1007', '20A', '2026-08-14', 'CONFIRMADA'),
(8, 5, 'Laura Perez', 'DOC1008', '20B', '2026-08-15', 'CONFIRMADA'),
(9, 7, 'Miguel Torres', 'DOC1009', '18D', '2026-08-15', 'CONFIRMADA'),
(10, 7, 'Gabriela Ruiz', 'DOC1010', '18E', '2026-08-16', 'PENDIENTE'),
(11, 9, 'Andres Gomez', 'DOC1011', '10A', '2026-08-16', 'CONFIRMADA'),
(12, 10, 'Valeria Diaz', 'DOC1012', '22F', '2026-08-17', 'CONFIRMADA'),
(13, 11, 'Fernando Cruz', 'DOC1013', '05A', '2026-08-17', 'CONFIRMADA'),
(14, 12, 'Paula Mendoza', 'DOC1014', '07B', '2026-08-18', 'CONFIRMADA');