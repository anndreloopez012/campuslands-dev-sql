PRAGMA foreign_keys = ON;

-- Ejercicio 001: Cafeteria Campus
INSERT INTO ventas (producto_id, estudiante, cantidad, fecha, metodo_pago, estado)
VALUES (4, 'Laura Gil', 1, '2026-08-21', 'efectivo', 'pendiente');

UPDATE ventas
SET estado = 'pagada'
WHERE id = 4 AND estado = 'pendiente';

UPDATE productos
SET estado = 'inactivo'
WHERE id = 5;

-- Elimina solo un producto sin ventas asociadas.
DELETE FROM productos
WHERE id = 5 AND NOT EXISTS (
	SELECT 1 FROM ventas WHERE ventas.producto_id = productos.id
);
