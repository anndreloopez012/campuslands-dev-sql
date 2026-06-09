PRAGMA foreign_keys = ON;

CREATE TABLE categorias (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL UNIQUE,
    estado TEXT NOT NULL DEFAULT 'activo' CHECK (
        estado IN ('activo', 'inactivo')
    )
);

CREATE TABLE productos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL UNIQUE,
    precio REAL NOT NULL CHECK (precio > 0),
    stock INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0),
    categoria_id INTEGER NOT NULL,
    FOREIGN KEY (categoria_id) REFERENCES categorias (id)
);

CREATE TABLE clientes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    fecha_registro TEXT NOT NULL DEFAULT (date('now'))
);

CREATE TABLE pedidos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    cliente_id INTEGER NOT NULL,
    fecha TEXT NOT NULL DEFAULT (date('now')),
    estado TEXT NOT NULL DEFAULT 'pendiente' CHECK (
        estado IN (
            'pendiente',
            'pagado',
            'enviado',
            'cancelado'
        )
    ),
    FOREIGN KEY (cliente_id) REFERENCES clientes (id)
);

CREATE TABLE detalle_pedidos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    pedido_id INTEGER NOT NULL,
    producto_id INTEGER NOT NULL,
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario REAL NOT NULL CHECK (precio_unitario >= 0),
    FOREIGN KEY (pedido_id) REFERENCES pedidos (id),
    FOREIGN KEY (producto_id) REFERENCES productos (id),
    UNIQUE (pedido_id, producto_id)
);