PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS prestamos;
DROP TABLE IF EXISTS libros;
DROP TABLE IF EXISTS usuarios;
DROP TABLE IF EXISTS sedes;

CREATE TABLE sedes (
    id_sede INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    direccion TEXT NOT NULL,
    ciudad TEXT NOT NULL
);

CREATE TABLE libros (
    id_libro INTEGER PRIMARY KEY,
    id_sede INTEGER NOT NULL,
    titulo TEXT NOT NULL,
    autor TEXT NOT NULL,
    isbn TEXT NOT NULL UNIQUE,
    stock INTEGER NOT NULL CHECK (stock >= 0),
    FOREIGN KEY (id_sede) REFERENCES sedes(id_sede)
);

CREATE TABLE usuarios (
    id_usuario INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    documento TEXT NOT NULL UNIQUE,
    correo TEXT NOT NULL UNIQUE,
    telefono TEXT NOT NULL
);

CREATE TABLE prestamos (
    id_prestamo INTEGER PRIMARY KEY,
    id_libro INTEGER NOT NULL,
    id_usuario INTEGER NOT NULL,
    fecha_prestamo TEXT NOT NULL CHECK (date(fecha_prestamo) IS NOT NULL),
    fecha_devolucion TEXT,
    estado TEXT NOT NULL CHECK (estado IN ('ACTIVO','DEVUELTO','ATRASADO')),
    FOREIGN KEY (id_libro) REFERENCES libros(id_libro),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE INDEX idx_libros_sede ON libros(id_sede);
CREATE INDEX idx_prestamos_libro ON prestamos(id_libro);
CREATE INDEX idx_prestamos_usuario ON prestamos(id_usuario);
CREATE INDEX idx_prestamos_estado ON prestamos(estado);