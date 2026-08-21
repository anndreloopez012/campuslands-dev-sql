PRAGMA foreign_keys = ON;

-- Ejercicio 66: ALTER TABLE Nivel Intermedio
-- Se ejecuta despues de los ALTER TABLE de ddl/schema.sql, por eso ya se
-- pueden usar las columnas nuevas (categoria, ejemplares_disponibles,
-- estado), el nombre nuevo de columna (nombre_prestatario) y el nombre
-- nuevo de tabla (escritores).

-- El libro de redes llego con categoria = 'programacion' por el
-- DEFAULT del ALTER TABLE. Se corrige a su categoria real.
UPDATE libros SET categoria = 'redes' WHERE titulo = 'Redes de Computadoras';

-- Escritor y libro nuevos, ya con la estructura final.
INSERT INTO escritores (nombre) VALUES
    ('Martin Kleppmann');

INSERT INTO libros (id_autor, titulo, categoria, ejemplares_disponibles) VALUES
    (3, 'Designing Data-Intensive Applications', 'bases_de_datos', 2);

-- Prestamo nuevo, creado ya con la estructura final (columna
-- nombre_prestatario y estado indicados de forma explicita).
INSERT INTO prestamos (id_libro, nombre_prestatario, fecha_prestamo, estado) VALUES
    (3, 'Byron Xicay', '2026-08-05', 'prestado');
