-- Ejercicio 20: Eventos Boletos
-- Datos base: 5 lugares, 5 eventos, 5 asistentes, 10 boletos

INSERT INTO lugares (nombre, ciudad, capacidad) VALUES
    ('Domo Polideportivo', 'Ciudad de Guatemala', 5000),
    ('Teatro Nacional', 'Ciudad de Guatemala', 1200),
    ('Estadio Cementos Progreso', 'Ciudad de Guatemala', 15000),
    ('Centro de Convenciones', 'Antigua Guatemala', 800),
    ('Auditorio Campus', 'Ciudad de Guatemala', 300);

INSERT INTO eventos (id_lugar, nombre, fecha, precio_base) VALUES
    (1, 'Concierto Rock Nacional', '2026-09-05 20:00', 150.00),
    (2, 'Obra de Teatro Clasico', '2026-09-10 19:00', 80.00),
    (3, 'Final de Futbol Regional', '2026-09-15 17:00', 200.00),
    (4, 'Conferencia de Tecnologia', '2026-09-20 09:00', 100.00),
    (5, 'Feria de Ciencias del Campus', '2026-09-25 10:00', 25.00);

INSERT INTO asistentes (nombre, correo) VALUES
    ('Manuel Estrada', 'manuel.estrada@correo.com'),
    ('Alejandra Chinchilla', 'alejandra.chinchilla@correo.com'),
    ('Byron Xicay', 'byron.xicay@correo.com'),
    ('Cristina Barrios', 'cristina.barrios@correo.com'),
    ('Douglas Pineda', 'douglas.pineda@correo.com');

INSERT INTO boletos (id_evento, id_asistente, precio, estado, fecha_compra) VALUES
    (1, 1, 150.00, 'vendido', '2026-08-01'),
    (1, 2, 150.00, 'vendido', '2026-08-02'),
    (2, 3, 80.00, 'vendido', '2026-08-01'),
    (2, 4, 80.00, 'reservado', '2026-08-03'),
    (3, 5, 200.00, 'vendido', '2026-08-02'),
    (3, 1, 200.00, 'vendido', '2026-08-04'),
    (4, 2, 100.00, 'reservado', '2026-08-05'),
    (4, 3, 100.00, 'cancelado', '2026-08-01'),
    (5, 4, 25.00, 'vendido', '2026-08-06'),
    (5, 5, 25.00, 'vendido', '2026-08-06');
