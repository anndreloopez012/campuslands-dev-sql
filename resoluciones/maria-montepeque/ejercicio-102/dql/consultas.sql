.headers on
.mode column

-- Ejercicio 102: Procedimientos almacenados Nivel Intermedio
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT p.id_prestamo, l.titulo, p.nombre_prestatario, p.fecha_prestamo, p.estado
FROM prestamos p
JOIN libros l ON l.id_libro = p.id_libro;

-- 2. Consulta con WHERE: solo los prestamos activos.
SELECT id_prestamo, id_libro, nombre_prestatario, fecha_prestamo
FROM prestamos
WHERE estado = 'prestado';

-- 3. Consulta con ORDER BY: prestamos ordenados por fecha.
SELECT id_prestamo, id_libro, estado, fecha_prestamo
FROM prestamos
ORDER BY fecha_prestamo;

-- 4. Conteo o resumen: total de prestamos por libro.
SELECT id_libro, COUNT(*) AS total_prestamos
FROM prestamos
GROUP BY id_libro;

-- 5. Validacion especifica de Procedimientos almacenados (via su
-- alternativa ejecutable, el trigger): un INSERT normal sobre un
-- libro que SI tiene copias disponibles ("Refactoring", stock 1, sin
-- prestamos activos todavia) debe pasar la validacion del trigger y
-- quedar registrado, igual que pasaria la validacion equivalente
-- dentro del procedimiento almacenado teorico.
INSERT INTO prestamos (id_libro, nombre_prestatario, fecha_prestamo)
VALUES (3, 'Fernando Diaz', '2026-08-06');

SELECT id_prestamo, id_libro, nombre_prestatario, estado
FROM prestamos
WHERE id_libro = 3;

-- Caso comentado que no es recomendable, dejar comentado: intentar
-- registrar un prestamo para "Clean Architecture" (id_libro = 1),
-- que ya tiene sus 1 unica copia prestada (0 disponibles). Se
-- verifico con Python (sqlite3) que
-- trg_validar_disponibilidad_prestamo aborta la operacion con el
-- error "No hay copias disponibles para este libro" y el INSERT no
-- llega a insertar ninguna fila: es la misma validacion que, en el
-- procedimiento almacenado teorico, se resolveria con un
-- SIGNAL SQLSTATE (MySQL) o un RAISE EXCEPTION (PostgreSQL).
-- INSERT INTO prestamos (id_libro, nombre_prestatario, fecha_prestamo)
-- VALUES (1, 'Gabriela Soto', '2026-08-07');
