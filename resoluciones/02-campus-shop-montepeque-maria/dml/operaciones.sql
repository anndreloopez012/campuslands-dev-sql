PRAGMA foreign_keys = ON;

INSERT INTO
    productos (
        nombre,
        precio,
        stock,
        categoria_id
    )
VALUES (
        'Stickers Campus',
        3000,
        80,
        2
    );

INSERT INTO
    clientes (nombre, email)
VALUES (
        'Valentina Soto',
        'valentina@campus.edu'
    );

UPDATE productos SET precio = 42000 WHERE nombre = 'Audífonos USB';

UPDATE pedidos SET estado = 'enviado' WHERE id = 6;

UPDATE productos SET stock = stock - 5 WHERE id = 1;

DELETE FROM detalle_pedidos WHERE pedido_id = 5;

DELETE FROM pedidos WHERE estado = 'cancelado';