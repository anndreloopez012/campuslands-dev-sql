PRAGMA foreign_keys = ON;

-- Ejercicio 102: Procedimientos almacenados Nivel Intermedio
-- Tema central: Procedimientos almacenados
-- Contexto: prestamos de libros tecnicos en una biblioteca.

CREATE TABLE autores (
    id_autor      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_autor  TEXT NOT NULL UNIQUE
);

CREATE TABLE libros (
    id_libro      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_autor      INTEGER NOT NULL,
    titulo        TEXT NOT NULL,
    stock_total   INTEGER NOT NULL CHECK (stock_total > 0),

    FOREIGN KEY (id_autor) REFERENCES autores (id_autor)
);

CREATE TABLE prestamos (
    id_prestamo          INTEGER PRIMARY KEY AUTOINCREMENT,
    id_libro             INTEGER NOT NULL,
    nombre_prestatario   TEXT NOT NULL,
    fecha_prestamo       TEXT NOT NULL,
    estado               TEXT NOT NULL DEFAULT 'prestado'
                             CHECK (estado IN ('prestado', 'devuelto')),

    FOREIGN KEY (id_libro) REFERENCES libros (id_libro)
);

-- =====================================================================
-- Procedimientos almacenados: SQLite no soporta CREATE PROCEDURE.
-- Aqui se documenta, como comentario, el procedimiento TEORICO
-- equivalente para MySQL y PostgreSQL: antes de registrar un
-- prestamo, valida que el libro tenga copias disponibles (stock_total
-- menos los prestamos activos) y, si no las tiene, cancela la
-- operacion con un error de negocio en vez de insertar el prestamo.
-- Mas abajo se implementa la alternativa SI ejecutable en SQLite con
-- un TRIGGER "BEFORE INSERT" que aplica la misma validacion.
-- =====================================================================

-- --- Version teorica MySQL ---
-- DELIMITER $$
-- CREATE PROCEDURE registrar_prestamo (
--     IN p_id_libro            INT,
--     IN p_nombre_prestatario  VARCHAR(100),
--     IN p_fecha_prestamo      DATE
-- )
-- BEGIN
--     DECLARE v_disponibles INT;
--
--     SELECT l.stock_total - COUNT(CASE WHEN p.estado = 'prestado' THEN 1 END)
--     INTO v_disponibles
--     FROM libros l
--     LEFT JOIN prestamos p ON p.id_libro = l.id_libro
--     WHERE l.id_libro = p_id_libro
--     GROUP BY l.id_libro, l.stock_total;
--
--     IF v_disponibles <= 0 THEN
--         SIGNAL SQLSTATE '45000'
--             SET MESSAGE_TEXT = 'No hay copias disponibles para este libro';
--     ELSE
--         INSERT INTO prestamos (id_libro, nombre_prestatario, fecha_prestamo)
--         VALUES (p_id_libro, p_nombre_prestatario, p_fecha_prestamo);
--     END IF;
-- END $$
-- DELIMITER ;
--
-- -- Uso: CALL registrar_prestamo(1, 'Ana Lopez', '2026-08-01');

-- --- Version teorica PostgreSQL ---
-- CREATE OR REPLACE PROCEDURE registrar_prestamo (
--     p_id_libro            INT,
--     p_nombre_prestatario  VARCHAR,
--     p_fecha_prestamo      DATE
-- )
-- LANGUAGE plpgsql
-- AS $$
-- DECLARE
--     v_disponibles INT;
-- BEGIN
--     SELECT l.stock_total - COUNT(*) FILTER (WHERE p.estado = 'prestado')
--     INTO v_disponibles
--     FROM libros l
--     LEFT JOIN prestamos p ON p.id_libro = l.id_libro
--     WHERE l.id_libro = p_id_libro
--     GROUP BY l.id_libro, l.stock_total;
--
--     IF v_disponibles <= 0 THEN
--         RAISE EXCEPTION 'No hay copias disponibles para este libro';
--     END IF;
--
--     INSERT INTO prestamos (id_libro, nombre_prestatario, fecha_prestamo)
--     VALUES (p_id_libro, p_nombre_prestatario, p_fecha_prestamo);
-- END;
-- $$;
--
-- -- Uso: CALL registrar_prestamo(1, 'Ana Lopez', '2026-08-01');

-- --- Alternativa ejecutable en SQLite: TRIGGER "BEFORE INSERT" ---
-- En vez de validar la disponibilidad dentro de un procedimiento antes
-- de decidir si insertar, en SQLite se deja la MISMA validacion en un
-- trigger que se dispara ANTES de cada INSERT en "prestamos": si el
-- libro ya no tiene copias disponibles, el trigger aborta la
-- operacion completa con RAISE(ABORT, ...) y el INSERT nunca llega a
-- ejecutarse.
CREATE TRIGGER trg_validar_disponibilidad_prestamo
BEFORE INSERT ON prestamos
FOR EACH ROW
WHEN (
    (SELECT l.stock_total FROM libros l WHERE l.id_libro = NEW.id_libro)
    - (SELECT COUNT(*) FROM prestamos p
       WHERE p.id_libro = NEW.id_libro AND p.estado = 'prestado')
) <= 0
BEGIN
    SELECT RAISE(ABORT, 'No hay copias disponibles para este libro');
END;
