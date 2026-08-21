DROP TABLE IF EXISTS prestamos;
DROP TABLE IF EXISTS libros;
DROP TABLE IF EXISTS campers;
DROP TABLE IF EXISTS autores;

CREATE TABLE autores (
    id_autor INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    nacionalidad TEXT NOT NULL,
    fecha_nacimiento TEXT NOT NULL,
    UNIQUE (nombre_completo)
);

CREATE TABLE libros (
    id_libro INTEGER PRIMARY KEY,
    id_autor INTEGER NOT NULL,
    titulo TEXT NOT NULL,
    isbn TEXT NOT NULL UNIQUE,
    anio_publicacion INTEGER NOT NULL,
    ejemplares_disponibles INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (id_autor) REFERENCES autores(id_autor),
    CHECK (anio_publicacion BETWEEN 1000 AND 2100),
    CHECK (ejemplares_disponibles >= 0)
);

CREATE TABLE campers (
    id_camper INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    fecha_ingreso TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'ACTIVO',
    CHECK (estado IN ('ACTIVO', 'INACTIVO'))
);

CREATE TABLE prestamos (
    id_prestamo INTEGER PRIMARY KEY,
    id_libro INTEGER NOT NULL,
    id_camper INTEGER NOT NULL,
    fecha_prestamo TEXT NOT NULL,
    fecha_devolucion TEXT,
    estado TEXT NOT NULL DEFAULT 'PRESTADO',
    FOREIGN KEY (id_libro) REFERENCES libros(id_libro),
    FOREIGN KEY (id_camper) REFERENCES campers(id_camper),
    CHECK (estado IN ('PRESTADO', 'DEVUELTO')),
    CHECK (
        fecha_devolucion IS NULL
        OR fecha_devolucion >= fecha_prestamo
    )
);