PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS detalle_prestamo;
DROP TABLE IF EXISTS libro_genero;
DROP TABLE IF EXISTS libro_autor;
DROP TABLE IF EXISTS prestamos;
DROP TABLE IF EXISTS generos;
DROP TABLE IF EXISTS autores;
DROP TABLE IF EXISTS libros;
DROP TABLE IF EXISTS usuarios;

CREATE TABLE autores (
    id_autor INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    nacionalidad TEXT,
    fecha_nacimiento TEXT
);

CREATE TABLE generos (
    id_genero INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    descripcion TEXT
);

CREATE TABLE libros (
    id_libro INTEGER PRIMARY KEY,
    titulo TEXT NOT NULL,
    isbn TEXT NOT NULL UNIQUE,
    anio_publicacion INTEGER NOT NULL,
    editorial TEXT NOT NULL,
    ejemplares INTEGER NOT NULL DEFAULT 1,
    estado TEXT NOT NULL DEFAULT 'disponible',
    CHECK (anio_publicacion BETWEEN 1000 AND 2100),
    CHECK (ejemplares >= 0),
    CHECK (estado IN ('disponible', 'agotado', 'inactivo'))
);

CREATE TABLE usuarios (
    id_usuario INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    documento TEXT NOT NULL UNIQUE,
    email TEXT UNIQUE,
    telefono TEXT,
    estado TEXT NOT NULL DEFAULT 'activo',
    CHECK (length(documento) >= 5),
    CHECK (estado IN ('activo', 'inactivo'))
);

CREATE TABLE prestamos (
    id_prestamo INTEGER PRIMARY KEY,
    id_usuario INTEGER NOT NULL,
    fecha_prestamo TEXT NOT NULL,
    fecha_devolucion_prevista TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'activo',
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    CHECK (fecha_devolucion_prevista >= fecha_prestamo),
    CHECK (estado IN ('activo', 'devuelto', 'atrasado'))
);

CREATE TABLE detalle_prestamo (
    id_detalle INTEGER PRIMARY KEY,
    id_prestamo INTEGER NOT NULL,
    id_libro INTEGER NOT NULL,
    fecha_devolucion_real TEXT,
    FOREIGN KEY (id_prestamo) REFERENCES prestamos(id_prestamo),
    FOREIGN KEY (id_libro) REFERENCES libros(id_libro),
    UNIQUE (id_prestamo, id_libro)
);

CREATE TABLE libro_autor (
    id_libro INTEGER NOT NULL,
    id_autor INTEGER NOT NULL,
    PRIMARY KEY (id_libro, id_autor),
    FOREIGN KEY (id_libro) REFERENCES libros(id_libro),
    FOREIGN KEY (id_autor) REFERENCES autores(id_autor)
);

CREATE TABLE libro_genero (
    id_libro INTEGER NOT NULL,
    id_genero INTEGER NOT NULL,
    PRIMARY KEY (id_libro, id_genero),
    FOREIGN KEY (id_libro) REFERENCES libros(id_libro),
    FOREIGN KEY (id_genero) REFERENCES generos(id_genero)
);

CREATE INDEX idx_libro_autor_autor
ON libro_autor(id_autor);

CREATE INDEX idx_libro_genero_genero
ON libro_genero(id_genero);

CREATE INDEX idx_prestamos_usuario
ON prestamos(id_usuario);

CREATE INDEX idx_prestamos_fecha
ON prestamos(fecha_prestamo);

CREATE INDEX idx_detalle_prestamo_prestamo
ON detalle_prestamo(id_prestamo);

CREATE INDEX idx_detalle_prestamo_libro
ON detalle_prestamo(id_libro);