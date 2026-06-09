PRAGMA foreign_keys = ON;

-- Ejercicio 04: Restaurante Campus
DROP TABLE IF EXISTS detalle_pedido;

DROP TABLE IF EXISTS pedidos;

DROP TABLE IF EXISTS platos;

DROP TABLE IF EXISTS mesas;

CREATE TABLE mesas (
    id_mesa INTEGER PRIMARY KEY AUTOINCREMENT,
    numero INTEGER NOT NULL UNIQUE,
    capacidad INTEGER NOT NULL CHECK (capacidad > 0),
    ubicacion TEXT NOT NULL CHECK (
        ubicacion IN (
            'interior',
            'terraza',
            'barra'
        )
    ),
    estado TEXT NOT NULL DEFAULT 'disponible' CHECK (
        estado IN (
            'disponible',
            'ocupada',
            'reservada'
        )
    )
);

CREATE TABLE platos (
    id_plato INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL UNIQUE, 
    categoria TEXT NOT NULL CHECK (
        categoria IN (
            'entrada',
            'fuerte',
            'postre',
            'bebida'
        )
    ),
    precio REAL NOT NULL CHECK (precio > 0), 
    disponible INTEGER NOT NULL DEFAULT 1 CHECK (disponible IN (0, 1))
);

CREATE TABLE pedidos (
    id_pedido INTEGER PRIMARY KEY AUTOINCREMENT,
    id_mesa INTEGER NOT NULL,
    fecha_pedido TEXT NOT NULL, 
    estado TEXT NOT NULL DEFAULT 'abierto' CHECK (
        estado IN (
            'abierto',
            'pagado',
            'cancelado'
        )
    ),
    FOREIGN KEY (id_mesa) REFERENCES mesas (id_mesa)
);

CREATE TABLE detalle_pedido (
    id_detalle INTEGER PRIMARY KEY AUTOINCREMENT,
    id_pedido INTEGER NOT NULL,
    id_plato INTEGER NOT NULL,
    cantidad INTEGER NOT NULL CHECK (cantidad > 0), 
    precio_unitario REAL NOT NULL CHECK (precio_unitario >= 0),
    FOREIGN KEY (id_pedido) REFERENCES pedidos (id_pedido),
    FOREIGN KEY (id_plato) REFERENCES platos (id_plato)
);