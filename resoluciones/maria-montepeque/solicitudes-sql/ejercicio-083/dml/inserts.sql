PRAGMA foreign_keys = ON;

-- Ejercicio 083: Viajes y Paracaidismo
-- Datos base: 4 clientes, 3 experiencias, 2 instructores, 4 reservas
-- (2 realizadas con pago, 1 confirmada sin pago todavia, 1 marcada
-- realizada por error con un pago que se debe corregir) y sus pagos.

INSERT INTO clientes (nombre_cliente, telefono) VALUES
    ('Manuel Estrada', '5555-7101'),
    ('Alejandra Chinchilla', '5555-7102'),
    ('Byron Xicay', '5555-7103'),
    ('Cristina Barrios', '5555-7104');

INSERT INTO experiencias (nombre_experiencia, tipo, precio) VALUES
    ('Salto en Tandem', 'paracaidismo', 1800.00),
    ('Tour Volcan Pacaya', 'tour', 450.00),
    ('Buceo en Arrecife', 'buceo', 900.00);

INSERT INTO instructores (nombre_instructor, certificacion) VALUES
    ('Hugo Marroquin', 'USPA nivel 2'),
    ('Cristina Barrios Guia', 'PADI Open Water');

-- Reserva 1: Manuel, Salto en Tandem, realizada.
INSERT INTO reservas (id_cliente, id_experiencia, id_instructor, fecha_reserva, estado) VALUES
    (1, 1, 1, '2026-08-01', 'realizada');
INSERT INTO pagos (id_reserva, monto, metodo_pago) VALUES
    (1, 1800.00, 'tarjeta');

-- Reserva 2: Alejandra, Tour Volcan Pacaya, realizada.
INSERT INTO reservas (id_cliente, id_experiencia, id_instructor, fecha_reserva, estado) VALUES
    (2, 2, 2, '2026-08-02', 'realizada');
INSERT INTO pagos (id_reserva, monto, metodo_pago) VALUES
    (2, 450.00, 'transferencia');

-- Reserva 3: Byron, Buceo en Arrecife, confirmada (todavia sin pago).
INSERT INTO reservas (id_cliente, id_experiencia, id_instructor, fecha_reserva, estado) VALUES
    (3, 3, 2, '2026-08-05', 'confirmada');

-- Reserva 4: Cristina, Salto en Tandem. Se marco 'realizada' y se
-- proceso el pago, pero despues se confirmo que la clienta cancelo
-- antes de saltar (el equipo de ventas se adelanto). Se corrige en
-- dml/operaciones.sql.
INSERT INTO reservas (id_cliente, id_experiencia, id_instructor, fecha_reserva, estado) VALUES
    (4, 1, 2, '2026-08-06', 'realizada');
INSERT INTO pagos (id_reserva, monto, metodo_pago) VALUES
    (4, 1800.00, 'tarjeta');

-- Caso comentado que debe fallar (queda comentado): registrar de
-- nuevo la reserva de Manuel Estrada para Salto en Tandem el mismo
-- dia, exactamente el problema de registros duplicados que describio
-- el cliente. El UNIQUE (id_cliente, id_experiencia, fecha_reserva)
-- lo bloquea.
-- INSERT INTO reservas (id_cliente, id_experiencia, id_instructor, fecha_reserva) VALUES (1, 1, 1, '2026-08-01');
