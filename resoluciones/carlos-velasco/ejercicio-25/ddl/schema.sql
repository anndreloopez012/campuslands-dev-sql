PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS prestamos;
DROP TABLE IF EXISTS libros;
DROP TABLE IF EXISTS usuarios;
DROP TABLE IF EXISTS sedes;

-- SEDES

CREATE TABLE sedes (
    id_sede INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    direccion TEXT NOT NULL,
    capacidad INTEGER NOT NULL CHECK (capacidad > 0)
);

-- LIBROS

CREATE TABLE libros (
    id_libro INTEGER PRIMARY KEY,
    titulo TEXT NOT NULL,
    autor TEXT NOT NULL,
    isbn TEXT NOT NULL UNIQUE,
    anio_publicacion INTEGER NOT NULL CHECK (anio_publicacion BETWEEN 1000 AND 2100),
    ejemplares INTEGER NOT NULL CHECK (ejemplares >= 0)
);

-- USUARIOS

CREATE TABLE usuarios (
    id_usuario INTEGER PRIMARY KEY,
    id_sede INTEGER NOT NULL,
    nombre_completo TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE,
    fecha_registro TEXT NOT NULL CHECK (date(fecha_registro) IS NOT NULL),
    estado TEXT NOT NULL DEFAULT 'ACTIVO'
        CHECK (estado IN ('ACTIVO', 'INACTIVO')),
    FOREIGN KEY (id_sede)
        REFERENCES sedes(id_sede)
);

-- PRESTAMOS

CREATE TABLE prestamos (
    id_prestamo INTEGER PRIMARY KEY,
    id_usuario INTEGER NOT NULL,
    id_libro INTEGER NOT NULL,
    fecha_prestamo TEXT NOT NULL CHECK (date(fecha_prestamo) IS NOT NULL),
    fecha_devolucion TEXT,
    estado TEXT NOT NULL DEFAULT 'PRESTADO'
        CHECK (estado IN ('PRESTADO', 'DEVUELTO', 'ATRASADO')),
    dias_prestamo INTEGER NOT NULL CHECK (dias_prestamo > 0),
    FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_libro)
        REFERENCES libros(id_libro),
    CHECK (
        fecha_devolucion IS NULL
        OR date(fecha_devolucion) >= date(fecha_prestamo)
    )
);