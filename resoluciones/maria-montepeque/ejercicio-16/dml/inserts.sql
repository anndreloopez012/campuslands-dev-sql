-- Ejercicio 16: Aerolinea Vuelos
-- Datos base: 5 aeropuertos, 5 aviones, 5 vuelos, 10 reservas

INSERT INTO aeropuertos (codigo, nombre, ciudad) VALUES
    ('GUA', 'La Aurora', 'Ciudad de Guatemala'),
    ('MEX', 'Benito Juarez', 'Ciudad de Mexico'),
    ('MIA', 'Miami International', 'Miami'),
    ('BOG', 'El Dorado', 'Bogota'),
    ('MAD', 'Barajas', 'Madrid');

INSERT INTO aviones (matricula, modelo, capacidad) VALUES
    ('TG-AAA', 'Boeing 737', 180),
    ('TG-BBB', 'Airbus A320', 160),
    ('TG-CCC', 'Boeing 787', 250),
    ('TG-DDD', 'Airbus A321', 190),
    ('TG-EEE', 'Embraer 190', 100);

INSERT INTO vuelos (id_avion, id_aeropuerto_origen, id_aeropuerto_destino, fecha_salida, precio_base) VALUES
    (1, 1, 2, '2026-08-10 08:00', 250.00),
    (2, 1, 3, '2026-08-11 09:30', 400.00),
    (3, 2, 4, '2026-08-12 14:00', 350.00),
    (4, 1, 5, '2026-08-13 22:00', 800.00),
    (5, 4, 1, '2026-08-14 06:45', 300.00);

INSERT INTO reservas (id_vuelo, pasajero, asiento, precio_pagado, estado) VALUES
    (1, 'Manuel Estrada', '1A', 250.00, 'confirmada'),
    (1, 'Alejandra Chinchilla', '1B', 250.00, 'confirmada'),
    (2, 'Byron Xicay', '2A', 400.00, 'confirmada'),
    (2, 'Cristina Barrios', '2B', 420.00, 'pendiente'),
    (3, 'Douglas Pineda', '3A', 350.00, 'confirmada'),
    (3, 'Ingrid Say', '3B', 350.00, 'cancelada'),
    (4, 'Manuel Estrada', '4A', 800.00, 'confirmada'),
    (4, 'Byron Xicay', '4B', 820.00, 'pendiente'),
    (5, 'Alejandra Chinchilla', '5A', 300.00, 'confirmada'),
    (5, 'Cristina Barrios', '5B', 300.00, 'confirmada');
