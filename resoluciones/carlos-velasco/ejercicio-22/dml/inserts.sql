PRAGMA foreign_keys = ON;

-- CLIENTES

INSERT INTO clientes (
    id_cliente,
    nombre_completo,
    correo,
    telefono,
    direccion
)
VALUES
    (1, 'Ana Martinez', 'ana.martinez@email.com', '555-2001', 'Zona 10, Ciudad de Guatemala'),
    (2, 'Carlos Lopez', 'carlos.lopez@email.com', '555-2002', 'Zona 11, Ciudad de Guatemala'),
    (3, 'Maria Gonzalez', 'maria.gonzalez@email.com', '555-2003', 'Zona 15, Ciudad de Guatemala'),
    (4, 'Diego Ramirez', 'diego.ramirez@email.com', '555-2004', 'Zona 7, Ciudad de Guatemala'),
    (5, 'Sofia Hernandez', 'sofia.hernandez@email.com', '555-2005', 'Zona 14, Ciudad de Guatemala');

-- RESTAURANTES

INSERT INTO restaurantes (
    id_restaurante,
    nombre,
    telefono,
    categoria,
    calificacion
)
VALUES
    (1, 'Sabor Chapin', '555-3001', 'Guatemalteca', 4.8),
    (2, 'Pizza Central', '555-3002', 'Pizza', 4.5),
    (3, 'Burger House', '555-3003', 'Hamburguesas', 4.3),
    (4, 'Wok Express', '555-3004', 'Asiatica', 4.6),
    (5, 'Verde Natural', '555-3005', 'Saludable', 4.7);

-- REPARTIDORES

INSERT INTO repartidores (
    id_repartidor,
    nombre_completo,
    telefono,
    vehiculo,
    disponible
)
VALUES
    (1, 'Luis Perez', '555-4001', 'MOTO', 1),
    (2, 'Jorge Castillo', '555-4002', 'BICICLETA', 1),
    (3, 'Andrea Morales', '555-4003', 'MOTO', 0),
    (4, 'Miguel Torres', '555-4004', 'AUTOMOVIL', 1),
    (5, 'Laura Gomez', '555-4005', 'MOTO', 1);

-- PEDIDOS

INSERT INTO pedidos (
    id_pedido,
    id_cliente,
    id_restaurante,
    id_repartidor,
    fecha_pedido,
    estado,
    total,
    tiempo_estimado_min
)
VALUES
    (1, 1, 1, 1, '2026-08-10 12:15', 'ENTREGADO', 85.50, 35),
    (2, 2, 2, 2, '2026-08-10 13:00', 'ENTREGADO', 72.00, 40),
    (3, 3, 3, 3, '2026-08-11 18:30', 'ENTREGADO', 96.75, 45),
    (4, 4, 4, 4, '2026-08-11 19:10', 'EN_CAMINO', 110.00, 40),
    (5, 5, 5, 5, '2026-08-12 12:45', 'ENTREGADO', 68.25, 30),
    (6, 1, 2, 1, '2026-08-12 13:20', 'PREPARANDO', 125.00, 50),
    (7, 2, 3, 2, '2026-08-13 18:45', 'PENDIENTE', 145.50, 45),
    (8, 3, 4, 4, '2026-08-14 19:00', 'EN_CAMINO', 88.90, 35),
    (9, 4, 1, 5, '2026-08-15 12:10', 'ENTREGADO', 155.00, 40),
    (10, 5, 5, 1, '2026-08-15 13:30', 'PENDIENTE', 74.50, 30);