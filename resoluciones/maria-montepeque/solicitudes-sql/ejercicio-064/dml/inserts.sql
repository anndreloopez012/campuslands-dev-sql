PRAGMA foreign_keys = ON;

-- Ejercicio 064: Mecanica de Autos
-- Datos base: 5 clientes, 6 vehiculos, 8 diagnosticos, 6 reparaciones,
-- 7 repuestos.

INSERT INTO clientes (nombre, telefono) VALUES
    ('Manuel Estrada', '5555-4001'),
    ('Alejandra Chinchilla', '5555-4002'),
    ('Byron Xicay', '5555-4003'),
    ('Cristina Barrios', '5555-4004'),
    ('Douglas Pineda', '5555-4005');

INSERT INTO vehiculos (id_cliente, placa, marca, modelo) VALUES
    (1, 'P123ABC', 'Toyota', 'Corolla'),
    (2, 'P456DEF', 'Honda', 'Civic'),
    (3, 'P789GHI', 'Mazda', '3'),
    (4, 'P321JKL', 'Nissan', 'Sentra'),
    (5, 'P654MNO', 'Chevrolet', 'Spark'),
    (1, 'P987PQR', 'Toyota', 'Hilux');

INSERT INTO diagnosticos (id_vehiculo, fecha_diagnostico, descripcion, estado) VALUES
    (1, '2026-08-01', 'Ruido en frenos delanteros', 'finalizado'),
    (2, '2026-08-02', 'Falla en encendido', 'finalizado'),
    (3, '2026-08-03', 'Fuga de aceite', 'en_reparacion'),
    (4, '2026-08-04', 'Cambio de bandas de distribucion', 'finalizado'),
    (5, '2026-08-05', 'Revision de bateria', 'pendiente'),
    (6, '2026-08-06', 'Alineacion y balanceo', 'finalizado'),
    (1, '2026-08-10', 'Cambio de aceite', 'finalizado'),
    (2, '2026-08-11', 'Revision de suspension', 'pendiente');

-- reparaciones: solo para diagnosticos ya atendidos (no 'pendiente').
INSERT INTO reparaciones (id_diagnostico, descripcion_trabajo, costo_mano_obra, fecha_reparacion) VALUES
    (1, 'Cambio de pastillas de freno', 350.00, '2026-08-01'),
    (2, 'Reparacion de bobina de encendido', 280.00, '2026-08-02'),
    (3, 'Cambio de sello de carter', 150.00, '2026-08-03'),
    (4, 'Cambio de bandas de distribucion', 420.00, '2026-08-04'),
    (6, 'Alineacion y balanceo de las 4 llantas', 180.00, '2026-08-06'),
    (7, 'Cambio de aceite y filtro', 90.00, '2026-08-10');

INSERT INTO repuestos (id_reparacion, nombre, cantidad, precio_unitario) VALUES
    (1, 'Pastillas de freno', 1, 220.00),
    (2, 'Bobina de encendido', 1, 180.00),
    (3, 'Sello de carter', 2, 25.00),
    (4, 'Banda de distribucion', 1, 150.00),
    (4, 'Kit de tensores', 1, 90.00),
    (6, 'Filtro de aceite', 1, 35.00),
    (6, 'Aceite sintetico 5W-30', 4, 45.00);

-- Caso que debe fallar (queda comentado): una segunda reparacion para el
-- mismo diagnostico viola UNIQUE (id_diagnostico) en reparaciones.
-- INSERT INTO reparaciones (id_diagnostico, descripcion_trabajo, costo_mano_obra) VALUES (1, 'Revision adicional', 50.00);
