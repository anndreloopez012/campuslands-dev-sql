PRAGMA foreign_keys = ON;

-- LUGARES

INSERT INTO lugares (id_lugar, nombre, ciudad, capacidad) VALUES
(1, 'Arena Campus', 'Ciudad de Guatemala', 5000),
(2, 'Centro Cultural Norte', 'Mixco', 1800),
(3, 'Auditorio Central', 'Villa Nueva', 2500),
(4, 'Foro Metropolitano', 'Ciudad de Guatemala', 3500),
(5, 'Plaza Eventos', 'Antigua Guatemala', 1200);

-- EVENTOS

INSERT INTO eventos (id_evento, id_lugar, nombre, fecha, categoria, estado) VALUES
(1, 1, 'Campus Music Fest', '2026-09-12 18:00', 'Musica', 'programado'),
(2, 2, 'Tech Summit Campus', '2026-09-20 09:00', 'Tecnologia', 'programado'),
(3, 3, 'Festival Gaming GT', '2026-10-03 14:00', 'Gaming', 'programado'),
(4, 4, 'Noche de Comedia', '2026-10-10 19:30', 'Comedia', 'programado'),
(5, 5, 'Feria Creativa', '2026-10-18 10:00', 'Arte', 'programado');

-- ASISTENTES

INSERT INTO asistentes (id_asistente, nombre_completo, correo, telefono) VALUES
(1, 'Carlos Velasco', 'carlos.velasco@example.com', '55510001'),
(2, 'Ana Martinez', 'ana.martinez@example.com', '55510002'),
(3, 'Luis Hernandez', 'luis.hernandez@example.com', '55510003'),
(4, 'Sofia Ramirez', 'sofia.ramirez@example.com', '55510004'),
(5, 'Diego Morales', 'diego.morales@example.com', '55510005');

-- BOLETOS

INSERT INTO boletos (
    id_boleto,
    id_evento,
    id_asistente,
    tipo,
    precio,
    fecha_compra,
    estado
) VALUES
(1, 1, 1, 'vip', 450.00, '2026-08-01 10:15', 'activo'),
(2, 1, 2, 'general', 180.00, '2026-08-02 11:20', 'activo'),
(3, 2, 3, 'preferencial', 300.00, '2026-08-03 09:30', 'activo'),
(4, 2, 4, 'general', 150.00, '2026-08-04 14:10', 'activo'),
(5, 3, 5, 'vip', 500.00, '2026-08-05 16:45', 'activo'),
(6, 3, 1, 'general', 200.00, '2026-08-06 08:25', 'activo'),
(7, 4, 2, 'preferencial', 280.00, '2026-08-07 13:50', 'activo'),
(8, 4, 3, 'general', 160.00, '2026-08-08 15:35', 'activo'),
(9, 5, 4, 'vip', 400.00, '2026-08-09 10:05', 'activo'),
(10, 5, 5, 'general', 120.00, '2026-08-10 17:20', 'activo');