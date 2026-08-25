PRAGMA foreign_keys = ON;

CREATE TABLE marcas (
    id_marca INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL UNIQUE
);

CREATE TABLE proveedores (
    id_proveedor INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL UNIQUE,
    telefono TEXT
);

CREATE TABLE bicicletas (
    id_bicicleta INTEGER PRIMARY KEY AUTOINCREMENT,
    id_marca INTEGER NOT NULL,
    modelo TEXT NOT NULL,
    tipo TEXT NOT NULL CHECK (tipo IN ('montana', 'ruta', 'urbana', 'electrica')),
    precio REAL NOT NULL CHECK (precio > 0),
    stock INTEGER NOT NULL CHECK (stock >= 0),
    FOREIGN KEY (id_marca) REFERENCES marcas (id_marca)
);

CREATE TABLE movimientos_inventario (
    id_movimiento INTEGER PRIMARY KEY AUTOINCREMENT,
    id_bicicleta INTEGER NOT NULL,
    id_proveedor INTEGER NOT NULL,
    tipo_movimiento TEXT NOT NULL CHECK (tipo_movimiento IN ('entrada', 'salida')),
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    fecha_movimiento TEXT NOT NULL,
    FOREIGN KEY (id_bicicleta) REFERENCES bicicletas (id_bicicleta),
    FOREIGN KEY (id_proveedor) REFERENCES proveedores (id_proveedor)
);
