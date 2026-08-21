PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS movimientos_inventario;
DROP TABLE IF EXISTS bicicletas;
DROP TABLE IF EXISTS proveedores;
DROP TABLE IF EXISTS marcas;

CREATE TABLE marcas (
    id_marca INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    pais_origen TEXT NOT NULL
);

CREATE TABLE proveedores (
    id_proveedor INTEGER PRIMARY KEY,
    nombre_empresa TEXT NOT NULL UNIQUE,
    telefono TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE
);

CREATE TABLE bicicletas (
    id_bicicleta INTEGER PRIMARY KEY,
    id_marca INTEGER NOT NULL,
    id_proveedor INTEGER NOT NULL,
    modelo TEXT NOT NULL,
    tipo TEXT NOT NULL,
    precio REAL NOT NULL,
    stock_actual INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (id_marca) REFERENCES marcas(id_marca),
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor),
    CHECK (precio > 0),
    CHECK (stock_actual >= 0),
    CHECK (tipo IN ('MTB', 'RUTA', 'URBANA', 'BMX', 'ELECTRICA')),
    UNIQUE (id_marca, modelo)
);

CREATE TABLE movimientos_inventario (
    id_movimiento INTEGER PRIMARY KEY,
    id_bicicleta INTEGER NOT NULL,
    tipo_movimiento TEXT NOT NULL,
    cantidad INTEGER NOT NULL,
    fecha_movimiento TEXT NOT NULL,
    observacion TEXT,
    FOREIGN KEY (id_bicicleta) REFERENCES bicicletas(id_bicicleta),
    CHECK (cantidad > 0),
    CHECK (tipo_movimiento IN ('ENTRADA', 'SALIDA'))
);