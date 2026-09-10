PRAGMA foreign_keys = ON;

-- Ejercicio 101: Procedimientos almacenados Nivel Basico
-- Tema central: Procedimientos almacenados
-- Contexto: ventas diarias de una cafeteria.

CREATE TABLE productos (
    id_producto       INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_producto   TEXT NOT NULL UNIQUE,
    precio_unitario   REAL NOT NULL CHECK (precio_unitario >= 0),
    stock             INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0)
);

CREATE TABLE ventas (
    id_venta         INTEGER PRIMARY KEY AUTOINCREMENT,
    id_producto      INTEGER NOT NULL,
    nombre_cliente   TEXT NOT NULL,
    cantidad         INTEGER NOT NULL CHECK (cantidad > 0),
    fecha_venta      TEXT NOT NULL,

    FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);

-- =====================================================================
-- Procedimientos almacenados: SQLite no soporta CREATE PROCEDURE (no
-- existe ese objeto en su motor). Aqui abajo se documenta, como
-- comentario, el procedimiento TEORICO equivalente para MySQL y para
-- PostgreSQL: dado un producto, un cliente y una cantidad, registra la
-- venta Y descuenta el stock del producto en un solo paso reutilizable.
-- Despues, mas abajo, se implementa la alternativa SI ejecutable en
-- SQLite usando un TRIGGER, que logra el mismo efecto practico
-- (encapsular esos dos pasos para que ocurran siempre juntos) sin
-- necesitar procedimientos almacenados.
-- =====================================================================

-- --- Version teorica MySQL ---
-- DELIMITER $$
-- CREATE PROCEDURE registrar_venta (
--     IN p_id_producto     INT,
--     IN p_nombre_cliente  VARCHAR(100),
--     IN p_cantidad        INT,
--     IN p_fecha_venta     DATE
-- )
-- BEGIN
--     INSERT INTO ventas (id_producto, nombre_cliente, cantidad, fecha_venta)
--     VALUES (p_id_producto, p_nombre_cliente, p_cantidad, p_fecha_venta);
--
--     UPDATE productos
--     SET stock = stock - p_cantidad
--     WHERE id_producto = p_id_producto;
-- END $$
-- DELIMITER ;
--
-- -- Uso: CALL registrar_venta(1, 'Sofia Martinez', 2, '2026-08-01');

-- --- Version teorica PostgreSQL ---
-- CREATE OR REPLACE PROCEDURE registrar_venta (
--     p_id_producto     INT,
--     p_nombre_cliente  VARCHAR,
--     p_cantidad        INT,
--     p_fecha_venta     DATE
-- )
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     INSERT INTO ventas (id_producto, nombre_cliente, cantidad, fecha_venta)
--     VALUES (p_id_producto, p_nombre_cliente, p_cantidad, p_fecha_venta);
--
--     UPDATE productos
--     SET stock = stock - p_cantidad
--     WHERE id_producto = p_id_producto;
-- END;
-- $$;
--
-- -- Uso: CALL registrar_venta(1, 'Sofia Martinez', 2, '2026-08-01');

-- --- Alternativa ejecutable en SQLite: TRIGGER ---
-- En vez de "llamar" a un procedimiento con parametros, en SQLite se
-- deja la MISMA logica (insertar la venta y descontar el stock)
-- encapsulada en un trigger que se dispara solo, cada vez que se
-- inserta una fila en "ventas". Quien registra la venta solo hace un
-- INSERT normal; el trigger se encarga del segundo paso (el UPDATE de
-- stock) automaticamente, igual que haria el procedimiento almacenado.
CREATE TRIGGER trg_actualizar_stock_venta
AFTER INSERT ON ventas
FOR EACH ROW
BEGIN
    UPDATE productos
    SET stock = stock - NEW.cantidad
    WHERE id_producto = NEW.id_producto;
END;
