PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS movimientos_inventario;
DROP TABLE IF EXISTS bicicletas;
DROP TABLE IF EXISTS proveedores;
DROP TABLE IF EXISTS marcas;

CREATE TABLE marcas (
    id_marca INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    pais_origen TEXT NOT NULL,

    CONSTRAINT chk_marca_nombre
        CHECK (length(trim(nombre)) >= 2)
);

CREATE TABLE proveedores (
    id_proveedor INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    telefono TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,

    CONSTRAINT chk_proveedor_email
        CHECK (email LIKE '%@%.%')
);

CREATE TABLE bicicletas (
    id_bicicleta INTEGER PRIMARY KEY,
    codigo TEXT NOT NULL UNIQUE,
    modelo TEXT NOT NULL,
    categoria TEXT NOT NULL,
    precio REAL NOT NULL,
    id_marca INTEGER NOT NULL,

    FOREIGN KEY (id_marca)
        REFERENCES marcas(id_marca),

    CONSTRAINT chk_bicicleta_precio
        CHECK (precio > 0),

    CONSTRAINT chk_bicicleta_categoria
        CHECK (
            categoria IN (
                'MONTAÑA',
                'CARRETERA',
                'URBANA',
                'BMX',
                'ELECTRICA'
            )
        )
);

CREATE TABLE movimientos_inventario (
    id_movimiento INTEGER PRIMARY KEY,
    id_bicicleta INTEGER NOT NULL,
    id_proveedor INTEGER NOT NULL,
    tipo_movimiento TEXT NOT NULL,
    cantidad INTEGER NOT NULL,
    fecha_movimiento TEXT NOT NULL,
    observacion TEXT,

    FOREIGN KEY (id_bicicleta)
        REFERENCES bicicletas(id_bicicleta),

    FOREIGN KEY (id_proveedor)
        REFERENCES proveedores(id_proveedor),

    CONSTRAINT chk_movimiento_tipo
        CHECK (tipo_movimiento IN ('ENTRADA', 'SALIDA')),

    CONSTRAINT chk_movimiento_cantidad
        CHECK (cantidad > 0),

    CONSTRAINT chk_movimiento_fecha
        CHECK (
            fecha_movimiento GLOB
            '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] *'
        )
);