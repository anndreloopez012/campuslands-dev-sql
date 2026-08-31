PRAGMA foreign_keys = ON;

-- Ejercicio 088: Clinica de Tatuajes
-- Datos base: 4 clientes, 3 artistas, 3 estilos, 5 sesiones (3
-- finalizadas con pago, 1 programada = caso pendiente, 1 marcada
-- finalizada por error con un pago que se corrige despues).

INSERT INTO clientes (nombre_cliente, telefono) VALUES
    ('Manuel Estrada', '5555-9101'),
    ('Alejandra Chinchilla', '5555-9102'),
    ('Byron Xicay', '5555-9103'),
    ('Cristina Barrios', '5555-9104');

INSERT INTO artistas (nombre_artista, especialidad) VALUES
    ('Karla Rivas', 'realismo'),
    ('Bryan Solis', 'tradicional americano'),
    ('Fernanda Lopez', 'blackwork');

INSERT INTO estilos (nombre_estilo, dificultad) VALUES
    ('Realismo', 'alta'),
    ('Tradicional Americano', 'media'),
    ('Blackwork', 'alta');

-- Sesion 1: Manuel con Karla Rivas, Realismo, finalizada.
INSERT INTO sesiones (id_cliente, id_artista, id_estilo, fecha_sesion, duracion_horas, estado) VALUES
    (1, 1, 1, '2026-08-01', 3, 'finalizada');
INSERT INTO pagos (id_sesion, monto, metodo_pago) VALUES
    (1, 900.00, 'tarjeta');

-- Sesion 2: Alejandra con Bryan Solis, Tradicional Americano,
-- finalizada.
INSERT INTO sesiones (id_cliente, id_artista, id_estilo, fecha_sesion, duracion_horas, estado) VALUES
    (2, 2, 2, '2026-08-02', 2, 'finalizada');
INSERT INTO pagos (id_sesion, monto, metodo_pago) VALUES
    (2, 500.00, 'efectivo');

-- Sesion 3: Byron con Fernanda Lopez, Blackwork, finalizada.
INSERT INTO sesiones (id_cliente, id_artista, id_estilo, fecha_sesion, duracion_horas, estado) VALUES
    (3, 3, 3, '2026-08-03', 4, 'finalizada');
INSERT INTO pagos (id_sesion, monto, metodo_pago) VALUES
    (3, 1200.00, 'tarjeta');

-- Sesion 4: Cristina con Karla Rivas, Realismo, todavia sin agendar
-- del todo (caso pendiente).
INSERT INTO sesiones (id_cliente, id_artista, id_estilo, fecha_sesion, duracion_horas, estado) VALUES
    (4, 1, 1, '2026-08-08', 3, 'programada');

-- Sesion 5: Manuel con Bryan Solis, Tradicional Americano. Se marco
-- 'finalizada' y se proceso el pago, pero despues Manuel pidio
-- posponerla. Se corrige en dml/operaciones.sql.
INSERT INTO sesiones (id_cliente, id_artista, id_estilo, fecha_sesion, duracion_horas, estado) VALUES
    (1, 2, 2, '2026-08-05', 2, 'finalizada');
INSERT INTO pagos (id_sesion, monto, metodo_pago) VALUES
    (5, 500.00, 'tarjeta');

-- Caso comentado que debe fallar (queda comentado): registrar un
-- segundo pago para la sesion 1, exactamente el tipo de dato
-- duplicado que este UNIQUE esta disenado para evitar.
-- INSERT INTO pagos (id_sesion, monto, metodo_pago) VALUES (1, 900.00, 'tarjeta');
