PRAGMA foreign_keys = ON;

-- Ejercicio 063: Clinica de Tatuajes
-- Datos base: 5 clientes, 3 artistas, 4 estilos, 10 sesiones, 6 pagos.

INSERT INTO clientes (nombre, telefono) VALUES
    ('Manuel Estrada', '5555-3001'),
    ('Alejandra Chinchilla', '5555-3002'),
    ('Byron Xicay', '5555-3003'),
    ('Cristina Barrios', '5555-3004'),
    ('Douglas Pineda', '5555-3005');

INSERT INTO artistas (nombre, especialidad) VALUES
    ('Sergio Lopez', 'Realismo'),
    ('Fernanda Castillo', 'Blackwork'),
    ('Kevin Morales', 'Tradicional Japones');

INSERT INTO estilos (nombre) VALUES
    ('Realismo'),
    ('Blackwork'),
    ('Tradicional Japones'),
    ('Acuarela');

INSERT INTO sesiones (id_cliente, id_artista, id_estilo, fecha_sesion, duracion_horas, estado) VALUES
    (1, 1, 1, '2026-07-01', 3.5, 'completada'),
    (2, 2, 2, '2026-07-03', 2.0, 'completada'),
    (3, 3, 3, '2026-07-05', 4.0, 'completada'),
    (4, 1, 1, '2026-07-10', 1.5, 'completada'),
    (5, 2, 2, '2026-07-12', 3.0, 'agendada'),
    (1, 3, 3, '2026-07-15', 2.5, 'agendada'),
    (2, 1, 1, '2026-07-18', 2.0, 'cancelada'),
    (3, 2, 4, '2026-07-20', 3.5, 'completada'),
    (4, 3, 2, '2026-07-22', 1.0, 'completada'),
    (5, 1, 3, '2026-07-25', 4.5, 'agendada');

-- pagos: solo de sesiones ya completadas; la sesion 8 se registra con
-- pago pendiente (se confirma en operaciones.sql).
INSERT INTO pagos (id_sesion, monto, metodo_pago, estado_pago) VALUES
    (1, 350.00, 'tarjeta', 'pagado'),
    (2, 220.00, 'efectivo', 'pagado'),
    (3, 480.00, 'transferencia', 'pagado'),
    (4, 150.00, 'tarjeta', 'pagado'),
    (9, 100.00, 'tarjeta', 'pagado');

INSERT INTO pagos (id_sesion, monto, metodo_pago) VALUES
    (8, 380.00, 'efectivo');

-- Caso que debe fallar (queda comentado): registrar un segundo pago para
-- la misma sesion viola UNIQUE (id_sesion) en pagos.
-- INSERT INTO pagos (id_sesion, monto, metodo_pago) VALUES (1, 350.00, 'efectivo');
