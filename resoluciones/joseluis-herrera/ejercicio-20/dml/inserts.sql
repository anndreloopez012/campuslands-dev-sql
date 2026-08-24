INSERT INTO lugares (
    id_lugar,
    nombre,
    direccion,
    capacidad,
    ciudad
) VALUES
(1, 'Centro de Convenciones Aurora', 'Avenida Reforma 101', 1200, 'Guatemala'),
(2, 'Teatro Central', 'Calle Principal 25', 800, 'Guatemala'),
(3, 'Arena Campus', 'Zona Universitaria 12', 2500, 'Guatemala'),
(4, 'Auditorio Metropolitano', 'Avenida Las Americas 45', 1500, 'Guatemala'),
(5, 'Foro Cultural Norte', 'Boulevard Norte 78', 600, 'Guatemala');

INSERT INTO eventos (
    id_evento,
    id_lugar,
    nombre,
    fecha_evento,
    categoria,
    precio_base
) VALUES
(1, 1, 'Tech Summit 2026', '2026-09-10', 'Tecnologia', 250.00),
(2, 2, 'Festival de Musica Campus', '2026-09-15', 'Musica', 180.00),
(3, 3, 'Conferencia de Innovacion', '2026-09-20', 'Educacion', 120.00),
(4, 4, 'Noche de Comedia', '2026-09-25', 'Entretenimiento', 90.00),
(5, 5, 'Feria de Emprendimiento', '2026-10-01', 'Negocios', 75.00);

INSERT INTO asistentes (
    id_asistente,
    nombre_completo,
    documento,
    correo,
    telefono
) VALUES
(1, 'Carlos Ramirez', '30030001', 'carlos.ramirez@email.com', '55510001'),
(2, 'Ana Lopez', '30030002', 'ana.lopez@email.com', '55510002'),
(3, 'Luis Martinez', '30030003', 'luis.martinez@email.com', '55510003'),
(4, 'Sofia Garcia', '30030004', 'sofia.garcia@email.com', '55510004'),
(5, 'Diego Castillo', '30030005', 'diego.castillo@email.com', '55510005');

INSERT INTO boletos (
    id_boleto,
    id_evento,
    id_asistente,
    codigo,
    fecha_compra,
    precio_pagado,
    estado
) VALUES
(1, 1, 1, 'BOL-0001', '2026-08-01 10:15', 250.00, 'ACTIVO'),
(2, 1, 2, 'BOL-0002', '2026-08-02 11:20', 250.00, 'ACTIVO'),
(3, 2, 3, 'BOL-0003', '2026-08-03 09:30', 180.00, 'ACTIVO'),
(4, 2, 4, 'BOL-0004', '2026-08-04 14:10', 180.00, 'USADO'),
(5, 3, 5, 'BOL-0005', '2026-08-05 15:25', 120.00, 'ACTIVO'),
(6, 3, 1, 'BOL-0006', '2026-08-06 16:40', 120.00, 'ACTIVO'),
(7, 4, 2, 'BOL-0007', '2026-08-07 12:05', 90.00, 'USADO'),
(8, 4, 3, 'BOL-0008', '2026-08-08 13:50', 90.00, 'ACTIVO'),
(9, 5, 4, 'BOL-0009', '2026-08-09 10:45', 75.00, 'ACTIVO'),
(10, 5, 5, 'BOL-0010', '2026-08-10 17:15', 75.00, 'ACTIVO');