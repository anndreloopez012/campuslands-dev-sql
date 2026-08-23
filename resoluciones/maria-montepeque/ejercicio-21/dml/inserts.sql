-- Ejercicio 21: Logistica Envios
-- Datos base: 5 clientes, 5 paquetes, 5 rutas, 10 envios

INSERT INTO clientes (nombre, telefono, correo) VALUES
    ('Manuel Estrada', '5033-1001', 'manuel.estrada@correo.com'),
    ('Alejandra Chinchilla', '5033-1002', 'alejandra.chinchilla@correo.com'),
    ('Byron Xicay', '5033-1003', 'byron.xicay@correo.com'),
    ('Cristina Barrios', '5033-1004', 'cristina.barrios@correo.com'),
    ('Douglas Pineda', '5033-1005', 'douglas.pineda@correo.com');

INSERT INTO paquetes (id_cliente, descripcion, peso) VALUES
    (1, 'Caja de libros', 5.5),
    (2, 'Equipo electronico', 2.0),
    (3, 'Ropa y accesorios', 3.2),
    (4, 'Repuestos de moto', 8.0),
    (5, 'Documentos legales', 0.5);

INSERT INTO rutas (origen, destino, distancia_km) VALUES
    ('Ciudad de Guatemala', 'Antigua Guatemala', 45.0),
    ('Ciudad de Guatemala', 'Quetzaltenango', 205.0),
    ('Ciudad de Guatemala', 'Escuintla', 60.0),
    ('Ciudad de Guatemala', 'Coban', 215.0),
    ('Ciudad de Guatemala', 'Puerto Barrios', 297.0);

INSERT INTO envios (id_paquete, id_ruta, fecha_envio, estado, costo) VALUES
    (1, 1, '2026-07-01', 'entregado', 50.00),
    (1, 3, '2026-07-15', 'entregado', 65.00),
    (2, 2, '2026-07-02', 'en_transito', 120.00),
    (2, 5, '2026-07-20', 'pendiente', 180.00),
    (3, 3, '2026-07-03', 'entregado', 65.00),
    (3, 1, '2026-07-18', 'entregado', 50.00),
    (4, 4, '2026-07-04', 'en_transito', 150.00),
    (4, 2, '2026-07-22', 'pendiente', 120.00),
    (5, 1, '2026-07-05', 'entregado', 50.00),
    (5, 5, '2026-07-25', 'cancelado', 180.00);
