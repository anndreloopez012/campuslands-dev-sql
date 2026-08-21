PRAGMA foreign_keys = ON;

-- Ejercicio 66: ALTER TABLE Nivel Intermedio
-- Tema central: ALTER TABLE
-- Contexto: prestamos de libros tecnicos de una biblioteca.

-- Version inicial de las 3 tablas, tal como se crearon antes de que la
-- biblioteca pidiera nuevos datos.
CREATE TABLE autores (
    id_autor   INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre     TEXT NOT NULL UNIQUE
);

CREATE TABLE libros (
    id_libro    INTEGER PRIMARY KEY AUTOINCREMENT,
    id_autor    INTEGER NOT NULL,
    titulo      TEXT NOT NULL,

    FOREIGN KEY (id_autor) REFERENCES autores (id_autor)
);

CREATE TABLE prestamos (
    id_prestamo       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_libro          INTEGER NOT NULL,
    prestatario       TEXT NOT NULL,
    fecha_prestamo    TEXT NOT NULL DEFAULT (date('now')),

    FOREIGN KEY (id_libro) REFERENCES libros (id_libro)
);

-- Se insertan datos con la estructura original, antes de modificar las
-- tablas. Sirve para demostrar que ALTER TABLE no destruye los datos ya
-- existentes.
INSERT INTO autores (nombre) VALUES
    ('Robert C. Martin'),
    ('Andrew S. Tanenbaum');

INSERT INTO libros (id_autor, titulo) VALUES
    (1, 'Clean Code'),
    (2, 'Redes de Computadoras');

INSERT INTO prestamos (id_libro, prestatario, fecha_prestamo) VALUES
    (1, 'Manuel Estrada', '2026-08-01'),
    (2, 'Alejandra Chinchilla', '2026-08-02');

-- ALTER TABLE 1: la biblioteca pide clasificar los libros por categoria
-- y saber cuantos ejemplares quedan. Se agregan con DEFAULT para que
-- los libros ya existentes queden validos de inmediato.
ALTER TABLE libros
    ADD COLUMN categoria TEXT NOT NULL DEFAULT 'programacion'
        CHECK (categoria IN ('programacion', 'redes', 'bases_de_datos', 'sistemas_operativos'));

ALTER TABLE libros
    ADD COLUMN ejemplares_disponibles INTEGER NOT NULL DEFAULT 1
        CHECK (ejemplares_disponibles >= 0);

-- ALTER TABLE 2: la biblioteca pide llevar el estado de cada prestamo.
ALTER TABLE prestamos
    ADD COLUMN estado TEXT NOT NULL DEFAULT 'prestado'
        CHECK (estado IN ('prestado', 'devuelto', 'atrasado'));

-- ALTER TABLE 3: renombrar una columna para que el nombre sea mas claro.
ALTER TABLE prestamos
    RENAME COLUMN prestatario TO nombre_prestatario;

-- ALTER TABLE 4: renombrar toda la tabla de autores. SQLite actualiza
-- automaticamente la FOREIGN KEY de libros.id_autor para que siga
-- apuntando a la tabla renombrada.
ALTER TABLE autores
    RENAME TO escritores;

-- Caso que debe fallar / no recomendable (queda comentado): en SQLite,
-- ALTER TABLE ... ADD COLUMN con NOT NULL y sin DEFAULT falla si la
-- tabla ya tiene filas.
-- ALTER TABLE escritores ADD COLUMN nacionalidad TEXT NOT NULL;
