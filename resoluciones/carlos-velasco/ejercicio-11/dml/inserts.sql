PRAGMA foreign_keys = ON;

-- RUTAS

INSERT INTO rutas (
    id_ruta,
    codigo,
    origen,
    destino,
    distancia_km
) VALUES
(1, 'R-001', 'Ciudad Capital', 'Antigua', 45.5),
(2, 'R-002', 'Ciudad Capital', 'Escuintla', 58.0),
(3, 'R-003', 'Ciudad Capital', 'Quetzaltenango', 205.0),
(4, 'R-004', 'Ciudad Capital', 'Puerto Barrios', 295.0),
(5, 'R-005', 'Antigua', 'Panajachel', 112.0);

-- BUSES

INSERT INTO buses (
    id_bus,
    placa,
    modelo,
    capacidad,
    anio,
    estado
) VALUES
(1, 'BUS-1001', 'Mercedes Benz Sprinter', 25, 2022, 'Disponible'),
(2, 'BUS-1002', 'Volvo B340M', 45, 2021, 'Disponible'),
(3, 'BUS-1003', 'Mercedes Benz O500', 50, 2023, 'Disponible'),
(4, 'BUS-1004', 'Scania K360', 55, 2020, 'Disponible'),
(5, 'BUS-1005', 'Volvo B380', 60, 2024, 'Disponible');

-- CONDUCTORES

INSERT INTO conductores (
    id_conductor,
    nombre_completo,
    documento,
    licencia,
    telefono,
    estado
) VALUES
(1, 'Carlos Mendoza Lopez', 'CON-1001', 'LIC-2001', '5551-1001', 'Activo'),
(2, 'Ana Rodriguez Perez', 'CON-1002', 'LIC-2002', '5551-1002', 'Activo'),
(3, 'Luis Hernandez Garcia', 'CON-1003', 'LIC-2003', '5551-1003', 'Activo'),
(4, 'Sofia Martinez Torres', 'CON-1004', 'LIC-2004', '5551-1004', 'Activo'),
(5, 'Daniela Castillo Ruiz', 'CON-1005', 'LIC-2005', '5551-1005', 'Activo');

-- VIAJES

INSERT INTO viajes (
    id_viaje,
    id_ruta,
    id_bus,
    id_conductor,
    fecha_hora,
    pasajeros_registrados,
    estado
) VALUES
(1, 1, 1, 1, '2026-08-21 07:00', 20, 'Programado'),
(2, 2, 2, 2, '2026-08-21 08:00', 38, 'Programado'),
(3, 3, 3, 3, '2026-08-21 09:00', 46, 'Programado'),
(4, 4, 4, 4, '2026-08-21 10:00', 51, 'Programado'),
(5, 5, 5, 5, '2026-08-21 11:00', 54, 'Programado'),
(6, 1, 2, 1, '2026-08-22 07:30', 35, 'Programado'),
(7, 2, 3, 2, '2026-08-22 08:30', 42, 'Programado'),
(8, 3, 4, 3, '2026-08-22 09:30', 48, 'Programado'),
(9, 4, 5, 4, '2026-08-22 10:30', 57, 'Programado'),
(10, 5, 1, 5, '2026-08-22 11:30', 18, 'Programado');