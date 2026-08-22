insert into clientes (nombre_cliente, telefono, direccion, nit) values
('Juan Pérez', '5551234', 'Zona 1, Guatemala', '1234567'),
('María López', '5555678', 'Zona 10, Guatemala', '2345678'),
('Carlos Gómez', '5559012', 'Mixco, Guatemala', '3456789'),
('Ana Martínez', '5553456', 'Villa Nueva, Guatemala', '4567890');


insert into productos (nombre_producto, cantidad_producto, precio, fecha_vencimiento) values
('Laptop Lenovo', 10, 5500),
('Mouse Logitech', 50, 150),
('Teclado Mecánico', 30, 300),
('Monitor Samsung', 20, 1200);


insert into categorias (id_producto, categoria_producto) values
(1, 'Computadoras'),
(2, 'Accesorios'),
(3, 'Accesorios'),
(4, 'Pantallas');

insert into ventas (id_cliente, id_producto, id_categoria) values
(1, 1, 1), -- Juan compra Laptop
(2, 2, 2), -- María compra Mouse
(3, 3, 2), -- Carlos compra Teclado
(4, 4, 4), -- Ana compra Monitor
(1, 2, 2); -- Juan también compra Mouse
