PRAGMA foreign_keys = ON;

-- Ejercicio 04: Restaurante Campus
INSERT INTO
    platos (
        nombre,
        categoria,
        precio,
        disponible
    )
VALUES (
        'Tacos al pastor',
        'fuerte',
        78.00,
        1
    );

INSERT INTO
    detalle_pedido (
        id_pedido,
        id_plato,
        cantidad,
        precio_unitario
    )
VALUES (5, 6, 2, 25.00);

UPDATE platos SET precio = 28.00 WHERE nombre = 'Limonada natural';

UPDATE pedidos SET estado = 'pagado' WHERE id_pedido = 5;

DELETE FROM detalle_pedido WHERE id_pedido = 6;

DELETE FROM pedidos WHERE id_pedido = 6 AND estado = 'cancelado';
