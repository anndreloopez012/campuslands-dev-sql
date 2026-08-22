PRAGMA foreign_keys = ON;

-- Ejercicio 060: Biblioteca Sci-Fi
INSERT INTO prestamos (libro_id, usuario_id, fecha_prestamo, estado) VALUES (3, 1, '2026-08-18', 'prestado');

UPDATE prestamos SET estado = 'devuelto' WHERE id = 1;

DELETE FROM usuarios WHERE id = 2 AND NOT EXISTS (SELECT 1 FROM prestamos WHERE usuario_id = usuarios.id);