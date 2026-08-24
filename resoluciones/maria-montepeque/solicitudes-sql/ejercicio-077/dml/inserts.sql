PRAGMA foreign_keys = ON;

-- Ejercicio 077: Taller de Motos
-- Datos base: 3 clientes, 3 motos, 5 repuestos, 4 ordenes (2
-- finalizadas, 1 en reparacion, 1 recibida con una linea cargada por
-- error) y sus lineas de detalle.

INSERT INTO clientes (nombre_cliente, telefono) VALUES
    ('Manuel Estrada', '5555-6001'),
    ('Alejandra Chinchilla', '5555-6002'),
    ('Byron Xicay', '5555-6003');

INSERT INTO motos (id_cliente, placa, modelo) VALUES
    (1, 'P-001ABC', 'Yamaha FZ 150'),
    (2, 'P-002DEF', 'Honda CB 190'),
    (3, 'P-003GHI', 'Suzuki GN 125');

INSERT INTO repuestos (nombre_repuesto, precio_unitario) VALUES
    ('Aceite Motor', 85.00),
    ('Filtro Aire', 45.00),
    ('Pastillas Freno', 120.00),
    ('Cadena Transmision', 210.00),
    ('Bujia', 30.00);

-- Orden 1: moto de Manuel, finalizada.
INSERT INTO ordenes_servicio (id_moto, descripcion, estado) VALUES
    (1, 'Cambio de aceite y filtro', 'finalizada');
INSERT INTO detalle_repuestos (id_orden, id_repuesto, cantidad, precio_unitario) VALUES
    (1, 1, 1, 85.00),
    (1, 2, 1, 45.00);

-- Orden 2: moto de Alejandra, finalizada.
INSERT INTO ordenes_servicio (id_moto, descripcion, estado) VALUES
    (2, 'Cambio de pastillas de freno y bujia', 'finalizada');
INSERT INTO detalle_repuestos (id_orden, id_repuesto, cantidad, precio_unitario) VALUES
    (2, 3, 2, 120.00),
    (2, 5, 1, 30.00);

-- Orden 3: moto de Byron, en reparacion.
INSERT INTO ordenes_servicio (id_moto, descripcion, estado) VALUES
    (3, 'Cambio de cadena de transmision', 'en_reparacion');
INSERT INTO detalle_repuestos (id_orden, id_repuesto, cantidad, precio_unitario) VALUES
    (3, 4, 1, 210.00);

-- Orden 4: moto de Manuel otra vez, recibida (todavia no se empieza a
-- trabajar). Se agrego por error una Cadena Transmision que esta moto
-- no necesita; se corrige con DELETE en dml/operaciones.sql mientras
-- la orden sigue 'recibida'.
INSERT INTO ordenes_servicio (id_moto, descripcion, estado) VALUES
    (1, 'Revision de frenos', 'recibida');
INSERT INTO detalle_repuestos (id_orden, id_repuesto, cantidad, precio_unitario) VALUES
    (4, 3, 1, 120.00),
    (4, 4, 1, 210.00);

-- Caso comentado que debe fallar (queda comentado): registrar de
-- nuevo Pastillas Freno como otra linea separada en la orden 2,
-- exactamente el problema que este UNIQUE esta disenado para evitar.
-- INSERT INTO detalle_repuestos (id_orden, id_repuesto, cantidad, precio_unitario) VALUES (2, 3, 1, 120.00);
